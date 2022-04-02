import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testttttt/Providers/user_provider.dart';
import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/UI/Widgets/chatListTile.dart';
import 'package:testttttt/UI/Widgets/logo.dart';
import 'package:testttttt/UI/views/post_auth_screens/Chat/message_main.dart';
import 'package:testttttt/UI/views/post_auth_screens/Chat/chatting.dart';
import 'package:testttttt/UI/views/post_auth_screens/Sites/sites.dart';
import 'package:testttttt/Utils/common.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:testttttt/Models/user.dart' as model;
import 'package:provider/provider.dart';

class AllChatScreen extends StatefulWidget {
  AllChatScreen({Key? key}) : super(key: key);

  @override
  State<AllChatScreen> createState() => _AllChatScreenState();
}

class _AllChatScreenState extends State<AllChatScreen> {
  final currentUserUID = FirebaseAuth.instance.currentUser!.uid;
  List siteImg = ["site1", "site2"];

  List siteName = ["Acres Marathon", "Akron Marathon"];
  Future? resultsLoaded;

  List sitelocation = ["Tampa,FL", "Leesburg,FL"];
  List _allChats = [];
  getUserChats() async {
    var data = await FirebaseFirestore.instance
        .collection("chats")
        .where("between", arrayContainsAny: [currentUserUID]).get();
    setState(() {
      _allChats = data.docs;
    });
    print(_allChats.first);
    return "complete";
  }

  @override
  void initState() {
    // TODO: implement initState
    print(_allChats);
    //getUserChats();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  final TextEditingController _search = new TextEditingController();

/*
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    resultsLoaded = getUserChats();
  }
*/
  void callChatScreen(String uid, String name, String currentusername,
      String photoUrlfriend, String photourluser) {
    Responsive.isDesktop(context)
        ? Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => MessageMain(
                      // photourlfriend: photoUrlfriend,
                      // photourluser: photourluser,
                      // index: 0,
                      // frienduid: uid,
                      // friendname: name,
                      // currentusername: currentusername,
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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    model.User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () {
          Responsive.isDesktop(context)
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewChatMain(
                      index: 0,
                    ),
                  ))
              : Navigator.pushNamed(context, AppRoutes.newchat);
        },
        child: Container(
          alignment: Alignment.center,
          width: Responsive.isDesktop(context) ? 200 : width * 0.35,
          height: 50,
          decoration: BoxDecoration(
            color: Color(0xff5081DB),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "New Chat",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                width: width * 0.02,
              ),
              Image.asset("assets/newchat.png"),
            ],
          ),
        ),
      ),
      backgroundColor: Color(0xff2B343B),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("chats")
              .where("between", arrayContainsAny: [user.uid]).snapshots(),
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
                      height: height * 0.04,
                    ),
                    GestureDetector(
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
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width * 0.08),
                                    itemBuilder:
                                        (BuildContext context, int index) {
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
                                mainAxisAlignment: MainAxisAlignment.center,
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
                    document!.isEmpty
                        ? Center(
                            child: Text(
                              "No Chats to display",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        : ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data?.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              // var document = _allChats[index];

                              return InkWell(
                                onTap: () {
                                  // document![index]
                                  //     .reference
                                  //     .collection("messages")
                                  //     .doc(document[index].id + "sent")
                                  //     .update({
                                  //   "isNew": false,
                                  // });

                                  callChatScreen(
                                      document[index]['uid1'] == user.uid
                                          ? document[index]["uid2"]
                                          : document[index]["uid1"],
                                      document[index]['user1'] == user.name
                                          ? document[index]["user2"]
                                          : document[index]["user1"],
                                      user.name,
                                      document[index]['photo1'] == user.dpurl
                                          ? document[index]["photo2"]
                                          : document[index]["photo1"],
                                      user.dpurl);
                                },
                                child: ChatListTile(
                                  doc: document[index],
                                  newChat: document[index]["isNew"],
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
    );
  }
}

class SiteDett extends StatelessWidget {
  const SiteDett({
    Key? key,
    required this.index,
    required this.width,
    required this.siteImg,
    required this.siteName,
    required this.sitelocation,
  }) : super(key: key);

  final double width;
  final List siteImg;
  final List siteName;
  final int index;
  final List sitelocation;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.only(bottom: 14.0),
        child: Container(
          width: width * 0.9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  children: [
                    Image.asset(
                      Common.assetImages + "${siteImg[index]}.png",
                      width: Responsive.isDesktop(context)
                          ? width * 0.06
                          : width * 0.14,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          siteName[index],
                          style: TextStyle(
                            fontSize: 17.0,
                            fontFamily: "Poppins",
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          sitelocation[index],
                          style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Poppins",
                              color: Color(0xFFd9dbe9)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
