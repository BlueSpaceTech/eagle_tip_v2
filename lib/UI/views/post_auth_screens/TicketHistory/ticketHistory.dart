// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testttttt/Providers/user_provider.dart';
import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/UI/Widgets/customHeader2.dart';
import 'package:testttttt/UI/views/post_auth_screens/TicketHistory/ticketHistoryDetail.dart';
import 'package:testttttt/Utils/common.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:testttttt/Models/user.dart' as model;
import 'package:provider/provider.dart';

class TicketHistory extends StatelessWidget {
  TicketHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    model.User? user = Provider.of<UserProvider>(context).getUser;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.support);
          },
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              color: backGround_color,
              height: height,
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(left: width * 0.04, top: height * 0.01),
                    child: CustomHeader2(),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Text(
                    "Ticket History",
                    style: TextStyle(
                        fontSize: 17.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Poppins"),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Text(
                    user!.name,
                    style: TextStyle(
                        fontSize: 13.0,
                        color: Color(0xFF6E7191),
                        fontWeight: FontWeight.w500,
                        fontFamily: "Poppins"),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Container(
                    height: height * 0.07,
                    child: Material(
                      color: Color(0xFF2E3840),
                      child: TabBar(
                        tabs: [
                          Tab(
                            child: Text(
                              "Open",
                              style: TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Poppins"),
                            ),
                          ),
                          Tab(
                            child: Text(
                              "Closed",
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
                        OpenTickets(
                          width: width,
                          height: height,
                        ),
                        ClosedTickets(
                          width: width,
                          height: height,
                        ),
                      ],
                    ),
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

class OpenTickets extends StatefulWidget {
  const OpenTickets({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  State<OpenTickets> createState() => _OpenTicketsState();
}

class _OpenTicketsState extends State<OpenTickets> {
  @override
  Widget build(BuildContext context) {
    model.User? user = Provider.of<UserProvider>(context).getUser;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("tickets")
            .where("sites", arrayContainsAny: user!.sites)
            .where("isopen", isEqualTo: true)
            .orderBy("timestamp")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }

          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return Text("Loading");
          // }
          if (!snapshot.hasData) {
            return Center(
                child: Text(
              "No ticket to display",
              style: TextStyle(color: Colors.white, fontSize: 13.0),
            ));
          }

          var doc = snapshot.data?.docs;
          // print(doc?.toList());
          var document = doc
              ?.where((element) =>
                  element["byid"] == user.uid ||
                  element["visibleto"] == user.userRole)
              .toList();
          // print(document);
          // var document = doc1?.toList();
          return document!.isEmpty
              ? Center(
                  child: Text(
                  "No ticket to display",
                  style: TextStyle(color: Colors.white, fontSize: 13.0),
                ))
              : ListView.builder(
                  itemCount: document.length,
                  itemBuilder: (BuildContext context, int index) {
                    // if ((document![index]["isopen"]) &&
                    //     (document[index]["byid"] == user.uid ||
                    //         document[index]["visibleto"] == user.userRole)) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TicketDetail(
                                    doc: document[index],
                                    ticketTitle: document[index]["messages"][0]
                                        ["title"],
                                    status: document[index]["isopen"]
                                        ? "Open"
                                        : "Closed",
                                    siteName: document[index]["sites"][0],
                                    ticketMessage: document[index]["messages"]
                                        [0]["description"],
                                    userName: document[index]["name"],
                                    date: DateFormat('dd/MM/yyyy')
                                        .format(DateTime.parse(document[index]
                                                ["timestamp"]
                                            .toDate()
                                            .toString()))
                                        .toString())));
                      },
                      child: Container(
                        width: widget.width * 0.8,
                        height: widget.height * 0.065,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: widget.width * 0.05,
                              right: widget.width * 0.05,
                              top: widget.height * 0.02),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: widget.height * 0.06,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      document[index]["messages"][0]["title"]
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Poppins"),
                                    ),
                                    Text(
                                      DateFormat('dd/MM/yyyy')
                                          .format(DateTime.parse(document[index]
                                                  ["timestamp"]
                                              .toDate()
                                              .toString()))
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Poppins"),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 17.0,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  //   return SizedBox(
                  //     child: Text(
                  //       "No tickets to display",
                  //       style: TextStyle(color: Colors.white, fontSize: 13.0),
                  //     ),
                  //   );
                  // },
                  );
        });
  }
}

class ClosedTickets extends StatefulWidget {
  const ClosedTickets({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  State<ClosedTickets> createState() => _ClosedTicketsState();
}

class _ClosedTicketsState extends State<ClosedTickets> {
  @override
  Widget build(BuildContext context) {
    model.User? user = Provider.of<UserProvider>(context).getUser;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("tickets")
            .where("sites", arrayContainsAny: user!.sites)
            .where("isopen", isEqualTo: false)
            .orderBy("timestamp")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something Went wrong");
          }
          if (!snapshot.hasData) {
            return Center(
                child: Text(
              "No ticket to display",
              style: TextStyle(color: Colors.white, fontSize: 13.0),
            ));
          }

          var doc = snapshot.data?.docs;
          //  print(doc?.toList());
          var document = doc
              ?.where((element) =>
                  element["byid"] == user.uid ||
                  element["visibleto"] == user.userRole)
              .toList();
          //  print(document);
          // var document = doc1?.toList();
          return document!.isEmpty
              ? Center(
                  child: Text(
                  "No ticket to display",
                  style: TextStyle(color: Colors.white, fontSize: 13.0),
                ))
              : ListView.builder(
                  itemCount: document.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TicketDetail(
                                    doc: document[index],
                                    ticketTitle: document[index]["messages"][0]
                                        ["title"],
                                    status: document[index]["isopen"]
                                        ? "Open"
                                        : "Closed",
                                    siteName: document[index]["sites"][0],
                                    ticketMessage: document[index]["messages"]
                                        [0]["description"],
                                    userName: document[index]["name"],
                                    date: DateFormat('dd/MM/yyyy')
                                        .format(DateTime.parse(document[index]
                                                ["timestamp"]
                                            .toDate()
                                            .toString()))
                                        .toString())));
                      },
                      child: Container(
                        width: widget.width * 0.8,
                        height: widget.height * 0.065,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: widget.width * 0.05,
                              right: widget.width * 0.05,
                              top: widget.height * 0.02),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: widget.height * 0.06,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      document[index]["messages"][0]["title"]
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Poppins"),
                                    ),
                                    Text(
                                      DateFormat('dd/MM/yyyy')
                                          .format(DateTime.parse(document[index]
                                                  ["timestamp"]
                                              .toDate()
                                              .toString()))
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Poppins"),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 17.0,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
        });
  }
}
