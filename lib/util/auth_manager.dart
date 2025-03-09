import 'package:flutter/cupertino.dart';
import 'package:flutter_ecommerce_shop/di/di.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthManager {
  static final ValueNotifier<String?> authChangeNotifire = ValueNotifier(null);
  static final SharedPreferences _sharedPref = locator.get();

  static void saveToken(String token) async {
    _sharedPref.setString('access_token', token);
    authChangeNotifire.value = token;
  }

  static void saveID(String id) async {
    _sharedPref.setString('user_id', id);
    authChangeNotifire.value = id;
  }

  static String getID() {
    return _sharedPref.getString('user_id') ?? '';
  }

  static String readAuth() {
    return _sharedPref.getString('access_token') ?? '';
  }

  static void logOut() {
    _sharedPref.clear();
    authChangeNotifire.value = null;
  }

  static bool isLogIn() {
    String token = AuthManager.readAuth();
    return token.isEmpty;
  }
}
