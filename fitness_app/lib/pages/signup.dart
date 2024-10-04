import 'package:FitnessApp/utils/colors.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:FitnessApp/services/auth_service.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  Map<String, dynamic>? localizedStrings;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadLocalizedStrings();
  }

  Future<void> _loadLocalizedStrings() async {
    String jsonString = await rootBundle.loadString('assets/json/signup.json');
    setState(() {
      localizedStrings = json.decode(jsonString);
    });
  }

  void signUserUp() async {
  // Show loading dialog while signing up
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    // Check if passwords are not the same
    if (passwordController.text != confirmPasswordController.text) {
      Navigator.pop(context); // Close loading dialog
        detailError('Password Mismatch', 'The passwords you entered do not match. Please try again.');
        return;
    } else {
      try {
        // Attempt to sign up with email and password
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        Navigator.pop(context); // Close loading dialog
        Navigator.pushReplacementNamed(context, '/home'); // Navigate to home
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context); // Close loading dialog

        // Log the error
        print("FirebaseAuth Exception: ${e.message}, Code: ${e.code}");

        // Handle specific error with email and password
        if (e.code == 'invalid-email' || e.code == 'channel-error') {
          detailError('Signup Failed', 'Please check if the entered email is correct and try again.'); // Show the popup for invalid email
        } else if (e.code == 'weak-password') {
          detailError('Weak Password', 'Your password must be at least 6 characters long. Please choose a stronger password.'); // Show the popup for weak password
        } else if (e.code == 'email-already-in-use') {
          detailError('Email already in use', 'This email address is already in use. Please choose a different email.'); // Show the popup for email already in use
        } else {
          // Handle other Firebase exceptions
          detailError('Unknown Error', 'An unexpected error occurred. Please try again later.'); // Show the popup for unknown error
        }
      } catch (e) {
        // Handle any other errors
        Navigator.pop(context); // Close loading dialog
        print("Unknown error occurred: $e");
        detailError('Unknown Error', 'An unexpected error occurred. Please try again later.'); // Show the popup for unknown error
      }
    }
  }
  
  //Show Error Popup
  void detailError(title, message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (localizedStrings == null) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  localizedStrings!['signup_title'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                SizedBox(height: 40),
                TextField(
                  decoration: InputDecoration(
                    labelText: localizedStrings!['name_label'],
                    labelStyle: TextStyle(
                      color: AppColors.medium,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.lightlight),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: localizedStrings!['email_label'],
                    labelStyle: TextStyle(
                      color: AppColors.medium,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.lightlight),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: localizedStrings!['password_label'],
                    labelStyle: TextStyle(
                      color: AppColors.medium,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.lightlight),
                    ),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                TextField(
                  controller: confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: localizedStrings!['confirm_password_label'],
                    labelStyle: TextStyle(
                      color: AppColors.medium,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.lightlight),
                    ),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.dark,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    signUserUp();
                  },
                  child: Text(
                    localizedStrings!['signup_button'],
                    style: TextStyle(fontSize: 18, color: AppColors.white),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  localizedStrings!['or_text'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.light,
                      fontSize: 16),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {

                      },
                      icon: Icon(Icons.facebook),
                    ),
                    IconButton(
                      onPressed: () async {
                        await AuthService().signInWithGoogle(context);
                      },
                      icon: Icon(Icons.g_mobiledata),
                    ),
                    IconButton(
                      onPressed: () {

                      },
                      icon: Icon(Icons.apple),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    localizedStrings!['already_account_text'],
                    style: TextStyle(
                      color: AppColors.light,
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
