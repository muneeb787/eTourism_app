import 'dart:ui';

import 'package:etourism_app/Utils/customColors.dart';
import 'package:etourism_app/components/customDrawer.dart';
import 'package:etourism_app/components/customNavigator.dart';
import 'package:etourism_app/components/placeItem.dart';
import 'package:etourism_app/models/hotel.model.dart';
import 'package:etourism_app/provider/auth.provider.dart';
import 'package:etourism_app/provider/hotels.provider.dart';
import 'package:etourism_app/provider/places.provider.dart';
import 'package:etourism_app/screens/Hotels/hotelView.screen.dart';
import 'package:etourism_app/screens/Places/placesByCategory.screen.dart';
import 'package:etourism_app/screens/Settings/update_profile.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

import '../components/category_item.dart';
import '../components/hotel_grid_item.dart';
import '../components/service_item.dart';

class HomePage extends StatefulWidget {
  static const pageName = '/homePage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<PlacesProvider>(context, listen: false).fetchPlaces();
    Provider.of<HotelProvider>(context, listen: false).fetchHotels();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      drawer: CustomDrawer(),
      body: Builder(builder: (BuildContext context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/bg-header.png"),
                      alignment: AlignmentDirectional.center,
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () => Scaffold.of(context).openDrawer(),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white.withOpacity(0.1),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.2),
                                    width: 1.5,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 10, sigmaY: 10),
                                    child: Container(
                                      padding: EdgeInsets.all(12),
                                      child: FaIcon(
                                        FontAwesomeIcons.bars,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Consumer<AuthProvider>(
                              builder: (context, value, child) {
                                var image = value.userData.imageUrl ??
                                    "https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fwww.gravatar.com%2Favatar%2F2c7d99fe281ecd3bcd65ab915bac6dd5%3Fs%3D250";
                                return Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white.withOpacity(0.9),
                                  ),
                                  child: image != null
                                      ? GestureDetector(
                                          onTap: () {
                                            NavigateWithSlideAnimation(
                                                context, UpdateProfileScreen());
                                          },
                                          child: ClipOval(
                                            child: Image.network(
                                              image,
                                              width: 40,
                                              height: 40,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )
                                      : Icon(FontAwesomeIcons.faceSmile),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 16,
                  right: 16,
                  top: 40,
                  child: Center(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 25.h),
                      child: const Image(
                        image: AssetImage('assets/images/white-logo.png'),
                        width: 250, // Added width to decrease size
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: -25,
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 0,
                          blurRadius: 10,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            FontAwesomeIcons.search,
                            size: 20,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Search Any Place",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Consumer2<PlacesProvider, HotelProvider>(
              builder: (context, placesData, hotelsData, child) {
                if (placesData.isLoading || hotelsData.isLoading) {
                  return Expanded(
                    child: Center(
                      child: Lottie.network(
                        'https://lottie.host/f376b805-1ce5-4df8-a2a4-5f56df143457/CvAAbIXrGw.json',
                        width: 200,
                        height: 200,
                      ),
                    ),
                  );
                }
                return Expanded(
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.all(16.0.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                            child: Text(
                              'Categories',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(
                            height: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CategoryItem(
                                    svgAsset: 'assets/icons/mountain.svg',
                                    label: 'Mountains'),
                                CategoryItem(
                                    svgAsset: 'assets/icons/beach.svg',
                                    label: 'Beach'),
                                CategoryItem(
                                    svgAsset: 'assets/icons/lake.svg',
                                    label: 'Lakes'),
                                CategoryItem(
                                    svgAsset: 'assets/icons/camp.svg',
                                    label: 'Camp'),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 8.0.w),
                                child: Text(
                                  'Most Visited',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(''),
                              ),
                            ],
                          ),
                          Container(
                            height: 150,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: placesData.places.length,
                              itemBuilder: (context, index) {
                                final item = placesData.places[index];
                                return PlaceItem(
                                  id: item.id,
                                  image: item.image,
                                  name: item.name,
                                  location: item.location,
                                  rating: item.rating?.toDouble() ?? 0,
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Services',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: Text(''),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0.h),
                            child: Row(
                              children: [
                                ServiceItem(
                                    svgAsset: 'assets/icons/hotel.svg',
                                    label: 'Hotel',
                                    isSelected: true),
                                ServiceItem(
                                    svgAsset: 'assets/icons/bus.svg',
                                    label: 'Bus',
                                    isSelected: false,
                                    isDisabled: true),
                              ],
                            ),
                          ),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.all(0),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 2 / 2,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                            ),
                            itemCount: hotelsData.hotels.length,
                            itemBuilder: (context, index) {
                              final item = hotelsData.hotels[index];
                              return HotelGridItem(hotel: item);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        );
      }),
    );
  }
}
