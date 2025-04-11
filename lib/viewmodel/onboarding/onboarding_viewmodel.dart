import 'package:flutter/material.dart';
import 'package:worklify_app/services/auth_service.dart';
import '../../../models/onboarding_model.dart';

class OnboardingViewModel with ChangeNotifier {
  final OnboardingModel onboardingData = OnboardingModel(
    title: 'Worklify 🚀✅',
    subtitle: 'Struggling to stay organized?\nLet us help you get it done!!',
    imageAsset: 'assets/images/white.jpg', // Replace later
  );
  final AuthService _authService = AuthService();

  Future<void> handleGoogleSignIn(BuildContext context) async {
    final user = await _authService.signInWithGoogle();
    if (user != null) {
      // Navigate to Home or next screen
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Sign-in failed")),
      );
    }
  }
}
