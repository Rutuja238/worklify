import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worklify_app/widgets/animated_video_widget.dart';
import '../../viewmodel/onboarding/onboarding_viewmodel.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<OnboardingViewModel>(context);
    final data = vm.onboardingData;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Spacer(),
            Text(
              data.title,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                data.subtitle,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30),
            AnimatedVideoWidget(
              videoAssetPath: 'assets/animation/splash_animation.mp4',
              height: 280,
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.deepOrange,
                  ),
                  onPressed: () {
                    final vm = Provider.of<OnboardingViewModel>(
                      context,
                      listen: false,
                    );
                    vm.handleGoogleSignIn(context);
                  },
                  child: const Text('Sign up', style: TextStyle(fontSize: 18)),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
