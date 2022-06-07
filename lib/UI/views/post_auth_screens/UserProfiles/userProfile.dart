// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:testttttt/Providers/user_provider.dart';
import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/UI/Widgets/customNav.dart';
import 'package:testttttt/UI/Widgets/custom_webbg.dart';
import 'package:testttttt/UI/Widgets/customappheader.dart';
import 'package:testttttt/UI/Widgets/logo.dart';
import 'package:testttttt/UI/views/post_auth_screens/Chat/chatting.dart';
import 'package:testttttt/UI/views/post_auth_screens/Chat/message_main.dart';
import 'package:testttttt/UI/views/post_auth_screens/UserProfiles/myprofile.dart';
import 'package:testttttt/Utils/common.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:testttttt/Models/user.dart' as model;

class UserProfile extends StatelessWidget {
  UserProfile({
    Key? key,
    required this.name,
    required this.email,
    required this.userRole,
    required this.dpUrl,
    required this.sites,
    required this.phonenumber,
    required this.uid,
    required this.fromsentto,
  }) : super(key: key);
  final String name, email, phonenumber, dpUrl, userRole, uid;
  final List sites;
  final bool fromsentto;
  void callChatScreen(String uid, String name, String currentusername,
      String photoUrlfriend, String photourluser, BuildContext context) {
    Responsive.isDesktop(context)
        ? Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => MessageMain(
                      Chatscreen: ChatScreenn(
                        photourlfriend: photoUrlfriend,
                        photourluser: photourluser,
                        index: 0,
                        frienduid: uid,
                        friendname: name,
                        currentusername: currentusername,
                      ),
                    )))
        : Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => ChatScreenn(
                      photourlfriend: photoUrlfriend,
                      photourluser: photourluser,
                      index: 0,
                      frienduid: uid,
                      friendname: name,
                      currentusername: currentusername,
                    )));
  }

  @override
  Widget build(BuildContext context) {
    model.User? user = Provider.of<UserProvider>(context).getUser;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: Responsive.isDesktop(context)
          ? MenuButton(isTapped: false, width: width)
          : SizedBox(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              height: Responsive.isDesktop(context) ? height * 1.15 : height,
              color: backGround_color,
              child: Padding(
                padding: EdgeInsets.only(
                    top: height * 0.03,
                    left: Responsive.isDesktop(context)
                        ? width * 0.015
                        : width * 0.04,
                    right: Responsive.isDesktop(context) ? 0.0 : width * 0.04),
                child: Column(
                  children: [
                    Responsive.isDesktop(context)
                        ? Navbar(
                            width: width,
                            height: height,
                            text1: "Home",
                            text2: "Sites",
                          )
                        : Padding(
                            padding: EdgeInsets.only(
                                left: width * 0.04, top: height * 0.02),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: (() {
                                    Navigator.pop(context);
                                  }),
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.22,
                                ),
                                Logo(width: width),
                              ],
                            ),
                          ),
                    SizedBox(
                      height: Responsive.isDesktop(context)
                          ? height * 0.1
                          : height * 0.05,
                    ),
                    Stack(
                      children: [
                        WebBg(),
                        Column(
                          children: [
                            Responsive.isDesktop(context)
                                ? Row(
                                    children: [
                                      dpUrl != ""
                                          ? CircleAvatar(
                                              radius: 35,
                                              backgroundColor: backGround_color,
                                              backgroundImage:
                                                  NetworkImage(dpUrl),
                                            )
                                          : ClipRRect(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: backGround_color,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(
                                                  Icons.person,
                                                  size: 35,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                      SizedBox(
                                        width: width * 0.02,
                                      ),
                                      UserNameandDet(
                                        width: width,
                                        name: name,
                                        userRole: userRole,
                                      ),
                                      SizedBox(
                                        width: width * 0.1,
                                      ),
                                      Visibility(
                                        visible: !fromsentto,
                                        child: InkWell(
                                          onTap: () {
                                            callChatScreen(
                                                uid,
                                                name,
                                                user!.name,
                                                dpUrl,
                                                user.dpurl,
                                                context);
                                          },
                                          child: Container(
                                            width: width * 0.06,
                                            height: height * 0.05,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              color: Color(0xFF5081DB),
                                            ),
                                            child: Center(
                                                child: Text(
                                              "Chat",
                                              style: TextStyle(
                                                fontSize: width * 0.008,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                              ),
                                            )),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(
                                    height: height * 0.26,
                                    width: width,
                                    child: Column(
                                      children: [
                                        dpUrl != ""
                                            ? CircleAvatar(
                                                radius: 22,
                                                backgroundColor:
                                                    backGround_color,
                                                backgroundImage:
                                                    NetworkImage(dpUrl),
                                              )
                                            : ClipRRect(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: backGround_color,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Icon(
                                                    Icons.person,
                                                    size: 30,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                        SizedBox(
                                          height: height * 0.005,
                                        ),
                                        UserNameandDet(
                                          width: width,
                                          userRole: userRole,
                                          name: name,
                                        ),
                                        SizedBox(
                                          height: height * 0.004,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            callChatScreen(
                                                uid,
                                                name,
                                                user!.name,
                                                dpUrl,
                                                user.dpurl,
                                                context);
                                          },
                                          child: Container(
                                            width: width * 0.2,
                                            height: height * 0.035,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              color: Color(0xFF5081DB),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Chat",
                                                style: TextStyle(
                                                  fontSize: 13.0,
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            SizedBox(
                              height: height * 0.04,
                            ),
                            Visibility(
                              visible: Responsive.isDesktop(context),
                              child: Column(
                                children: [
                                  Divider(
                                    color: Colors.black,
                                    thickness: 1.0,
                                  ),
                                  SizedBox(
                                    height: height * 0.04,
                                  ),
                                ],
                              ),
                            ),
                            ContactInfo(
                                email: email,
                                phonenumber: phonenumber,
                                height: Responsive.isDesktop(context)
                                    ? height * 1.06
                                    : height,
                                width: width),
                            SizedBox(
                              height: Responsive.isDesktop(context)
                                  ? height * 0.025
                                  : height * 0.02,
                            ),
                            Divider(
                              color: Responsive.isDesktop(context)
                                  ? Colors.black
                                  : Color(0xFF2E3840),
                              thickness:
                                  Responsive.isDesktop(context) ? 1.0 : 3.0,
                            ),
                            SizedBox(
                              height: Responsive.isDesktop(context)
                                  ? height * 0.04
                                  : height * 0.02,
                            ),
                            Responsive.isDesktop(context)
                                ? Row(
                                    children:
                                        List.generate(sites.length, (index) {
                                      return Padding(
                                        padding: EdgeInsets.only(right: 20),
                                        child: SiteRow(
                                          width: width,
                                          sitename: sites[index],
                                          siteloc: "",
                                          imgpath: "Group 268",
                                        ),
                                      );
                                    }),
                                  )
                                : ListView(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    children:
                                        List.generate(sites.length, (index) {
                                      return Padding(
                                        padding: EdgeInsets.only(bottom: 10),
                                        child: SiteRow(
                                          width: width,
                                          sitename: sites[index].toString(),
                                          siteloc: "",
                                          imgpath: "Group 268",
                                        ),
                                      );
                                    }),
                                  ),
                            Visibility(
                              visible: Responsive.isDesktop(context),
                              child: SizedBox(
                                height: height * 0.04,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}

class UserNameandDet extends StatelessWidget {
  const UserNameandDet({
    Key? key,
    required this.width,
    required this.name,
    required this.userRole,
  }) : super(key: key);

  final double width;
  final String name;
  final String userRole;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: Responsive.isDesktop(context)
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        Text(
          name,
          style: TextStyle(
              fontSize: Responsive.isDesktop(context) ? width * 0.011 : 18.0,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontFamily: 'Poppins'),
        ),
        SizedBox(
          height: 4.0,
        ),
        Text(
          userRole,
          style: TextStyle(
              fontSize: Responsive.isDesktop(context) ? width * 0.01 : 14.0,
              color: Color(0xFFD9DBE9),
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins'),
        ),
      ],
    );
  }
}

class DesktopSiteData extends StatelessWidget {
  const DesktopSiteData({
    Key? key,
    required this.width,
    required this.sitename,
    required this.imgPath,
    required this.siteloc,
    required this.height,
  }) : super(key: key);

  final double width;
  final String imgPath;
  final double height;
  final String sitename;
  final String siteloc;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 120.0,
          height: 80.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white,
            image: DecorationImage(
                image: AssetImage(
                  Common.assetImages + "$imgPath.png",
                ),
                fit: BoxFit.fill),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          sitename,
          style: TextStyle(
              color: Colors.white,
              fontSize: width * 0.01,
              fontWeight: FontWeight.w400,
              fontFamily: "Poppins"),
        ),
        Text(
          siteloc,
          style: TextStyle(
              color: Colors.white,
              fontSize: width * 0.007,
              fontWeight: FontWeight.w400,
              fontFamily: "Poppins"),
        ),
      ],
    );
  }
}
