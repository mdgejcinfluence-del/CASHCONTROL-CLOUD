
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';

class StorageService {
  static const String _pinKey = 'user_pin';
  static const String _isConfiguredKey = 'is_configured';

  // --- Gestion du PIN ---
  static Future<void> savePin(String pin) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_pinKey, pin);
  }

  static Future<String?> getPin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_pinKey);
  }

  // --- État de Configuration ---
  static Future<bool> isAppConfigured() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isConfiguredKey) ?? false;
  }

  static Future<void> setConfigured(bool status) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isConfiguredKey, status);
  }

  // --- Initialisation de Hive pour les données métier ---
  static Future<void> initDatabase() async {
    await Hive.initFlutter();
    // On ouvrira les boîtes (tables) pour les transactions et employés plus tard
    await Hive.openBox('business_data');
  }
}
