// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:testttttt/Providers/user_provider.dart';
import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/UI/Widgets/customContainer.dart';
import 'package:testttttt/UI/Widgets/customHeader2.dart';
import 'package:testttttt/UI/Widgets/customNav.dart';
import 'package:testttttt/UI/Widgets/custom_webbg.dart';
import 'package:testttttt/UI/Widgets/customappheader.dart';
import 'package:testttttt/UI/views/post_auth_screens/Chat/chatting.dart';
import 'package:testttttt/UI/views/post_auth_screens/Chat/message_model.dart';
import 'package:testttttt/UI/views/post_auth_screens/Support/supoort_chat.dart';
import 'package:testttttt/UI/views/post_auth_screens/UserProfiles/myprofile.dart';
import 'package:testttttt/Utils/common.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:testttttt/Models/user.dart' as model;

class TicketDetail extends StatefulWidget {
  TicketDetail({
    Key? key,
    required this.ticketTitle,
    required this.status,
    required this.siteName,
    required this.ticketMessage,
    required this.userName,
    required this.date,
    required this.doc,
  }) : super(key: key);

  final String ticketTitle;
  final String status;
  final String siteName;
  final String ticketMessage;
  final String userName;
  final String date;
  final DocumentSnapshot doc;

  @override
  State<TicketDetail> createState() => _TicketDetailState();
}

class _TicketDetailState extends State<TicketDetail> {
  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: Responsive.isDesktop(context)
          ? MenuButton(isTapped: false, width: width)
          : SizedBox(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: Responsive.isDesktop(context) ? height * 1.17 : height,
            color: backGround_color,
            child: Padding(
              padding: EdgeInsets.only(
                  top: height * 0.01,
                  left: Responsive.isDesktop(context) ? 0.0 : width * 0.04,
                  right: Responsive.isDesktop(context) ? 0.0 : width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Responsive.isDesktop(context)
                      ? Navbar(
                          width: width,
                          height: height,
                          text1: "Home",
                          text2: "Sites",
                        )
                      : CustomHeader2(),
                  SizedBox(
                    height: height * 0.06,
                  ),
                  Stack(
                    children: [
                      WebBg(),
                      CustomContainer(
                          opacity: 0.2,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: Responsive.isDesktop(context)
                                    ? width * 0.04
                                    : 0.0,
                                right: Responsive.isDesktop(context)
                                    ? width * 0.04
                                    : 0.0,
                                top: Responsive.isDesktop(context)
                                    ? height * 0.03
                                    : 0.0),
                            child: Column(
                              children: [
                                Ticketdet(
                                  date: widget.date,
                                  siteName: widget.siteName,
                                  userName: widget.userName,
                                  status: widget.status,
                                ),
                                SizedBox(
                                  height: height * 0.04,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      widget.ticketTitle,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontFamily: "Poppins",
                                          fontSize: 18.0),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height * 0.04,
                                ),
                                TicketMessages(
                                  docid: widget.doc,
                                  byname: widget.userName,
                                  width: width,
                                ),
                                // Column(
                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                //   children: [
                                //     Text(
                                //       "${widget.userName}: ",
                                //       style: TextStyle(
                                //           color: Colors.white,
                                //           fontSize: 12.0,
                                //           fontWeight: FontWeight.bold,
                                //           fontFamily: "Poppins"),
                                //     ),
                                //     Container(
                                //       width: width * 0.9,
                                //       child: Text(
                                //         widget.ticketMessage,
                                //         style: TextStyle(
                                //             color: Colors.white,
                                //             fontSize: 12.0,
                                //             fontWeight: FontWeight.w400,
                                //             fontFamily: "Poppins"),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                // SizedBox(
                                //   height: height * 0.04,
                                // ),
                                // Column(
                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                //   children: [
                                //     Row(
                                //       mainAxisAlignment: MainAxisAlignment.end,
                                //       children: [
                                //         Text(
                                //           "Support: ",
                                //           style: TextStyle(
                                //               color: Colors.white,
                                //               fontSize: 12.0,
                                //               fontWeight: FontWeight.bold,
                                //               fontFamily: "Poppins"),
                                //         ),
                                //       ],
                                //     ),
                                //     Container(
                                //       width: width * 0.9,
                                //       child: Text(
                                //         "Diam aenean ullamcorper viverra sed tincidunt. Volutpat amet et scelerisque lacus, vitae rhoncus iaculis. In egestas a cras orci cras. Neque at magna nunc turpis. Leo mattis porttitor sed nisl.",
                                //         textAlign: TextAlign.right,
                                //         style: TextStyle(
                                //             color: Colors.white,
                                //             fontSize: 12.0,
                                //             fontWeight: FontWeight.w400,
                                //             fontFamily: "Poppins"),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                SizedBox(
                                  height: Responsive.isDesktop(context)
                                      ? height * 0.05
                                      : height * 0.03,
                                ),
                                Visibility(
                                  visible: widget.doc["isopen"] &&
                                      widget.doc["visibleto"] == user.userRole,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                              builder: (context) =>
                                                  SupportChatScreenn(
                                                    docid: widget.doc,
                                                    title: widget.ticketTitle,
                                                    username: widget.userName,
                                                    email: widget.doc["email"],
                                                    isbefore: widget
                                                        .doc["beforelogin"],
                                                  )));
                                    },
                                    child: CustomButton(
                                      width: width,
                                      height: height,
                                      buttonText: "Reply",
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                /*
                                Visibility(
                                  visible: widget.doc["isopen"] &&
                                      widget.doc["visibleto"] == user.userRole,
                                  child: InkWell(
                                    onTap: () {
                                      FirebaseFirestore.instance
                                          .collection("tickets")
                                          .doc(widget.doc.id)
                                          .update({"isopen": false});
                                      Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                              builder: (context) =>
                                                  MyProfile()));
                                    },
                                    child: CustomButton(
                                      width: width,
                                      height: height,
                                      buttonText: "Close",
                                    ),
                                  ),
                                ),
                                */
                              ],
                            ),
                          ),
                          width: width,
                          topPad: 0.0,
                          height: height * 0.85)
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TicketMessages extends StatefulWidget {
  const TicketMessages(
      {Key? key,
      required this.docid,
      required this.byname,
      required this.width})
      : super(key: key);
  final DocumentSnapshot docid;
  final String byname;
  final double width;

  @override
  State<TicketMessages> createState() => _TicketMessagesState();
}

class _TicketMessagesState extends State<TicketMessages> {
  _chatBubble(String message, bool isMe, String name) {
    if (isMe) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                alignment: Alignment.topRight,
                child: Text(
                  name,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Poppins"),
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Container(
                alignment: Alignment.topRight,
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.80,
                  ),
                  padding: EdgeInsets.only(right: 8, left: 8),
                  margin: EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                    message,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Poppins"),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                alignment: Alignment.topRight,
                child: Text(
                  name,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Poppins"),
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.80,
                  ),
                  padding: EdgeInsets.only(right: 8, left: 8),
                  margin: EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                    message,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Poppins"),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("tickets")
            .doc(widget.docid.id)
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
          return Container(
            width: widget.width * 0.4,
            child: ListView.builder(
              shrinkWrap: true,
              reverse: true,
              padding: EdgeInsets.all(20),
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (BuildContext context, int index) {
                final currentUserUID = FirebaseAuth.instance.currentUser!.uid;
                final document = snapshot.data?.docs[index];
                // final Message message = messages[index];
                //  final bool isMe = message.sender == "currentUser";
                /*
                final bool isSameUser = prevUserId == "";
                prevUserId = message.sender.id;
                f
      */
                final bool isMe = document!["by"] == currentUserUID;
                final String name = document["by"] == widget.docid["byid"]
                    ? widget.byname
                    : "Support";
                return _chatBubble(document["message"], isMe, name);
              },
            ),
          );
        });
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.width,
    required this.buttonText,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.isDesktop(context) ? width * 0.27 : width * 0.9,
      height: Responsive.isDesktop(context) ? height * 0.055 : height * 0.07,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Color(0xFF5081DB),
      ),
      child: Center(
        child: Text(
          buttonText,
          style: TextStyle(
              fontSize: 18.0,
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontFamily: "Poppins"),
        ),
      ),
    );
  }
}

