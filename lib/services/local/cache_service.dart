import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static SharedPreferencesService? _instance;
  late SharedPreferences sharedPreferences;

  factory SharedPreferencesService() {
    _instance ??= SharedPreferencesService._();
    return _instance!;
  }

  SharedPreferencesService._();

  Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<bool> saveBoolValue({
    required String key,
    required bool value,
  }) async {
    return await sharedPreferences.setBool(key, value);
  }

  bool getBoolValue({
    required String key,
    bool defaultValue = false,
  }) {
    return sharedPreferences.getBool(key) ?? defaultValue;
  }

  Future<bool> removeBoolValue({
    required String key,
  }) async {
    return await sharedPreferences.remove(key);
  }
}
