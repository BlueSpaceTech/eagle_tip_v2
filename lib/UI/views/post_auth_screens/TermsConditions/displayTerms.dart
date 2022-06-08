// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testttttt/Models/user.dart' as model;
import 'package:testttttt/Providers/user_provider.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:testttttt/Utils/responsive.dart';

class OrderedList extends StatelessWidget {
  OrderedList(this.texts);
  final List<dynamic> texts;

  @override
  Widget build(BuildContext context) {
    var widgetList = <Widget>[];
    int counter = 0;
    for (var text in texts) {
      // Add list item
      counter++;
      widgetList.add(OrderedListItem(counter, text));
      // Add space between items
      widgetList.add(SizedBox(height: 13.0));
    }

    return Column(children: widgetList);
  }
}

class OrderedListItem extends StatelessWidget {
  OrderedListItem(this.counter, this.text);
  final int counter;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "$counter. ",
          style: TextStyle(color: Colors.white),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class DisplayTerms extends StatefulWidget {
  @override
  State<DisplayTerms> createState() => _DisplayTermsState();
}

class _DisplayTermsState extends State<DisplayTerms> {
  CollectionReference terms =
      FirebaseFirestore.instance.collection("termconditions");
  List termss1List = [];
  List privacyList = [];

  privacy1() async {
    await terms.doc("k5c1eJ3DFh3P9IO7HEAA").get().then((data) {
      if (data.exists) {
        if (mounted) {
          setState(() {
            privacyList = data.get("privacypolicy");
            // print(privacyList);
          });
        }
      }
    });
  }

  terms1() async {
    await terms.doc("k5c1eJ3DFh3P9IO7HEAA").get().then((data) {
      if (data.exists) {
        if (mounted) {
          setState(() {
            termss1List = data.get("terms");
            // print(termss1List);
          });
        }
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    terms1();
    privacy1();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: Responsive.isDesktop(context) ? height * 1.8 : height * 3,
          color: backGround_color,
          child: Padding(
            padding: EdgeInsets.only(
                top: height * 0.09, left: width * 0.06, right: width * 0.06),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: width * 0.88,
                      child: Text(
                        "CONTRACT FOR PRIVACY POLICY AND TERMS AND CONDITIONS FOR THE EAGLE TRANSPORT INVENTORY PROGRAM APP",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.white,
                          fontSize: Responsive.isDesktop(context) ? 16.0 : 13.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.04),
                Text(
                  "This agreement, effective from _____________ is between the service providing company Eagle Transport that works through the app Eagle Transport Inventory Program that works its for smooth distribution of gas to various gas stations associated with it inside the USA.",
                  style: TextStyle(
                    fontSize: Responsive.isDesktop(context) ? 15.0 : 13.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: height * 0.06,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: width * 0.88,
                      child: Text(
                        "Privacy Policy",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.white,
                          fontSize: Responsive.isDesktop(context) ? 16.0 : 13.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.06,
                ),
                OrderedList(privacyList),
                SizedBox(
                  height: height * 0.06,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: width * 0.88,
                      child: Text(
                        "Terms and Conditions",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.white,
                          fontSize: Responsive.isDesktop(context) ? 16.0 : 13.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.06,
                ),
                OrderedList(termss1List),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
