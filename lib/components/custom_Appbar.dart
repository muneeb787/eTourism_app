import 'package:etourism_app/Utils/customColors.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final Color textColor;
  final bool showBackButton;
  final bool showActions;
  final VoidCallback? onBackButtonPressed;
  final List<Widget>? actions;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.backgroundColor = CustomColors.primaryColor,
    this.textColor = CustomColors.secondaryColor,
    this.showBackButton = true,
    this.showActions = false,
    this.onBackButtonPressed,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: backgroundColor,
      leading: showBackButton
          ? IconButton(
        icon: Icon(Icons.arrow_back_ios, color: textColor,),
        onPressed: onBackButtonPressed ?? () {
          Navigator.pop(context);
        },
      )
          : null,
      title: Text(title , style: TextStyle(
        fontWeight: FontWeight.w700,
        color: textColor
      ),),
      actions: showActions
          ? actions ??
          [
            TextButton(
              onPressed: () {
                // Handle language change action
              },
              child: Text(
                'English',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ]
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
