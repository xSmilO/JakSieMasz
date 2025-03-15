import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  SharedPreferencesService();

  Future<String?> fetchString(String token) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    return sharedPreferences.getString(token);
  }

  Future<void> saveString(String token, String value) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(token, value);
  }

  Future<void> deleteData() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();

    // set default values
    await saveString("ip_addr", "http://10.0.2.2:3000");
    await saveString("ai_name", "Stasiek");
  }
}
