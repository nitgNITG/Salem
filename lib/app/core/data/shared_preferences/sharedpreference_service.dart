import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static SharedPreferencesService? _instance;
  static late final SharedPreferences _prefs;

  // Private constructor to create a singleton instance
  SharedPreferencesService._();

  // Getter to access the singleton instance
  static SharedPreferencesService get instance {
    return _instance ?? SharedPreferencesService._();
  }

  // Initialize SharedPreferences
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Get a string value from SharedPreferences
  String? getString(String key, {String? defaultValue}) {
    try {
      return _prefs.getString(key) ?? defaultValue;
    } catch (e) {
      return defaultValue;
    }
  }

  // Set a string value in SharedPreferences
  Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  // Get an int value from SharedPreferences
  int? getInt(String key, {int? defaultValue}) {
    return _prefs.getInt(key) ?? defaultValue;
  }

  // Set an int value in SharedPreferences
  Future<void> setInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  Future<bool> clear() async {
    final boo = await _prefs.clear();
    return boo;
  }

  // Get a boolean value from SharedPreferences
  bool? getBool(String key, {bool? defaultValue}) {
    return _prefs.getBool(key) ?? defaultValue;
  }

  // Set a boolean value in SharedPreferences
  Future<void> setBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  // Clear a value from SharedPreferences
  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }

  Future<Map<String, dynamic>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();

    // Retrieve user data from SharedPreferences
    int userId = prefs.getInt('userId') ?? 0; // Default to 0 if not found
    String firstName = prefs.getString('firstName') ?? '';
    String lastName = prefs.getString('lastName') ?? '';
    String email = prefs.getString('email') ?? '';
    String token = prefs.getString('token') ?? '';
    String have_wallet = prefs.getString('have_wallet') ?? '';
    String wallet_uuid = prefs.getString('wallet_uuid') ?? '';

    // Print retrieved values
    print('Retrieved from Shared Preferences:');
    print('User ID: $userId');
    print('First Name: $firstName');
    print('Last Name: $lastName');
    print('Email: $email');
    print('Token: $token');
    print('wallet_uuid: $wallet_uuid');

    // Return as a map
    return {
      'userId': userId,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'token': token,
      'have_wallet':have_wallet,
      'wallet_uuid':wallet_uuid,
    };
  }
}
