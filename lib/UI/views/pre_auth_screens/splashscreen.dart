import 'dart:async';

import 'package:testttttt/UI/Widgets/logo.dart';
import 'package:testttttt/UI/views/post_auth_screens/HomeScreens/Home_screen.dart';
import 'package:testttttt/UI/views/pre_auth_screens/login_screen.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  checkscreen() {}

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: backGround_color,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0),
        child: Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Responsive.isDesktop(context)
                  ? LogoSplash(width: width)
                  : Logo(
                      width: width * 2,
                    ),
              SizedBox(
                height: height * 0.02,
              ),
              Text(
                "Eagle Transport Inventry Program",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Poppins",
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: height * 0.18,
              ),
              CircularProgressIndicator(
                color: Colors.white,
              ),
              SizedBox(
                height: height * 0.04,
              ),
              Text(
                "Loading",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Poppins",
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
