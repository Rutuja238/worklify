import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    String displayName = user?.displayName ?? "User";

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FF),
      appBar: AppBar(
        title: Text("Hi, $displayName!"),
         actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.black),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: Text(
          "Welcome, $displayName",
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _navIcon(Icons.home_outlined, 0),
            _navIcon(Icons.chat_bubble_outline, 1),
            _buildMiddleButton(), // Plus button
            _navIcon(Icons.calendar_today_outlined, 2),
            _navIcon(Icons.person_outline, 3),
          ],
        ),
      ),
    );
  }

  Widget _navIcon(IconData icon, int index) {
    return IconButton(
      icon: Icon(
        icon,
        color: _selectedIndex == index ? Colors.deepPurple : Colors.grey,
        size: 26,
      ),
      onPressed: () {
        setState(() {
          _selectedIndex = index;
        });
      },
    );
  }

  Widget _buildMiddleButton() {
    return Container(
      height: 58,
      width: 58,
      decoration: const BoxDecoration(
        color: Colors.deepPurple,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: IconButton(
        icon: const Icon(Icons.add, color: Colors.white, size: 30),
        onPressed: () {
          // Handle add action
        },
      ),
    );
  }
}
