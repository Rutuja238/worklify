import 'package:flutter/material.dart';
import '../view/onboarding/onboarding_screen.dart';
import '../view/home/home_screen.dart';
import '../view/profile/profile_screen.dart';

class AppRoutes {
  static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String profile = '/profile';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      default:
        return MaterialPageRoute(builder: (_) => const Scaffold(
              body: Center(child: Text("No route defined")),
            ));
    }
  }
}
