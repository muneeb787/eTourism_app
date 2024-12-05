import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Utils/customColors.dart';
import '../screens/Places/placesByCategory.screen.dart';

class CategoryItem extends StatelessWidget {
  final String svgAsset;
  final String label;

  CategoryItem({required this.svgAsset, required this.label});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlacesByCategory(category: label),
          ),
        )
      },
      child: Container(
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
      ),
    );
  }
}