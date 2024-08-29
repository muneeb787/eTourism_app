import 'package:etourism_app/components/custom_Appbar.dart';
import 'package:etourism_app/models/location.model.dart';
import 'package:etourism_app/provider/hotels.provider.dart';
import 'package:etourism_app/screens/hotelView.screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../models/hotel.model.dart';
// import 'hotel_details_page.dart'; // Assuming this is your hotel details page

class PlacesOnMap extends StatefulWidget {
  final LocationModel location;
  final String place_id;

  const PlacesOnMap(
      {super.key, required this.location, required this.place_id});

  @override
  State<PlacesOnMap> createState() => _PlacesOnMapState();
}

class _PlacesOnMapState extends State<PlacesOnMap> {
  late GoogleMapController _mapController;
  Set<Marker> _markers = {};
  late BitmapDescriptor _hotelIcon;

  @override
  void initState() {
    super.initState();
    _loadHotelIcon();
    _addPlaceMarker(); // Add the marker for the place

    // Fetch hotels and add markers once the data is loaded
    Provider.of<HotelProvider>(context, listen: false)
        .fetchHotelsByPlaces(widget.place_id)
        .then((_) {
      _addHotelMarkers(
          Provider.of<HotelProvider>(context, listen: false).hotelsByPlaces);
    });
  }

  // Load the custom hotel icon
  Future<void> _loadHotelIcon() async {
    _hotelIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(48, 48)),
      'assets/icons/hotel_icon.png',
    );
  }

  void _addPlaceMarker() {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('place_marker'),
          position: LatLng(widget.location.latitude, widget.location.longitude),
          infoWindow: InfoWindow(title: 'Selected Place'),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueRed,
          ), // Use a red marker for the place
        ),
      );
    });
  }

  void _addHotelMarkers(List<HotelModel> hotels) {
    setState(() {
      for (var hotel in hotels) {
        _markers.add(
          Marker(
            markerId: MarkerId(hotel.id.toString()),
            position: LatLng(hotel.location.latitude, hotel.location.longitude),
            infoWindow: InfoWindow(
              title: hotel.name,
              onTap: () {
                _openHotelDetails(hotel);
              },
            ),
            icon: _hotelIcon, // Use the custom hotel icon
          ),
        );
      }
    });
  }

  void _openHotelDetails(HotelModel hotel) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HotelViewScreen(hotelId: hotel.id ?? ""),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Places & Hotels",
        showBackButton: true,
      ),
      body: Consumer<HotelProvider>(
        builder: (context, hotelProvider, child) {
          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(widget.location.latitude, widget.location.longitude),
              zoom: 12,
            ),
            markers: _markers,
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
            },
          );
        },
      ),
    );
  }
}
