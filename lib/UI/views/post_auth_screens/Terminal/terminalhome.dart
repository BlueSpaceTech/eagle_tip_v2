// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_element, avoid_print

import 'dart:convert';
// import 'dart:html';
// import 'dart:html';
import 'package:intl/intl.dart';

import 'package:csv/csv.dart';
import 'package:provider/provider.dart';
import 'package:testttttt/Providers/user_provider.dart';
import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/UI/Widgets/customNav.dart';
import 'package:testttttt/UI/Widgets/customfab.dart';
import 'package:testttttt/UI/Widgets/customsubmitbutton.dart';
import 'package:testttttt/UI/views/post_auth_screens/Chat/allchats.dart';
import 'package:flutter/material.dart';
import 'package:testttttt/Models/user.dart' as model;

// import 'package:testttttt/UI/views/post_auth_screens/Sites/site_details.dart';
import 'package:testttttt/UI/views/post_auth_screens/Tanks/tanks_request.dart';

class TerminalHome extends StatefulWidget {
  final List sites;
  const TerminalHome({Key? key, required this.sites}) : super(key: key);

  @override
  _TerminalHomeState createState() => _TerminalHomeState();
}

class _TerminalHomeState extends State<TerminalHome> {
  List siteImg = ["site1", "site2"];
  List siteName = ["Acres Marathon", "Akron Marathon"];
  List sitelocation = ["Tampa,FL", "Leesburg,FL"];
  @override
  Widget build(BuildContext context) {
    // model.User user = Provider.of<UserProvider>(context).getUser;

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Navbar(
                  width: width,
                  height: height,
                  text1: "Home",
                  text2: "Sites",
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: height * 0.9,
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        decoration: BoxDecoration(color: Color(0xff20272C)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: height * 0.2,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.crudscreen);
                              },
                              child: CustomSubmitButton(
                                  width: width, title: "Edit Employees"),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.faqTerminal);
                                },
                                child: CustomSubmitButton(
                                    width: width, title: "Edit FAQ")),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.createNotification);
                              },
                              child: CustomSubmitButton(
                                  width: width, title: "Send Notification"),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 5,
                        child: Container(
                          height: height * 0.9,
                          decoration: BoxDecoration(color: Color(0xff2B343B)),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "Order Request Status",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 32,
                                            fontFamily: "Poppins"),
                                      ),
                                      Text(
                                        "19-02-2022",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff6E7191),
                                            fontSize: 20,
                                            fontFamily: "Poppins"),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: width * 0.06),
                                  InkWell(
                                    onTap: () async {},
                                    child: customfab(
                                        width: width,
                                        text: "Create Report",
                                        height: height),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.02),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: width * 0.03),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Sites",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.white,
                                                          fontSize: 17,
                                                          fontFamily:
                                                              "Poppins"),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      "6/7",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color:
                                                              Color(0xff6E7191),
                                                          fontSize: 15,
                                                          fontFamily:
                                                              "Poppins"),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  "Send Reminder",
                                                  style: TextStyle(
                                                      decoration: TextDecoration
                                                          .underline,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color(0xff92B8FF),
                                                      fontSize: 15,
                                                      fontFamily: "Poppins"),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            width: width * 0.28,
                                            height: height * 0.6,
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black,
                                                  blurRadius: 1.0,
                                                ),
                                              ],
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)),
                                              color: Color(0xff313D47),
                                            ),
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: width * 0.01,
                                                  vertical: height * 0.02),
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return SiteDett(
                                                    width: width,
                                                    siteImg: siteImg,
                                                    index: index,
                                                    siteName: siteName,
                                                    sitelocation: sitelocation);
                                              },
                                              itemCount: siteImg.length,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.02),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: width * 0.03),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Request Recieved",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.white,
                                                          fontSize: 17,
                                                          fontFamily:
                                                              "Poppins"),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      "1/7",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color:
                                                              Color(0xff6E7191),
                                                          fontSize: 15,
                                                          fontFamily:
                                                              "Poppins"),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            width: width * 0.28,
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black,
                                                  blurRadius: 1.0,
                                                ),
                                              ],
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)),
                                              color: Color(0xff313D47),
                                            ),
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: width * 0.01,
                                                  vertical: height * 0.02),
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return SiteDett(
                                                    width: width,
                                                    siteImg: siteImg,
                                                    index: index,
                                                    siteName: siteName,
                                                    sitelocation: sitelocation);
                                              },
                                              itemCount: siteImg.length,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
