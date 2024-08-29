import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final Function()? onPressed;
  final String? text;
  final double? width;
  final double? height; // New property for custom height
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor; // New property for custom border color
  final IconData? iconData;
  final Widget? icon;
  final Widget? leadingIcon; // Added a leading icon for flexibility
  final Widget? image; // New property for adding an image

  const CustomElevatedButton({
    Key? key,
    this.onPressed,
    this.text,
    this.width,
    this.height,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.iconData,
    this.icon,
    this.leadingIcon,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        fixedSize: Size(width ?? 330, height ?? 55), // Use the new height parameter with a default value
        backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: BorderSide(color: borderColor ?? Colors.transparent), // Border color
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (leadingIcon != null) ...[
            leadingIcon!,
            SizedBox(width: 8), // Add spacing between icon and text
          ],
          if (iconData != null) ...[
            Icon(iconData, color: textColor ?? Colors.white),
            SizedBox(width: 8), // Add spacing between icon and text
          ],
          if (icon != null) ...[
            icon!,
            SizedBox(width: 8), // Add spacing between icon and text
          ],
          if (image != null) ...[
            image!,
            SizedBox(width: 8), // Add spacing between image and text
          ],
          Text(
            text ?? '',
            style: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 16,
              color: textColor ?? Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
