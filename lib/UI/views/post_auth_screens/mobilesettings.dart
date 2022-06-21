// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/Services/authentication_helper.dart';
import 'package:testttttt/UI/Widgets/customappheader.dart';
import 'package:testttttt/UI/Widgets/logo.dart';
import 'package:testttttt/UI/views/post_auth_screens/HomeScreens/Home_screen.dart';
import 'package:testttttt/UI/views/post_auth_screens/HomeScreens/bottomNav.dart';
import 'package:testttttt/UI/views/post_auth_screens/UserProfiles/myprofile.dart';
import 'package:testttttt/Utils/common.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:testttttt/Utils/detectPlatform.dart';
import 'package:testttttt/Utils/responsive.dart';

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
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        title: Text(
                          'Request Confirmation',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: Responsive.isDesktop(context)
                                ? width * 0.05
                                : 23.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Poppins",
                            color: Colors.black,
                          ),
                        ),
                        content: Container(
                          height: Responsive.isDesktop(context)
                              ? height * 0.3
                              : height * 0.23,
                          child: Column(
                            children: [
                              Text(
                                "Are you sure you want to Logout ?",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Poppins"),
                              ),
                              SizedBox(
                                height: Responsive.isDesktop(context)
                                    ? height * 0.02
                                    : height * 0.05,
                              ),
                              SizedBox(
                                height: Responsive.isDesktop(context)
                                    ? height * 0.006
                                    : 8.0,
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      width: Responsive.isDesktop(context)
                                          ? width * 0.45
                                          : width * 0.32,
                                      height: height * 0.055,
                                      decoration: BoxDecoration(
                                        color: Color(0Xffed5c62),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "Poppins"),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: Responsive.isDesktop(context)
                                        ? width * 0.06
                                        : 12.0,
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      if (PlatformInfo().isWeb()) {
                                        SharedPreferences.getInstance()
                                            .then((prefs) {
                                          prefs.setBool("remember_me", false);
                                        });
                                      }
                                      AuthFunctions.signOut().then((value) =>
                                          Navigator.of(context)
                                              .pushNamedAndRemoveUntil(
                                                  "/login_screen",
                                                  (Route<dynamic> route) =>
                                                      false)
                                              .whenComplete(
                                                  () => print("Logged Out")));
                                    },
                                    child: Container(
                                      width: Responsive.isDesktop(context)
                                          ? width * 0.45
                                          : width * 0.32,
                                      height: height * 0.055,
                                      decoration: BoxDecoration(
                                        color: Color(0Xff5081db),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Logout",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "Poppins"),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
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
