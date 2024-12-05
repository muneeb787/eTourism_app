import 'package:etourism_app/Components/custom_ElevatedButton.dart';
import 'package:etourism_app/Utils/customColors.dart';
import 'package:etourism_app/Utils/getLocation.dart';
import 'package:etourism_app/components/custom_Appbar.dart';
import 'package:etourism_app/models/room.model.dart';
import 'package:etourism_app/provider/hotels.provider.dart';
import 'package:etourism_app/screens/Rooms/rooms_list.screen.dart';
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

  final String fallbackImageUrl =
      'https://static.vecteezy.com/system/resources/previews/002/034/969/original/modern-house-villa-exterior-with-swimming-pool-at-backyard-illustration-vector.jpg';

  @override
  void initState() {
    super.initState();
    Provider.of<HotelProvider>(context, listen: false)
        .fetchHotelByID(widget.hotelId)
        .then((_) {
          print("hotelProvider.hotelDetail.location.latitude: ${Provider.of<HotelProvider>(context, listen: false).hotelDetail.location.latitude}");
          print("hotelProvider.hotelDetail.location.longitude: ${Provider.of<HotelProvider>(context, listen: false).hotelDetail.location.longitude}");
      _loadLocation();
    });
  }

  Future<void> _loadLocation() async {
    var hotelProvider = Provider.of<HotelProvider>(context, listen: false);
    print("hotelProvider: ${hotelProvider}");
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
                  width: double.infinity,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image(
                        image: NetworkImage(data.hotelDetail.bannerUrl),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.network(
                            fallbackImageUrl,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                      SafeArea(
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
                    ],
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
                        SizedBox(height: 16),
                        ExpansionTile(
                          title: Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.cloudSun,
                                color: CustomColors.primaryColor,
                                size: 24,
                              ),
                              SizedBox(width: 12),
                              Text(
                                "${data.hotelDetail.weather?.main}: ${data.hotelDetail.weather?.description}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: CustomColors.primaryColor,
                                ),
                              ),
                            ],
                          ),
                          childrenPadding: EdgeInsets.all(16),
                          expandedCrossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _weatherInfoItem(
                                  FontAwesomeIcons.temperatureHalf,
                                  "Temperature",
                                  "${data.hotelDetail.weather?.temperature.current}°C",
                                ),
                                _weatherInfoItem(
                                  FontAwesomeIcons.temperatureArrowDown,
                                  "Feels like",
                                  "${data.hotelDetail.weather?.temperature.feelsLike}°C",
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _weatherInfoItem(
                                  FontAwesomeIcons.droplet,
                                  "Humidity",
                                  "${data.hotelDetail.weather?.humidity}%",
                                ),
                                _weatherInfoItem(
                                  FontAwesomeIcons.wind,
                                  "Wind Speed",
                                  "${data.hotelDetail.weather?.windSpeed} km/h",
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
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

  Widget _weatherInfoItem(IconData icon, String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: CustomColors.darkGray),
              SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: CustomColors.darkGray,
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: CustomColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
