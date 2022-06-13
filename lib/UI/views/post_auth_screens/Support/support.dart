// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testttttt/Providers/user_provider.dart';
import 'package:testttttt/UI/Widgets/customContainer.dart';
import 'package:testttttt/UI/Widgets/customNav.dart';
import 'package:testttttt/UI/Widgets/customTextField.dart';
import 'package:testttttt/UI/Widgets/customappheader.dart';
import 'package:testttttt/UI/Widgets/customtoast.dart';
import 'package:testttttt/UI/Widgets/logo.dart';
import 'package:testttttt/Utils/common.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:testttttt/Models/user.dart' as model;
import 'package:testttttt/Utils/detectPlatform.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  String? EmployerCode;
  String? Name;
  String? Email;
  String? Subject;
  String? Message;
  FToast? fToast;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fToast = FToast();
    fToast!.init(context);
  }

  CollectionReference tickets =
      FirebaseFirestore.instance.collection("tickets");

  @override
  Widget build(BuildContext context) {
    model.User? user = Provider.of<UserProvider>(context).getUser;

    String visible(model.User user) {
      switch (user.userRole) {
        case "SiteUser":
          return "SiteManager";
        case "SiteManager":
          return "SiteOwner";
        case "SiteOwner":
          return "TerminalUser";
        case "TerminalUser":
          return "TerminalManager";
        case "TerminalManager":
          return "AppAdmin";
        case "AppAdmin":
          return "SuperAdmin";
        case "SuperAdmin":
          return "SuperAdmin";
      }
      return "";
    }

    Future<void> addTicket(context) {
      return tickets.add({
        "beforelogin": false,
        "byid": user!.uid,
        "email": user.email,
        "isopen": true,
        "messages": [
          {
            "title": Subject,
            "description": Message,
          }
        ],
        "name": user.name,
        "sites": user.sites,
        "timestamp": FieldValue.serverTimestamp(),
        "visibleto": visible(user),
      }).then((value) {
        tickets.doc(value.id).update({
          "docid": value.id,
        });
        tickets.doc(value.id).collection("messages").add({
          "createdOn": FieldValue.serverTimestamp(),
          "message": Message,
          "by": user.uid,
        });
      }).catchError((error) => print("Failed to add ticket: $error"));
    }

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton:
          Responsive.isDesktop(context) || Responsive.isTablet(context)
              ? MenuButton(isTapped: false, width: width)
              : SizedBox(),
      body: SingleChildScrollView(
        child: Container(
          height: Responsive.isDesktop(context) || Responsive.isTablet(context)
              ? height * 1.13
              : height * 1.05,
          width: width,
          color: backGround_color,
          child: Padding(
            padding: EdgeInsets.only(
              top: Responsive.isDesktop(context) || Responsive.isTablet(context)
                  ? height * 0.0
                  : height * 0.1,
              // left: Responsive.isDesktop(context) ? width * 0.01 : 0.0,
              // right: Responsive.isDesktop(context) ? width * 0.01 : 0.0),
            ),
            child: Column(
              children: [
                Navbar(
                  width: width,
                  height: height,
                  text1: "Home",
                  text2: "Chat",
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Responsive.isDesktop(context) ||
                                Responsive.isTablet(context)
                            ? Container()
                            : TopRow(width: width),
                        SizedBox(
                          height: Responsive.isDesktop(context) ||
                                  Responsive.isTablet(context)
                              ? height * 0.013
                              : height * 0.05,
                        ),
                        CustomContainer(
                            child: Column(
                              children: [
                                Text(
                                  "Support",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: Responsive.isDesktop(context)
                                          ? width * 0.013
                                          : width * 0.05,
                                      fontFamily: "Poppins"),
                                ),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                SizedBox(
                                  height: height * 0.012,
                                ),
                                SupportTextField(
                                    valueChanged: (value) {
                                      setState(() {
                                        Subject = value;
                                      });
                                    },
                                    width: width,
                                    height: height,
                                    labelText: "Subject"),
                                SizedBox(
                                  height: height * 0.012,
                                ),
                                MessageTextField(
                                    valueChanged: (value) {
                                      setState(() {
                                        Message = value;
                                      });
                                    },
                                    width: width,
                                    height: height,
                                    labelText: "Message"),
                                SizedBox(
                                  height: height * 0.04,
                                ),
                                InkWell(
                                  onTap: () {
                                    if (Message != null || Subject != null) {
                                      addTicket(context);
                                      fToast!.showToast(
                                        child: ToastMessage().show(
                                            width, context, "Ticket Added"),
                                        gravity: ToastGravity.BOTTOM,
                                        toastDuration: Duration(seconds: 3),
                                      );
                                      Navigator.pop(context);
                                    } else {
                                      fToast!.showToast(
                                        child: ToastMessage().show(
                                            width,
                                            context,
                                            "Please enter all detailss"),
                                        gravity: ToastGravity.BOTTOM,
                                        toastDuration: Duration(seconds: 3),
                                      );
                                    }
                                  },
                                  child: Container(
                                    width: Responsive.isDesktop(context)
                                        ? width * 0.3
                                        : Responsive.isTablet(context)
                                            ? width * 0.6
                                            : width * 0.9,
                                    height: height * 0.065,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(13.0),
                                      color: Color(0xFF5081DB),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Send",
                                        style: TextStyle(
                                            fontSize: Responsive.isDesktop(
                                                        context) ||
                                                    Responsive.isTablet(context)
                                                ? width * 0.009
                                                : width * 0.04,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Poppins"),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            width: Responsive.isDesktop(context) ||
                                    Responsive.isTablet(context)
                                ? width
                                : width * 0.9,
                            topPad: 0.0,
                            height: height,
                            opacity: 0.0)
                      ],
                    ),
                    Visibility(
                      visible: false,
                      child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TopRow extends StatelessWidget {
  const TopRow({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: width * 0.06,
          ),
        ),
        SizedBox(
          width: width * 0.17,
        ),
        Logo(width: width),
        SizedBox(
          width: width * 0.125,
        ),
        Image.asset(
          Common.assetImages + "call_out.png",
          width: width * 0.048,
        ),
      ],
    );
  }
}

class SupportTextField extends StatefulWidget {
  const SupportTextField({
    Key? key,
    required this.width,
    required this.valueChanged,
    required this.height,
    required this.labelText,
  }) : super(key: key);

  final double width;
  final double height;
  final String labelText;
  final ValueChanged valueChanged;

  @override
  State<SupportTextField> createState() => _SupportTextFieldState();
}

class _SupportTextFieldState extends State<SupportTextField> {
  @override
  FocusNode myFocusNode = FocusNode();
  void initState() {
    super.initState();
    myFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    myFocusNode.dispose();
  }

  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.isDesktop(context)
          ? widget.width * 0.3
          : Responsive.isTablet(context)
              ? widget.width * 0.6
              : widget.width * 0.9,
      padding: EdgeInsets.only(
          top: Responsive.isDesktop(context)
              ? widget.height * 0.006
              : Responsive.isTablet(context)
                  ? widget.height * 0.006
                  : 0.0,
          left: Responsive.isDesktop(context)
              ? widget.width * 0.014
              : Responsive.isTablet(context)
                  ? widget.width * 0.021
                  : widget.width * 0.06,
          right: widget.width * 0.06),
      height: widget.height * 0.07,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: TextField(
        controller: _controller,
        focusNode: myFocusNode,
        onChanged: (value) {
          setState(() {
            widget.valueChanged(value);
          });
        },
        style: TextStyle(fontFamily: "Poppins"),
        cursorColor: Colors.black12,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: widget.labelText,
          labelStyle: TextStyle(
              fontSize:
                  Responsive.isDesktop(context) || Responsive.isTablet(context)
                      ? widget.width * 0.009
                      : 17.0,
              color:
                  myFocusNode.hasFocus ? Color(0xFF5E8BE0) : Color(0xffAEB0C3),
              fontFamily: "Poppins",
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

class MessageTextField extends StatefulWidget {
  const MessageTextField({
    Key? key,
    required this.width,
    required this.height,
    required this.valueChanged,
    required this.labelText,
  }) : super(key: key);

  final double width;
  final double height;
  final String labelText;
  final ValueChanged valueChanged;

  @override
  _MessageTextFieldState createState() => _MessageTextFieldState();
}

class _MessageTextFieldState extends State<MessageTextField> {
  FocusNode myFocusNode = FocusNode();
  void initState() {
    super.initState();
    myFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    myFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.isDesktop(context)
          ? widget.width * 0.3
          : Responsive.isTablet(context)
              ? widget.width * 0.6
              : widget.width * 0.9,
      padding: EdgeInsets.only(
          top: Responsive.isDesktop(context)
              ? widget.height * 0.006
              : Responsive.isTablet(context)
                  ? widget.height * 0.006
                  : 0.0,
          left: Responsive.isDesktop(context)
              ? widget.width * 0.014
              : Responsive.isTablet(context)
                  ? widget.width * 0.021
                  : widget.width * 0.06,
          right: widget.width * 0.06),
      height: widget.height * 0.25,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: TextField(
        maxLines: null,
        keyboardType: TextInputType.multiline,
        onChanged: (val) {
          setState(() {
            widget.valueChanged(val);
          });
        },
        focusNode: myFocusNode,
        style: TextStyle(fontFamily: "Poppins"),
        cursorColor: Colors.black12,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: widget.labelText,
          labelStyle: TextStyle(
              fontSize:
                  Responsive.isDesktop(context) || Responsive.isTablet(context)
                      ? widget.width * 0.009
                      : 17.0,
              color:
                  myFocusNode.hasFocus ? Color(0xFF5E8BE0) : Color(0xffAEB0C3),
              fontFamily: "Poppins",
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
