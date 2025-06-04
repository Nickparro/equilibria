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
        initialRoute: '/',
        routes: {
          '/': (context) => HomeScreen(), //podria ponerse que HomeSreen es StatelessWidget con const
          '/register': (context) => ActivityRegisterScreen(),
          '/balance': (context) => BalanceScreen(),
          '/activepauses': (context) => ActivePausesSuggestionScreen(),
          '/reminder': (context) => ReminderScreen(),
          '/history': (context) => HistoryScreen(),
          '/configuration': (context) => ConfigurationScreen(),
        },
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
   // Aquí podrás manejar el estado global si decides usarlo
}

