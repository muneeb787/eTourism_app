import 'package:etourism_app/Services/services.dart';
import 'package:etourism_app/Utils/toast.dart';
import 'package:etourism_app/models/hotel.model.dart';
import 'package:etourism_app/models/location.model.dart';
import 'package:etourism_app/models/place.model.dart';
import 'package:etourism_app/screens/main_activity.screen.dart';
import 'package:flutter/material.dart';

class BookingProvider with ChangeNotifier {
  final _service = Services();
  late String error;

  bool get isLoading => _isLoading;
  bool _isLoading = false;

  Future<void> requestBooking(BuildContext context, Map<String, dynamic> bookingDetails) async {
    _isLoading = true;
    notifyListeners();
    await _service.requestBooking(
      bookingDetails: bookingDetails,
      onSuccess: (message) async {
        CustomToast().toastMessage(errorMsg: message, bgColor: Colors.green);
        _isLoading = false;
        notifyListeners();
        Navigator.pushReplacementNamed(context, MainActivity.pageName);
      },
      onError: (e) {
        _isLoading = false;
        error = e.toString();
        CustomToast().toastMessage(errorMsg: error, bgColor: Colors.red);
        notifyListeners();
      },
    );
  }
}
