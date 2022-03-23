// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/Services/authentication_helper.dart';
import 'package:testttttt/UI/Widgets/customappheader.dart';
import 'package:testttttt/UI/Widgets/logo.dart';
import 'package:testttttt/UI/views/post_auth_screens/UserProfiles/myprofile.dart';
import 'package:testttttt/Utils/common.dart';
import 'package:testttttt/Utils/constants.dart';

class MobileSetting extends StatefulWidget {
  @override
  State<MobileSetting> createState() => _MobileSettingState();
}

class _MobileSettingState extends State<MobileSetting> {
  bool? switchVal1 = false;

  bool? switchVal2 = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: height,
          width: width,
          color: backGround_color,
          child: Padding(
            padding: EdgeInsets.only(
                left: width * 0.04, right: width * 0.04, top: height * 0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: width * 0.06,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.17,
                    ),
                    Logo(width: width),
                    SizedBox(
                      width: width * 0.18,
                    ),
                    MenuButton(isTapped: false, width: width),
                  ],
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Settings",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins"),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.settings);
                    },
                    child: MiscBox(width: width, MiscName: "Preferences")),
                SizedBox(
                  height: height * 0.02,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.about);
                  },
                  child: MiscBox(width: width, MiscName: "About"),
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                InkWell(
                  onTap: () {
                    AuthFunctions.signOut();
                    Navigator.pushNamed(context, AppRoutes.loginscreen);
                  },
                  child: Text(
                    "Log out",
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Color(0xFF92b8ff),
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Poppins"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
