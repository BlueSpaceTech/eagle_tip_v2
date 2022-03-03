// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/UI/Widgets/customContainer.dart';
import 'package:testttttt/UI/Widgets/customHeader2.dart';
import 'package:testttttt/UI/Widgets/customNav.dart';
import 'package:testttttt/UI/Widgets/customappheader.dart';
import 'package:testttttt/Utils/common.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:flutter/material.dart';

class ParticularRequest extends StatelessWidget {
  const ParticularRequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: Responsive.isDesktop(context)
          ? MenuButton(isTapped: false, width: width)
          : SizedBox(),
      body: SingleChildScrollView(
        child: Container(
          height: Responsive.isDesktop(context) ? height * 1.19 : height * 1.07,
          color: backGround_color,
          child: Padding(
            padding: EdgeInsets.only(
                left: Responsive.isDesktop(context) ? 0.0 : width * 0.04,
                right: Responsive.isDesktop(context) ? 0.0 : width * 0.04,
                top: Responsive.isDesktop(context)
                    ? height * 0.04
                    : height * 0.1),
            child: Column(
              children: [
                Responsive.isDesktop(context)
                    ? Navbar(
                        width: width,
                        height: height,
                        text1: "Home",
                        text2: "Sites",
                      )
                    : CustomHeader2(),
                SizedBox(
                  height: height * 0.05,
                ),
                CustomContainer(
                    opacity: 0.2,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.06, right: width * 0.06),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Visibility(
                            visible: Responsive.isDesktop(context),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Order ID: 654681",
                                  style: TextStyle(
                                    fontSize: width * 0.013,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Poppins",
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Responsive.isDesktop(context)
                                ? height * 0.04
                                : height * 0.03,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: "Request:",
                                  style: TextStyle(
                                      fontSize: Responsive.isDesktop(context)
                                          ? width * 0.01
                                          : 13.0,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Poppins",
                                      color: Colors.white),
                                  children: [
                                    TextSpan(
                                      text: "  #3456345",
                                      style: TextStyle(
                                        fontSize: Responsive.isDesktop(context)
                                            ? width * 0.01
                                            : 13.0,
                                        color: Color(0xFFD9DBE9),
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Poppins",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  text: "Date:",
                                  style: TextStyle(
                                      fontSize: Responsive.isDesktop(context)
                                          ? width * 0.01
                                          : 13.0,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Poppins",
                                      color: Colors.white),
                                  children: [
                                    TextSpan(
                                      text: "  5/27/15",
                                      style: TextStyle(
                                        fontSize: Responsive.isDesktop(context)
                                            ? width * 0.01
                                            : 13.0,
                                        color: Color(0xFFD9DBE9),
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Poppins",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.015,
                          ),
                          RichText(
                            text: TextSpan(
                              text: "Site:",
                              style: TextStyle(
                                  fontSize: Responsive.isDesktop(context)
                                      ? width * 0.01
                                      : 13.0,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Poppins",
                                  color: Colors.white),
                              children: [
                                TextSpan(
                                  text: "  Acres Marathon",
                                  style: TextStyle(
                                    fontSize: Responsive.isDesktop(context)
                                        ? width * 0.01
                                        : 13.0,
                                    color: Color(0xFFD9DBE9),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Poppins",
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.015,
                          ),
                          RichText(
                            text: TextSpan(
                              text: "Request made by:",
                              style: TextStyle(
                                  fontSize: Responsive.isDesktop(context)
                                      ? width * 0.01
                                      : 13.0,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Poppins",
                                  color: Colors.white),
                              children: [
                                TextSpan(
                                  text: "  Ahmed Elizando",
                                  style: TextStyle(
                                    fontSize: Responsive.isDesktop(context)
                                        ? width * 0.01
                                        : 13.0,
                                    color: Color(0xFFD9DBE9),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Poppins",
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Responsive.isDesktop(context)
                                ? height * 0.04
                                : height * 0.04,
                          ),
                          TankDet(
                            tankDet: "Tank 1: Regular",
                            productID: "132",
                            requestedAmount: "4,500 Gal",
                          ),
                          SizedBox(
                            height: Responsive.isDesktop(context)
                                ? height * 0.04
                                : height * 0.02,
                          ),
                          TankDet(
                            tankDet: "Tank 2: Midgrade",
                            productID: "132",
                            requestedAmount: "5,500 Gal",
                          ),
                          SizedBox(
                            height: Responsive.isDesktop(context)
                                ? height * 0.04
                                : height * 0.02,
                          ),
                          TankDet(
                            tankDet: "Tank 3: Premium",
                            productID: "132",
                            requestedAmount: "8,000 Gal",
                          ),
                          SizedBox(
                            height: Responsive.isDesktop(context)
                                ? height * 0.04
                                : height * 0.02,
                          ),
                          TankDet(
                            tankDet: "Tank 4: ULSD",
                            productID: "132",
                            requestedAmount: "8,000 Gal",
                          ),
                          SizedBox(
                            height: Responsive.isDesktop(context)
                                ? height * 0.04
                                : height * 0.02,
                          ),
                          Visibility(
                            visible: Responsive.isDesktop(context),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    width: width * 0.08,
                                    height: height * 0.05,
                                    decoration: BoxDecoration(
                                      color: Color(0Xff5081db),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Close",
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
                          ),
                        ],
                      ),
                    ),
                    width: width,
                    topPad: 0.0,
                    height:
                        Responsive.isDesktop(context) ? height * 0.9 : height)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TankDet extends StatelessWidget {
  const TankDet({
    Key? key,
    required this.productID,
    required this.requestedAmount,
    required this.tankDet,
  }) : super(key: key);
  final String tankDet;
  final String requestedAmount;
  final String productID;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tankDet,
          style: TextStyle(
            fontSize: Responsive.isDesktop(context) ? width * 0.01 : 16.0,
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontFamily: "Poppins",
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              productID,
              style: TextStyle(
                fontSize: Responsive.isDesktop(context) ? width * 0.01 : 16.0,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
                color: Color(0xFF6E7191),
              ),
            ),
            Text(
              requestedAmount,
              style: TextStyle(
                fontSize: Responsive.isDesktop(context) ? width * 0.01 : 16.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: "Poppins",
              ),
            ),
          ],
        ),
      ],
    );
  }
}
