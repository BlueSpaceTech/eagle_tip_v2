// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'dart:ffi';

import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/UI/Widgets/customNav.dart';
import 'package:testttttt/UI/Widgets/custom_webbg.dart';
import 'package:testttttt/UI/Widgets/customappheader.dart';
import 'package:testttttt/UI/Widgets/logo.dart';
import 'package:testttttt/UI/views/post_auth_screens/UserProfiles/myprofile.dart';
import 'package:testttttt/Utils/common.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: Responsive.isDesktop(context)
          ? MenuButton(isTapped: false, width: width)
          : SizedBox(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              height: Responsive.isDesktop(context) ? height * 1.15 : height,
              color: backGround_color,
              child: Padding(
                padding: EdgeInsets.only(
                    top: height * 0.03,
                    left: Responsive.isDesktop(context)
                        ? width * 0.015
                        : width * 0.04,
                    right: Responsive.isDesktop(context) ? 0.0 : width * 0.04),
                child: Column(
                  children: [
                    Responsive.isDesktop(context)
                        ? Navbar(
                            width: width,
                            height: height,
                            text1: "Home",
                            text2: "Sites",
                          )
                        : Padding(
                            padding: EdgeInsets.only(
                                left: width * 0.04, top: height * 0.02),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: (() {
                                    Navigator.pop(context);
                                  }),
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.22,
                                ),
                                Logo(width: width),
                              ],
                            ),
                          ),
                    SizedBox(
                      height: Responsive.isDesktop(context)
                          ? height * 0.1
                          : height * 0.05,
                    ),
                    Stack(
                      children: [
                        WebBg(),
                        Column(
                          children: [
                            Responsive.isDesktop(context)
                                ? Row(
                                    children: [
                                      Image.asset(
                                        Common.assetImages + "Ellipse 45.png",
                                        width: width * 0.045,
                                      ),
                                      SizedBox(
                                        width: width * 0.02,
                                      ),
                                      UserNameandDet(width: width),
                                      SizedBox(
                                        width: width * 0.1,
                                      ),
                                      Container(
                                        width: width * 0.06,
                                        height: height * 0.05,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          color: Color(0xFF5081DB),
                                        ),
                                        child: Center(
                                            child: Text(
                                          "Chat",
                                          style: TextStyle(
                                            fontSize: width * 0.008,
                                            fontFamily: "Poppins",
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        )),
                                      ),
                                    ],
                                  )
                                : Container(
                                    height: height * 0.26,
                                    width: width,
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          Common.assetImages + "Ellipse 45.png",
                                          width: width * 0.18,
                                        ),
                                        SizedBox(
                                          height: height * 0.005,
                                        ),
                                        UserNameandDet(width: width),
                                        SizedBox(
                                          height: height * 0.004,
                                        ),
                                        Container(
                                          width: width * 0.2,
                                          height: height * 0.035,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            color: Color(0xFF5081DB),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Chat",
                                              style: TextStyle(
                                                fontSize: 13.0,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            SizedBox(
                              height: height * 0.04,
                            ),
                            Visibility(
                              visible: Responsive.isDesktop(context),
                              child: Column(
                                children: [
                                  Divider(
                                    color: Colors.black,
                                    thickness: 1.0,
                                  ),
                                  SizedBox(
                                    height: height * 0.04,
                                  ),
                                ],
                              ),
                            ),
                            ContactInfo(
                                height: Responsive.isDesktop(context)
                                    ? height * 1.06
                                    : height,
                                width: width),
                            SizedBox(
                              height: Responsive.isDesktop(context)
                                  ? height * 0.025
                                  : height * 0.02,
                            ),
                            Divider(
                              color: Responsive.isDesktop(context)
                                  ? Colors.black
                                  : Color(0xFF2E3840),
                              thickness:
                                  Responsive.isDesktop(context) ? 1.0 : 3.0,
                            ),
                            SizedBox(
                              height: Responsive.isDesktop(context)
                                  ? height * 0.04
                                  : height * 0.02,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: Responsive.isDesktop(context)
                                      ? 0.0
                                      : width * 0.08,
                                  right: Responsive.isDesktop(context)
                                      ? 0.0
                                      : width * 0.04),
                              child: SitesData(
                                  height: height * 1.08, width: width),
                            ),
                            Visibility(
                              visible: Responsive.isDesktop(context),
                              child: SizedBox(
                                height: height * 0.04,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}

class UserNameandDet extends StatelessWidget {
  const UserNameandDet({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: Responsive.isDesktop(context)
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        Text(
          "Ahmad Elizondo",
          style: TextStyle(
              fontSize: Responsive.isDesktop(context) ? width * 0.011 : 18.0,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontFamily: 'Poppins'),
        ),
        SizedBox(
          height: 4.0,
        ),
        Text(
          "Manager",
          style: TextStyle(
              fontSize: Responsive.isDesktop(context) ? width * 0.01 : 14.0,
              color: Color(0xFFD9DBE9),
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins'),
        ),
      ],
    );
  }
}

class DesktopSiteData extends StatelessWidget {
  const DesktopSiteData({
    Key? key,
    required this.width,
    required this.sitename,
    required this.imgPath,
    required this.siteloc,
    required this.height,
  }) : super(key: key);

  final double width;
  final String imgPath;
  final double height;
  final String sitename;
  final String siteloc;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 120.0,
          height: 80.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white,
            image: DecorationImage(
                image: AssetImage(
                  Common.assetImages + "$imgPath.png",
                ),
                fit: BoxFit.fill),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          sitename,
          style: TextStyle(
              color: Colors.white,
              fontSize: width * 0.01,
              fontWeight: FontWeight.w400,
              fontFamily: "Poppins"),
        ),
        Text(
          siteloc,
          style: TextStyle(
              color: Colors.white,
              fontSize: width * 0.007,
              fontWeight: FontWeight.w400,
              fontFamily: "Poppins"),
        ),
      ],
    );
  }
}
