// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/UI/Widgets/customContainer.dart';
import 'package:testttttt/UI/Widgets/customHeader2.dart';
import 'package:testttttt/UI/Widgets/customNav.dart';
import 'package:testttttt/UI/Widgets/custom_webbg.dart';
import 'package:testttttt/UI/Widgets/customappheader.dart';
import 'package:testttttt/Utils/common.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:flutter/material.dart';

class TicketDetail extends StatelessWidget {
  TicketDetail(
      {Key? key,
      required this.ticketTitle,
      required this.status,
      required this.siteName,
      required this.ticketMessage,
      required this.userName,
      required this.date})
      : super(key: key);

  final String ticketTitle;
  final String status;
  final String siteName;
  final String ticketMessage;
  final String userName;
  final String date;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: Responsive.isDesktop(context)
          ? MenuButton(isTapped: false, width: width)
          : SizedBox(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: Responsive.isDesktop(context) ? height * 1.17 : height,
            color: backGround_color,
            child: Padding(
              padding: EdgeInsets.only(
                  top: height * 0.01,
                  left: Responsive.isDesktop(context) ? 0.0 : width * 0.04,
                  right: Responsive.isDesktop(context) ? 0.0 : width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                    height: height * 0.06,
                  ),
                  Stack(
                    children: [
                      WebBg(),
                      CustomContainer(
                          opacity: 0.2,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: Responsive.isDesktop(context)
                                    ? width * 0.04
                                    : 0.0,
                                right: Responsive.isDesktop(context)
                                    ? width * 0.04
                                    : 0.0,
                                top: Responsive.isDesktop(context)
                                    ? height * 0.03
                                    : 0.0),
                            child: Column(
                              children: [
                                Ticketdet(
                                  date: date,
                                  siteName: siteName,
                                  userName: userName,
                                  status: status,
                                ),
                                SizedBox(
                                  height: height * 0.04,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      ticketTitle,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontFamily: "Poppins",
                                          fontSize: 18.0),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height * 0.04,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "$userName: ",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Poppins"),
                                    ),
                                    Container(
                                      width: width * 0.9,
                                      child: Text(
                                        ticketMessage,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "Poppins"),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height * 0.04,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Support: ",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "Poppins"),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      width: width * 0.9,
                                      child: Text(
                                        "Diam aenean ullamcorper viverra sed tincidunt. Volutpat amet et scelerisque lacus, vitae rhoncus iaculis. In egestas a cras orci cras. Neque at magna nunc turpis. Leo mattis porttitor sed nisl.",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "Poppins"),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: Responsive.isDesktop(context)
                                      ? height * 0.05
                                      : height * 0.03,
                                ),
                                CustomButton(
                                  width: width,
                                  height: height,
                                  buttonText: "Reply",
                                ),
                              ],
                            ),
                          ),
                          width: width,
                          topPad: 0.0,
                          height: height * 0.85)
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.width,
    required this.buttonText,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context, false);
      },
      child: Container(
        width: Responsive.isDesktop(context) ? width * 0.27 : width * 0.9,
        height: Responsive.isDesktop(context) ? height * 0.055 : height * 0.07,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Color(0xFF5081DB),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontFamily: "Poppins"),
          ),
        ),
      ),
    );
  }
}

class Ticketdet extends StatelessWidget {
  const Ticketdet({
    Key? key,
    required this.userName,
    required this.date,
    required this.siteName,
    required this.status,
  }) : super(key: key);
  final String userName;
  final String siteName;
  final String date;
  final String status;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: "User:",
                style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Poppins",
                    color: Colors.white),
                children: [
                  TextSpan(
                    text: "  $userName",
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Color(0xFFD9DBE9),
                      fontWeight: FontWeight.w400,
                      fontFamily: "Poppins",
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            RichText(
              text: TextSpan(
                text: "Site:",
                style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Poppins",
                    color: Colors.white),
                children: [
                  TextSpan(
                    text: "  $siteName",
                    style: TextStyle(
                      fontSize: 13.0,
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: "Date:",
                style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Poppins",
                    color: Colors.white),
                children: [
                  TextSpan(
                    text: date,
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Color(0xFFD9DBE9),
                      fontWeight: FontWeight.w400,
                      fontFamily: "Poppins",
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            RichText(
              text: TextSpan(
                text: "Status:",
                style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Poppins",
                    color: Colors.white),
                children: [
                  TextSpan(
                    text: "  $status",
                    style: TextStyle(
                      fontSize: 13.0,
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
      ],
    );
  }
}
