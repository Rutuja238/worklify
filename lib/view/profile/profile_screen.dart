import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
          children: [
            const Icon(Icons.account_circle, size: 100),
            const SizedBox(height: 24),
            Text("Name: ${user?.displayName ?? "N/A"}", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 12),
            Text("Email: ${user?.email ?? "N/A"}", style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
