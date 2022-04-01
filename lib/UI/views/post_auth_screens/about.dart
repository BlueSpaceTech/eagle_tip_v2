// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/UI/Widgets/customappheader.dart';
import 'package:testttttt/UI/Widgets/logo.dart';
import 'package:testttttt/Utils/common.dart';
import 'package:testttttt/Utils/constants.dart';

class AboutMobile extends StatefulWidget {
  @override
  State<AboutMobile> createState() => _AboutMobileState();
}

class _AboutMobileState extends State<AboutMobile> {
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
                      "About",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins"),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: width * 0.012, right: width * 0.012),
                  // padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: height * 0.3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.aboutCompany);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "About the company",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Poppins",
                                      fontSize: width * 0.03,
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.005,
                                  ),
                                  Text(
                                    "Know more about Eagle Tip",
                                    style: TextStyle(
                                      color: Color(0xFFD5D6D8),
                                      fontFamily: "Poppins",
                                      fontSize: width * 0.025,
                                    ),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: width * 0.03,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        AboutColumn(
                          heading: "Phone number",
                          detail: "(252) 937-2464",
                          width: width,
                          height: height,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Terms and Conditions",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Poppins",
                                fontSize: width * 0.03,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.005,
                            ),
                            RichText(
                              text: TextSpan(
                                text: "Read Eagle Tip's Terms and conditions",
                                style: TextStyle(
                                    color: Color(0xFFD4D6D9),
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Poppins"),
                                children: [
                                  TextSpan(
                                    text: "  here.",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Color(0xFF92B8FF),
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Poppins"),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        AboutColumn(
                          heading: "App version",
                          detail: "02.01.00",
                          width: width,
                          height: height,
                        ),
                      ],
                    ),
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

class AboutColumn extends StatelessWidget {
  const AboutColumn({
    Key? key,
    required this.width,
    required this.height,
    required this.detail,
    required this.heading,
  }) : super(key: key);

  final double width;
  final double height;
  final String heading;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Poppins",
            fontSize: width * 0.03,
          ),
        ),
        SizedBox(
          height: height * 0.005,
        ),
        Text(
          detail,
          style: TextStyle(
            color: Color(0xFFD5D6D8),
            fontFamily: "Poppins",
            fontSize: width * 0.025,
          ),
        ),
      ],
    );
  }
}
