import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NewChatListTile extends StatelessWidget {
  const NewChatListTile({
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
    return Ink(
      padding: EdgeInsets.only(top: height * 0.03),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          doc["dpUrl"] == ""
              ? ClipRRect(
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
                )
              : CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(doc["dpUrl"]),
                ),
          SizedBox(
            width: 10,
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doc["name"],
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  doc["userRole"],
                  style: TextStyle(
                      fontSize: 12,
                      color: Color(0xffD9DBE9),
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
