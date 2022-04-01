// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:testttttt/UI/Widgets/customappheader.dart';
import 'package:testttttt/UI/Widgets/logo.dart';
import 'package:testttttt/Utils/constants.dart';

class AboutCompany extends StatefulWidget {
  @override
  State<AboutCompany> createState() => _AboutCompanyState();
}

class _AboutCompanyState extends State<AboutCompany> {
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
                      "About the company",
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
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Eagle Transport Corporation",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Poppins",
                          fontSize: width * 0.03,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.005,
                      ),
                      Container(
                        width: width * 0.7,
                        // height: height,
                        child: Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Amet blandit id nulla quisque. Senectus ut odio blandit parturient amet vitae neque, mattis. Viverra cras ut turpis aliquet suspendisse feugiat ipsum. Enim, mi diam at lorem non a. Ornare nisl mollis in amet. Vel sit felis sollicitudin leo vitae ultrices a. Pharetra, molestie turpis condimentum proin natoque auctor felis. Sed id varius sit elementum est vel bibendum.",
                          style: TextStyle(
                            color: Color(0xFFD5D6D8),
                            fontFamily: "Poppins",
                            fontSize: width * 0.025,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
