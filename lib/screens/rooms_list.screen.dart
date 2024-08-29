import 'package:etourism_app/Components/custom_ElevatedButton.dart';
import 'package:etourism_app/Utils/customColors.dart';
import 'package:etourism_app/components/custom_Appbar.dart';
import 'package:etourism_app/provider/hotels.provider.dart';
import 'package:etourism_app/screens/roomView.screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RoomsList extends StatelessWidget {
  const RoomsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Rooms", showBackButton: true),
      body: Consumer<HotelProvider>(
        builder: (context, hotelProvider, child) {
          final rooms = hotelProvider.hotelDetail.rooms;

          return ListView.builder(
            itemCount: rooms?.length,
            itemBuilder: (context, index) {
              final room = rooms?[index];

              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Image section
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0),
                        ),
                        child: Image.network(
                          room?.photos?[0] ??
                              '', // Replace with actual image URL property
                          height: 150.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Room title
                            Text(
                              'Room Name',
                              style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            // Room details
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.bed,
                                            color: Colors.redAccent),
                                        SizedBox(width: 8.0),
                                        Text(
                                          "01 Room",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 20),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      children: [
                                        Icon(Icons.people,
                                            color: Colors.redAccent),
                                        SizedBox(width: 8.0),
                                        Text(
                                          "02 Guests",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 20),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      children: [
                                        Icon(Icons.smoke_free,
                                            color: Colors.redAccent),
                                        SizedBox(width: 8.0),
                                        Text(
                                          "Non-Smoking Room",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "PKR ${room?.price ?? 'Price'}",
                                      style: TextStyle(
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      "(For 01 Night/Room)",
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          color: CustomColors.darkGray,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: 20.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // View more details button
                                TextButton(
                                  onPressed: () {
                                    // Handle view more details
                                  },
                                  child: Text(
                                    "View More Details",
                                    style: TextStyle(
                                        color: CustomColors.darkGray,
                                        fontSize: 18),
                                  ),
                                ),
                                // Select room button
                                CustomElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => RoomViewScreen(roomDetails: hotelProvider.hotelDetail.rooms![index]),
                                        ));
                                  },
                                  width: 150,
                                  height: 45,
                                  backgroundColor: CustomColors.primaryColor,
                                  text: "Select Room",
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
