import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodel/home/home_viewmodel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<HomeViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Dashboard', style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.black),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
        elevation: 0,
      ),
      body: Center(
        child: Text('Welcome, ${vm.user?.displayName ?? "User"}!'),
      ),
    );
  }
}
