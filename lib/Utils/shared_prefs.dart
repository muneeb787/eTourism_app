import 'dart:convert';

import 'package:etourism_app/Models/user.model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SharedPrefs {
  static final instance = SharedPrefs();

  Future<void> saveUserToSharedPreferences(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user', jsonEncode(user.toJson()));
  }

  Future<User?> getUserFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('user');
    print("sadasd  $userData");
    if (userData != null) {
      Map<String, dynamic> userMap = jsonDecode(userData);
      return User.fromJson(userMap);
    }

    return null;
  }

  Future setToken({required String token}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("token", token);
  }

  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }
}