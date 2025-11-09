import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../features/pre_launch/presentation/screens/pre_launch_screen.dart';

// Basic routing configuration
final routerProvider = Provider<Router>((ref) {
  return Router();
});

// Placeholder screens
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

// Simple router class
class Router {
  void goToHome(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const PreLaunchScreen(),
        settings: const RouteSettings(name: '/home'),
      ),
    );
  }
  
  void goToSplash(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const SplashScreen(),
        settings: const RouteSettings(name: '/splash'),
      ),
    );
  }
}
