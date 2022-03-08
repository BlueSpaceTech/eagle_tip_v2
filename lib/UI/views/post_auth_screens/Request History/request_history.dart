// ignore_for_file: prefer_const_constructors
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
// import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/UI/views/post_auth_screens/Request%20History/particular_request.dart';
// import 'package:testttttt/Utils/common.dart';
// import 'package:testttttt/Utils/constants.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:testttttt/Models/user.dart' as model;
import '../../../../Providers/user_provider.dart';

class Requests extends StatelessWidget {
  const Requests({
    Key? key,
    required this.height,
    required this.requestId,
    required this.width,
    required this.requestDate,
  }) : super(key: key);

  final double height;
  final List requestId;
  final double width;
  final List requestDate;

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;
    return SizedBox(
      height: height * 0.6,
      width: width * 0.3,
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("requesthistory")
            .where("site", whereIn: user.sites)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (BuildContext context, int index) {
              final document = snapshot.data?.docs[index];
              return ReqContainer(
                  width: width,
                  index: index,
                  height: height,
                  requestId: document!["id"],
                  siteName: document["site"],
                  tankdata: document["data"],
                  username: document["requestby"],
                  requestDate: DateFormat('dd/MM/yyyy')
                      .format(
                          DateTime.parse(document["date"].toDate().toString()))
                      .toString());
            },
          );
        },
      ),
    );
  }
}

class ReqContainer extends StatelessWidget {
  const ReqContainer({
    Key? key,
    required this.width,
    required this.height,
    required this.tankdata,
    required this.index,
    required this.siteName,
    required this.requestId,
    required this.username,
    required this.requestDate,
  }) : super(key: key);

  final double width;
  final double height;
  final String requestId;
  final List tankdata;
  final String requestDate;
  final String username;
  final String siteName;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => ParticularRequest(
                tanksData: tankdata,
                sitename: siteName,
                name: username,
                orderid: requestId,
                date: requestDate,
              ),
            ),
          );
        },
        child: SizedBox(
          width: width * 0.9,
          height: height * 0.075,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Acres Marathon #$requestId",
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Poppins",
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    requestDate,
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Poppins",
                      color: Color(0xFFD9DBE9),
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: Responsive.isDesktop(context)
                    ? width * 0.015
                    : width * 0.045,
                color: Colors.white,
              )
            ],
          ),
        ));
  }
}
