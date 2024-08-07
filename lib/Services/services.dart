import 'dart:convert';
import 'package:etourism_app/models/user.model.dart';
import 'package:http/http.dart' as http;

var headers = <String, String>{
  "Accept": "application/json",
  "Content-Type": "application/json",
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Credentials": 'true',
  "Access-Control-Allow-Headers":
      "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
};

class Services {
  final String _baseUrl = "https://etourismapp-backend.onrender.com";

  Future<void> loginUser({
    required String email,
    required String password,
    required Function(User user, String token) onSuccess,
    required Function(String e) onError,
  }) async {
    print("object");
    try {
      var response = await http.post(
        Uri.parse(_baseUrl + "/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );
      dynamic responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print("responseData: $responseData");
        User user = User.fromJson(responseData['user']);
        print("user ${user.toJson()}");
        onSuccess(user, "${responseData['token']}");
      } else {
        print("responseData['message'] ${responseData['message']}");
        onError(responseData['message']);
      }
    } catch (e) {
      print("e $e");
      onError("An error occurred: $e");
    }
  }

  Future<void> registerUser({
    required String email,
    required String name,
    required String username,
    required String password,
    required Function(String message) onSuccess,
    required Function(String e) onError,
  }) async {
    print("object");
    try {
      var response = await http.post(
        Uri.parse(_baseUrl + "/register"),
        headers: headers,
        body: jsonEncode({
          'email': email,
          'Name': name,
          'userName': username,
          'password': password,
          'role': "user"
        }),
      );
      print('asdasdasd ${response.statusCode}');
      if (response.statusCode == 201) {
        dynamic responseData = await jsonDecode(response.body);
        print(responseData);
        print(responseData['message']);
        onSuccess(responseData['message'] ?? "");
      } else {
        dynamic responseData = await jsonDecode(response.body);
        for (final errorKey in responseData['data'].keys) {
          final List<dynamic> errorList = responseData['data'][errorKey];
          if (errorList.isNotEmpty) {
            print("First error: ${errorList[0]}");
            onError(errorList[0]);
          }
        }
      }
    } catch (e) {
      onError("An error occurred: $e");
    }
  }

  Future<void> fetchPlaces({
    required String email,
    required String name,
    required String username,
    required String password,
    required Function(String message) onSuccess,
    required Function(String e) onError,
  }) async {
    print("object");
    try {
      var response = await http.post(
        Uri.parse(_baseUrl + "/register"),
        headers: headers,
        body: jsonEncode({
          'email': email,
          'Name': name,
          'userName': username,
          'password': password,
          'role': "user"
        }),
      );
      print('asdasdasd ${response.statusCode}');
      if (response.statusCode == 201) {
        dynamic responseData = await jsonDecode(response.body);
        print(responseData);
        print(responseData['message']);
        onSuccess(responseData['message'] ?? "");
      } else {
        dynamic responseData = await jsonDecode(response.body);
        for (final errorKey in responseData['data'].keys) {
          final List<dynamic> errorList = responseData['data'][errorKey];
          if (errorList.isNotEmpty) {
            print("First error: ${errorList[0]}");
            onError(errorList[0]);
          }
        }
      }
    } catch (e) {
      onError("An error occurred: $e");
    }
  }
}
