import 'package:etourism_app/Services/services.dart';
import 'package:etourism_app/models/hotel.model.dart';
import 'package:etourism_app/models/place.model.dart';
import 'package:flutter/material.dart';


class PlacesProvider with ChangeNotifier {
  final _service = Services();

  List<PlaceModel> get places => _places;
  final List<PlaceModel> _places = [];

  List<PlaceModel> get placesByCategory => _placesByCategory;
  final List<PlaceModel> _placesByCategory = [];



  bool get isLoading => _isLoading;
  bool _isLoading = false;



  Future<void> fetchPlaces() async {
    _isLoading = true;
    try {
      final dynamic data = await _service.fetchPlaces();

      if (data is List<dynamic> && data.isNotEmpty) {
        final List<Map<String, dynamic>> dataList =
            List<Map<String, dynamic>>.from(data[0]['data']);

        places.clear(); // Clear the list before adding new elements
        print("datalist $dataList");
        for (final Map<String, dynamic> element in dataList) {
          _places.add(PlaceModel.fromJson(element));
        }
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

  Future<void> fetchPlacesByCategory(String category) async {
    _isLoading = true;
    try {
      print("object in fetchPlacesByCategory");
      final dynamic data = await _service.fetchPlacesByCategory(category);

      if (data is List<dynamic> && data.isNotEmpty) {
        final List<Map<String, dynamic>> dataList =
            List<Map<String, dynamic>>.from(data[0]['data']);

        _placesByCategory.clear(); // Clear the list before adding new elements

        for (final Map<String, dynamic> element in dataList) {
          _placesByCategory.add(PlaceModel.fromJson(element));
        }
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
}
