import 'package:etourism_app/Components/custom_ElevatedButton.dart';
import 'package:etourism_app/Utils/customColors.dart';
import 'package:etourism_app/models/room.model.dart';
import 'package:etourism_app/screens/room_booking.screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RoomViewScreen extends StatelessWidget {
  final RoomModel roomDetails;

  const RoomViewScreen({super.key, required this.roomDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: PageView.builder(
                    itemCount: roomDetails.photos?.length ?? 0,
                    itemBuilder: (context, index) {
                      return Image.network(
                        roomDetails.photos![index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 10,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      FontAwesomeIcons.angleLeft,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 30,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      roomDetails.photos?.length ?? 0,
                      (index) => Container(
                        margin: EdgeInsets.symmetric(horizontal: 4.0),
                        width: 8.0,
                        height: 8.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Room Name', // You can replace this with actual hotel name if available
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.numbers, color: Colors.grey),
                          SizedBox(width: 4),
                          Text(
                            'Room # ${roomDetails.roomNumber}', // Replace with actual location if available
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Text(
                        'PKR ${roomDetails.price}/-',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: CustomColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.bed, color: Colors.redAccent),
                          SizedBox(width: 8.0),
                          Text(
                            "01 Room",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 20),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        children: [
                          Icon(Icons.people, color: Colors.redAccent),
                          SizedBox(width: 8.0),
                          Text(
                            "02 Guests",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 20),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        children: [
                          Icon(Icons.smoke_free, color: Colors.redAccent),
                          SizedBox(width: 8.0),
                          Text(
                            "Non-Smoking Room",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'About',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    roomDetails.description ?? 'No description available',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Facilities',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  ...roomDetails.amenities?.map((amenity) {
                        return Row(
                          children: [
                            Icon(Icons.check, color: Colors.green),
                            SizedBox(width: 4),
                            Text(
                              '${amenity[0].toUpperCase()}${amenity.substring(1)}', // Capitalize first letter
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        );
                      }).toList() ??
                      [],
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: CustomElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RoomBookingScreen(roomDetails: roomDetails,),
                        ));
                  },
                  backgroundColor: CustomColors.primaryColor,
                  text: "Select this Room",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
