import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  Future<String?> fetchString(String token) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    return sharedPreferences.getString(token);
  }

  Future saveString(String token, String value) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(token, value);
  }
}
