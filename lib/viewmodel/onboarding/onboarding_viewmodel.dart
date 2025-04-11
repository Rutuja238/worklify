import 'package:flutter/material.dart';
import '../../../models/onboarding_model.dart';

class OnboardingViewModel with ChangeNotifier {
  final OnboardingModel onboardingData = OnboardingModel(
    title: 'Worklify 🚀✅',
    subtitle: 'Struggling to stay organized?\nLet us help you get it done!!',
    imageAsset: 'assets/images/white.jpg', // Replace later
  );
}
