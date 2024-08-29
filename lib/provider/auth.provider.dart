import 'package:etourism_app/Utils/check_connectivity.dart';
import 'package:etourism_app/Utils/shared_prefs.dart';
import 'package:etourism_app/Utils/toast.dart';
import 'package:etourism_app/models/user.model.dart';
import 'package:etourism_app/provider/customBottomNavBar.provider.dart';
import 'package:etourism_app/screens/login.screen.dart';
import 'package:etourism_app/screens/main_activity.screen.dart';
import 'package:etourism_app/screens/welcome.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

import '../Services/services.dart';

class AuthProvider with ChangeNotifier {
  bool get isLoading => _isLoading;
  bool get isButtonLoading => _isButtonLoading;

  bool _isLoading = false;
  bool _isButtonLoading = false;

  late String error;
  final _service = Services();

  User _userData = new User(id: '', username: '', email: '', name: '');
  User get userData => _userData;

  Future<void> checkLoginStatus(BuildContext context) async {
    final token = await SharedPrefs.instance.getToken() ?? "";
    print("token -- $token");
    if (token != "") {
      User? user = await SharedPrefs.instance.getUserFromSharedPreferences();
      print("userFirstObject : ${user?.toJson()}");
      _userData = user ?? User(id: '', username: '', email: '', name: '');
      print("objectobjectobject : ${_userData.toJson()}");
      Internet().checkInternetConnectivity().then(
            (value) => {
              if (value)
                {
                  print("object in test ${_userData.toJson()}"),
                  Navigator.pushNamed(context, MainActivity.pageName)
                }
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
        _userData = user;
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

  Future<void> logoutUser({
    required BuildContext context,
  }) async {
    error = '';
    context.loaderOverlay.show();
    notifyListeners();

    // Save user information to SharedPreferences (if needed)
    SharedPrefs.instance.removeUserFromSharedPreferences();
    SharedPrefs.instance.setToken(token: '');
    // Display a toast for successful logout
    CustomToast().toastMessage(
      errorMsg: "Logout Successfully",
      bgColor: Colors.green,
    );

    // Reset loading state and navigate to the main activity
    context.loaderOverlay.hide();
    Provider.of<BottomNavBarProvider>(context, listen: false)
        .changeCurrentIndex(0);
    Navigator.pushReplacementNamed(context, LoginScreen.pageName);
    notifyListeners();
  }

  Future<void> updateUserImage(bool removeImage) async {
    String error = '';
    _isLoading = true;
    notifyListeners();

    try {
      if (removeImage) {
        // Case: Remove the image
        await _service.updateUserImage(
          onSuccess: (User user, String message) async {
            CustomToast()
                .toastMessage(errorMsg: message, bgColor: Colors.green);
            _userData = user;
            SharedPrefs.instance.saveUserToSharedPreferences(user);
            _isLoading = false;
            notifyListeners();
          },
          onError: (e) {
            _isLoading = false;
            error = e.toString();
            CustomToast().toastMessage(errorMsg: error, bgColor: Colors.red);
            notifyListeners();
          },
          imageUrl: "", // Use empty string to indicate removal
        );
      } else {
        // Case: Update the image
        final picker = ImagePicker();
        final pickedFile = await picker.pickImage(source: ImageSource.gallery);

        if (pickedFile != null) {
          final imageUrl = await _service.uploadImageToCloudinary(pickedFile);

          if (imageUrl != null && imageUrl.isNotEmpty) {
            await _service.updateUserImage(
              onSuccess: (User user, String message) async {
                CustomToast()
                    .toastMessage(errorMsg: message, bgColor: Colors.green);
                _userData = user;
                SharedPrefs.instance.saveUserToSharedPreferences(user);
                _isLoading = false;
                notifyListeners();
              },
              onError: (e) {
                _isLoading = false;
                error = e.toString();
                CustomToast().toastMessage(errorMsg: error, bgColor: Colors.red);
                notifyListeners();
              },
              imageUrl: imageUrl,
            );
          } else {
            // Handle case where imageUrl is null or empty
            _isLoading = false;
            error = 'Image upload failed.';
            CustomToast().toastMessage(errorMsg: error, bgColor: Colors.red);
            notifyListeners();
          }
        } else {
          // Handle case where no file was selected
          _isLoading = false;
          error = 'No image selected.';
          CustomToast().toastMessage(errorMsg: error, bgColor: Colors.red);
          notifyListeners();
        }
      }
    } catch (e) {
      _isLoading = false;
      error = e.toString();
      CustomToast().toastMessage(errorMsg: error, bgColor: Colors.red);
      notifyListeners();
    }
  }

  Future<void> updateProfileData({
    required String name,
    required String username,
    required BuildContext context,
  }) async {
    error = '';
    _isButtonLoading = true;
    context.loaderOverlay.show();
    notifyListeners();
    await _service.updateProfileData(
      name: name,
      username: username,
      onSuccess: (user, message) async {
        print("authProvider $user");
        _userData = user;
        SharedPrefs.instance.saveUserToSharedPreferences(user);
        final userData =
        await SharedPrefs.instance.getUserFromSharedPreferences();
        print("userData: $userData");
        CustomToast().toastMessage(
            errorMsg: message, bgColor: Colors.green);
        _isButtonLoading = false;
        Navigator.pop(context);
        notifyListeners();
        context.loaderOverlay.hide();
      },
      onError: (e) {
        _isButtonLoading = false;
        error = e.toString();
        CustomToast().toastMessage(errorMsg: error, bgColor: Colors.red);
        notifyListeners();
        context.loaderOverlay.hide();
      },
    );
  }

  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
    required BuildContext context,
  }) async {
    error = '';
    _isButtonLoading = true;
    context.loaderOverlay.show();
    notifyListeners();
    await _service.updatePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
      onSuccess: (message) async {
        CustomToast().toastMessage(
            errorMsg: message, bgColor: Colors.green);
        _isButtonLoading = false;
        Navigator.pop(context);
        notifyListeners();
        context.loaderOverlay.hide();
      },
      onError: (e) {
        _isButtonLoading = false;
        error = e.toString();
        CustomToast().toastMessage(errorMsg: error, bgColor: Colors.red);
        notifyListeners();
        context.loaderOverlay.hide();
      },
    );
  }

}
