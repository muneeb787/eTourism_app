import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationSelectionWidget extends StatefulWidget {
  final Function(LatLng, String) onLocationSelected;

  const LocationSelectionWidget({Key? key, required this.onLocationSelected})
      : super(key: key);

  @override
  _LocationSelectionWidgetState createState() =>
      _LocationSelectionWidgetState();
}

class _LocationSelectionWidgetState extends State<LocationSelectionWidget> {
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};

  // Default location set to Pakistan (Islamabad)
  static const LatLng _defaultLocation = LatLng(33.6844, 73.0479);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _defaultLocation,
              zoom: 5,
            ),
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
            },
            markers: _markers,
            onTap: _handleMapTap,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              if (_markers.isNotEmpty) {
                Navigator.of(context).pop();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text('Please select a location on the map')),
                );
              }
            },
            child: Text('Confirm Location'),
          ),
        ),
      ],
    );
  }

  void _handleMapTap(LatLng location) async {
    String address = await _getAddressFromLatLng(location);
    _updateSelectedLocation(location, address);
  }

  Future<String> _getAddressFromLatLng(LatLng location) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        location.latitude,
        location.longitude,
      );
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        return '${place.street}, ${place.locality}, ${place.country}';
      }
    } catch (e) {
      print('Error getting address: $e');
    }
    return 'Unknown location';
  }

  void _updateSelectedLocation(LatLng location, String address) {
    setState(() {
      _markers = {
        Marker(
          markerId: MarkerId('selected_location'),
          position: location,
          infoWindow: InfoWindow(title: address),
        ),
      };
    });
    _mapController?.animateCamera(CameraUpdate.newLatLngZoom(location, 10));
    widget.onLocationSelected(location, address);
  }
}