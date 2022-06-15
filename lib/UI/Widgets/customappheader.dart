// ignore_for_file: prefer_const_constructors

import 'package:showcaseview/showcaseview.dart';
import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/UI/views/FAQss/mainfaq.dart';
import 'package:testttttt/UI/views/on-borading-tour/welcome_tour.dart';
import 'package:testttttt/UI/views/post_auth_screens/Support/support.dart';
import 'package:testttttt/UI/views/post_auth_screens/UserProfiles/myprofile.dart';
import 'package:testttttt/UI/views/post_auth_screens/tour.dart';
import 'package:testttttt/Utils/common.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:flutter/material.dart';

import '../views/post_auth_screens/HomeScreens/bottomNav.dart';
import 'logo.dart';

class CustomAppheader extends StatelessWidget {
  CustomAppheader({Key? key, required this.width}) : super(key: key);
  final double width;

  @override
  Widget build(BuildContext context) {
    bool? isTapped = false;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.08),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(""),
          Logo(width: width),
          MenuButton(isTapped: isTapped, width: width),
        ],
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  MenuButton({
    Key? key,
    required this.isTapped,
    required this.width,
  }) : super(key: key);

  final bool? isTapped;
  final double width;

  Map ScreeRoutes = {1: MainFaq(), 2: SupportScreen(), 3: WelcomeTour()};
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      padding: EdgeInsets.only(bottom: 500.0),
      onSelected: (value) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ScreeRoutes[value]));
      },
      color: Color(0xFF3f4850),
      child: isTapped!
          ? Image.asset(
              Common.assetImages + "Group 287.png",
              width:
                  Responsive.isDesktop(context) || Responsive.isTablet(context)
                      ? width * 0.03
                      : width * 0.075,
            )
          : Image.asset(
              Common.assetImages + "Group 288.png",
              width:
                  Responsive.isDesktop(context) || Responsive.isTablet(context)
                      ? width * 0.03
                      : width * 0.082,
            ),
      itemBuilder: (context) => [
        PopupMenuItem(
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.faq);
            },
            child: Text(
              "FAQ",
              style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontFamily: "Poppins"),
            ),
          ),
          value: 1,
        ),
        PopupMenuItem(
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.support);
            },
            child: Text(
              "Support Ticket",
              style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontFamily: "Poppins"),
            ),
          ),
          value: 2,
        ),
        PopupMenuItem(
          child: Text(
            "Take Tour Again",
            style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontFamily: "Poppins"),
          ),
          value: 3,
        )
      ],
    );
  }
}
