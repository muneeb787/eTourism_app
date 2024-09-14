import 'package:etourism_app/components/custom_Appbar.dart';
import 'package:etourism_app/models/hotel.model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Components/custom_ElevatedButton.dart';
import '../Utils/customColors.dart';
import '../Utils/getLocation.dart';
import '../provider/hotels.provider.dart';
import 'hotelView.screen.dart';

class HotelsListScreen extends StatelessWidget {
  const HotelsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Hotels",
        showBackButton: false,
        textColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Consumer<HotelProvider>(
            builder: (context, data, child) {
              if (data.isLoading) {
                return Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: data.hotels.length,
                  itemBuilder: (context, index) {
                    final item = data.hotels[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 14),
                      child: HotelListItem(hotel: item),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class HotelListItem extends StatelessWidget {
  final HotelModel hotel;

  const HotelListItem({required this.hotel});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String>>(
      future: getLocationDetailsFromLatLng(
          hotel.location.latitude, hotel.location.longitude),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData) {
          return Text('No location data available');
        } else {
          final locationObject = snapshot.data!;
          return Container(
            height: 160, // Set this to the height of the image
            decoration: BoxDecoration(
              color: CustomColors.gray.withOpacity(0.3),
              borderRadius: BorderRadius.circular(20),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.black26,
              //     blurRadius: 8,
              //     offset: Offset(0, 4),
              //   ),
              // ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                  child: Image.network(
                    hotel.bannerUrl,
                    width: 110,
                    height: 160, // Ensure the height matches the Container height
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min, // Ensure Column takes up the minimum required height
                      children: [
                        Text(
                          hotel.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.orange, size: 25),
                            SizedBox(width: 4),
                            Text(
                              hotel.rating.toString(),
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Text(
                          '${locationObject['locality']}, ${locationObject['country']}',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                              fontWeight: FontWeight.w600),
                        ),
                        Spacer(), // Push the last row to the bottom
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'PKR ${hotel.rating}', // Corrected from hotel.rating to hotel.price
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            CustomElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HotelViewScreen(hotelId: hotel.id ?? ""),
                                  ),
                                );
                              },
                              text: 'Book Now',
                              backgroundColor: CustomColors.primaryColor,
                              width: 120,
                              height: 40, // Adjusted height for button
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}


