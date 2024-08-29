import 'package:geocoding/geocoding.dart';

Future<Map<String, String>> getLocationDetailsFromLatLng(double latitude, double longitude) async {
  try {
    List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);

    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[0];
      return {
        'name': place.name ?? '',
        'street': place.street ?? '',
        'locality': place.locality ?? '',
        'subLocality': place.subLocality ?? '',
        'administrativeArea': place.administrativeArea ?? '',
        'country': place.country ?? ''
      };
    } else {
      return {
        'error': 'No location data'
      };
    }
  } catch (e) {
    print('Error in getAddressFromLatLng: $e');
    return {
      'error': 'Error fetching location'
    };
  }
}
