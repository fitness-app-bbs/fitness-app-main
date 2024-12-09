import 'dart:convert';
import 'package:flutter/services.dart';

class TranslationManager {
  final Map<String, dynamic> _localizedStrings = {};

  Future<void> load(String languageCode) async {
    try {
      final String jsonString =
      await rootBundle.loadString('assets/json/l10n/$languageCode.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      _localizedStrings.clear();
      _localizedStrings.addAll(jsonMap);
    } catch (e) {
      print("Error loading translation for $languageCode: $e");
    }
  }

  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }
}
