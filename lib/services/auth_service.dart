import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
  try {
    await _googleSignIn.signOut(); // Clears previous session
    try {
      await _googleSignIn.disconnect(); // Try to remove cached account
    } catch (e) {
      print("Google disconnect failed: $e");
    }

    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return null;

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    return userCredential.user;
  } catch (e) {
    print("Google sign-in error: $e");
    return null;
  }
}

  Future<void> signOut() async {
  try {
    await _auth.signOut();
    await _googleSignIn.signOut();
    await _googleSignIn.disconnect();
  } catch (e) {
    print("Google disconnect failed: $e");
  }
}


  User? get currentUser => _auth.currentUser;
}
