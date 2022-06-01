// ignore_for_file: prefer_const_constructors, await_only_futures

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:testttttt/Providers/user_provider.dart';
import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/Services/authentication_helper.dart';
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

Map ScreeRoutes = {
  1: AppRoutes.myProfile,
  2: AppRoutes.desktopSetting,
  // 3: FirebaseAuth.instance.signOut()
};

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
                  InkWell(
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, AppRoutes.homeScreen, (route) => false);
                    },
                    child: SvgPicture.asset(
                      "assets/newLogo.svg",
                      width: widget.width * 0.15,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: widget.height * 0.024),
                    child: Container(
                      width: Responsive.isDesktop(context)
                          ? widget.width * 0.15
                          : widget.width * 0.27,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, AppRoutes.homeScreen);
                              setState(() {
                                index = 0;
                              });
                            },
                            child: Navtext(
                              color:
                                  index == 0 ? Colors.white : Color(0xFFA0A3BD),
                              width: widget.width,
                              text: "Home",
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, AppRoutes.messagemain);
                              setState(() {
                                index = 1;
                              });
                            },
                            child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("chats")
                                  .where("between",
                                      arrayContainsAny: [user.uid]).snapshots(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.none) {
                                  return Navtext(
                                    color: index == 1
                                        ? Colors.white
                                        : Color(0xFFA0A3BD),
                                    text: "Chatt",
                                    width: widget.width,
                                  );
                                }
                                // if (docs2.isEmpty) {
                                //   return Navtext(
                                //     color: index == 1
                                //         ? Colors.white
                                //         : Color(0xFFA0A3BD),
                                //     text: "Chat",
                                //     width: widget.width,
                                //   );
                                // }

                                if (snapshot.hasData) {
                                  List docsss = snapshot.data!.docs;
                                  List docs2 = [];
                                  for (var ele in docsss) {
                                    if (ele["isNew"] != user.uid &&
                                        ele["isNew"] != "constant") {
                                      docs2.add(ele);
                                    }
                                  }

                                  return Badge(
                                    showBadge: docs2.isNotEmpty,
                                    badgeContent: Text(
                                      docs2.length.toString(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    child: Navtext(
                                      color: index == 1
                                          ? Colors.white
                                          : Color(0xFFA0A3BD),
                                      text: "Chat",
                                      width: widget.width,
                                    ),
                                    // );
                                    // },
                                  );
                                } else {
                                  //   return
                                  return Text("Chat",
                                      style: TextStyle(
                                          color: index == 2
                                              ? Colors.white
                                              : Color(0xFFA0A3BD),
                                          // fontSize: Responsive.isDesktop(context) ? width * 0.01 : width * 0.02,
                                          fontSize: widget.width * 0.01,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Poppins"));
                                }
                              },
                            ),
                          ),
                          // ),
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
                                            arrayContainsAny: [user.userRole])
                                        // .where("isNew", ar: true)
                                        .snapshots(),
                                    builder: (context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Navtext(
                                          color: index == 2
                                              ? Colors.white
                                              : Color(0xFFA0A3BD),
                                          text: "Notifications",
                                          width: widget.width,
                                        );
                                      }

                                      if (snapshot.hasData) {
                                        final documents = [];
                                        final docs = snapshot.data!.docs;
                                        if (docs.isNotEmpty) {
                                          for (var element in docs) {
                                            List notify = element["isNew"];
                                            List siites = element["sites"];
                                            istrue() {
                                              for (int i = 0;
                                                  i < user.sites.length;
                                                  i++) {
                                                for (int j = 0;
                                                    j < siites.length;
                                                    j++) {
                                                  if (user.sites[i] ==
                                                      siites[j]) {
                                                    return true;
                                                  }
                                                }
                                              }
                                              return false;
                                            }

                                            // print(siites);
                                            // if(){}
                                            if (!notify.contains(FirebaseAuth
                                                    .instance
                                                    .currentUser!
                                                    .uid) &&
                                                istrue()) {
                                              documents.add(element);
                                            }
                                          }
                                        }
                                        return Badge(
                                          showBadge: documents.isEmpty,
                                          badgeContent: Text(
                                            documents.length.toString(),
                                            // "0",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          child: Navtext(
                                            color: index == 2
                                                ? Colors.white
                                                : Color(0xFFA0A3BD),
                                            text: "Notifications",
                                            width: widget.width,
                                          ),
                                        );
                                      }
                                      return Navtext(
                                        color: index == 2
                                            ? Colors.white
                                            : Color(0xFFA0A3BD),
                                        text: "Notifications",
                                        width: widget.width,
                                      );
                                    })),
                          )
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
                    PopupMenuButton(
                      padding: EdgeInsets.only(bottom: 500.0),
                      onSelected: (value) {
                        print(value);
                        Navigator.pushNamed(context, ScreeRoutes[value]);
                        // print("hi");
                        // print(user.uid);
                        // print("hello");
                      },
                      color: Color(0xFF3f4850),
                      child: CircleAvatar(
                        radius: 22,
                        backgroundColor: backGround_color,
                        backgroundImage: NetworkImage(user.dpurl),
                      ),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Text(
                            "My Profile",
                            style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontFamily: "Poppins"),
                          ),
                          value: 1,
                        ),
                        PopupMenuItem(
                          child: Text(
                            "Settings",
                            style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontFamily: "Poppins"),
                          ),
                          value: 2,
                        ),
                        PopupMenuItem(
                          child: TextButton(
                            onPressed: () {
                              AuthFunctions.signOut();
                              Navigator.pushNamedAndRemoveUntil(context,
                                  AppRoutes.loginscreen, (route) => false);
                            },
                            child: Container(
                              width: 100,
                              child: Text(
                                "Logout",
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    fontFamily: "Poppins"),
                              ),
                            ),
                          ),
                          // value: 3,
                        )
                      ],
                    )
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
