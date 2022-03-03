// ignore_for_file: prefer_const_constructors

import 'package:testttttt/UI/views/post_auth_screens/Support/support.dart';
import 'package:testttttt/Utils/common.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:flutter/material.dart';

class SupportMessage extends StatelessWidget {
  const SupportMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: width,
          height: height,
          color: backGround_color,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: height * 0.02,
                    left: width * 0.07,
                    right: width * 0.05),
                child: TopRow(width: width),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Text(
                "Support",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 18.0,
                    fontFamily: "Poppins"),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Text(
                "1 FEB 12.00",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 12.0,
                    fontFamily: "Poppins"),
              ),
              SizedBox(
                height: height * 0.66,
              ),
              MessageRow(width: width, height: height),
            ],
          ),
        ),
      ),
    );
  }
}

class MessageRow extends StatelessWidget {
  const MessageRow({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: [
          Container(
            width: width * 0.89,
            height: height * 0.06,
            decoration: BoxDecoration(
              color: Color(0xFF20272C),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Write...",
                  hintStyle: TextStyle(
                    fontSize: 14.0,
                    color: Color(0xFFA6A9AB),
                  ),
                ),
              ),
            ),
          ),
          Image.asset(
            Common.assetImages + "Group_1.png",
            width: width * 0.11,
          ),
        ],
      ),
    );
  }
}
