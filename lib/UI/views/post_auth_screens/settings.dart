// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:testttttt/UI/Widgets/customappheader.dart';
import 'package:testttttt/UI/Widgets/logo.dart';
import 'package:testttttt/Utils/common.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class Settings extends StatefulWidget {
  Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Push Notifications",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Poppins"),
                    ),
                    FlutterSwitch(
                        height: 30,
                        width: 60,
                        padding: 2.0,
                        toggleSize: 27,
                        activeColor: Color(0xFF5081db),
                        inactiveColor: Color(0xFFd9dbe9),
                        value: switchVal1!,
                        onToggle: (val) {
                          setState(() {
                            switchVal1 = val;
                          });
                        })
                  ],
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "In-App Notifications",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Poppins"),
                    ),
                    FlutterSwitch(
                        height: 30,
                        width: 60,
                        padding: 2.0,
                        toggleSize: 27,
                        activeColor: Color(0xFF5081db),
                        inactiveColor: Color(0xFFd9dbe9),
                        value: switchVal2!,
                        onToggle: (val) {
                          setState(() {
                            switchVal2 = val;
                          });
                        })
                  ],
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                Text(
                  "Default Site",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Poppins"),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Container(
                  height: height * 0.072,
                  width: width * 0.89,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: width * 0.04, right: width * 0.04),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Acres Marathon",
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Poppins"),
                        ),
                        Image.asset(
                          Common.assetImages + "down_black.png",
                          width: width * 0.07,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Text(
                  "Log out",
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Color(0xFF92b8ff),
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Poppins"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
