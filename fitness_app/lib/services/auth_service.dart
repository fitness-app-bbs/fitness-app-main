import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart'; // Required for Navigator
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      // Trigger the Google Sign-In flow
      final GoogleSignInAccount? gUser = await _googleSignIn.signIn();
      if (gUser == null) {
        // User canceled the sign-in process
        return;
      }

      // Obtain the authentication details from the request
      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      // Create a new credential using the tokens
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      // Sign in to Firebase with the created credentials
      await _auth.signInWithCredential(credential);

      Navigator.pop(context); // Close loading dialog

      // Navigate to the home page after a successful login
      Navigator.pushReplacementNamed(context, '/auth');
    } catch (e) {
      print('Error during Google Sign-In: $e');
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
