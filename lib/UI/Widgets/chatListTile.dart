import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testttttt/Providers/user_provider.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:testttttt/Models/user.dart' as model;
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatListTile extends StatefulWidget {
  const ChatListTile({
    Key? key,
    required this.height,
    required this.width,
    required this.doc,
    required this.newChat,
  }) : super(key: key);
  final double height;
  final String newChat;
  final double width;
  final DocumentSnapshot doc;

  @override
  State<ChatListTile> createState() => _ChatListTileState();
}

class _ChatListTileState extends State<ChatListTile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // fetchrecenttime(widget.doc);
    // gettimeago(widget.doc);
  }

  // gettimeago(DocumentSnapshot doc) async {
  //   Timestamp timestamp = Timestamp(20, 20);
  //   DocumentReference dbRef = FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(FirebaseAuth.instance.currentUser!.uid);
  //   await dbRef.get().then((data) {
  //     if (data.exists) {
  //       if (mounted) {
  //         setState(() {
  //           print("fetching");
  //           timestamp = data.get("recentTime");

  //           // email = data.get("email");
  //           // phone = data.get("phonenumber");
  //         });
  //       }
  //     }
  //   });

  //   final datetime = DateTime.now().difference(timestamp.toDate());
  //  if((datetime.inDays/7).floor()>=1){
  //    return ';'
  //  }
  // }

  List timestamps = [];
  fetchrecenttime(DocumentSnapshot doc) async {
    CollectionReference col = FirebaseFirestore.instance
        .collection("chats")
        .doc(widget.doc.id)
        .collection("messages");
    await col.get().then((value) {
      if (value.docs.isNotEmpty) {
        value.docs.forEach((element) {
          timestamps.add(element["createdOn"]);
        });
      }
    });
    print(timestamps);
  }

  getleasttime() {
    DateTime now = DateTime.now();
    int least = 2020202020020222;

    for (var time in timestamps) {
      if (now.difference(time.toDate()).inMilliseconds < least) {
        setState(() {
          least = time.toDate();
        });
      }
    }
    return least;
  }

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;
    return Ink(
      padding: EdgeInsets.only(top: widget.height * 0.03),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(widget.doc["photo1"] == user.dpurl
                ? widget.doc["photo2"]
                : widget.doc["photo1"]),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            width: Responsive.isDesktop(context)
                ? widget.width * 0.18
                : widget.width * 0.55,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.doc["user1"] == user.name
                      ? widget.doc['user2']
                      : widget.doc["user1"],
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600),
                ),
                // Text(
                //   "yes",
                //   style: TextStyle(
                //       fontSize: 12,
                //       color: Color(0xffD9DBE9),
                //       fontFamily: "Poppins",
                //       fontWeight: FontWeight.w500),
                // ),
              ],
            ),
          ),
          Visibility(
            visible: widget.newChat != user.uid,
            child: Container(
              alignment: Alignment.center,
              width: 20,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xff5081DB)),
            ),
          )
        ],
      ),
    );
  }
}
