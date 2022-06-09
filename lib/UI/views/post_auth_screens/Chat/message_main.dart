// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:testttttt/Providers/user_provider.dart';
import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/UI/Widgets/chatListTile.dart';
import 'package:testttttt/UI/Widgets/customNav.dart';
import 'package:testttttt/UI/Widgets/customappheader.dart';
import 'package:testttttt/UI/Widgets/customtoast.dart';
import 'package:testttttt/UI/Widgets/logo.dart';
import 'package:testttttt/UI/views/post_auth_screens/Chat/allchats.dart';
import 'package:testttttt/UI/views/post_auth_screens/Chat/newchat.dart';
import 'package:testttttt/UI/views/post_auth_screens/Chat/chatting.dart';
import 'package:testttttt/UI/views/post_auth_screens/Chat/web_chatting.dart';
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
    if (Responsive.isDesktop(context)) {
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
    // TODO: implement initState
    setState(() {
      ChatSCREEN = widget.Chatscreen;
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
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Responsive.isDesktop(context)
          ? MenuButton(isTapped: false, width: width)
          : SizedBox(),
      backgroundColor: Color(0xff2B343B),
      body: Responsive(
        mobile: AllChatScreen(),
        tablet: AllChatScreen(),
        desktop: Column(
          children: [
            Navbar(
              width: width,
              height: height,
              text1: "Home",
              text2: "Sites",
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
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
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
                                                            borderRadius:
                                                                BorderRadius
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
                                              Navigator.pop(context);
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
                                                    fontSize:
                                                        Responsive.isDesktop(
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
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Responsive(
        mobile: NewChatScreen(),
        tablet: NewChatScreen(),
        desktop: Column(
          children: [
            Navbar(
              width: width,
              height: height,
              text1: "Home",
              text2: "Sites",
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
