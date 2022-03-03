// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:testttttt/UI/views/post_auth_screens/CRUD/Add%20New%20User/Owner/addUserOwner.dart';
import 'package:testttttt/Utils/common.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:flutter/material.dart';

class AddUserByManager extends StatelessWidget {
  const AddUserByManager({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: height,
            color: backGround_color,
            child: Padding(
              padding: EdgeInsets.only(
                  left: width * 0.04, right: width * 0.04, top: height * 0.01),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: width * 0.06,
                      ),
                      SizedBox(
                        width: width * 0.17,
                      ),
                      Image.asset(Common.assetImages + "Logo 2 2.png"),
                      SizedBox(
                        width: width * 0.2,
                      ),
                      Image.asset(
                        Common.assetImages + "Group 288.png",
                        width: width * 0.08,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.06,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Add new user",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontFamily: "Poppins",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  Text(
                    "Site",
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      fontFamily: "Poppins",
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  /*
                  Row(
                    children: [
                      SiteChip(siteName: "Acres Marathon", height: height),
                      SizedBox(
                        width: 10.0,
                      ),
                      SiteChip(siteName: "Bridge Marathon", height: height),
                    ],
                  ),
                  */
                  SizedBox(
                    height: height * 0.45,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13.0),
                        ),
                        child: Container(
                          height: height * 0.06,
                          width: width * 0.33,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13.0),
                            color: Color(0xFF5081db),
                          ),
                          child: Center(
                            child: Text(
                              "Next",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontFamily: "Poppins"),
                            ),
                          ),
                        ),
                      ),
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
