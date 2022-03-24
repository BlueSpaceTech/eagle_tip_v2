// ignore_for_file: prefer_const_constructors, duplicate_ignore, unused_import, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:testttttt/Providers/user_provider.dart';
import 'package:testttttt/Routes/approutes.dart';

import 'package:testttttt/Services/authentication_helper.dart';
import 'package:testttttt/UI/Widgets/customNav.dart';
import 'package:testttttt/UI/Widgets/custom_webbg.dart';
import 'package:testttttt/UI/Widgets/customappheader.dart';
import 'package:testttttt/UI/Widgets/customsubmitbutton.dart';
import 'package:testttttt/UI/Widgets/logo.dart';
import 'package:testttttt/UI/views/post_auth_screens/UserProfiles/myprofile.dart';
import 'package:testttttt/Utils/common.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:firebase_messaging_platform_interface/firebase_messaging_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testttttt/Models/user.dart' as model;
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool? isTapped = false;

  bool isLoading = false;

  @override
  void initState() {
    //addData();
    // TODO: implement initState
    super.initState();
    // model.User user = Provider.of<UserProvider>(context).getUser;
    // CollectionReference tokens =
    //     FirebaseFirestore.instance.collection("tokens");
    // FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    // firebaseMessaging.getToken().then((value) {
    //   print(value);
    //   // tokens.doc(user.userRole).update(data);
    // });

    addData();
    checkupdateTC();
    print(showdilog);

    //print(checkupdateTC());
    //checkupdateTC();
  }

  TermConditions(double widht, double height, bool show) {
    return showDialog(
      context: context,
      builder: (ctx) => Dialog(
        child: Visibility(
          visible: show,
          child: Container(
            padding: EdgeInsets.all(20),
            width: widht * 0.7,
            height: height * 0.9,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.close)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Terms and conditions Updated",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: "Poppins",
                          fontSize: 24),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "use the link below to view updated Terms and Conditions. Once you have read the content, acknowledge you understand and agree by clicking the ${"agree"} button.",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 18,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
                Container(
                  height: height * 0.5,
                  child: SingleChildScrollView(
                      child: Column(children: [
                    Container(
                      height: height * 0.8,
                      color: Colors.red,
                      child: Text(""),
                    ),
                  ])),
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    "https://link-of-terms&conditions",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff5081DB),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ]),
                SizedBox(
                  height: 2,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () {},
                        child:
                            CustomSubmitButton(width: widht, title: "Agree")),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List? check;
  DocumentReference dialog = FirebaseFirestore.instance
      .collection('termconditions')
      .doc("k5c1eJ3DFh3P9IO7HEAA")
      .collection("dialog")
      .doc("yFXxdJGVDUkgU8o8hCUU");
  bool showdilog = false;
  final FirebaseAuth auth = FirebaseAuth.instance;
  checkupdateTC() async {
    bool showdilogg = false;
    print("inside");
    DocumentReference dbRef = await FirebaseFirestore.instance
        .collection('termconditions')
        .doc("k5c1eJ3DFh3P9IO7HEAA")
        .collection("dialog")
        .doc("yFXxdJGVDUkgU8o8hCUU");
    print("inside2");

    await dbRef.get().then((data) {
      if (data.exists) {
        setState(() {
          check = data.get("viewedby");
        });
        print("dataexts");
        print(check);
        if (check!.contains(auth.currentUser!.uid)) {
          print("already viewed");
        } else {
          WidgetsBinding.instance!.addPostFrameCallback((_) async {
            if (true) {
              await _showDialog();
            }
          });
        }
      }
    });
    // return showdilogg;
  }

  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  _showDialog() {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              padding: EdgeInsets.all(20),
              width: 600,
              height: 400,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                          onTap: () {
                            AuthFunctions.signOut();
                            Navigator.pushNamed(context, AppRoutes.loginscreen);
                          },
                          child: Icon(Icons.close)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Terms and conditions Updated",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: "Poppins",
                            fontSize: 24),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "use the link below to view updated Terms and Conditions. Once you have read the content, acknowledge you understand and agree by clicking the ${"agree"} button.",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 18,
                            fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "https://link-of-terms&conditions",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff5081DB),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ]),
                  SizedBox(
                    height: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () {
                            check!.add(auth.currentUser!.uid);
                            print(check);
                            dialog.update({"viewedby": check}).then(
                                (value) => Navigator.pop(context));
                          },
                          child:
                              CustomSubmitButton(width: 1000, title: "Agree")),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Responsive.isDesktop(context)
          ? MenuButton(isTapped: false, width: width)
          : SizedBox(),
      body: isLoading == true
          ? CircularProgressIndicator()
          : SingleChildScrollView(
              child: Container(
                height: Responsive.isDesktop(context) ? height : height * 1.5,
                color: backGround_color,
                child: Responsive.isDesktop(context)
                    ? Stack(
                        children: [
                          Opacity(opacity: 0.2, child: WebBg()),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // TermConditions(width, height, showdilog),
                              Navbar(
                                width: width,
                                height: height,
                                text1: "Home",
                                text2: "Chat",
                              ),
                              SizedBox(
                                height: height * 0.05,
                              ),
                              SiteNameAndLocation(
                                  fontSize: 17.0, fontSize2: 13.0),
                              SizedBox(
                                height: height * 0.05,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.siteDetails,
                                  );
                                },
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image.asset(
                                      Common.assetImages + "Ellipse 49.png",
                                      width: width * 0.15,
                                    ),
                                    SizedBox(
                                      width: width * 0.068,
                                      child: Text(
                                        "Request fuel",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: width * 0.016,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                            fontFamily: "Poppins"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: height * 0.07,
                              ),
                              Visibility(
                                visible: user.userRole != "SiteUser",
                                child: InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, AppRoutes.siteScreen);
                                    },
                                    child: SiteContainer(
                                        width: width,
                                        text: "Sites",
                                        height: height)),
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Visibility(
                                visible: user.userRole != "SiteUser",
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, AppRoutes.crudscreen);
                                  },
                                  child: SiteContainer(
                                      width: width,
                                      text: "Edit Employees",
                                      height: height),
                                ),
                              )
                            ],
                          ),
                          /*
                    Positioned(
                      bottom: height * 0.02,
                      right: width * 0.03,
                      child:
                          MenuButton(isTapped: !isTapped!, width: width * 0.34),
                    ),
                    */
                        ],
                      )
                    : Padding(
                        padding: EdgeInsets.only(top: height * 0.1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomAppheader(width: width),
                            SizedBox(
                              height: height * 0.05,
                            ),
                            SiteNameAndLocation(
                              fontSize2: 13.0,
                              fontSize: 17.0,
                            ),
                            SizedBox(
                              height: height * 0.05,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.siteDetails,
                                );
                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Image.asset(
                                    Common.assetImages + "Ellipse 49.png",
                                    width: width * 0.7,
                                  ),
                                  SizedBox(
                                    width: width * 0.4,
                                    child: Text(
                                      "Request fuel",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 34.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                          fontFamily: "Poppins"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height * 0.07,
                            ),
                            Visibility(
                              visible: user.userRole != "SiteUser",
                              child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, AppRoutes.siteScreen);
                                  },
                                  child: SiteContainer(
                                      width: width,
                                      text: "Sites",
                                      height: height)),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Visibility(
                              visible: user.userRole != "SiteUser",
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.crudscreen);
                                },
                                child: SiteContainer(
                                    width: width,
                                    text: "Edit Employees",
                                    height: height),
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

class SiteNameAndLocation extends StatelessWidget {
  const SiteNameAndLocation({
    Key? key,
    required this.fontSize,
    required this.fontSize2,
  }) : super(key: key);

  final double fontSize;
  final double fontSize2;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {},
          child: Text(
            "Acres Marathon",
            style: TextStyle(
                color: Colors.white,
                fontSize: 17.0,
                fontWeight: FontWeight.w400,
                fontFamily: "Poppins"),
          ),
        ),
        Text(
          "Tampa, FL",
          style: TextStyle(
              color: Color(0xFF6E7191),
              fontSize: 13.0,
              fontWeight: FontWeight.w500,
              fontFamily: "Poppins"),
        ),
      ],
    );
  }
}

class SiteContainer extends StatelessWidget {
  const SiteContainer({
    Key? key,
    required this.width,
    required this.text,
    required this.height,
  }) : super(key: key);

  final double width;
  final String text;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.isDesktop(context) ? width * 0.2 : width * 0.72,
      height: height * 0.062,
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(Responsive.isDesktop(context) ? 14.0 : 16.0),
        color: Color(0xFF5081DB),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              fontSize: 18.0,
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontFamily: "Poppins"),
        ),
      ),
    );
  }
}
