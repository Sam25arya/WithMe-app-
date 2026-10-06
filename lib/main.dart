import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'core/theme/app_theme.dart';
import 'core/routes/app_routes.dart';
import 'core/constants/app_strings.dart';

/// The main entrypoint of the With Me application.
/// Firebase is initialized before the app launches.
void main() async {
  // Required when calling async code before runApp
  WidgetsFlutterBinding.ensureInitialized();

  // Connect to Firebase using auto-generated config
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const WithMeApp());
}

/// WithMeApp sets up the core application configuration:
/// - Title and Theme
/// - Initial Route (Splash → Login)
/// - Route navigation map
class WithMeApp extends StatelessWidget {
  const WithMeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.routes,
    );
  }
}

/// Backward-compatible alias for earlier smoke tests and app entry usage.
typedef MyApp = WithMeApp;
