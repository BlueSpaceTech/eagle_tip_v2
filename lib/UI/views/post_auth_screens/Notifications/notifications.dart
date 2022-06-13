// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:testttttt/Models/sites.dart';
import 'package:testttttt/Providers/user_provider.dart';
import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/UI/Widgets/customContainer.dart';
import 'package:testttttt/UI/Widgets/customHeader2.dart';
import 'package:testttttt/UI/Widgets/customNav.dart';
import 'package:testttttt/UI/Widgets/custom_webbg.dart';
import 'package:testttttt/UI/Widgets/customappheader.dart';
import 'package:testttttt/UI/Widgets/logo.dart';
import 'package:testttttt/UI/views/post_auth_screens/HomeScreens/Home_screen.dart';
import 'package:testttttt/UI/views/post_auth_screens/Notifications/particularNotification.dart';
import 'package:testttttt/UI/views/post_auth_screens/Support/support_desktop.dart';
import 'package:testttttt/Utils/common.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testttttt/Models/user.dart' as model;

import '../../../../Services/site_call.dart';

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
  List<SitesDetails>? sitedetails;

  getData() async {
    sitedetails = await SiteCall().getSites();
  }

  List isNew = [true, true, false, false, false];
  getsiteloc(String currentsite) {
    String siteloc = "";
    sitedetails!.forEach((element) {
      if (element.sitename == currentsite) {
        setState(() {
          siteloc = element.sitelocation;
        });
      }
    });
    return siteloc;
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
    print(Uri.base);
  }

  @override
  Widget build(BuildContext context) {
    model.User? user = Provider.of<UserProvider>(context).getUser;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Responsive.isDesktop(context)
          ? MenuButton(isTapped: false, width: width)
          : SizedBox(),
      body: SingleChildScrollView(
        child: Container(
          width: width,
          height: Responsive.isDesktop(context) || Responsive.isTablet(context)
              ? height * 1.18
              : height,
          color: backGround_color,
          child: Padding(
            padding: EdgeInsets.only(
                top: Responsive.isDesktop(context) ||
                        Responsive.isTablet(context)
                    ? height * 0.02
                    : height * 0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: Responsive.isDesktop(context) ||
                      Responsive.isTablet(context),
                  child: Navbar(
                    width: width,
                    height: height,
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
                    child: Row(
                      children: [
                        Text(""),
                        SizedBox(
                          width: width * 0.15,
                        ),
                        Logo(width: width),
                        SizedBox(
                          width: width * 0.14,
                        ),
                        // Image.asset(
                        //   Common.assetImages + "Vector.png",
                        //   width: width * 0.048,
                        // ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Visibility(
                  visible: Responsive.isMobile(context),
                  child: Padding(
                    padding: EdgeInsets.only(left: width * 0.08),
                    child: Text(
                      "Notifications",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: Responsive.isDesktop(context) ||
                      Responsive.isTablet(context),
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
                                        GestureDetector(
                                          onTap: () {},
                                          child: Text(
                                            user!.currentsite,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 19.0,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "Poppins"),
                                          ),
                                        ),
                                        // Text(
                                        //   "getsiteloc(user.currentsite)",
                                        //   style: TextStyle(
                                        //       color: Color(0xFF6E7191),
                                        //       fontSize: 13.0,
                                        //       fontWeight: FontWeight.w500,
                                        //       fontFamily: "Poppins"),
                                        // ),
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
                                            return Center(
                                              child: Text(
                                                "No Notifications to display",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13.0),
                                              ),
                                            );
                                          }
                                          return snapshot.data?.docs.length
                                                      .toInt() ==
                                                  0
                                              ? Center(
                                                  child: Text(
                                                  "No Notifications to display",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 13.0),
                                                ))
                                              : ListView.builder(
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  itemCount: snapshot
                                                      .data?.docs.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    final document = snapshot
                                                        .data?.docs[index];
                                                    List docSiteslen =
                                                        document!["sites"];
                                                    bool? visibleTo() {
                                                      for (int i = 0;
                                                          i <
                                                              docSiteslen
                                                                  .length;
                                                          i++) {
                                                        for (int j = 0;
                                                            j <
                                                                user.sites
                                                                    .length;
                                                            j++) {
                                                          if (document["sites"]
                                                                  [i] ==
                                                              user.sites[j]
                                                                  .toString()
                                                                  .replaceAll(
                                                                      " ",
                                                                      "")) {
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
                                                          width: width,
                                                          // isnew: document!["isNew"],
                                                          newNotify:
                                                              document["isNew"],
                                                          docid: document.id,
                                                          hyperlinkk: document[
                                                              "hyperLink"],
                                                          userid: FirebaseAuth
                                                              .instance
                                                              .currentUser!
                                                              .uid
                                                              .toString(),
                                                          notifyContent:
                                                              document[
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
                                Visibility(
                                  visible: user.userRole != "SiteUser",
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(context,
                                          AppRoutes.createNotification);
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: width * 0.11,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Color(0xff5081DB),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
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
                  height: Responsive.isDesktop(context) ||
                          Responsive.isTablet(context)
                      ? height * 0.06
                      : height * 0.02,
                ),
                Visibility(
                  visible: Responsive.isMobile(context),
                  child: Center(
                    child: Container(
                      height: height * 0.6,
                      width: Responsive.isDesktop(context) ||
                              Responsive.isTablet(context)
                          ? width * 0.5
                          : width,
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("pushNotifications")
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
                                  // List notifs = document!["isNew"];

                                  return snapshot.data?.docs.length.toInt() == 0
                                      ? Center(
                                          child: Text(
                                          "No Notifications to display",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13.0),
                                        ))
                                      : Notify(
                                          width: width,
                                          // isnew: document!["isNew"],
                                          newNotify: document!["isNew"],
                                          hyperlinkk: document["hyperLink"],
                                          docid: document.id,
                                          userid: FirebaseAuth
                                              .instance.currentUser!.uid
                                              .toString(),
                                          notifyContent:
                                              document["description"],
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
    // required this.isnew,
    required this.notifyDate,
    required this.newNotify,
    required this.docid,
    // required this.valueChanged,
    required this.userid,
    required this.hyperlinkk,
  }) : super(key: key);

  final double width;
  final double height;
  final List newNotify;
  final String userid;
  final String docid;
  final String notifyName;
  // final int index;
  final String hyperlinkk;
  final String notifyDate;
  // final ValueChanged valueChanged;
  final String notifyContent;

  @override
  State<Notify> createState() => _NotifyState();
}

class _NotifyState extends State<Notify> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(widget.hyperlinkk);
        setState(() {
          if (!widget.newNotify.contains(widget.userid)) {
            widget.newNotify.add(widget.userid);
          }
          FirebaseFirestore.instance
              .collection("pushNotifications")
              .doc(widget.docid)
              .update({
            "isNew": widget.newNotify,
          });
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SpecificNotification(
                notifyName: widget.notifyName,
                hyperlink: widget.hyperlinkk,
                notifyContent: widget.notifyContent),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 10.0, right: widget.width * 0.06),
        child: SizedBox(
          height: widget.height * 0.06,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
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
                      SizedBox(
                        width: widget.width * 0.007,
                      ),
                      !widget.newNotify.contains(widget.userid)
                          ? CircleAvatar(
                              backgroundColor: Colors.blue, maxRadius: 4.0)
                          : SizedBox(),
                    ],
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
