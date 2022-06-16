// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:testttttt/Providers/user_provider.dart';
import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/Services/authentication_helper.dart';
import 'package:testttttt/UI/Widgets/chatListTile.dart';
import 'package:testttttt/UI/Widgets/customNav.dart';
import 'package:testttttt/UI/Widgets/customappheader.dart';
import 'package:testttttt/UI/Widgets/customtoast.dart';
import 'package:testttttt/UI/Widgets/logo.dart';
import 'package:testttttt/UI/views/post_auth_screens/Chat/allchats.dart';
import 'package:testttttt/UI/views/post_auth_screens/Chat/newchat.dart';
import 'package:testttttt/UI/views/post_auth_screens/Chat/chatting.dart';
import 'package:testttttt/UI/views/post_auth_screens/Chat/web_chatting.dart';
import 'package:testttttt/UI/views/post_auth_screens/HomeScreens/Home_screen.dart';
import 'package:testttttt/UI/views/post_auth_screens/Notifications/notifications.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:testttttt/Utils/detectPlatform.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:testttttt/Models/user.dart' as model;

import '../Support/support.dart';

class MessageMain extends StatefulWidget {
  MessageMain({
    Key? key,
    // required this.index,
    // required this.frienduid,
    // required this.friendname,
    // required this.currentusername,
    // required this.photourluser,
    // required this.photourlfriend,
    required this.Chatscreen,
  }) : super(key: key);
  // int index;
  // final friendname;
  // final frienduid;
  // final currentusername;
  // final photourluser;
  // final photourlfriend;
  Widget Chatscreen;

  @override
  _MessageMainState createState() => _MessageMainState();
}

class _MessageMainState extends State<MessageMain> {
  void callChatScreenn(String uid, String name, String currentusername,
      String photoUrlfriend, String photourluser) {
    if (Responsive.isDesktop(context) || Responsive.isTablet(context)) {
      getChatId(uid, name, currentusername, photoUrlfriend, photourluser);
      print("changed1");

      // WidgetsBinding.instance!.addPostFrameCallback((context) => setState(() {
      //       ChatSCREEN = ChatScreenn(
      //         photourlfriend: photoUrlfriend,
      //         photourluser: photourluser,
      //         index: 0,
      //         frienduid: uid,
      //         friendname: name,
      //         currentusername: currentusername,
      //       );
      //     }));

      print("changed2");
    } else {
      Navigator.push(
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
  }

  Widget? ChatSCREEN;
  @override
  void initState() {
    addData();
    fToast = FToast();
    fToast!.init(context);
    // TODO: implement initState
    setState(() {
      ChatSCREEN = widget.Chatscreen;
    });
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      ShowCaseWidget.of(context)!.startShowCase([_key1]);
    });
    super.initState();
  }

  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  CollectionReference chat = FirebaseFirestore.instance.collection("chats");
  final currentUserUID = FirebaseAuth.instance.currentUser!.uid;
  getChatId(String frienduid, String friendname, String currentusername,
      String photourlfriend, String photourluser) async {
    var chatDocId;
    await chat
        .where("users", isEqualTo: {frienduid: null, currentUserUID: null})
        .limit(1)
        .get()
        .then((QuerySnapshot querySnapshot) {
          if (querySnapshot.docs.isNotEmpty) {
            setState(() {
              chatDocId = querySnapshot.docs.single.id;
            });
          } else {
            chat.add({
              'users': {frienduid: null, currentUserUID: null},
              "between": [frienduid, currentUserUID],
              "user1": friendname,
              "user2": currentusername,
              "uid1": currentUserUID,
              "uid2": frienduid,
              "photo1": photourluser,
              "photo2": photourlfriend,
              "recentTime": FieldValue.serverTimestamp()
            }).then((value) => {chatDocId = value.id});
          }
        })
        .catchError((err) {});
    setState(() {
      ChatSCREEN = WebChatScreenn(
        chatId: chatDocId,
        friendname: friendname,
        photourlfriend: photourlfriend,
      );
      print(chatDocId);
    });
  }

  List siteImg = ["site1", "site2"];

  List siteName = ["Acres Marathon", "Akron Marathon"];
  Future? resultsLoaded;

  List sitelocation = ["Tampa,FL", "Leesburg,FL"];
  String? EmployerCode;
  String? Name;
  String? Email;
  String? Subject;
  String? Message;
  FToast? fToast;

  CollectionReference tickets =
      FirebaseFirestore.instance.collection("tickets");
  String visible(model.User user) {
    switch (user.userRole) {
      case "SiteUser":
        return "SiteManager";
      case "SiteManager":
        return "SiteOwner";
      case "SiteOwner":
        return "TerminalUser";
      case "TerminalUser":
        return "TerminalManager";
      case "TerminalManager":
        return "AppAdmin";
      case "AppAdmin":
        return "SuperAdmin";
      case "SuperAdmin":
        return "SuperAdmin";
    }
    return "";
  }

