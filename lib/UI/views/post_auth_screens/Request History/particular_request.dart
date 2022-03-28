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
  ParticularRequest({
    Key? key,
    required this.tanksData,
    required this.name,
    required this.orderid,
    required this.date,
    required this.sitename,
  }) : super(key: key);
  late final List tanksData;
  late final String name;
  late final String sitename;
  late final String date;
  late final String orderid;
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
                                  "Inventory Resquest: $orderid",
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
                                      text: "  #$orderid",
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
                                      text: "  $date",
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
                                  text: "  $sitename",
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
                                  text: "  $name",
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
                          Tankss(tanksdata: tanksData, height: height),
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

class Tankss extends StatelessWidget {
  Tankss({Key? key, required this.tanksdata, required this.height})
      : super(key: key);
  final List tanksdata;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.4,
      child: ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: tanksdata.length,
          separatorBuilder: (context, index) {
            return SizedBox(
              height:
                  Responsive.isDesktop(context) ? height * 0.04 : height * 0.02,
            );
          },
          itemBuilder: (context, index) {
            return TankDet(
              tankDet:
                  "Tank ${tanksdata[index]["tanknumber"]}: ${tanksdata[index]["fueltype"]}",
              productID: "${tanksdata[index]["tankid"]}",
              requestedAmount: "${tanksdata[index]["amount"]}",
            );
          }),
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