class Ticketdet extends StatelessWidget {
  const Ticketdet({
    Key? key,
    required this.userName,
    required this.date,
    required this.siteName,
    required this.status,
  }) : super(key: key);
  final String userName;
  final String siteName;
  final String date;
  final String status;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: "User:",
                style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Poppins",
                    color: Colors.white),
                children: [
                  TextSpan(
                    text: "  $userName",
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Color(0xFFD9DBE9),
                      fontWeight: FontWeight.w400,
                      fontFamily: "Poppins",
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            RichText(
              text: TextSpan(
                text: "Site:",
                style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Poppins",
                    color: Colors.white),
                children: [
                  TextSpan(
                    text: "  $siteName",
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Color(0xFFD9DBE9),
                      fontWeight: FontWeight.w400,
                      fontFamily: "Poppins",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: "Date:",
                style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Poppins",
                    color: Colors.white),
                children: [
                  TextSpan(
                    text: date,
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Color(0xFFD9DBE9),
                      fontWeight: FontWeight.w400,
                      fontFamily: "Poppins",
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            RichText(
              text: TextSpan(
                text: "Status:",
                style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Poppins",
                    color: Colors.white),
                children: [
                  TextSpan(
                    text: "  $status",
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Color(0xFFD9DBE9),
                      fontWeight: FontWeight.w400,
                      fontFamily: "Poppins",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
