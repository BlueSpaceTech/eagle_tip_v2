// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/UI/Widgets/customContainer.dart';
import 'package:testttttt/UI/Widgets/customHeader2.dart';
import 'package:testttttt/UI/Widgets/customNav.dart';
import 'package:testttttt/UI/Widgets/customappheader.dart';
import 'package:testttttt/UI/views/post_auth_screens/HomeScreens/Home_screen.dart';
import 'package:testttttt/Utils/common.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SpecificNotification extends StatelessWidget {
  SpecificNotification(
      {Key? key,
      required this.notifyName,
      required this.notifyContent,
      required this.hyperlink})
      : super(key: key);
  final String notifyName;
  final String? hyperlink;
  final String notifyContent;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: Responsive.isDesktop(context)
          ? MenuButton(isTapped: false, width: width)
          : SizedBox(),
      body: SingleChildScrollView(
        child: Container(
          height: Responsive.isDesktop(context) ? height * 1.18 : height,
          color: backGround_color,
          child: Padding(
            padding: EdgeInsets.only(
              top: Responsive.isDesktop(context) ? height * 0.02 : height * 0.1,
              left: Responsive.isDesktop(context) ? 0.0 : width * 0.03,
              right: Responsive.isDesktop(context) ? 0.0 : width * 0.02,
            ),
            child: Column(
              children: [
                Responsive.isDesktop(context)
                    ? Navbar(
                        width: width,
                        height: height,
                      )
                    : CustomHeader2(),
                SizedBox(
                  height: height * 0.06,
                ),
                Responsive.isDesktop(context)
                    ? CustomContainer(
                        opacity: 0.2,
                        child: Padding(
                          padding: EdgeInsets.only(top: height * 0.01),
                          child: Column(
                            children: [
                              Text(
                                notifyName,
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Poppins"),
                              ),
                              SizedBox(
                                height: height * 0.06,
                              ),
                              Container(
                                width: width * 0.4,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      notifyContent,
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Poppins"),
                                    ),
                                    InkWell(
                                      onTap: (() {
                                        if (hyperlink != null) {
                                          launch(hyperlink!);
                                        }
                                        // print(hyperlink);
                                      }),
                                      child: Text(
                                        hyperlink ?? "",
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "Poppins"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: height * 0.08,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  width: width * 0.3,
                                  height: height * 0.07,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.0),
                                    color: Color(0xFF5081DB),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Back",
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Poppins"),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        width: width,
                        topPad: 10.0,
                        height: height * 0.9)
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            notifyName,
                            style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Poppins"),
                          ),
                          SizedBox(
                            height: height * 0.06,
                          ),
                          SizedBox(
                            width: width * 0.4,
                            child: Text(
                              notifyContent,
                              style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Poppins"),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.4,
                          ),
                          InkWell(
                            onTap: (() {
                              if (hyperlink != null) {
                                launch(hyperlink!);
                              }
                              // print(hyperlink);
                            }),
                            child: Text(
                              hyperlink ?? "",
                              style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Poppins"),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: width * 0.75,
                              height: height * 0.07,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0),
                                color: Color(0xFF5081DB),
                              ),
                              child: Center(
                                child: Text(
                                  "Back",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
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
      ),
    );
  }
}
