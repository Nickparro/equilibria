import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/login_onboarding_screen.dart';
import 'screens/home_screen.dart';
import 'screens/activity_register_screen.dart';
import 'screens/balance_screen.dart';
import 'screens/active_pauses_suggestion_screen.dart';
import 'screens/reminder_screen.dart';
import 'screens/history_screen.dart';
import 'screens/configuration_screen.dart';


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
        initialRoute: '/login',
        routes: {
          '/': (context) => HomeScreen(), //podria ponerse que HomeSreen es StatelessWidget con const
          '/register': (context) => ActivityRegisterScreen(),
          '/balance': (context) => BalanceScreen(),
          '/activepauses': (context) => ActivePausesSuggestionScreen(),
          '/reminder': (context) => ReminderScreen(),
          '/history': (context) => HistoryScreen(),
          '/configuration': (context) => ConfigurationScreen(),
          '/login': (context) => LoginPage(),
        },
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

  void agregarActividad(String categoria, int minutos) {
    if (tiempoPorCategoria.containsKey(categoria)) {
      tiempoPorCategoria[categoria] = tiempoPorCategoria[categoria]! + minutos;
      notifyListeners();
    }
  }

  Map<String, double> obtenerDistribucionTiempo() {
    return Map.from(tiempoPorCategoria);
  }
}

