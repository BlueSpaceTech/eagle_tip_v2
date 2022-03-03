// ignore_for_file: prefer_const_constructors

import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/UI/Widgets/customContainer.dart';
import 'package:testttttt/UI/Widgets/customNav.dart';
import 'package:testttttt/UI/Widgets/logo.dart';
import 'package:testttttt/UI/views/post_auth_screens/Support/support_message.dart';
import 'package:testttttt/Utils/common.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SupportDesktop extends StatelessWidget {
  const SupportDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: backGround_color,
          child: Column(
            children: [
              Navbar(
                width: width,
                height: height,
                text1: "Home",
                text2: "Sites",
              ),
              SizedBox(
                height: height * 0.06,
              ),
              SupportCont(width: width, height: height)
            ],
          ),
        ),
      ),
    );
  }
}

class SupportCont extends StatelessWidget {
  const SupportCont({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backGround_color,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          SvgPicture.asset(
            webbg,
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.8,
          ),
          Padding(
            padding: EdgeInsets.only(
                left:
                    Responsive.isDesktop(context) ? width * 0.08 : width * 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Responsive.isDesktop(context)
                    ? Padding(
                        padding: EdgeInsets.only(top: height * 0.00),
                        child: Row(
                          children: [
                            Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: width * 0.02,
                            ),
                            SizedBox(
                              width: width * 0.014,
                            ),
                            Text(
                              "Back",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: width * 0.014,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Poppins",
                              ),
                            ),
                          ],
                        ),
                      )
                    : SizedBox(),
                SizedBox(
                  width: Responsive.isDesktop(context) ? width * 0.02 : 0.0,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: Responsive.isDesktop(context)
                        ? width * 0.45
                        : width * 0.9,
                    height: height * 0.75,
                    decoration: BoxDecoration(
                        color: Color(0xFF3f4850),
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: height * 0.054,
                          decoration: BoxDecoration(
                            color: Color(0xFF20272C),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: Responsive.isDesktop(context)
                                    ? width * 0.18
                                    : width * 0.34,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Support",
                                    style: TextStyle(
                                        fontSize: Responsive.isDesktop(context)
                                            ? width * 0.008
                                            : width * 0.02,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Poppins"),
                                  ),
                                  Text(
                                    "1 FEB 12:00",
                                    style: TextStyle(
                                        fontSize: Responsive.isDesktop(context)
                                            ? width * 0.007
                                            : width * 0.02,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Poppins"),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: Responsive.isDesktop(context)
                                    ? width * 0.16
                                    : width * 0.3,
                              ),
                              Image.asset(
                                Common.assetImages + "call_out.png",
                                width: Responsive.isDesktop(context)
                                    ? width * 0.015
                                    : width * 0.035,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: height * 0.01,
                              left: width * 0.01,
                              right: width * 0.0),
                          child: Row(
                            children: [
                              Container(
                                width: Responsive.isDesktop(context)
                                    ? width * 0.39
                                    : width * 0.8,
                                height: Responsive.isDesktop(context)
                                    ? height * 0.05
                                    : height * 0.03,
                                decoration: BoxDecoration(
                                  color: Color(0xFF20272C),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 10.0,
                                      top: Responsive.isDesktop(context)
                                          ? 10.0
                                          : 0.0,
                                      bottom: Responsive.isDesktop(context)
                                          ? 0.0
                                          : 15.0),
                                  child: TextFormField(
                                    textAlign: TextAlign.left,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Message",
                                      hintStyle: TextStyle(
                                        fontSize: Responsive.isDesktop(context)
                                            ? width * 0.01
                                            : width * 0.018,
                                        color: Color(0xFFA6A9AB),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Image.asset(
                                Common.assetImages + "Group_1.png",
                                width: width * 0.05,
                                height: height * 0.05,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: Responsive.isDesktop(context)
                      ? width * 0.14
                      : width * 0.0,
                ),
                Responsive.isDesktop(context)
                    ? Padding(
                        padding: EdgeInsets.only(top: height * 0.8),
                        child: Image.asset(
                          Common.assetImages + "Group 287.png",
                          width: Responsive.isDesktop(context)
                              ? width * 0.024
                              : width * 0.07,
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
