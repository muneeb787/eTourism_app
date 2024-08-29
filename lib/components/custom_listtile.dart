import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color iconColor;
  final Color textColor;
  final double iconSize;
  final double textSize;
  final FontWeight textWeight;
  final double elevation;
  final double borderRadius;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;

  const CustomListTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.iconColor = Colors.red,
    this.textColor = Colors.black,
    this.iconSize = 26.0,
    this.textSize = 22.0,
    this.textWeight = FontWeight.normal,
    this.elevation = 10.0,
    this.borderRadius = 12.0,
    this.margin = const EdgeInsets.symmetric(vertical: 8.0),
    this.padding = const EdgeInsets.all(5.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: elevation,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: ListTile(
          leading: Icon(icon, color: iconColor, size: iconSize),
          title: Text(
            title,
            style: TextStyle(
              color: textColor,
              fontSize: textSize,
              fontWeight: textWeight,
            ),
          ),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: onTap,
        ),
      ),
    );
  }
}