  final _key1 = GlobalKey();
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // ChatSCREEN = widget.Chatscreen;
    model.User? user = Provider.of<UserProvider>(context).getUser;
    Future<void> addTicket(context) {
      return tickets.add({
        "beforelogin": false,
        "byid": user!.uid,
        "email": user.email,
        "isopen": true,
        "messages": [
          {
            "title": Subject,
            "description": Message,
          }
        ],
        "name": user.name,
        "sites": user.sites,
        "timestamp": FieldValue.serverTimestamp(),
        "visibleto": visible(user),
      }).then((value) {
        tickets.doc(value.id).update({
          "docid": value.id,
        });
        tickets.doc(value.id).collection("messages").add({
          "createdOn": FieldValue.serverTimestamp(),
          "message": Message,
          "by": user.uid,
        });
      }).catchError((error) => print("Failed to add ticket: $error"));
    }

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Responsive.isDesktop(context)
          ? MenuButton(isTapped: false, width: width)
          : SizedBox(),
      backgroundColor: Color(0xff2B343B),
      body: Responsive(
        mobile: AllChatScreen(),
        tablet: Column(
          children: [
            Navbar(
              width: width,
              height: height,
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: DefaultTabController(
                        length: 2,
                        child: Column(
                          children: [
                            Container(
                              height: height * 0.07,
                              child: Material(
                                color: Color(0xFF2E3840),
                                child: TabBar(
                                  tabs: [
                                    Tab(
                                      child: Text(
                                        "Chat",
                                        style: TextStyle(
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Poppins"),
                                      ),
                                    ),
                                    Tab(
                                      child: Text(
                                        "Support Ticket",
                                        style: TextStyle(
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Poppins"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: TabBarView(
                                children: [
                                  Container(
                                    height: height * 0.8,
                                    child: StreamBuilder<QuerySnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .collection("chats")
                                            .where("between",
                                                arrayContainsAny: [
                                              user!.uid
                                            ]).snapshots(),
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData) {
                                            return Center(
                                              child: CircularProgressIndicator(
                                                color: Colors.blue,
                                              ),
                                            );
                                          }
                                          var document = snapshot.data?.docs;
                                          // var docid = document!.single.id;

                                          return SingleChildScrollView(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: Responsive.isDesktop(
                                                              context) ||
                                                          Responsive.isTablet(
                                                              context)
                                                      ? width * 0.01
                                                      : width * 0.09,
                                                  right: Responsive.isDesktop(
                                                              context) ||
                                                          Responsive.isTablet(
                                                              context)
                                                      ? width * 0.01
                                                      : width * 0.09,
                                                  top: Responsive.isDesktop(
                                                              context) ||
                                                          Responsive.isTablet(
                                                              context)
                                                      ? height * 0.01
                                                      : height * 0.1),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Visibility(
                                                    visible:
                                                        Responsive.isMobile(
                                                            context),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(""),
                                                        Logo(width: width),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 10.0),
                                                          child: Icon(
                                                            Icons.search,
                                                            color: Colors.white,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          Responsive.isDesktop(
                                                                      context) ||
                                                                  Responsive
                                                                      .isTablet(
                                                                          context)
                                                              ? Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              NewChatMain(
                                                                                index: 0,
                                                                              )))
                                                              : Navigator.pushNamed(
                                                                  context,
                                                                  AppRoutes
                                                                      .newchat);
                                                        },
                                                        child: Showcase(
                                                          description:
                                                              "You can chat with new users by clicking new chat button.",
                                                          key: _key1,
                                                          titleTextStyle:
                                                              TextStyle(
                                                            fontSize: 17.0,
                                                            color: Colors.white,
                                                          ),
                                                          descTextStyle:
                                                              TextStyle(
                                                            fontSize: 16.0,
                                                            color: Colors.white,
                                                          ),
                                                          shapeBorder:
                                                              RoundedRectangleBorder(),
                                                          overlayPadding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          showcaseBackgroundColor:
                                                              Color(0xFF5081DB),
                                                          contentPadding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          disposeOnTap: true,
                                                          onTargetClick: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            ShowCaseWidget(
                                                                              builder: Builder(builder: (_) {
                                                                                return NewChatMain(
                                                                                  index: 0,
                                                                                );
                                                                              }),
                                                                            )));
                                                          },
                                                          child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            width: Responsive
                                                                        .isDesktop(
                                                                            context) ||
                                                                    Responsive
                                                                        .isTablet(
                                                                            context)
                                                                ? 150
                                                                : width * 0.35,
                                                            height: 50,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0xff5081DB),
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10)),
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  "New Chat",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .white,
                                                                      fontFamily:
                                                                          "Poppins",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                                SizedBox(
                                                                  width: 25,
                                                                ),
                                                                Image.asset(
                                                                    "assets/newchat.png"),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  ListView.builder(
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemCount: snapshot
                                                          .data?.docs.length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        // var document = _allChats[index];

                                                        return InkWell(
                                                          onTap: () {
                                                            // document![index]
                                                            //     .reference
                                                            //     .collection("messages")
                                                            //     .doc(document[index].id +
                                                            //         "sent")
                                                            //     .update({
                                                            //   "isNew": false,
                                                            // });
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "chats")
                                                                .doc(document![
                                                                        index]
                                                                    .id)
                                                                .update({
                                                              "isNew":
                                                                  "constant",
                                                            });
                                                            callChatScreenn(
                                                                document[index]['uid1'] ==
                                                                        user.uid
                                                                    ? document[index]
                                                                        ["uid2"]
                                                                    : document[index][
                                                                        "uid1"],
                                                                document[index][
                                                                            'user1'] ==
                                                                        user
                                                                            .name
                                                                    ? document[index]
                                                                        [
                                                                        "user2"]
                                                                    : document[index]
                                                                        [
                                                                        "user1"],
                                                                user.name,
                                                                document[index]
                                                                            [
                                                                            'photo1'] ==
                                                                        user
                                                                            .dpurl
                                                                    ? document[index]
                                                                        [
                                                                        "photo2"]
                                                                    : document[index]
                                                                        ["photo1"],
                                                                user.dpurl);
                                                          },
                                                          child: ChatListTile(
                                                            doc: document![
                                                                index],
                                                            newChat:
                                                                document[index]
                                                                    ["isNew"],
                                                            height: height,
                                                            width: width,
                                                          ),
                                                        );
                                                      }),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: height * 0.03,
                                        left: width * 0.03,
                                        right: width * 0.03),
                                    child: Column(
                                      children: [
                                        Text(
                                          "Support",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize:
                                                  Responsive.isDesktop(context)
                                                      ? width * 0.013
                                                      : width * 0.05,
                                              fontFamily: "Poppins"),
                                        ),
                                        SizedBox(
                                          height: height * 0.02,
                                        ),
                                        SizedBox(
                                          height: height * 0.012,
                                        ),
                                        SupportTextField(
                                            controller1: _controller1,
                                            valueChanged: (value) {
                                              setState(() {
                                                Subject = value;
                                              });
                                            },
                                            width: width,
                                            height: height,
                                            labelText: "Subject"),
                                        SizedBox(
                                          height: height * 0.012,
                                        ),
                                        MessageTextField(
                                            controller2: _controller2,
                                            valueChanged: (value) {
                                              setState(() {
                                                Message = value;
                                              });
                                            },
                                            width: width,
                                            height: height,
                                            labelText: "Message"),
                                        SizedBox(
                                          height: height * 0.04,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            if (Message != null ||
                                                Subject != null) {
                                              addTicket(context);
                                              fToast!.showToast(
                                                child: ToastMessage().show(
                                                    width,
                                                    context,
                                                    "Ticket Added"),
                                                gravity: ToastGravity.BOTTOM,
                                                toastDuration:
                                                    Duration(seconds: 3),
                                              );
                                              setState(() {
                                                _controller1.text = "";
                                                _controller2.text = "";
                                              });
                                            } else {
                                              fToast!.showToast(
                                                child: ToastMessage().show(
                                                    width,
                                                    context,
                                                    "Please enter all detailss"),
                                                gravity: ToastGravity.BOTTOM,
                                                toastDuration:
                                                    Duration(seconds: 3),
                                              );
                                            }
                                          },
                                          child: Container(
                                            width: Responsive.isDesktop(context)
                                                ? width * 0.3
                                                : Responsive.isTablet(context)
                                                    ? width * 0.6
                                                    : width * 0.9,
                                            height: height * 0.065,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(13.0),
                                              color: Color(0xFF5081DB),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Send",
                                                style: TextStyle(
                                                    fontSize: Responsive
                                                                .isDesktop(
                                                                    context) ||
                                                            Responsive.isTablet(
                                                                context)
                                                        ? width * 0.009
                                                        : width * 0.04,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: "Poppins"),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                  // Expanded(
                  //     flex: 5,
                  //     child: ChatScreenn(
                  //       photourlfriend: widget.photourlfriend,
                  //       photourluser: widget.photourluser,
                  //       currentusername: widget.currentusername,
                  //       frienduid: widget.frienduid,
                  //       friendname: widget.friendname,
                  //       index: widget.index,
                  //     )),
                  Expanded(flex: 5, child: ChatSCREEN!),
                ],
              ),
            ),
          ],
        ),
        desktop: Column(
          children: [
            Navbar(
              width: width,
              height: height,
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: DefaultTabController(
                        length: 2,
                        child: Column(
                          children: [
                            Container(
                              height: height * 0.07,
                              child: Material(
                                color: Color(0xFF2E3840),
                                child: TabBar(
                                  tabs: [
                                    Tab(
                                      child: Text(
                                        "Chat",
                                        style: TextStyle(
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Poppins"),
                                      ),
                                    ),
                                    Tab(
                                      child: Text(
                                        "Support Ticket",
                                        style: TextStyle(
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Poppins"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: TabBarView(
                                children: [
                                  Container(
                                    height: height * 0.8,
                                    child: StreamBuilder<QuerySnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .collection("chats")
                                            .where("between",
                                                arrayContainsAny: [
                                              user.uid
                                            ]).snapshots(),
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData) {
                                            return Center(
                                              child: CircularProgressIndicator(
                                                color: Colors.blue,
                                              ),
                                            );
                                          }
                                          var document = snapshot.data?.docs;
                                          // var docid = document!.single.id;

                                          return SingleChildScrollView(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: Responsive.isDesktop(
                                                          context)
                                                      ? width * 0.01
                                                      : width * 0.09,
                                                  right: Responsive.isDesktop(
                                                          context)
                                                      ? width * 0.01
                                                      : width * 0.09,
                                                  top: Responsive.isDesktop(
                                                          context)
                                                      ? height * 0.01
                                                      : height * 0.1),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Visibility(
                                                    visible:
                                                        !Responsive.isDesktop(
                                                            context),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(""),
                                                        Logo(width: width),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 10.0),
                                                          child: Icon(
                                                            Icons.search,
                                                            color: Colors.white,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          Responsive.isDesktop(
                                                                      context) ||
                                                                  Responsive
                                                                      .isTablet(
                                                                          context)
                                                              ? Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            NewChatMain(
                                                                      index: 0,
                                                                    ),
                                                                  ))
                                                              : Navigator.pushNamed(
                                                                  context,
                                                                  AppRoutes
                                                                      .newchat);
                                                        },
                                                        child: Showcase(
                                                          description:
                                                              "You can chat with new users here",
                                                          titleTextStyle:
                                                              TextStyle(
                                                            fontSize: 17.0,
                                                            color: Colors.white,
                                                          ),
                                                          descTextStyle:
                                                              TextStyle(
                                                            fontSize: 16.0,
                                                            color: Colors.white,
                                                          ),
                                                          shapeBorder:
                                                              RoundedRectangleBorder(),
                                                          overlayPadding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          showcaseBackgroundColor:
                                                              Color(0xFF5081DB),
                                                          contentPadding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          disposeOnTap: true,
                                                          key: _key1,
                                                          onTargetClick: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            ShowCaseWidget(
                                                                              builder: Builder(builder: (_) {
                                                                                return NewChatMain(
                                                                                  index: 0,
                                                                                );
                                                                              }),
                                                                            )));
                                                          },
                                                          child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            width: Responsive
                                                                    .isDesktop(
                                                                        context)
                                                                ? 150
                                                                : width * 0.35,
                                                            height: 50,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0xff5081DB),
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10)),
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  "New Chat",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .white,
                                                                      fontFamily:
                                                                          "Poppins",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                                SizedBox(
                                                                  width: 25,
                                                                ),
                                                                Image.asset(
                                                                    "assets/newchat.png"),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  ListView.builder(
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemCount: snapshot
                                                          .data?.docs.length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        // var document = _allChats[index];

                                                        return InkWell(
                                                          onTap: () {
                                                            // document![index]
                                                            //     .reference
                                                            //     .collection("messages")
                                                            //     .doc(document[index].id +
                                                            //         "sent")
                                                            //     .update({
                                                            //   "isNew": false,
                                                            // });
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "chats")
                                                                .doc(document![
                                                                        index]
                                                                    .id)
                                                                .update({
                                                              "isNew":
                                                                  "constant",
                                                            });
                                                            callChatScreenn(
                                                                document[index]['uid1'] ==
                                                                        user.uid
                                                                    ? document[index]
                                                                        ["uid2"]
                                                                    : document[index][
                                                                        "uid1"],
                                                                document[index][
                                                                            'user1'] ==
                                                                        user
                                                                            .name
                                                                    ? document[index]
                                                                        [
                                                                        "user2"]
                                                                    : document[index]
                                                                        [
                                                                        "user1"],
                                                                user.name,
                                                                document[index]
                                                                            [
                                                                            'photo1'] ==
                                                                        user
                                                                            .dpurl
                                                                    ? document[index]
                                                                        [
                                                                        "photo2"]
                                                                    : document[index]
                                                                        ["photo1"],
                                                                user.dpurl);
                                                          },
                                                          child: ChatListTile(
                                                            doc: document![
                                                                index],
                                                            newChat:
                                                                document[index]
                                                                    ["isNew"],
                                                            height: height,
                                                            width: width,
                                                          ),
                                                        );
                                                      }),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: height * 0.03,
                                        left: width * 0.03,
                                        right: width * 0.03),
                                    child: Column(
                                      children: [
                                        Text(
                                          "Support",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: Responsive.isDesktop(
                                                          context) ||
                                                      Responsive.isTablet(
                                                          context)
                                                  ? width * 0.013
                                                  : width * 0.05,
                                              fontFamily: "Poppins"),
                                        ),
                                        SizedBox(
                                          height: height * 0.02,
                                        ),
                                        SizedBox(
                                          height: height * 0.012,
                                        ),
                                        SupportTextField(
                                            controller1: _controller1,
                                            valueChanged: (value) {
                                              setState(() {
                                                Subject = value;
                                              });
                                            },
                                            width: width,
                                            height: height,
                                            labelText: "Subject"),
                                        SizedBox(
                                          height: height * 0.012,
                                        ),
                                        MessageTextField(
                                            controller2: _controller2,
                                            valueChanged: (value) {
                                              setState(() {
                                                Message = value;
                                              });
                                            },
                                            width: width,
                                            height: height,
                                            labelText: "Message"),
                                        SizedBox(
                                          height: height * 0.04,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            print("Working");
                                            if (Message != null ||
                                                Subject != null) {
                                              addTicket(context);
                                              fToast!.showToast(
                                                child: ToastMessage().show(
                                                    width,
                                                    context,
                                                    "Ticket Added"),
                                                gravity: ToastGravity.BOTTOM,
                                                toastDuration:
                                                    Duration(seconds: 3),
                                              );
                                              setState(() {
                                                _controller1.text = "";
                                                _controller2.text = "";
                                              });
                                            } else {
                                              fToast!.showToast(
                                                child: ToastMessage().show(
                                                    width,
                                                    context,
                                                    "Please enter all detailss"),
                                                gravity: ToastGravity.BOTTOM,
                                                toastDuration:
                                                    Duration(seconds: 3),
                                              );
                                            }
                                          },
                                          child: Container(
                                            width: Responsive.isDesktop(context)
                                                ? width * 0.3
                                                : Responsive.isTablet(context)
                                                    ? width * 0.6
                                                    : width * 0.9,
                                            height: height * 0.065,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(13.0),
                                              color: Color(0xFF5081DB),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Send",
                                                style: TextStyle(
                                                    fontSize: Responsive
                                                                .isDesktop(
                                                                    context) ||
                                                            Responsive.isTablet(
                                                                context)
                                                        ? width * 0.009
                                                        : width * 0.04,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: "Poppins"),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                  // Expanded(
                  //     flex: 5,
                  //     child: ChatScreenn(
                  //       photourlfriend: widget.photourlfriend,
                  //       photourluser: widget.photourluser,
                  //       currentusername: widget.currentusername,
                  //       frienduid: widget.frienduid,
                  //       friendname: widget.friendname,
                  //       index: widget.index,
                  //     )),
                  Expanded(flex: 5, child: ChatSCREEN!),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Widget buildchatscreen(BuildContext context) => ChatScreenn(index: 0);

class NewChatMain extends StatefulWidget {
  NewChatMain({Key? key, required this.index}) : super(key: key);
  int index;
  @override
  _NewChatMainState createState() => _NewChatMainState();
}

class _NewChatMainState extends State<NewChatMain> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      ShowCaseWidget.of(context)!.startShowCase([_key1]);
    });
  }

  final _key1 = GlobalKey();
  @override
  Widget build(BuildContext context) {
    model.User? user = Provider.of<UserProvider>(context).getUser;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Responsive(
        mobile: NewChatScreen(),
        tablet: Column(
          children: [
            Visibility(
              visible:
                  Responsive.isDesktop(context) || Responsive.isTablet(context),
              child: Container(
                color: Color(0xFF2B343B),
                width: width,
                height: height * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: Responsive.isDesktop(context)
                          ? width * 0.42
                          : width * 0.6,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: width * 0.03,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) => HomeScreen(
                                      showdialog: false, sites: user!.sites)),
                                ),
                              );
                            },
                            child: SvgPicture.asset(
                              "assets/newLogo.svg",
                              width: width * 0.15,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: height * 0.024),
                            child: Container(
                              width: Responsive.isDesktop(context)
                                  ? width * 0.15
                                  : width * 0.27,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: ((context) => HomeScreen(
                                              showdialog: true,
                                              sites: user!.sites)),
                                        ),
                                      );
                                      setState(() {
                                        index = 0;
                                      });
                                    },
                                    child: Navtext(
                                      color: index == 0
                                          ? Colors.white
                                          : Color(0xFFA0A3BD),
                                      width: width,
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
                                          .where("between", arrayContainsAny: [
                                        user!.uid
                                      ]).snapshots(),
                                      builder: (context,
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
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
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            child: Navtext(
                                              color: index == 1
                                                  ? Colors.white
                                                  : Color(0xFFA0A3BD),
                                              text: "Chat",
                                              width: width,
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
                                                  fontSize: width * 0.01,
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
                                                    arrayContainsAny: [
                                                  user.userRole
                                                ])
                                                // .where("isNew", ar: true)
                                                .snapshots(),
                                            builder: (context,
                                                AsyncSnapshot<QuerySnapshot>
                                                    snapshot) {
                                              if (snapshot.hasData) {
                                                final documents = [];
                                                final docs =
                                                    snapshot.data!.docs;
                                                if (docs.isNotEmpty) {
                                                  for (var element in docs) {
                                                    List notify =
                                                        element["isNew"];
                                                    List siites =
                                                        element["sites"];
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
                                                    if (!notify.contains(
                                                            FirebaseAuth
                                                                .instance
                                                                .currentUser!
                                                                .uid) &&
                                                        istrue()) {
                                                      documents.add(element);
                                                    }
                                                  }
                                                }
                                                return Badge(
                                                    showBadge:
                                                        documents.isNotEmpty,
                                                    badgeContent: Text(
                                                      documents.length
                                                          .toString(),
                                                      // "0",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    child: Showcase(
                                                      disposeOnTap: true,
                                                      onTargetClick: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                ShowCaseWidget(
                                                              builder: Builder(
                                                                builder:
                                                                    (context) =>
                                                                        Notifications(),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      titleTextStyle: TextStyle(
                                                        fontSize: 17.0,
                                                        color: Colors.white,
                                                      ),
                                                      descTextStyle: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Colors.white,
                                                      ),
                                                      shapeBorder:
                                                          RoundedRectangleBorder(),
                                                      overlayPadding:
                                                          EdgeInsets.all(8.0),
                                                      showcaseBackgroundColor:
                                                          Color(0xFF5081DB),
                                                      contentPadding:
                                                          EdgeInsets.all(8.0),
                                                      description:
                                                          "Click to go to notifications page",
                                                      key: _key1,
                                                      child: Badge(
                                                        showBadge: documents
                                                            .isNotEmpty,
                                                        badgeContent: Text(
                                                          documents.length
                                                              .toString(),
                                                          // "0",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        child: Navtext(
                                                          color: index == 2
                                                              ? Colors.white
                                                              : Color(
                                                                  0xFFA0A3BD),
                                                          text: "Notifications",
                                                          width: width,
                                                        ),
                                                      ),
                                                    ));
                                              }
                                              return Navtext(
                                                color: index == 2
                                                    ? Colors.white
                                                    : Color(0xFFA0A3BD),
                                                text: "Notifications",
                                                width: width,
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
                      padding: EdgeInsets.only(right: width * 0.07),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(""),
                            SizedBox(
                              width: width * 0.02,
                            ),
                            PopupMenuButton(
                              padding: EdgeInsets.only(bottom: 500.0),
                              onSelected: (value) {
                                print(value);
                                Navigator.pushNamed(
                                    context, ScreeRoutes[value]);
                                // print("hi");
                                // print(user.uid);
                                // print("hello");
                              },
                              color: Color(0xFF3f4850),
                              child: user.dpurl != ""
                                  ? CircleAvatar(
                                      radius: 22,
                                      backgroundColor: backGround_color,
                                      backgroundImage: NetworkImage(user.dpurl),
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
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0)),
                                          title: Text(
                                            'Request Confirmation',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize:
                                                  Responsive.isDesktop(context)
                                                      ? 23.0
                                                      : 23.0,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "Poppins",
                                              color: Colors.black,
                                            ),
                                          ),
                                          content: Container(
                                            height: Responsive.isDesktop(
                                                        context) ||
                                                    Responsive.isTablet(context)
                                                ? height * 0.18
                                                : height * 0.23,
                                            child: Column(
                                              children: [
                                                Text(
                                                  "Are you sure you want to Logout ?",
                                                  style: TextStyle(
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontFamily: "Poppins"),
                                                ),
                                                SizedBox(
                                                  height: Responsive.isDesktop(
                                                              context) ||
                                                          Responsive.isTablet(
                                                              context)
                                                      ? height * 0.02
                                                      : height * 0.05,
                                                ),
                                                SizedBox(
                                                  height: Responsive.isDesktop(
                                                              context) ||
                                                          Responsive.isTablet(
                                                              context)
                                                      ? height * 0.006
                                                      : 8.0,
                                                ),
                                                SizedBox(
                                                  height: height * 0.02,
                                                ),
                                                Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        width: Responsive
                                                                    .isDesktop(
                                                                        context) ||
                                                                Responsive
                                                                    .isTablet(
                                                                        context)
                                                            ? width * 0.1
                                                            : width * 0.32,
                                                        height: height * 0.055,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0Xffed5c62),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            "Cancel",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 13.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontFamily:
                                                                    "Poppins"),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: Responsive
                                                                  .isDesktop(
                                                                      context) ||
                                                              Responsive
                                                                  .isTablet(
                                                                      context)
                                                          ? 15.0
                                                          : 12.0,
                                                    ),
                                                    InkWell(
                                                      onTap: () async {
                                                        if (PlatformInfo()
                                                            .isWeb()) {
                                                          SharedPreferences
                                                                  .getInstance()
                                                              .then((prefs) {
                                                            prefs.setBool(
                                                                "remember_me",
                                                                false);
                                                          });
                                                        }
                                                        AuthFunctions.signOut();
                                                        Navigator.pushNamed(
                                                            context,
                                                            AppRoutes
                                                                .loginscreen);
                                                      },
                                                      child: Container(
                                                        width: Responsive
                                                                    .isDesktop(
                                                                        context) ||
                                                                Responsive
                                                                    .isTablet(
                                                                        context)
                                                            ? width * 0.1
                                                            : width * 0.32,
                                                        height: height * 0.055,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0Xff5081db),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            "Logout",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 13.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontFamily:
                                                                    "Poppins"),
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
                                      );
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
            ),
            Expanded(
              child: Stack(children: [
                Row(
                  children: [
                    Expanded(flex: 2, child: NewChatScreen()),
                    Expanded(
                        flex: 5,
                        child: ChatScreenn(
                          photourlfriend: "f",
                          photourluser: "f",
                          currentusername: "f",
                          friendname: "Start chat by clicking on user",
                          frienduid: "",
                          index: widget.index,
                        )),
                  ],
                ),
              ]),
            ),
          ],
        ),
        desktop: Column(
          children: [
            Visibility(
              visible:
                  Responsive.isDesktop(context) || Responsive.isTablet(context),
              child: Container(
                color: Color(0xFF2B343B),
                width: width,
                height: height * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: Responsive.isDesktop(context)
                          ? width * 0.42
                          : width * 0.6,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: width * 0.03,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) => HomeScreen(
                                      showdialog: false, sites: user.sites)),
                                ),
                              );
                            },
                            child: SvgPicture.asset(
                              "assets/newLogo.svg",
                              width: width * 0.15,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: height * 0.024),
                            child: Container(
                              width: Responsive.isDesktop(context)
                                  ? width * 0.15
                                  : width * 0.27,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: ((context) => HomeScreen(
                                              showdialog: true,
                                              sites: user.sites)),
                                        ),
                                      );
                                      setState(() {
                                        index = 0;
                                      });
                                    },
                                    child: Navtext(
                                      color: index == 0
                                          ? Colors.white
                                          : Color(0xFFA0A3BD),
                                      width: width,
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
                                          .where("between", arrayContainsAny: [
                                        user.uid
                                      ]).snapshots(),
                                      builder: (context,
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
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
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            child: Navtext(
                                              color: index == 1
                                                  ? Colors.white
                                                  : Color(0xFFA0A3BD),
                                              text: "Chat",
                                              width: width,
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
                                                  fontSize: width * 0.01,
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
                                                    arrayContainsAny: [
                                                  user.userRole
                                                ])
                                                // .where("isNew", ar: true)
                                                .snapshots(),
                                            builder: (context,
                                                AsyncSnapshot<QuerySnapshot>
                                                    snapshot) {
                                              if (snapshot.hasData) {
                                                final documents = [];
                                                final docs =
                                                    snapshot.data!.docs;
                                                if (docs.isNotEmpty) {
                                                  for (var element in docs) {
                                                    List notify =
                                                        element["isNew"];
                                                    List siites =
                                                        element["sites"];
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
                                                    if (!notify.contains(
                                                            FirebaseAuth
                                                                .instance
                                                                .currentUser!
                                                                .uid) &&
                                                        istrue()) {
                                                      documents.add(element);
                                                    }
                                                  }
                                                }
                                                return Showcase(
                                                  disposeOnTap: true,
                                                  onTargetClick: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ShowCaseWidget(
                                                          builder: Builder(
                                                            builder: (context) =>
                                                                Notifications(),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  titleTextStyle: TextStyle(
                                                    fontSize: 17.0,
                                                    color: Colors.white,
                                                  ),
                                                  descTextStyle: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.white,
                                                  ),
                                                  shapeBorder:
                                                      RoundedRectangleBorder(),
                                                  overlayPadding:
                                                      EdgeInsets.all(8.0),
                                                  showcaseBackgroundColor:
                                                      Color(0xFF5081DB),
                                                  contentPadding:
                                                      EdgeInsets.all(8.0),
                                                  description:
                                                      "Click to go to notifications page",
                                                  key: _key1,
                                                  child: Badge(
                                                    showBadge:
                                                        documents.isNotEmpty,
                                                    badgeContent: Text(
                                                      documents.length
                                                          .toString(),
                                                      // "0",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    child: Navtext(
                                                      color: index == 2
                                                          ? Colors.white
                                                          : Color(0xFFA0A3BD),
                                                      text: "Notifications",
                                                      width: width,
                                                    ),
                                                  ),
                                                );
                                              }
                                              return Navtext(
                                                color: index == 2
                                                    ? Colors.white
                                                    : Color(0xFFA0A3BD),
                                                text: "Notifications",
                                                width: width,
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
                      padding: EdgeInsets.only(right: width * 0.07),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(""),
                            SizedBox(
                              width: width * 0.02,
                            ),
                            PopupMenuButton(
                              padding: EdgeInsets.only(bottom: 500.0),
                              onSelected: (value) {
                                print(value);
                                Navigator.pushNamed(
                                    context, ScreeRoutes[value]);
                                // print("hi");
                                // print(user.uid);
                                // print("hello");
                              },
                              color: Color(0xFF3f4850),
                              child: user.dpurl != ""
                                  ? CircleAvatar(
                                      radius: 22,
                                      backgroundColor: backGround_color,
                                      backgroundImage: NetworkImage(user.dpurl),
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
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0)),
                                          title: Text(
                                            'Request Confirmation',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize:
                                                  Responsive.isDesktop(context)
                                                      ? 23.0
                                                      : 23.0,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "Poppins",
                                              color: Colors.black,
                                            ),
                                          ),
                                          content: Container(
                                            height: Responsive.isDesktop(
                                                        context) ||
                                                    Responsive.isTablet(context)
                                                ? height * 0.18
                                                : height * 0.23,
                                            child: Column(
                                              children: [
                                                Text(
                                                  "Are you sure you want to Logout ?",
                                                  style: TextStyle(
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontFamily: "Poppins"),
                                                ),
                                                SizedBox(
                                                  height: Responsive.isDesktop(
                                                              context) ||
                                                          Responsive.isTablet(
                                                              context)
                                                      ? height * 0.02
                                                      : height * 0.05,
                                                ),
                                                SizedBox(
                                                  height: Responsive.isDesktop(
                                                              context) ||
                                                          Responsive.isTablet(
                                                              context)
                                                      ? height * 0.006
                                                      : 8.0,
                                                ),
                                                SizedBox(
                                                  height: height * 0.02,
                                                ),
                                                Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        width: Responsive
                                                                    .isDesktop(
                                                                        context) ||
                                                                Responsive
                                                                    .isTablet(
                                                                        context)
                                                            ? width * 0.1
                                                            : width * 0.32,
                                                        height: height * 0.055,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0Xffed5c62),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            "Cancel",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 13.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontFamily:
                                                                    "Poppins"),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: Responsive
                                                                  .isDesktop(
                                                                      context) ||
                                                              Responsive
                                                                  .isTablet(
                                                                      context)
                                                          ? 15.0
                                                          : 12.0,
                                                    ),
                                                    InkWell(
                                                      onTap: () async {
                                                        if (PlatformInfo()
                                                            .isWeb()) {
                                                          SharedPreferences
                                                                  .getInstance()
                                                              .then((prefs) {
                                                            prefs.setBool(
                                                                "remember_me",
                                                                false);
                                                          });
                                                        }
                                                        AuthFunctions.signOut();
                                                        Navigator.pushNamed(
                                                            context,
                                                            AppRoutes
                                                                .loginscreen);
                                                      },
                                                      child: Container(
                                                        width: Responsive
                                                                    .isDesktop(
                                                                        context) ||
                                                                Responsive
                                                                    .isTablet(
                                                                        context)
                                                            ? width * 0.1
                                                            : width * 0.32,
                                                        height: height * 0.055,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0Xff5081db),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            "Logout",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 13.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontFamily:
                                                                    "Poppins"),
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
                                      );
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
            ),
            Expanded(
              child: Stack(children: [
                Row(
                  children: [
                    Expanded(flex: 2, child: NewChatScreen()),
                    Expanded(
                        flex: 5,
                        child: ChatScreenn(
                          photourlfriend: "f",
                          photourluser: "f",
                          currentusername: "f",
                          friendname: "Start chat by clicking on user",
                          frienduid: "",
                          index: widget.index,
                        )),
                  ],
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
