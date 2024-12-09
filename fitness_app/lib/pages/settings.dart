import 'package:flutter/material.dart';
import 'package:FitnessApp/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class SettingsPage extends StatelessWidget {
  final VoidCallback onBack;

  SettingsPage({required this.onBack});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    final brightness = Theme.of(context).brightness;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor(brightness),
      appBar: AppBar(
        title: Text(
          appState.translationManager.translate('settings'),
          style: TextStyle(color: AppColors.textColor(brightness)),
        ),
        backgroundColor: AppColors.backgroundColor(brightness),
        iconTheme: IconThemeData(color: AppColors.textColor(brightness)),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: onBack,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Profile Section
            ListTile(
              leading: Icon(Icons.person, color: AppColors.medium),
              title: Text(appState.translationManager.translate('profile')),
              subtitle: Text(appState.translationManager.translate('edit_your_info')),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {},
            ),
            Divider(),

            // Notifications Section
            SwitchListTile(
              title: Text(appState.translationManager.translate('notifications')),
              subtitle: Text(appState.translationManager.translate('enable_or_disable_notifications')),
              value: false,
              activeColor: AppColors.medium,
              onChanged: (bool value) {},
            ),
            Divider(),

            // Dark Mode Section
            SwitchListTile(
              title: Text(appState.translationManager.translate('Dark Mode')),
              subtitle: Text(appState.translationManager.translate('dark_mode_desc')),
              value: appState.themeMode == ThemeMode.dark,
              activeColor: AppColors.medium,
              onChanged: (bool value) {
                appState.toggleThemeMode();
              },
            ),
            Divider(),

            // Language Section
            ListTile(
              leading: Icon(Icons.language, color: AppColors.medium),
              title: Text(appState.translationManager.translate('language')),
              subtitle: Text(appState.translationManager.translate('change_language')),
              trailing: DropdownButton<String>(
                value: appState.locale.languageCode,
                items: [
                  DropdownMenuItem(value: 'en', child: Text('English')),
                  DropdownMenuItem(value: 'de', child: Text('Deutsch')),
                ],
                onChanged: (String? newLanguage) {
                  if (newLanguage != null) {
                    appState.changeLocale(newLanguage);
                  }
                },
              ),
            ),
            Divider(),

            // Privacy and Security Section
            ListTile(
              leading: Icon(Icons.lock, color: AppColors.medium),
              title: Text(appState.translationManager.translate('privacy_security')),
              subtitle: Text(appState.translationManager.translate('privacy_settings')),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {},
            ),
            Divider(),

            // Help and Support Section
            ListTile(
              leading: Icon(Icons.help_outline, color: AppColors.medium),
              title: Text(appState.translationManager.translate('help_support')),
              subtitle: Text(appState.translationManager.translate('contact_us')),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {},
            ),
            Divider(),

            // App Version Section
            ListTile(
              leading: Icon(Icons.info_outline, color: AppColors.medium),
              title: Text('App Version'),
              subtitle: Text('0.1.27'),
              onTap: () {},
            ),
            Divider(),

            // Logout Button
            ListTile(
              leading: Icon(Icons.exit_to_app, color: AppColors.red),
              title: Text(appState.translationManager.translate('logout')),
              onTap: () {
                _showLogoutConfirmationDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Logout'),
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, '/auth');
              },
            ),
          ],
        );
      },
    );
  }
}
