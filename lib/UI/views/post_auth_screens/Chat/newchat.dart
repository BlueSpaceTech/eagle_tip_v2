import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testttttt/Providers/user_provider.dart';
import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/UI/Widgets/chatListTile.dart';
import 'package:testttttt/UI/Widgets/logo.dart';
import 'package:testttttt/UI/Widgets/newchatListtile.dart';
import 'package:testttttt/UI/views/post_auth_screens/Chat/allchats.dart';
import 'package:testttttt/UI/views/post_auth_screens/Chat/chatting.dart';
import 'package:testttttt/UI/views/post_auth_screens/Chat/message_main.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testttttt/Models/user.dart' as model;

class NewChatScreen extends StatefulWidget {
  const NewChatScreen({Key? key}) : super(key: key);

  @override
  _NewChatScreenState createState() => _NewChatScreenState();
}

class _NewChatScreenState extends State<NewChatScreen> {
  void callChatScreen(String uid, String name, String currentusername,
      String photoUrlfriend, String photourluser) {
    Responsive.isDesktop(context)
        ? Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => MessageMain(
                      photourlfriend: photoUrlfriend,
                      photourluser: photourluser,
                      index: 0,
                      frienduid: uid,
                      friendname: name,
                      currentusername: currentusername,
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
                    currentusername: currentusername)));
  }

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;
    List siteImg = ["site1", "site2"];
    List siteName = ["Acres Marathon", "Akron Marathon"];
    List sitelocation = ["Tampa,FL", "Leesburg,FL"];
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xff2B343B),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("users")
              .where(
                "isverified",
                isEqualTo: true,
              )
              .where("sites", arrayContainsAny: user.sites)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("There's some error");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              );
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  Visibility(
                    visible: Responsive.isDesktop(context),
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      width: width * 0.3,
                      height: 80,
                      color: Color(0xff5081DB),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.pushNamed(
                                  context, AppRoutes.messagemain);
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                          Text("New Chat",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22)),
                          Text("   "),
                        ],
                      ),
                    ),
                  ),
                  Padding(
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: !Responsive.isDesktop(context),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        SizedBox(
                          height: Responsive.isDesktop(context)
                              ? height * 0.01
                              : height * 0.04,
                        ),
                        Visibility(
                          visible: !Responsive.isDesktop(context),
                          child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet<void>(
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
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w600,
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
                                          padding: EdgeInsets.symmetric(
                                              horizontal: width * 0.08),
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return SiteDett(
                                                width: width,
                                                siteImg: siteImg,
                                                index: index,
                                                siteName: siteName,
                                                sitelocation: sitelocation);
                                          },
                                          itemCount: siteImg.length,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
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
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Image.asset("assets/down.png"),
                                      ],
                                    ),
                                    Text(
                                      "Tampa, FL",
                                      style: TextStyle(
                                          color: Color(0xff6E7191),
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data?.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              final document = snapshot.data?.docs[index];
                              return GestureDetector(
                                onTap: () {
                                  callChatScreen(
                                      document!["uid"],
                                      document["name"],
                                      user.name,
                                      document["dpUrl"],
                                      user.dpurl);
                                },
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: NewChatListTile(
                                    doc: document!,
                                    height: height,
                                    width: width,
                                  ),
                                ),
                              );
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
