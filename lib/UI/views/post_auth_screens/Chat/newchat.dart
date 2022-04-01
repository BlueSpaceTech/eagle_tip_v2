import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart';
import 'package:testttttt/Providers/user_provider.dart';
import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/Services/Crud_functions.dart';
import 'package:testttttt/UI/Widgets/chatListTile.dart';
import 'package:testttttt/UI/Widgets/logo.dart';
import 'package:testttttt/UI/Widgets/newchatListtile.dart';
import 'package:testttttt/UI/views/post_auth_screens/Chat/allchats.dart';
import 'package:testttttt/UI/views/post_auth_screens/Chat/chatting.dart';
import 'package:testttttt/UI/views/post_auth_screens/Chat/message_main.dart';
import 'package:testttttt/UI/views/post_auth_screens/Chat/web_chatting.dart';
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
  var chatId;
  bool _loading = false;
  void callChatScreen(String uid, String name, String currentusername,
      String photoUrlfriend, String photourluser) async {
    setState(() {
      _loading = true;
    });
    await getChatId(uid, name, currentusername, photoUrlfriend, photourluser);

    await Future.delayed(const Duration(seconds: 3));
    print(chatId + "gggggR");
    setState(() {
      _loading = false;
    });
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
                      Chatscreen: WebChatScreenn(
                        photourlfriend: photoUrlfriend,
                        friendname: name,
                        chatId: chatId,
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
                    currentusername: currentusername)));
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
              "recentTime": FieldValue.serverTimestamp(),
              "isNew": currentUserUID,
            }).then((value) => {
                  setState(() {
                    chatId = value.id;
                  })
                });
          }
        })
        .catchError((err) {});
  }

  final TextEditingController _SEARCH = new TextEditingController();
  Future? resultsloaded;
  String userRole = "";
  getCurrentUserRole() async {
    DocumentReference dbRef = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    await dbRef.get().then((data) {
      if (data.exists) {
        if (mounted) {
          setState(() {
            print("fetching");

            userRole = data.get("userRole");
            // email = data.get("email");
            // phone = data.get("phonenumber");
          });
        }
      }
    });
  }

  List _allResults = [];
  List _resultList = [];

  getUserdetails(List sites, String uid) async {
    var data = await FirebaseFirestore.instance
        .collection("users")
        .where(
          "isverified",
          isEqualTo: true,
        )
        .where("sites", arrayContainsAny: sites)
        .where("uid", isNotEqualTo: uid)
        .get();
    setState(() {
      _allResults = data.docs;
    });
    searchresult();
    return "done";
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    model.User user = Provider.of<UserProvider>(context).getUser;
    resultsloaded = getUserdetails(user.sites, user.uid);
  }

  _onsearchange() {
    searchresult();
  }

  serchrole() {
    searchresult();
  }

  searchresult() {
    var showResults = [];
    if (_SEARCH.text != "") {
      //we have a search parameter
      for (var usersnap in _resultList) {
        var name = model.User.fromSnap(usersnap).name.toLowerCase();

        if (name.contains(_SEARCH.text.toLowerCase())) {
          showResults.add(usersnap);
        }

        /*
        if (sites.contains(selectedsites)) {
          showResults.add(usersnap);
        }
        */
      }
    } else {
      for (var usersnap in _allResults) {
        var role = model.User.fromSnap(usersnap).userRole;
        var user = model.User.fromSnap(usersnap);
        List visiblefor = CrudFunction().allChatVisibility(userRole);
        // List visiblefor = ["SiteManager", "SiteUser"];
        if (visiblefor.contains(usersnap["userRole"])) {
          print("contains");
          showResults.add(usersnap);
        } else {
          // _allResults.remove(user);
          print("removed");
        }
      }

      // showResults = List.from(_allResults);
    }
    setState(() {
      _resultList = showResults;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUserRole();
    _SEARCH.addListener(_onsearchange);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _SEARCH.removeListener(_onsearchange);
    _SEARCH.dispose();
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
        body: SingleChildScrollView(
          child: Stack(children: [
            Column(
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
                            Navigator.pushNamed(context, AppRoutes.messagemain);
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
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(
                            left: width * 0.06, right: width * 0.06),
                        height: height * 0.064,
                        width: Responsive.isDesktop(context)
                            ? width * 0.3
                            : width * 0.8,
                        decoration: BoxDecoration(
                          color: Color(0xff535C65),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: TextField(
                          controller: _SEARCH,
                          style: TextStyle(
                              fontFamily: "Poppins", color: Colors.white),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            hintText: "Search by name",
                            hintStyle:
                                TextStyle(color: Colors.white.withOpacity(0.5)),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _resultList.length,
                          itemBuilder: (BuildContext context, int index) {
                            final document = _resultList[index];
                            return InkWell(
                              onTap: () {
                                callChatScreen(
                                    document!["uid"],
                                    document["name"],
                                    user.name,
                                    document["dpUrl"],
                                    user.dpurl);
                              },
                              child: NewChatListTile(
                                doc: document!,
                                height: height,
                                width: width,
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              ],
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Visibility(
                    visible: _loading,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.grey.shade300,
                      color: Colors.blue,
                    )),
              ),
            ),
          ]),
        ));
  }
}
