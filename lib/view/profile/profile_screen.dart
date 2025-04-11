import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:worklify_app/services/auth_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _logout(BuildContext context) async {
    await AuthService().signOut();
    Navigator.pushNamedAndRemoveUntil(context, '/onboarding', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(child: Icon(Icons.account_circle, size: 100)),
            const SizedBox(height: 24),
            Text("👤 Name: ${user?.displayName ?? "N/A"}", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 12),
            Text("📧 Email: ${user?.email ?? "N/A"}", style: const TextStyle(fontSize: 18)),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _logout(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text("Logout", style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
