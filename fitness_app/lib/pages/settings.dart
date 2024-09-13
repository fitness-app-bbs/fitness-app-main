import 'package:flutter/material.dart';
import 'package:FitnessApp/utils/colors.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: AppColors.white,
      ),
      body: Center(
        child: Text('Settings are comming soon'),
      ),
    );
  }
}
