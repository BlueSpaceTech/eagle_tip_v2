// ignore_for_file: prefer_const_constructors, await_only_futures

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:testttttt/Providers/user_provider.dart';
import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/UI/Widgets/logo.dart';
import 'package:testttttt/Utils/common.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:testttttt/Models/user.dart' as model;
import 'package:badges/badges.dart';

int index = 0;

class Navbar extends StatefulWidget {
  const Navbar({
    Key? key,
    required this.width,
    required this.height,
    required this.text1,
    required this.text2,
  }) : super(key: key);

  final double width;
  final double height;
  final String text1;
  final String text2;

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;
    return Visibility(
      visible: Responsive.isDesktop(context),
      child: Container(
        color: Color(0xFF2B343B),
        width: widget.width,
        height: widget.height * 0.1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: Responsive.isDesktop(context)
                  ? widget.width * 0.42
                  : widget.width * 0.6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: widget.width * 0.03,
                  ),
                  Logo(width: widget.width * 0.6),
                  Padding(
                    padding: EdgeInsets.only(top: widget.height * 0.024),
                    child: Container(
                      width: Responsive.isDesktop(context)
                          ? widget.width * 0.15
                          : widget.width * 0.27,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: InkWell(
                              onTap: () {
                                (user.userRole == "TerminalManager" ||
                                        user.userRole == "TerminalUser")
                                    ? Navigator.pushReplacementNamed(
                                        context, AppRoutes.terminalhome)
                                    : Navigator.pushReplacementNamed(
                                        context, AppRoutes.homeScreen);
                                setState(() {
                                  index = 0;
                                });
                              },
                              child: Navtext(
                                color: index == 0
                                    ? Colors.white
                                    : Color(0xFFA0A3BD),
                                width: widget.width,
                                text: "Home",
                              ),
                            ),
                          ),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: InkWell(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, AppRoutes.messagemain);
                                setState(() {
                                  index = 1;
                                });
                              },
                              child: Navtext(
                                color: index == 1
                                    ? Colors.white
                                    : Color(0xFFA0A3BD),
                                text: "Chat",
                                width: widget.width,
                              ),
                            ),
                          ),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: InkWell(
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                      context, AppRoutes.notifications);
                                  setState(() {
                                    index = 2;
                                  });
                                },
                                child: StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection("pushNotifications")
                                        .where("visibleto",
                                            arrayContainsAny: ["SiteManager"])
                                        // .where("isNew", ar: true)
                                        .snapshots(),
                                    builder: (context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      final documents = [];
                                      final docs = snapshot.data!.docs;
                                      if (docs.isNotEmpty) {
                                        for (var element in docs) {
                                          List notify = element["isNew"];

                                          if (!notify.contains(FirebaseAuth
                                              .instance.currentUser!.uid)) {
                                            documents.add(element);
                                          }
                                        }
                                      }
                                      if (!snapshot.hasData) {
                                        return SizedBox();
                                      }
                                      return Badge(
                                        showBadge:
                                            documents.isEmpty ? false : true,
                                        badgeContent: Text(
                                          documents.isEmpty
                                              ? "0"
                                              : documents.length.toString(),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        child: Navtext(
                                          color: index == 2
                                              ? Colors.white
                                              : Color(0xFFA0A3BD),
                                          text: "Notifications",
                                          width: widget.width,
                                        ),
                                      );
                                    })),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: widget.width * 0.07),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(""),
                    SizedBox(
                      width: widget.width * 0.02,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.myProfile);
                      },
                      child: CircleAvatar(
                        radius: 22,
                        backgroundColor: backGround_color,
                        backgroundImage: NetworkImage(user.dpurl),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Navtext extends StatelessWidget {
  const Navtext({
    Key? key,
    required this.text,
    required this.width,
    required this.color,
  }) : super(key: key);

  final double width;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontSize: Responsive.isDesktop(context) ? width * 0.01 : width * 0.02,
          fontWeight: FontWeight.w500,
          fontFamily: "Poppins"),
    );
  }
}
