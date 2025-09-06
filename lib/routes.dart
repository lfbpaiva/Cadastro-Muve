import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_choice_screen.dart';
import 'screens/register_user_screen.dart';
import 'screens/register_client_screen.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';

class Routes {
  static const splash = '/';
  static const login = '/login';
  static const registerChoice = '/register_choice';
  static const registerUser = '/register_user';
  static const registerClient = '/register_client';
  static const home = '/home';
  static const profile = '/profile'; // <-- nova rota

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splash: (context) => const SplashScreen(),
      login: (context) => const LoginScreen(),
      registerChoice: (context) => const RegisterChoiceScreen(),
      registerUser: (context) => const RegisterUserScreen(),
      registerClient: (context) => const RegisterClientScreen(),
      home: (context) => const HomeScreen(),
      profile: (context) => const ProfileScreen(), // <-- mapeamento do Perfil
    };
  }
}
