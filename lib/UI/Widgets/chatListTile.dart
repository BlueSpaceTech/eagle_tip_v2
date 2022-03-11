import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testttttt/Providers/user_provider.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:testttttt/Models/user.dart' as model;
import 'package:provider/provider.dart';

class ChatListTile extends StatelessWidget {
  const ChatListTile({
    Key? key,
    required this.height,
    required this.width,
    required this.doc,
  }) : super(key: key);
  final double height;
  final double width;
  final DocumentSnapshot doc;

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;
    return Ink(
      padding: EdgeInsets.only(top: height * 0.03),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(
                doc["photo1"] == user.dpurl ? doc["photo2"] : doc["photo1"]),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            width: Responsive.isDesktop(context) ? width * 0.18 : width * 0.55,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doc["user1"] == user.name ? doc['user2'] : doc["user1"],
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  "yesterday",
                  style: TextStyle(
                      fontSize: 12,
                      color: Color(0xffD9DBE9),
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("chats")
                .doc(doc.id)
                .collection("messages")
                .where("isNew", isEqualTo: true)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              final documentlen = snapshot.data?.docs.length;
              final doclist = [];
              final currentUserUID = FirebaseAuth.instance.currentUser!.uid;
              final docs = snapshot.data!.docs;
              docs.forEach((element) {
                if (element["uid"] != currentUserUID) {
                  doclist.add(element);
                }
              });
              if (snapshot.hasData) {
                return Container(
                  alignment: Alignment.center,
                  width: 20,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xff5081DB)),
                  child: Text(
                    doclist.isEmpty ? "" : doclist.length.toString(),
                    style:
                        TextStyle(color: Colors.white, fontFamily: "Poppins"),
                  ),
                );
              }
              return Text("");
            },
          ),
        ],
      ),
    );
  }
}
