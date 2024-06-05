

import 'package:etourism_app/Utils/shared_prefs.dart';
import 'package:etourism_app/Utils/toast.dart';
import 'package:flutter/material.dart';

import '../Services/services.dart';

class AuthProvider with ChangeNotifier {
  bool get isLoading => _isLoading;
  bool get isButtonLoading => _isButtonLoading;

  final bool _isLoading = false;
  bool _isButtonLoading = false;

  late String error;
  final _service = Services();

  Future<void> loginUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    error = '';
    _isButtonLoading = true;
    notifyListeners();
    await _service.loginUser(
      email: email,
      password: password,
      onSuccess: (user, token) async {
        print("authProvider $user");
        SharedPrefs.instance.saveUserToSharedPreferences(user);
        final userData =
            await SharedPrefs.instance.getUserFromSharedPreferences();
        print("userData: $userData");
        SharedPrefs.instance.setToken(token: token);
        CustomToast().toastMessage(
            errorMsg: "Login Successfully", bgColor: Colors.green);
        _isButtonLoading = false;
        // Navigator.pushReplacementNamed(context, MainActivity.pageName);
        notifyListeners();
      },
      onError: (e) {
        _isButtonLoading = false;
        error = e.toString();
        CustomToast().toastMessage(errorMsg: error, bgColor: Colors.red);
        notifyListeners();
      },
    );
  }

  Future<void> registerUser({
    required String email,
    required String password,
    required BuildContext context,
    required String username,


  }) async {
    error = '';
    _isButtonLoading = true;
    notifyListeners();
    await _service.registerUser(

      email: email,
      username: username,

      password: password,

      onSuccess: (user, token , message) async {
        print("authProvider $user");
        SharedPrefs.instance.saveUserToSharedPreferences(user);
        final userData = await SharedPrefs.instance.getUserFromSharedPreferences();
        print("userData: $userData");
        SharedPrefs.instance.setToken(token: token);
        CustomToast().toastMessage(
            errorMsg: message, bgColor: Colors.green);
        _isButtonLoading = false;
        notifyListeners();
        // Navigator.pushReplacementNamed(context, AddOrganizationScreen.pageName);
      },
      onError: (e) {
        _isButtonLoading = false;
        error = e.toString();
        CustomToast().toastMessage(errorMsg: error, bgColor: Colors.red);
        notifyListeners();
      },
    );
  }
}