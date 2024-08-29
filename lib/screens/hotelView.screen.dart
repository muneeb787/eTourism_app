import 'package:etourism_app/Components/custom_ElevatedButton.dart';
import 'package:etourism_app/Utils/customColors.dart';
import 'package:etourism_app/Utils/getLocation.dart';
import 'package:etourism_app/components/custom_Appbar.dart';
import 'package:etourism_app/models/room.model.dart';
import 'package:etourism_app/provider/hotels.provider.dart';
import 'package:etourism_app/screens/rooms_list.screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HotelViewScreen extends StatefulWidget {
  final String hotelId;
  const HotelViewScreen({super.key, required this.hotelId});

  @override
  State<HotelViewScreen> createState() => _HotelViewState();
}

class _HotelViewState extends State<HotelViewScreen> {
  Map<String, String> _locationDetails = {
    'street': 'Loading...',
    'locality': '',
    'administrativeArea': '',
    'country': ''
  };

  @override
  void initState() {
    super.initState();
    Provider.of<HotelProvider>(context, listen: false)
        .fetchHotelByID(widget.hotelId)
        .then((_) {
      _loadLocation();
    });
  }

  Future<void> _loadLocation() async {
    var hotelProvider = Provider.of<HotelProvider>(context, listen: false);
    Map<String, String> location = await getLocationDetailsFromLatLng(
        hotelProvider.hotelDetail.location.latitude,
        hotelProvider.hotelDetail.location.longitude);

    if (mounted) {
      setState(() {
        _locationDetails = location;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<HotelProvider>(
        builder: (context, data, child) {
          if (data.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else {
            String locationDisplay = _locationDetails.containsKey('error')
                ? _locationDetails['error']!
                : '${_locationDetails['locality']}, ${_locationDetails['country']}'
                    .trim();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(data.hotelDetail.bannerUrl),
                          fit: BoxFit.cover)),
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () => {Navigator.pop(context)},
                              child: Icon(FontAwesomeIcons.angleLeft,
                                  color: Colors.white),
                            ),
                            Text(
                              "Hotel View",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                            Text('')
                          ],
                        ),
                        Container(
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.hotelDetail.name,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(FontAwesomeIcons.locationDot,
                                size: 15, color: CustomColors.darkGray),
                            SizedBox(width: 5),
                            Text(
                              locationDisplay,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.solidStar,
                              size: 15,
                              color: CustomColors.primaryColor,
                            ),
                            SizedBox(width: 5),
                            Text(
                              '${data.hotelDetail.rating}',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey),
                            ),
                            SizedBox(width: 10),
                            Text(
                              '( ',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey),
                            ),
                            Text(
                              '150 Reviews',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: CustomColors.primaryColor,
                              ),
                            ),
                            Text(
                              ' )',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Text(
                          'About:',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 8),
                        Text(
                          data.hotelDetail.about ?? 'No description available.',
                          style: TextStyle(
                              fontSize: 20,
                              color: CustomColors.darkGray,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 16),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(FontAwesomeIcons.heart),
                              CustomElevatedButton(
                                onPressed: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => RoomsList(),
                                      ))
                                },
                                text: "Select a Room",
                                backgroundColor: CustomColors.primaryColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
