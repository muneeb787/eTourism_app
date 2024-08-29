import 'package:etourism_app/Services/services.dart';
import 'package:etourism_app/models/hotel.model.dart';
import 'package:etourism_app/models/location.model.dart';
import 'package:etourism_app/models/place.model.dart';
import 'package:flutter/material.dart';

class HotelProvider with ChangeNotifier {
  final _service = Services();

  List<HotelModel> get hotels => _hotels;
  final List<HotelModel> _hotels = [];

  List<HotelModel> get hotelsByPlaces => _hotelsByPlaces;
  final List<HotelModel> _hotelsByPlaces = [];

  bool get isLoading => _isLoading;
  bool _isLoading = false;

  HotelModel get hotelDetail => _hotelDetail;
  late HotelModel _hotelDetail = HotelModel(managerId: "", name: "", location: LocationModel(address: "", city: "", state: "", country: "", latitude: 0, longitude: 0));

  Future<void> fetchHotels() async {
    print("Hotel func Calling");
    _isLoading = true;
    try {
      final dynamic data = await _service.fetchHotels();

      if (data is List<dynamic> && data.isNotEmpty) {
        final List<Map<String, dynamic>> dataList =
            List<Map<String, dynamic>>.from(data[0]['data']);

        _hotels.clear(); // Clear the list before adding new elements

        for (final Map<String, dynamic> element in dataList) {
          print("Hotel element  $element");
          _hotels.add(HotelModel.fromJson(element));
        }

        print("bodies ${_hotels.length}");
        _isLoading = false;
        notifyListeners();
      } else {
        throw Exception('Unexpected response format');
      }
    } catch (e) {
      _isLoading = false;
      // handle error
      print("An error occurred: $e");
      notifyListeners();
    }
  }

  Future<void> fetchHotelsByPlaces(String place) async {
    print("Hotel func Calling");
    _isLoading = true;
    try {
      final dynamic data = await _service.fetchHotelsByPlaces(place);

      if (data is List<dynamic> && data.isNotEmpty) {
        final List<Map<String, dynamic>> dataList =
            List<Map<String, dynamic>>.from(data[0]['data']);

        _hotelsByPlaces.clear(); // Clear the list before adding new elements

        for (final Map<String, dynamic> element in dataList) {
          print("Hotel element  $element");
          _hotelsByPlaces.add(HotelModel.fromJson(element));
        }

        print("bodies ${_hotels.length}");
        _isLoading = false;
        notifyListeners();
      } else {
        throw Exception('Unexpected response format');
      }
    } catch (e) {
      _isLoading = false;
      // handle error
      print("An error occurred: $e");
      notifyListeners();
    }
  }

  Future<void> fetchHotelByID(String id) async {
    print("Hotel func Calling");
    _isLoading = true;
    try {
      final dynamic data = await _service.fetchHotelByID(id);

      _hotelDetail = HotelModel.fromJson(data);
      print("object in fetchHotelByID: ${_hotelDetail}");
      _isLoading = false;
      notifyListeners();

    } catch (e) {
      _isLoading = false;
      // handle error
      print("An error occurred: $e");
      notifyListeners();
    }
  }
}
