import 'package:flutter/material.dart';
import '../../screens/splash/splash_screen.dart';
import '../../screens/auth/login_screen.dart';
import '../../screens/auth/register_screen.dart';
import '../../screens/onboarding/welcome_screen.dart';

/// AppRoutes defines all screen route names and their builders.
class AppRoutes {
  static const String splash    = '/';
  static const String login     = '/login';
  static const String register  = '/register';
  static const String onboarding = '/onboarding';
  static const String home      = '/home';
  static const String chat      = '/chat';

  static Map<String, WidgetBuilder> get routes {
    return {
      splash:   (context) => const SplashScreen(),
      login:    (context) => const LoginScreen(),
      register: (context) => const RegisterScreen(),
      // onboarding, home, chat → added in Phase 3

      onboarding: (context) =>  const WelcomeScreen(),

      // home, chat -> Phase 4
    };
  }
}
