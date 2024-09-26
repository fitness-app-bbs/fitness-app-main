import 'package:flutter/material.dart';
import 'package:FitnessApp/utils/colors.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Map<String, dynamic>? localizedStrings;

  @override
  void initState() {
    super.initState();
    _loadLocalizedStrings();
  }

  Future<void> _loadLocalizedStrings() async {
    String jsonString = await rootBundle.loadString('assets/json/login.json');
    setState(() {
      localizedStrings = json.decode(jsonString);
    });
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
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  child: Text(
                    localizedStrings!['login_button_text'],
                    style: TextStyle(fontSize: 18, color: AppColors.white),
                  ),
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
