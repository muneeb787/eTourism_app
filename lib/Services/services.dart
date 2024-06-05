import 'dart:convert';

import 'package:etourism_app/Models/user.model.dart';
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
  final String _baseUrl = "https://etourismapp-backend.onrender.com/";

  Future<void> loginUser({
    required String email,
    required String password,
    required Function(User user, String token) onSuccess,
    required Function(String e) onError,
  }) async {
    print("object");
    try {
      var response = await http.post(
        Uri.parse(_baseUrl + "/user/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );
      dynamic responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        User user = User.fromJson(jsonDecode(response.body));
        onSuccess(user, "${responseData['data']['bearer_token']}");
      } else {
        onError(responseData['message']);
      }
    } catch (e) {
      onError("An error occurred: $e");
    }
  }

  Future<void> registerUser({
    required String email,
    required String password,
    required Function(User user, String token, String message) onSuccess,
    required Function(String e) onError,

    required String username,

  }) async {
    print("object");
    try {
      var response = await http.post(
        Uri.parse(_baseUrl + "/user"),
        headers: headers,
        body: jsonEncode({
          'email': email,
          'username': username,
          'password': password,

        }),
      );
      print('asdasdasd ${response.statusCode}');
      if (response.statusCode == 200) {
        dynamic responseData = await jsonDecode(response.body);

        print(responseData);
        User user = User.fromJson(jsonDecode(response.body));
        print(responseData['message']);
        onSuccess(user, "${responseData['data']['bearer_token']}",
            responseData['message'] ?? "");
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