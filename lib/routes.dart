// lib/routes.dart
import 'package:flutter/material.dart';
import 'package:muve/error_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_choice_screen.dart';
import 'screens/register_user_screen.dart';
import 'screens/register_client_screen.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/events/events_screen.dart';
import 'screens/events/sertanejo_screen.dart';
import 'screens/events/escolha_screen.dart';
import 'screens/events/events_contratante_screen.dart';

class Routes {
  static const splash = '/';
  static const login = '/login';
  static const registerChoice = '/register_choice';
  static const registerUser = '/register_user';
  static const registerClient = '/register_client';
  static const home = '/home';
  static const profile = '/profile';
  static const events = '/events';
  static const sertanejo = '/sertanejo';
  static const error = '/error';
  static const escolha = '/escolha';
  static const eventsContratante = '/events_contratante'; // nova rota

  static Map<String, WidgetBuilder> getRoutes() => {
    splash: (context) => const SplashScreen(),
    login: (context) => const LoginScreen(),
    registerChoice: (context) => const RegisterChoiceScreen(),
    registerUser: (context) => const RegisterUserScreen(),
    registerClient: (context) => const RegisterClientScreen(),
    home: (context) => const HomeScreen(),
    profile: (context) => const ProfileScreen(),
    events: (context) => const EventsScreen(),
    sertanejo: (context) => const SertanejoScreen(),
    error: (context) => const ErrorScreen(),
    Routes.escolha: (context) => const EscolhaScreen(),
    Routes.eventsContratante: (context) => const EventsContratanteScreen(),
  };
}
