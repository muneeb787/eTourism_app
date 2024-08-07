import 'package:etourism_app/Utils/check_connectivity.dart';
import 'package:etourism_app/Utils/shared_prefs.dart';
import 'package:etourism_app/Utils/toast.dart';
import 'package:etourism_app/models/user.model.dart';
import 'package:etourism_app/screens/login.screen.dart';
import 'package:etourism_app/screens/main_activity.screen.dart';
import 'package:etourism_app/screens/welcome.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Services/services.dart';

class AuthProvider with ChangeNotifier {
  bool get isLoading => _isLoading;
  bool get isButtonLoading => _isButtonLoading;

  final bool _isLoading = false;
  bool _isButtonLoading = false;

  late String error;
  final _service = Services();

  User _userData = new User(id: '', username: '', email: '', name: '');

  Future<void> checkLoginStatus(BuildContext context) async {
    final token = await SharedPrefs.instance.getToken() ?? "";
    print("token -- $token");
    if (token != "") {
      final user = await SharedPrefs.instance.getUserFromSharedPreferences();
      print("userFirstObject : ${user?.toJson()}");
      _userData = user ?? User(id: '', username: '', email: '', name: '');
      print("objectobjectobject : ${_userData.toJson()}");
      Internet().checkInternetConnectivity().then(
            (value) => {
              if (value)
                {Navigator.pushNamed(context, MainActivity.pageName)}
              else
                {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      title: Text(
                        'No Internet Connection',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      content: Text(
                        'Please connect to the internet and try again.',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            // Close the application
                            SystemNavigator.pop();
                          },
                          child: Text('Ok'),
                        ),
                      ],
                    ),
                  )
                }
            },
          );
    } else {
      {
        Navigator.pushNamed(context, WelcomeScreen.pageName);
      }
    }
  }

  Future<void> loginUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    error = '';
    _isButtonLoading = true;
    print("in Login");
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
        Navigator.pushReplacementNamed(context, MainActivity.pageName);
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
    required String name,
    required String password,
    required BuildContext context,
    required String username,
  }) async {
    error = '';
    _isButtonLoading = true;
    notifyListeners();
    await _service.registerUser(
      email: email,
      name: name,
      username: username,
      password: password,
      onSuccess: (message) async {
        CustomToast().toastMessage(errorMsg: message, bgColor: Colors.green);
        _isButtonLoading = false;
        notifyListeners();
        Navigator.pushReplacementNamed(context, LoginScreen.pageName);
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
