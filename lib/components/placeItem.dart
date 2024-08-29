import 'package:etourism_app/Utils/customColors.dart';
import 'package:etourism_app/Utils/getLocation.dart';
import 'package:etourism_app/models/location.model.dart';
import 'package:etourism_app/screens/PlacesOnMap.screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class PlaceItem extends StatefulWidget {
  final String id;
  final String image;
  final String name;
  final LocationModel location;
  final double rating;

  PlaceItem({
    required this.id,
    required this.image,
    required this.name,
    required this.location,
    required this.rating,
  });

  @override
  State<PlaceItem> createState() => _PlaceItemState();
}

class _PlaceItemState extends State<PlaceItem> {
  Map<String, String> _locationDetails = {
    'street': 'Loading...',
    'locality': '',
    'administrativeArea': '',
    'country': ''
  };

  @override
  void initState() {
    super.initState();
    _loadLocation();
  }

  Future<void> _loadLocation() async {
    Map<String, String> location = await getLocationDetailsFromLatLng(
        widget.location.latitude, widget.location.longitude);
    setState(() {
      _locationDetails = location;
    });
  }
  // Future<void> _getAddressFromLatLng() async {
  //   try {
  //     List<Placemark> placemarks = await placemarkFromCoordinates(
  //       widget.location.latitude,
  //       widget.location.longitude,
  //     );
  //
  //     if (placemarks.isNotEmpty) {
  //       Placemark place = placemarks[0];
  //       print('Received placemark: $place');
  //       setState(() {
  //         _location = '${place.locality ?? ''}, ${place.country ?? ''}'.trim();
  //         if (_location.isEmpty) {
  //           _location = 'Location details not available';
  //         }
  //       });
  //     } else {
  //       print('No placemarks found');
  //       setState(() {
  //         _location = 'No location data';
  //       });
  //     }
  //   } catch (e) {
  //     print('Error in _getAddressFromLatLng: $e');
  //     setState(() {
  //       _location = 'Error fetching location';
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    String locationDisplay = _locationDetails.containsKey('error')
        ? _locationDetails['error']!
        : '${_locationDetails['locality']}, ${_locationDetails['country']}'
        .trim();
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlacesOnMap(location: widget.location, place_id: widget.id),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(10),
        height: 200,
        width: 200,
        child: Stack(
          fit: StackFit.passthrough,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.network(
                widget.image,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: Row(
                children: [
                  Icon(Icons.star, color: Colors.yellow, size: 14),
                  SizedBox(width: 4),
                  Text(
                    widget.rating.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: CustomColors.secondaryColor,
                    ),
                  ),
                  Text(
                    locationDisplay,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: CustomColors.secondaryColor,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}