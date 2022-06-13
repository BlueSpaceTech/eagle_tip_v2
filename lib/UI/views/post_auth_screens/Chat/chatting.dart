import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testttttt/Providers/user_provider.dart';
import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/UI/views/post_auth_screens/Chat/message_model.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:testttttt/Models/user.dart' as model;
import 'package:provider/provider.dart';

class ChatScreenn extends StatefulWidget {
  ChatScreenn({
    Key? key,
    required this.index,
    required this.frienduid,
    required this.friendname,
    required this.currentusername,
    required this.photourluser,
    required this.photourlfriend,
  }) : super(key: key);
  int index;
  final frienduid;
  final friendname;
  final currentusername;
  final photourluser;
  final photourlfriend;

  @override
  _ChatScreennState createState() => _ChatScreennState(
      frienduid, friendname, currentusername, photourluser, photourlfriend);
}

class _ChatScreennState extends State<ChatScreenn> {
  final frienduid;
  final friendname;
  final currentusername;
  final photourluser;
  final photourlfriend;
  final currentUserUID = FirebaseAuth.instance.currentUser!.uid;
  final TextEditingController _sendcontroller = new TextEditingController();
  _ChatScreennState(
    this.frienduid,
    this.friendname,
    this.currentusername,
    this.photourluser,
    this.photourlfriend,
  );
  CollectionReference chat = FirebaseFirestore.instance.collection("chats");
  void sendmessage(String message) {
    print("entered in send");
    if (message == "") {
      return;
    } else {
      print("entered in send1");

      print(chatDocId + "ffjjff");
      chat.doc(chatDocId).collection("messages").add({
        "createdOn": FieldValue.serverTimestamp(),
        "uid": currentUserUID,
        "message": message,
        "isNew": true,
      }).then((value) {
        print("entered in send2");
        _sendcontroller.text = "";
        chat.doc(chatDocId).update({
          "recentTime": FieldValue.serverTimestamp(),
          "isNew": currentUserUID,
        }).then((value) {
          print("updated recent time");
        });
      });
    }
  }

  _chatBubble(String message, bool isMe) {
    if (isMe) {
      return Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topRight,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.80,
              ),
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Text(
                message,
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.80,
              ),
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Color(0xff5081DB),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Text(
                message,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
        ],
      );
    }
  }

  _sendMessageArea(double height, double width) {
    return Visibility(
      visible: friendname != "Start chat by clicking on user",
      child: Container(
        margin: EdgeInsets.only(bottom: 5, left: 5, right: 5),
        padding: EdgeInsets.only(left: 15, right: 10),
        alignment: Alignment.centerLeft,
        height: height * 0.08,
        width: width * 0.92,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Color(0xff20272C),
        ),
        child: TextField(
          controller: _sendcontroller,
          onSubmitted: (value) {
            sendmessage(_sendcontroller.text);
          },
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            suffixIcon: InkWell(
                onTap: () {
                  sendmessage(_sendcontroller.text);
                },
                child: Image.asset("assets/send.png")),
            border: InputBorder.none,
            hintText: 'Message',
            hintStyle: TextStyle(
                color: Colors.white.withOpacity(0.6), fontFamily: "Poppins"),
          ),
        ),
      ),
    );
  }

  Stream<QuerySnapshot>? _stream;
  var chatDocId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("initated");

    chat
        .where("users", isEqualTo: {frienduid: null, currentUserUID: null})
        .limit(1)
        .get()
        .then((QuerySnapshot querySnapshot) {
          if (querySnapshot.docs.isNotEmpty) {
            setState(() {
              chatDocId = querySnapshot.docs.single.id;
              print(chatDocId);
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
    // _stream = getchats();
    print("finish");
  }

/*
  getchats() async {
    Stream<QuerySnapshot> doc = await FirebaseFirestore.instance
        .collection("chats")
        .doc(chatDocId)
        .collection("messages")
        .orderBy("createdOn", descending: true)
        .snapshots();
    return doc;
  }
*/

  @override
  Widget build(BuildContext context) {
    chat
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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    int prevUserId;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * 0.09),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xff2B343B),
          title: Container(
            padding: EdgeInsets.only(top: height * 0.03),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 10,
                ),
                Visibility(
                  visible: Responsive.isDesktop(context) ||
                          Responsive.isTablet(context)
                      ? false
                      : true,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: 25,
                ),
                Container(
                  width: width * 0.5,
                  child: Row(
                    children: [
                      widget.photourlfriend == ""
                          ? Visibility(
                              visible: friendname !=
                                      "Start chat by clicking on user" &&
                                  widget.photourluser != "",
                              child: ClipRRect(
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.person,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          : Visibility(
                              visible: friendname !=
                                      "Start chat by clicking on user" &&
                                  widget.photourluser != "",
                              child: CircleAvatar(
                                radius: 20,
                                backgroundImage:
                                    NetworkImage(widget.photourlfriend),
                              ),
                            ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        friendname,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Color(0XFF3F4850),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("chats")
              .doc(chatDocId)
              .collection("messages")
              .orderBy("createdOn", descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              );
            }
            /*
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              );
            }
            */
            return Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    reverse: true,
                    padding: EdgeInsets.all(20),
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      final document = snapshot.data?.docs[index];
                      // final Message message = messages[index];
                      //  final bool isMe = message.sender == "currentUser";
                      /*
                    final bool isSameUser = prevUserId == "";
                    prevUserId = message.sender.id;
                    f
      */
                      final bool isMe = document!["uid"] == currentUserUID;
                      return _chatBubble(document["message"], isMe);
                    },
                  ),
                ),
                _sendMessageArea(height, width),
              ],
            );
          }),
    );
  }
}
