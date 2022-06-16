// ignore_for_file: prefer_const_constructors, prefer_final_fields, unused_field, prefer_const_literals_to_create_immutables, unused_local_variable

import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:testttttt/Providers/user_provider.dart';
import 'package:testttttt/UI/views/post_auth_screens/Chat/allchats.dart';
import 'package:testttttt/UI/views/post_auth_screens/Chat/chatting.dart';
import 'package:testttttt/UI/views/post_auth_screens/Chat/message_main.dart';
import 'package:testttttt/UI/views/post_auth_screens/HomeScreens/Home_screen.dart';
import 'package:testttttt/UI/views/post_auth_screens/Notifications/notifications.dart';
import 'package:testttttt/UI/views/post_auth_screens/UserProfiles/myprofile.dart';
import 'package:testttttt/Utils/common.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testttttt/Models/user.dart' as model;

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 1;
  static const TextStyle optionStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: Color(0xFFA0A3BD),
  );

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addData();
  }

  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    model.User? user = Provider.of<UserProvider>(context).getUser;
    double height = MediaQuery.of(context).size.height;
    List<Widget> _widgetOptions = <Widget>[
      MyProfile(),
      HomeScreen(
        showdialog: true,
        sites: user?.sites ?? [],
      ),

      Notifications(),
      //  MessageMain(
      // photourlfriend: "",
      // photourluser: "",
      // currentusername: "s",
      // friendname: "noname",
      // frienduid: "no uid",
      // index: 0,
      AllChatScreen(),
      //  ),
    ];
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFF1A1F23),
        unselectedItemColor: Color(0xFFA0A3BD),
        selectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            activeIcon: Image.asset(
              Common.assetImages + "activeProfile.png",
              width: width * 0.05,
            ),
            icon: Image.asset(
              Common.assetImages + "profil.png",
              width: width * 0.05,
            ),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            activeIcon: Image.asset(
              Common.assetImages + "activeHome.png",
              width: width * 0.05,
            ),
            icon: Image.asset(
              Common.assetImages + "home.png",
              width: width * 0.05,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            activeIcon: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("pushNotifications")
                    .where("visibleto",
                        arrayContainsAny: [user?.userRole ?? ""])
                    // .where("isNew", ar: true)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    final documents = [];
                    final docs = snapshot.data!.docs;
                    if (docs.isNotEmpty) {
                      for (var element in docs) {
                        List notify = element["isNew"];

                        if (!notify
                            .contains(FirebaseAuth.instance.currentUser!.uid)) {
                          documents.add(element);
                        }
                      }
                    }
                    return Badge(
                      showBadge: documents.isNotEmpty,
                      badgeContent: Text(
                        documents.length.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                      child: Image.asset(
                        Common.assetImages + "activeNotification.png",
                        width: width * 0.05,
                      ),
                    );
                  }
                  return Container();
                }),
            icon: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("pushNotifications")
                    .where("visibleto",
                        arrayContainsAny: [user?.userRole ?? ""])
                    // .where("isNew", ar: true)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    final documents = [];
                    final docs = snapshot.data!.docs;
                    if (docs.isNotEmpty) {
                      for (var element in docs) {
                        List notify = element["isNew"];

                        if (!notify
                            .contains(FirebaseAuth.instance.currentUser!.uid)) {
                          documents.add(element);
                        }
                      }
                    }
                    return Badge(
                      showBadge: documents.isNotEmpty,
                      badgeContent: Text(
                        documents.length.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                      child: Image.asset(
                        Common.assetImages + "Group 308.png",
                        width: width * 0.05,
                      ),
                    );
                  }
                  return Container();
                }),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
              activeIcon: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("chats").where(
                    "between",
                    arrayContainsAny: [user?.uid ?? ""]).snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    List docsss = snapshot.data!.docs;
                    List docs2 = [];
                    for (var ele in docsss) {
                      if (ele["isNew"] != user?.uid &&
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
                        child: Image.asset(
                          Common.assetImages + "activeChat.png",
                          width: width * 0.05,
                        )
                        // );
                        // },
                        );
                  }
                  return Container();
                },
              ),
              icon: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("chats").where(
                    "between",
                    arrayContainsAny: [user?.uid ?? ""]).snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    List docsss = snapshot.data!.docs;
                    List docs2 = [];
                    for (var ele in docsss) {
                      if (ele["isNew"] != user?.uid &&
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
                        child: Image.asset(
                          Common.assetImages + "message.png",
                          width: width * 0.05,
                        )
                        // );
                        // },
                        );
                  }
                  return Container();
                },
              ),
              label: "chat")
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
