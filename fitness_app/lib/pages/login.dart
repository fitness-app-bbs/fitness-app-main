import 'package:flutter/material.dart';
import 'package:FitnessApp/utils/colors.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:FitnessApp/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Map<String, dynamic>? localizedStrings;
  Map<String, dynamic>? loginUser;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadLocalizedStrings();
    _loadLoginUser();
  }

  Future<void> _loadLocalizedStrings() async {
    String jsonString = await rootBundle.loadString('assets/json/login.json');
    setState(() {
      localizedStrings = json.decode(jsonString);
    });
  }

  Future<void> _loadLoginUser() async {
    String credentialsString = await rootBundle.loadString('assets/json/user.json');
    setState(() {
      loginUser = json.decode(credentialsString);
    });
  }

  void signUserIn() async {
  // Show loading dialog while signing in
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      // Attempt to sign in with email and password
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.pop(context); // Close loading dialog
      Navigator.pushReplacementNamed(context, '/auth'); // Navigate to home
      // Catch FirebaseAuth exceptions
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context); // Close loading dialog

      // Log the error
      print("FirebaseAuth Exception: ${e.message}, Code: ${e.code}");

      // Show error dialog if email is not found or password is incorrect
      if (e.code == 'invalid-email' || e.code == 'invalid-credential' || e.code == 'channel-error') {
        detailError('Login Failed', 'The email or password you entered is incorrect. Please try again.'); // Show the popup for incorrect login details
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
    if (localizedStrings == null || loginUser == null) {
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
                Image.asset(
                  localizedStrings!['logo_path'],
                  height: 200,
                ),
                SizedBox(height: 20),
                Text(
                  localizedStrings!['welcome_text'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                SizedBox(height: 40),
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
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.dark,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: signUserIn,
                  child: Text(
                    localizedStrings!['login_button_text'],
                    style: TextStyle(fontSize: 18, color: AppColors.white),
                  ),
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
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: Text(
                    localizedStrings!['signup_text'],
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
