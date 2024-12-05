import 'package:etourism_app/components/custom_Appbar.dart';
import 'package:etourism_app/models/hotel.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

import '../../Components/custom_ElevatedButton.dart';
import '../../Utils/customColors.dart';
import '../../Utils/getLocation.dart';
import '../../provider/hotels.provider.dart';
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
      body: Consumer<HotelProvider>(
        builder: (context, data, child) {
          if (data.isLoading) {
            return Center(
              child: Lottie.asset(
                'assets/loading.json',
                width: 200,
                height: 200,
              ),
            );
          } else {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              itemCount: data.hotels.length,
              itemBuilder: (context, index) {
                final item = data.hotels[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 16.w),
                  child: HotelListItem(hotel: item),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class HotelListItem extends StatelessWidget {
  final HotelModel hotel;
  final String fallbackImageUrl =
      'https://static.vecteezy.com/system/resources/previews/002/034/969/original/modern-house-villa-exterior-with-swimming-pool-at-backyard-illustration-vector.jpg';

  const HotelListItem({required this.hotel});

  Widget _buildRatingBar() {
    return Row(
      children: [
        ...List.generate(5, (index) {
          return Icon(
            index < (hotel.rating ?? 0).floor()
                ? Icons.star
                : Icons.star_border,
            size: 18,
            color: Colors.amber,
          );
        }),
        const SizedBox(width: 4),
        Text(
          hotel.rating?.toStringAsFixed(1) ?? "N/A",
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.amber,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String>>(
      future: getLocationDetailsFromLatLng(
          hotel.location.latitude, hotel.location.longitude),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Lottie.asset(
                'assets/animations/loading.json',
                width: 100,
                height: 100,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData) {
          return Text('No location data available');
        } else {
          final locationObject = snapshot.data!;
          return Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                  ),
                  child: Image(
                    image: NetworkImage(hotel.bannerUrl),
                    fit: BoxFit.cover,
                    width: 140,
                    height: 200,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.network(
                        fallbackImageUrl,
                        fit: BoxFit.cover,
                        width: 140,
                        height: 200,
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                hotel.name,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        _buildRatingBar(),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(FontAwesomeIcons.locationDot,
                                color: CustomColors.primaryColor, size: 18),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                '${locationObject['locality']}, ${locationObject['country']}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(FontAwesomeIcons.cloudSun,
                                color: CustomColors.primaryColor, size: 18),
                            SizedBox(width: 8),
                            Text(
                              '${hotel.weather?.main} ${hotel.weather?.temperature.current}°C',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HotelViewScreen(
                                        hotelId: hotel.id ?? ""),
                                  ),
                                );
                              },
                              text: 'Book Now',
                              backgroundColor: CustomColors.primaryColor,
                              width: 120,
                              height: 36,
                            ),
                          ],
                        ),
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
