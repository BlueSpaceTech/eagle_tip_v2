import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:testttttt/Providers/user_provider.dart';
import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/UI/Widgets/chatListTile.dart';
import 'package:testttttt/UI/Widgets/customNav.dart';
import 'package:testttttt/UI/Widgets/logo.dart';
import 'package:testttttt/UI/views/post_auth_screens/Chat/allchats.dart';
import 'package:testttttt/UI/views/post_auth_screens/Chat/newchat.dart';
import 'package:testttttt/UI/views/post_auth_screens/Chat/chatting.dart';
import 'package:testttttt/UI/views/post_auth_screens/Chat/web_chatting.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:testttttt/Models/user.dart' as model;

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

  @override
  Widget build(BuildContext context) {
    // ChatSCREEN = widget.Chatscreen;
    model.User user = Provider.of<UserProvider>(context).getUser;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
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
                    child: Container(
                      height: height * 0.8,
                      child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection("chats")
                              .where("between",
                                  arrayContainsAny: [user.uid]).snapshots(),
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
                                    left: Responsive.isDesktop(context)
                                        ? width * 0.01
                                        : width * 0.09,
                                    right: Responsive.isDesktop(context)
                                        ? width * 0.01
                                        : width * 0.09,
                                    top: Responsive.isDesktop(context)
                                        ? height * 0.01
                                        : height * 0.1),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Visibility(
                                      visible: !Responsive.isDesktop(context),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(""),
                                          Logo(width: width),
                                          Padding(
                                            padding: EdgeInsets.only(top: 10.0),
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
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            showModalBottomSheet(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Container(
                                                  height: height * 0.5,
                                                  color: Color(0xff3F4850),
                                                  child: Column(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        height: height * 0.03,
                                                      ),
                                                      Text(
                                                        "Choose another site",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Poppins",
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors.white,
                                                            fontSize: 18),
                                                      ),
                                                      SizedBox(
                                                        height: height * 0.05,
                                                      ),
                                                      ListView.builder(
                                                        physics:
                                                            NeverScrollableScrollPhysics(),
                                                        shrinkWrap: true,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    width *
                                                                        0.08),
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          return SiteDett(
                                                              width: width,
                                                              siteImg: siteImg,
                                                              index: index,
                                                              siteName:
                                                                  siteName,
                                                              sitelocation:
                                                                  sitelocation);
                                                        },
                                                        itemCount:
                                                            siteImg.length,
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: Container(
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Acers Marathon",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.white,
                                                          fontFamily: "Poppins",
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Image.asset(
                                                        "assets/down.png"),
                                                  ],
                                                ),
                                                Text(
                                                  "Tampa, FL",
                                                  style: TextStyle(
                                                      color: Color(0xff6E7191),
                                                      fontFamily: "Poppins",
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Responsive.isDesktop(context)
                                                ? Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          NewChatMain(
                                                        index: 0,
                                                      ),
                                                    ))
                                                : Navigator.pushNamed(
                                                    context, AppRoutes.newchat);
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: Responsive.isDesktop(context)
                                                ? 150
                                                : width * 0.35,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color: Color(0xff5081DB),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "New Chat",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white,
                                                      fontFamily: "Poppins",
                                                      fontWeight:
                                                          FontWeight.w600),
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
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: snapshot.data?.docs.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          // var document = _allChats[index];

                                          return InkWell(
                                            onTap: () {
                                              document![index]
                                                  .reference
                                                  .collection("messages")
                                                  .doc(document[index].id +
                                                      "sent")
                                                  .update({
                                                "isNew": false,
                                              });

                                              callChatScreenn(
                                                  document[index]['uid1'] ==
                                                          user.uid
                                                      ? document[index]["uid2"]
                                                      : document[index]["uid1"],
                                                  document[index]['user1'] ==
                                                          user.name
                                                      ? document[index]["user2"]
                                                      : document[index]
                                                          ["user1"],
                                                  user.name,
                                                  document[index]['photo1'] ==
                                                          user.name
                                                      ? document[index]
                                                          ["photo2"]
                                                      : document[index]
                                                          ["photo2"],
                                                  user.dpurl);
                                            },
                                            child: ChatListTile(
                                              doc: document![index],
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
