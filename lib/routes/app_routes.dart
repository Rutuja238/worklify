import 'package:flutter/material.dart';
import 'package:worklify_app/view/task/add_task_screen.dart';
import '../view/onboarding/onboarding_screen.dart';
import '../view/home/home_screen.dart';
import '../view/profile/profile_screen.dart';

class AppRoutes {
  static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String addTask = '/add-task';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case addTask:
        return MaterialPageRoute(builder: (_) => const AddTaskScreen()); //
      default:
        return MaterialPageRoute(builder: (_) => const Scaffold(
              body: Center(child: Text("No route defined")),
            ));
    }
  }
}
