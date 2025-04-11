import 'package:flutter/material.dart';
import '../view/onboarding/onboarding_screen.dart';

class AppRoutes {
  static const String onboarding = '/onboarding';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      default:
        return MaterialPageRoute(builder: (_) => const Scaffold(
              body: Center(child: Text("No route defined")),
            ));
    }
  }
}
