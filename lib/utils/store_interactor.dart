import 'package:shared_preferences/shared_preferences.dart';

class StoreInteractor {
  static const _tokenKey = 'TOKEN';

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_tokenKey, token);
  }
}
