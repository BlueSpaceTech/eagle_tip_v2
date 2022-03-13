// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:testttttt/Providers/user_provider.dart';
import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/UI/Widgets/customContainer.dart';
import 'package:testttttt/UI/Widgets/customHeader2.dart';
import 'package:testttttt/UI/Widgets/customNav.dart';
import 'package:testttttt/UI/Widgets/custom_webbg.dart';
import 'package:testttttt/UI/Widgets/customappheader.dart';
import 'package:testttttt/UI/Widgets/logo.dart';
import 'package:testttttt/UI/views/post_auth_screens/Notifications/particularNotification.dart';
import 'package:testttttt/UI/views/post_auth_screens/Support/support_desktop.dart';
import 'package:testttttt/Utils/common.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testttttt/Models/user.dart' as model;

class Notifications extends StatefulWidget {
  Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List<String> notifyNames = [
    "Hurricane Coming!",
    "Edget Iaoreet",
    "Vel mauris",
    "Dapibus massa",
    "Diam dolor"
  ];

  List<String> notifyDates = [
    "Today",
    "9/22/16",
    "6/9/14",
    "2/11/12",
    "5/7/16"
  ];

  List isNew = [true, true, false, false, false];

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: Responsive.isDesktop(context)
          ? MenuButton(isTapped: false, width: width)
          : SizedBox(),
      body: SingleChildScrollView(
        child: Container(
          width: width,
          height: Responsive.isDesktop(context) ? height * 1.12 : height,
          color: backGround_color,
          child: Padding(
            padding: EdgeInsets.only(
                top: Responsive.isDesktop(context)
                    ? height * 0.02
                    : height * 0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: Responsive.isDesktop(context),
                  child: Navbar(
                    width: width,
                    height: height,
                    text1: "Home",
                    text2: "Chat",
                    /*
                    widget3: Row(
                      children: [
                        Text(
                          "Notifications",
                          style: TextStyle(
                            fontSize: Responsive.isDesktop(context)
                                ? width * 0.01
                                : width * 0.02,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins",
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Container(
                          child: CircleAvatar(
                            backgroundColor: Color(0xFFED5C62),
                            radius: 8.0,
                            child: Center(
                              child: Text(
                                _notifyNumberGenerator().toString(),
                                style: TextStyle(fontSize: 10.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    */
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.09),
                  child: Visibility(
                    visible: Responsive.isMobile(context),
                    child: CustomHeader2(),
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Visibility(
                  visible: Responsive.isMobile(context),
                  child: Padding(
                    padding: EdgeInsets.only(left: width * 0.08),
                    child: Row(
                      children: [
                        Text(
                          "Notifications",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: "Poppins",
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Container(
                          child: CircleAvatar(
                            backgroundColor: Color(0xFFED5C62),
                            radius: 8.0,
                            child: Center(
                              child: Text(
                                "",
                                style: TextStyle(fontSize: 10.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: Responsive.isDesktop(context),
                  child: Stack(
                    children: [
                      Opacity(opacity: 0.2, child: WebBg()),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: width * 0.15,
                          ),
                          Container(
                            width: width * 0.5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          "Acres Marathon",
                                          style: TextStyle(
                                            fontSize: width * 0.008,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "Poppins",
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          height: height * 0.003,
                                        ),
                                        Text(
                                          "Tampa,FL",
                                          style: TextStyle(
                                            fontSize: width * 0.007,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "Poppins",
                                            color: Color(0xFF6E7191),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height * 0.05,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: width * 0.05),
                                  child: Container(
                                    height: height * 0.6,
                                    width: width * 0.5,
                                    child: StreamBuilder(
                                        stream: FirebaseFirestore.instance
                                            .collection("pushNotifications")
                                            .where("visibleto",
                                                arrayContainsAny: [
                                              user.userRole
                                            ]).snapshots(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<QuerySnapshot>
                                                snapshot) {
                                          if (!snapshot.hasData) {
                                            return CircularProgressIndicator();
                                          }
                                          return ListView.builder(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount:
                                                  snapshot.data?.docs.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                final document =
                                                    snapshot.data?.docs[index];
                                                List docSiteslen =
                                                    document!["sites"];
                                                bool? visibleTo() {
                                                  for (int i = 0;
                                                      i < docSiteslen.length;
                                                      i++) {
                                                    for (int j = 0;
                                                        j < user.sites.length;
                                                        j++) {
                                                      if (document["sites"]
                                                              [i] ==
                                                          user.sites[j]) {
                                                        return true;
                                                      } else {
                                                        continue;
                                                      }
                                                    }
                                                  }
                                                  return false;
                                                }

                                                if (visibleTo()!) {
                                                  return Notify(
                                                      valueChanged: (val) {
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                "pushNotifications")
                                                            .doc(document.id)
                                                            .update(
                                                                {"isNew": val});
                                                      },
                                                      width: width,
                                                      isnew: document["isNew"],
                                                      notifyContent: document[
                                                          "description"],
                                                      // index: index,
                                                      height: height,
                                                      notifyName:
                                                          document["title"],
                                                      notifyDate: document[
                                                          "description"]);
                                                } else {
                                                  return Text("");
                                                }
                                              });
                                        }),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: width * 0.02,
                          ),
                          Container(
                            height: height * 0.8,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, AppRoutes.createNotification);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: width * 0.11,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Color(0xff5081DB),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Create Notification",
                                          style: TextStyle(
                                              fontSize: width * 0.008,
                                              color: Colors.white,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          width: width * 0.005,
                                        ),
                                        Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Responsive.isDesktop(context)
                      ? height * 0.06
                      : height * 0.02,
                ),
                Visibility(
                  visible: Responsive.isMobile(context),
                  child: Center(
                    child: Container(
                      height: height * 0.6,
                      width:
                          Responsive.isDesktop(context) ? width * 0.5 : width,
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("notifications")
                              .where("visibleto", arrayContainsAny: [
                            user.userRole
                          ]).snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return CircularProgressIndicator();
                            }
                            return ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data?.docs.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final document = snapshot.data?.docs[index];
                                  return Notify(
                                      valueChanged: (val) {
                                        FirebaseFirestore.instance
                                            .collection("notifications")
                                            .doc(document!.id)
                                            .update({"isNew": val});
                                      },
                                      width: width,
                                      isnew: document!["isNew"],
                                      notifyContent: document["description"],
                                      // index: index,
                                      height: height,
                                      notifyName: document["title"],
                                      notifyDate: document["description"]);
                                });
                          }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Notify extends StatefulWidget {
  Notify({
    Key? key,
    required this.width,
    required this.height,
    required this.notifyContent,
    required this.notifyName,
    // required this.index,
    required this.isnew,
    required this.notifyDate,
    required this.valueChanged,
  }) : super(key: key);

  final double width;
  final bool isnew;
  final double height;
  final String notifyName;
  // final int index;
  final ValueChanged valueChanged;
  final String notifyDate;
  final String notifyContent;

  @override
  State<Notify> createState() => _NotifyState();
}

class _NotifyState extends State<Notify> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final newNotify = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SpecificNotification(
                notifyName: widget.notifyName,
                notifyContent: widget.notifyContent),
          ),
        );
        setState(() {
          if (newNotify != null) {
            widget.valueChanged(newNotify);
          }
        });
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 10.0, right: widget.width * 0.06),
        child: Container(
          height: widget.height * 0.06,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: Responsive.isDesktop(context)
                    ? widget.width * 0.3
                    : widget.width * 0.5,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.isnew
                        ? Image.asset(
                            Common.assetImages + "Rectangle 522.png",
                            height: Responsive.isDesktop(context)
                                ? widget.height * 0.036
                                : widget.height * 0.05,
                          )
                        : SizedBox(),
                    SizedBox(
                      width: Responsive.isDesktop(context)
                          ? widget.width * 0.01
                          : widget.width * 0.07,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.notifyName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Poppins",
                          ),
                        ),
                        Text(
                          widget.notifyDate,
                          style: TextStyle(
                            color: Color(0xFFD9DBE9),
                            fontSize: 10.0,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 17.0,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
