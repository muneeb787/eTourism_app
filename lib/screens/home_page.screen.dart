import 'dart:ui';

import 'package:etourism_app/Utils/customColors.dart';
import 'package:etourism_app/components/customDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  static const pageName = '/homePage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      drawer: CustomDrawer(),
      // appBar: AppBar(
      //   title: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       Icon(Icons.menu),
      //       Text('TourPlace', style: TextStyle(fontFamily: 'Cursive')),
      //       CircleAvatar(
      //         backgroundImage: AssetImage('assets/images/white-logo.png'),
      //       ),
      //     ],
      //   ),
      //   flexibleSpace: Container(
      //     height: 300,
      //     decoration: BoxDecoration(
      //       gradient: LinearGradient(
      //         colors: [Colors.orange, Colors.red],
      //         begin: Alignment.topLeft,
      //         end: Alignment.bottomRight,
      //       ),
      //     ),
      //   ),
      // ),
      body: Builder(builder: (BuildContext context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 250, // Reduced height back to original
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
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white.withOpacity(0.9),
                              ),
                              padding: EdgeInsets.all(3),
                              child: FaIcon(FontAwesomeIcons.user),
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
                        // width: 200,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 16,
                  right: 16,
                  bottom:
                      -25, // Adjust this value to control how much the search bar overlaps
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
                          SizedBox(
                            width: 10,
                          ),
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
            SizedBox(
              height: 70,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Categories',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CategoryItem(
                        svgAsset: 'assets/icons/mountain.svg',
                        label: 'Mountains'),
                    CategoryItem(
                        svgAsset: 'assets/icons/beach.svg', label: 'Beach'),
                    CategoryItem(
                        svgAsset: 'assets/icons/lake.svg', label: 'Lakes'),
                    CategoryItem(
                        svgAsset: 'assets/icons/camp.svg', label: 'Camp'),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Most Visited',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('See All'),
                  ),
                ],
              ),
            ),
            Container(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  PlaceItem(
                    image:
                        'https://cdn.thecollector.com/wp-content/uploads/2023/11/tallest-mountains-in-the-world.jpg',
                    name: 'Kanchenjungha',
                    location: 'Rangpur, Bangladesh',
                    rating: 4.7,
                  ),
                  PlaceItem(
                    image:
                        'https://skift.com/wp-content/uploads/2023/04/zany-jadraque-ZCRtfop2hZY-unsplash.jpg',
                    name: 'Cox\'s Bazar Sea Beach',
                    location: 'Cox\'s Bazar, Bangladesh',
                    rating: 4.5,
                  ),
                  PlaceItem(
                    image:
                        'https://www.gns.cri.nz/assets/Uploads/Heroes/lake-hero-2-v2__FillWzEyMDAsNjAwXQ.jpg',
                    name: 'Fewa Lake',
                    location: 'Pokhara, Nepal',
                    rating: 4.6,
                  ),
                  PlaceItem(
                    image:
                        'https://www.easycamp.com/Admin/Public/GetImage.ashx?Image=/Files/Images/EasyCamp/Join+the+Fun/2022/Festivals+Article+850x500.jpg&Width=1260&Compression=80&Crop=5',
                    name: 'Camping Site',
                    location: 'Bandarban, Bangladesh',
                    rating: 4.3,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Services',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('See All'),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                ServiceItem(
                    svgAsset: 'assets/icons/hotel.svg',
                    label: 'Hotel',
                    isSelected: true),
                ServiceItem(
                    svgAsset: 'assets/icons/bus.svg',
                    label: 'Bus',
                    isSelected: false),
              ],
            ),
          ],
        );
      }),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String svgAsset;
  final String label;

  CategoryItem({required this.svgAsset, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            offset: Offset(0, 2),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            svgAsset,
            width: 30,
            height: 30,
            color: CustomColors.primaryColor,
          ),
          SizedBox(height: 8.0),
          Text(
            label,
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: CustomColors.darkGray),
          ),
        ],
      ),
    );
  }
}

class PlaceItem extends StatelessWidget {
  final String image;
  final String name;
  final String location;
  final double rating;

  PlaceItem({
    required this.image,
    required this.name,
    required this.location,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 200,
      width: 200,
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(22.0),
            child: Image.network(
              image,
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
                  rating.toString(),
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
                  name,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: CustomColors.secondaryColor,
                  ),
                ),
                Text(
                  location,
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
    );
  }
}

class ServiceItem extends StatelessWidget {
  final IconData? icon;
  final String? svgAsset;
  final String label;
  final bool isSelected;

  ServiceItem(
      {this.icon, this.svgAsset, required this.label, this.isSelected = false})
      : assert(icon != null || svgAsset != null,
            'Either icon or svgAsset must be provided');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? CustomColors.primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              offset: Offset(0, 2),
              blurRadius: 10.0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Icon(icon,
                  size: 30, color: isSelected ? Colors.white : Colors.black)
            else if (svgAsset != null)
              SvgPicture.asset(
                svgAsset!,
                width: 20,
                height: 20,
                color: isSelected ? Colors.white : Colors.black,
              ),
            SizedBox(width: 8.0),
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
