import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/login_onboarding_screen.dart';
import 'screens/balance_screen.dart';
import 'screens/active_pauses_suggestion_screen.dart';
import 'screens/activity_register_screen.dart';
import 'screens/history_screen.dart';

void main() {
  runApp(EquilibriaApp());
}

class EquilibriaApp extends StatelessWidget {
  const EquilibriaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Equilibria',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
          useMaterial3: true,
        ),
        home: Consumer<MyAppState>(
          builder: (context, appState, _) {
            return appState.isLoggedIn ? MainNavigation() : LoginPage();
          },
        ),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  final Map<String, double> tiempoPorCategoria = {
    'Estudio': 0,
    'Trabajo': 0,
    'Ejercicio': 0,
    'Descanso': 0,
    'Ocio': 0,
  };

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  void login() {
    _isLoggedIn = true;
    notifyListeners();
  }

 final List<Actividad> historialActividades = [];

  void agregarActividad(String categoria, int minutos, [String descripcion = '']) {
    if (tiempoPorCategoria.containsKey(categoria)) {
      tiempoPorCategoria[categoria] = tiempoPorCategoria[categoria]! + minutos;
      historialActividades.insert(
        0,
        Actividad(categoria: categoria, descripcion: descripcion, minutos: minutos),
      );
      notifyListeners();
    }
  }

  void editarActividad(int index, String categoria, int minutos, String descripcion) {
  final vieja = historialActividades[index];
  tiempoPorCategoria[vieja.categoria] = tiempoPorCategoria[vieja.categoria]! - vieja.minutos;
  tiempoPorCategoria[categoria] = (tiempoPorCategoria[categoria] ?? 0) + minutos;
  
  historialActividades[index] = Actividad(
    categoria: categoria,
    minutos: minutos,
    descripcion: descripcion,
  );

  notifyListeners();
}

  Map<String, double> obtenerDistribucionTiempo() => Map.from(tiempoPorCategoria);
  List<Actividad> obtenerHistorial() => List.unmodifiable(historialActividades);

}


class Actividad {
  final String categoria;
  final String descripcion;
  final int minutos;
  final DateTime timestamp;

  Actividad({
    required this.categoria,
    required this.descripcion,
    required this.minutos,
  }) : timestamp = DateTime.now();
}

class MainNavigation extends StatefulWidget {
  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 1;

  final List<Widget> _screens = [
    HistoryScreen(),
    BalanceScreen(),
    ActivePausesSuggestionScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F4FA),
      body: _screens[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF6C63FF),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ActivityRegisterScreen()),
          );
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Icon(Icons.add, color: Colors.white, size: 28),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: Color(0xFF6C63FF),
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w400),
          elevation: 8,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'Historial',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pie_chart),
              label: 'Balance',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.fitness_center),
              label: 'Pausas',
            ),
          ],
        ),
      ),
    );
  }
}