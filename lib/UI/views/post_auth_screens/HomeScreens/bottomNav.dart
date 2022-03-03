// ignore_for_file: prefer_const_constructors, prefer_final_fields, unused_field, prefer_const_literals_to_create_immutables, unused_local_variable

import 'package:testttttt/UI/views/post_auth_screens/Chat/allchats.dart';
import 'package:testttttt/UI/views/post_auth_screens/Chat/message_main.dart';
import 'package:testttttt/UI/views/post_auth_screens/HomeScreens/Home_screen.dart';
import 'package:testttttt/UI/views/post_auth_screens/Notifications/notifications.dart';
import 'package:testttttt/UI/views/post_auth_screens/UserProfiles/myprofile.dart';
import 'package:testttttt/Utils/common.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 1;
  static const TextStyle optionStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: Color(0xFFA0A3BD),
  );
  List<Widget> _widgetOptions = <Widget>[
    MyProfile(),
    HomeScreen(),
    Notifications(),
    MessageMain(
      currentusername: "s",
      friendname: "noname",
      frienduid: "no uid",
      index: 0,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFF1A1F23),
        unselectedItemColor: Color(0xFFA0A3BD),
        selectedItemColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            activeIcon: Image.asset(
              Common.assetImages + "activeProfile.png",
              width: width * 0.05,
            ),
            icon: Image.asset(
              Common.assetImages + "profil.png",
              width: width * 0.05,
            ),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            activeIcon: Image.asset(
              Common.assetImages + "activeHome.png",
              width: width * 0.05,
            ),
            icon: Image.asset(
              Common.assetImages + "home.png",
              width: width * 0.05,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            activeIcon: Image.asset(
              Common.assetImages + "activeNotification.png",
              width: width * 0.05,
            ),
            icon: Image.asset(
              Common.assetImages + "Group 308.png",
              width: width * 0.05,
            ),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            activeIcon: Image.asset(
              Common.assetImages + "activeChat.png",
              width: width * 0.05,
            ),
            icon: Image.asset(
              Common.assetImages + "message.png",
              width: width * 0.05,
            ),
            label: 'Chat',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
