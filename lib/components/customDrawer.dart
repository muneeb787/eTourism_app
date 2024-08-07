import 'package:flutter/material.dart';
import 'package:etourism_app/Utils/customColors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: CustomColors.primaryColor,
            ),

            child: Center(
              child: const Image(
                image: AssetImage('assets/images/white-logo.png'),
                // width: 200,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('My Account' , style: TextStyle(fontSize: 20),),
            onTap: () {
              // Handle My Account tap
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings' , style: TextStyle(fontSize: 20),),
            onTap: () {
              // Handle Settings tap
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout' , style: TextStyle(fontSize: 20),),
            onTap: () {
              // Handle Logout tap
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
