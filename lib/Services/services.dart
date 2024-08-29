import 'dart:convert';
import 'package:etourism_app/Utils/shared_prefs.dart';
import 'package:etourism_app/models/user.model.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

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
        print("😂😂😂: ${responseData}");
        onError(responseData['message']);
      }
    } catch (e) {
      onError("An error occurred: $e");
    }
  }

  Future<void> updateProfileData({
    required String name,
    required String username,
    required Function(User user, String message) onSuccess,
    required Function(String e) onError,
  }) async {
    final String token = await SharedPrefs.instance.getToken() ?? "";
    print("object");
    try {
      var response = await http.post(
        Uri.parse(_baseUrl + "/profileUpdate"),
        headers: {
          ...headers,
          'Authorization': "Bearer $token",
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "Name": name,
          "userName": username,
        }),
      );
      dynamic responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print("responseData: $responseData");
        User user = User.fromJson(responseData['data']);
        print("user ${user.toJson()}");
        onSuccess(user, "${responseData['message']}");
      } else {
        print("responseData['message'] ${responseData['message']}");
        onError(responseData['message']);
      }
    } catch (e) {
      print("e $e");
      onError("An error occurred: $e");
    }
  }

  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
    required Function(String message) onSuccess,
    required Function(String e) onError,
  }) async {
    final String token = await SharedPrefs.instance.getToken() ?? "";
    print("object");
    try {
      var response = await http.post(
        Uri.parse(_baseUrl + "/user/updatePassword"),
        headers: {
          ...headers,
          'Authorization': "Bearer $token",
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "currentPassword": currentPassword,
          "newPassword": newPassword,
          "confirmPassword": newPassword,
        }),
      );
      dynamic responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print("responseData: $responseData");
        onSuccess("${responseData['message']}");
      } else {
        print("responseData['message'] ${responseData['message']}");
        onError(responseData['message']);
      }
    } catch (e) {
      print("e $e");
      onError("An error occurred: $e");
    }
  }

  Future<List<Map<String, dynamic>>> fetchPlaces() async {
    try {
      var response =
          await http.get(Uri.parse(_baseUrl + "/places"), headers: headers);
      print(response.statusCode);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print("object ❤️❤️");
        // Ensure data is a List<Map<String, dynamic>> even if it's a single item
        return [if (data is Map<String, dynamic>) data else ...data];
      } else {
        dynamic responseData = await jsonDecode(response.body);
        throw Exception('FAILED TO LOAD Complaint Types');
      }
    } catch (e) {
      print("An error occurred: $e");
      throw Exception('FAILED TO LOAD Complaint Types');
    }
  }

  Future<List<Map<String, dynamic>>> fetchHotels() async {
    try {
      var response =
          await http.get(Uri.parse(_baseUrl + "/hotels"), headers: headers);
      print(response.statusCode);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Ensure data is a List<Map<String, dynamic>> even if it's a single item
        return [if (data is Map<String, dynamic>) data else ...data];
      } else {
        dynamic responseData = await jsonDecode(response.body);
        throw Exception('FAILED TO LOAD Complaint Types');
      }
    } catch (e) {
      print("An error occurred: $e");
      throw Exception('FAILED TO LOAD Complaint Types');
    }
  }

  Future<List<Map<String, dynamic>>> fetchHotelsByPlaces(String place) async {
    try {
      var response = await http.get(
          Uri.parse(_baseUrl + "/place/${place}/hotels-nearby"),
          headers: headers);
      print(response.statusCode);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Ensure data is a List<Map<String, dynamic>> even if it's a single item
        return [if (data is Map<String, dynamic>) data else ...data];
      } else {
        dynamic responseData = await jsonDecode(response.body);
        throw Exception('FAILED TO LOAD Complaint Types');
      }
    } catch (e) {
      print("An error occurred: $e");
      throw Exception('FAILED TO LOAD Complaint Types');
    }
  }

  Future<Map<String, dynamic>> fetchHotelByID(String id) async {
    try {
      var response = await http.get(Uri.parse(_baseUrl + "/hotel/${id}"),
          headers: headers);
      print(response.statusCode);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Ensure data is a List<Map<String, dynamic>> even if it's a single item
        print("object in service ${data['data']}");
        return data['data'];
      } else {
        dynamic responseData = await jsonDecode(response.body);
        throw Exception('FAILED TO LOAD Complaint Types');
      }
    } catch (e) {
      print("An error occurred: $e");
      throw Exception('FAILED TO LOAD Complaint Types');
    }
  }

  Future<List<Map<String, dynamic>>> fetchHotelsNearbyPlace(
      String placeId) async {
    try {
      var response = await http.get(
          Uri.parse(_baseUrl + "/place/${placeId}/hotels-nearby"),
          headers: headers);
      print(response.statusCode);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Ensure data is a List<Map<String, dynamic>> even if it's a single item
        return [if (data is Map<String, dynamic>) data else ...data];
      } else {
        dynamic responseData = await jsonDecode(response.body);
        throw Exception('FAILED TO LOAD Complaint Types');
      }
    } catch (e) {
      print("An error occurred: $e");
      throw Exception('FAILED TO LOAD Complaint Types');
    }
  }

  Future<List<Map<String, dynamic>>> fetchPlacesByCategory(
      String category) async {
    final String token = await SharedPrefs.instance.getToken() ?? "";
    try {
      var response = await http.get(
        Uri.parse(_baseUrl + "/places/category/${category.toLowerCase()}"),
        headers: headers..addAll({'Authorization': "Bearer $token"}),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Ensure data is a List<Map<String, dynamic>> even if it's a single item
        return [if (data is Map<String, dynamic>) data else ...data];
      } else {
        dynamic responseData = await jsonDecode(response.body);
        throw Exception('FAILED TO LOAD Complaint Types');
      }
    } catch (e) {
      print("An error occurred: $e");
      throw Exception('FAILED TO LOAD Complaint Types');
    }
  }

  Future<List<Map<String, dynamic>>> requestBooking({
    required Map<String, dynamic> bookingDetails,
    required Function(String message) onSuccess,
    required Function(String e) onError
  }) async {
    final String token = await SharedPrefs.instance.getToken() ?? "";
    try {
      var response = await http.post(
        Uri.parse(_baseUrl + "/booking/bookroom"),
        headers: {
          'Authorization': "Bearer $token",
          'Content-Type': 'application/json', // Ensure this header is set
        },
        body: json.encode(bookingDetails), // Encode the body as JSON
      );

      print(response.statusCode);
      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        onSuccess(data["message"]); // Call onSuccess callback
        return [if (data is Map<String, dynamic>) data else ...data];
      } else {
        dynamic responseData = json.decode(response.body);
        String errorMessage = responseData['message'] ?? 'Failed to request booking';
        onError(errorMessage); // Call onError callback
        throw Exception(errorMessage);
      }
    } catch (e) {
      print("An error occurred: $e");
      onError("An error occurred: $e"); // Call onError callback
      throw Exception('Failed to request booking');
    }
  }

  Future<void> updateUserImage({
    required String imageUrl,
    required Function(User user, String message) onSuccess,
    required Function(String e) onError,
  }) async {
    final String token = await SharedPrefs.instance.getToken() ?? "";
    try {
      var response = await http.post(
        Uri.parse(_baseUrl + "/user/updateProfilePic"),
        body: jsonEncode({
          'imageUrl': imageUrl,
        }),
        headers: {
          ...headers,
          'Authorization': "Bearer $token",
          'Content-Type': 'application/json',
        },
      );

      print(response.statusCode);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print("responseData: $data");

        // Ensure 'data' contains the 'user' and 'message' fields
        if (data != null && data['data'] != null && data['message'] != null) {
          User user = User.fromJson(data['data']);
          String message = data['message'];

          // Call onSuccess with the user and message
          onSuccess(user, message);
        } else {
          throw Exception('Invalid response format');
        }
      } else {
        // Handle error responses
        final responseData = json.decode(response.body);
        String errorMessage = responseData['message'] ?? 'Failed to update profile picture';
        onError(errorMessage);
      }
    } catch (e) {
      print("An error occurred: $e");
      onError('An error occurred: $e');
    }
  }

  Future<String?> uploadImageToCloudinary(XFile file) async {
    final formData = http.MultipartRequest('POST', Uri.parse('https://api.cloudinary.com/v1_1/de6y4p2ou/image/upload'));
    formData.fields['upload_preset'] = 'e-tourism';
    formData.files.add(await http.MultipartFile.fromPath('file', file.path));

    try {
      final response = await formData.send();
      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final decodedData = jsonDecode(responseData);
        return decodedData['secure_url'];
      } else {
        print('Image upload failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Image upload error: $error');
    }
    return null;
  }



}
