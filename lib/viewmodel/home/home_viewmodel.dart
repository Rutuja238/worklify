import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeViewModel with ChangeNotifier {
  final User? user = FirebaseAuth.instance.currentUser;
}
