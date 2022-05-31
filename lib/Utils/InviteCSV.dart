// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/Services/authentication_helper.dart';
import 'package:testttttt/UI/Widgets/customNav.dart';
import 'package:testttttt/UI/Widgets/customappheader.dart';
import 'package:testttttt/UI/Widgets/customfab.dart';
import 'package:testttttt/UI/Widgets/customtoast.dart';
import 'package:testttttt/UI/Widgets/logo.dart';
import 'package:testttttt/Utils/responsive.dart';

import '../Services/Crud_functions.dart';

class OpenCSV extends StatefulWidget {
  final List inviteData;

  const OpenCSV({Key? key, required this.inviteData}) : super(key: key);
  @override
  State<OpenCSV> createState() => _OpenCSVState();
}

class _OpenCSVState extends State<OpenCSV> {
  // List inviteData=[];
  // List<PlatformFile>? _paths;
  bool? isTapped = false;
  // String? _extension="csv";
  // FileType _pickingType = FileType.custom;
  // LinkedScrollControllerGroup? _controllers;
  ScrollController? _letters;
  ScrollController? _numbers;
  late ScrollController SCROL;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        floatingActionButton: InviteButton(inviteData: widget.inviteData),
        backgroundColor: Color(0xff2B343B),
        body: Column(
          children: [
            Navbar(
                width: width, height: height, text1: "text1", text2: "text2"),
            Expanded(
              child: Stack(clipBehavior: Clip.none, children: [
                //  WebBg(),
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal:
                            Responsive.isDesktop(context) ? width * 0.1 : 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: height * 0.05,
                        ),
                        Visibility(
                          visible: !Responsive.isDesktop(context),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: Responsive.isDesktop(context)
                                    ? 0
                                    : width * 0.01,
                                right: Responsive.isDesktop(context)
                                    ? 0
                                    : width * 0.01,
                                top: Responsive.isDesktop(context)
                                    ? height * 0.015
                                    : height * 0.04),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.08),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                      )),
                                  Logo(width: width),
                                  MenuButton(isTapped: isTapped, width: width),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Responsive.isDesktop(context)
                              ? height * 0.076
                              : height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Invite Users",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  color: Colors.white,
                                  fontSize: 20),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 85,
                        ),
                        SingleChildScrollView(
                          controller: _letters,
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            height: 40,
                            color: Color(0xff2B343B),
                            child: Row(
                              children: [
                                Container(
                                  width: Responsive.isDesktop(context)
                                      ? width * 0.08
                                      : width * 0.16,
                                  child: Text(
                                    "",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white.withOpacity(0.5),
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Container(
                                  width: Responsive.isDesktop(context)
                                      ? width * 0.22
                                      : width * 0.4,
                                  child: Text(
                                    "Name",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white.withOpacity(0.5),
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Container(
                                  width: Responsive.isDesktop(context)
                                      ? width * 0.12
                                      : width * 0.24,
                                  child: Text(
                                    "Role",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white.withOpacity(0.5),
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Container(
                                  width: Responsive.isDesktop(context)
                                      ? width * 0.32
                                      : width * 0.52,
                                  child: Text(
                                    "Sites",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white.withOpacity(0.5),
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Container(
                                  width: Responsive.isDesktop(context)
                                      ? width * 0.32
                                      : width * 0.52,
                                  child: Text(
                                    "Email",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white.withOpacity(0.5),
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.white.withOpacity(0.5),
                        ),
                        widget.inviteData.isEmpty
                            ? Center(
                                child: Text(
                                  "No Invitations to display",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            : ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.only(top: 0),
                                shrinkWrap: true,
                                itemCount: widget.inviteData.length,
                                itemBuilder: (BuildContext context, int index) {
                                  // final document = _resultList[index];
                                  // List site = document!["sites"];

                                  return SingleChildScrollView(
                                    physics: Responsive.isDesktop(context)
                                        ? NeverScrollableScrollPhysics()
                                        : BouncingScrollPhysics(),
                                    controller: _numbers,
                                    scrollDirection: Axis.horizontal,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: index % 2 == 0
                                            ? Color(0xff2B343B)
                                            : Color(0xff24292E),
                                      ),
                                      height: 60,
                                      child: Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                widget.inviteData
                                                    .removeAt(index);
                                              });
                                            },
                                            child: Container(
                                                width: Responsive.isDesktop(
                                                        context)
                                                    ? width * 0.08
                                                    : width * 0.16,
                                                child: Image.asset(
                                                    "assets/delete.png")),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              // callUserInfoScreen(
                                              //     document["name"],
                                              //     document["email"],
                                              //     userRole,
                                              //     document["sites"],
                                              //     document["phonenumber"]);
                                            },
                                            child: Container(
                                              width:
                                                  Responsive.isDesktop(context)
                                                      ? width * 0.22
                                                      : width * 0.4,
                                              child: Text(
                                                '${index + 1}. ${widget.inviteData[index][0]}',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "Poppins"),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: Responsive.isDesktop(context)
                                                ? width * 0.12
                                                : width * 0.24,
                                            child: Text(
                                                widget.inviteData[index][4],
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "Poppins")),
                                          ),
                                          Container(
                                            width: Responsive.isDesktop(context)
                                                ? width * 0.22
                                                : width * 0.52,
                                            child: Text(
                                                widget.inviteData[index][1],
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "Poppins")),
                                          ),
                                          Container(
                                            width: Responsive.isDesktop(context)
                                                ? width * 0.32
                                                : width * 0.52,
                                            child: Text(
                                                widget.inviteData[index][2],
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "Poppins")),
                                          ),
                                          SizedBox(
                                            width: width * 0.04,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                        SizedBox(
                          height: height * 0.1,
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ));
  }
}

class InviteButton extends StatefulWidget {
  final List inviteData;
  const InviteButton({Key? key, required this.inviteData}) : super(key: key);

  @override
  State<InviteButton> createState() => _InviteButtonState();
}

class _InviteButtonState extends State<InviteButton> {
  FToast? fToast;
  @override
  void dispose() {
    super.dispose();
    widget.inviteData.clear();
    //listeners to remove
  }

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast!.init(context);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Center(
              child: Text(
                'Are you sure you want to send an invite?',
                style: TextStyle(
                  fontSize: 23.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Poppins",
                  color: Colors.black,
                ),
              ),
            ),
            content: Container(
              width: Responsive.isDesktop(context) ? width * 0.38 : width * 0.8,
              height: height * 0.2,
              child: Column(
                children: [
                  Text(
                      "After clicking OK, an email will be sent to the selected users.",
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: "Poppins",
                          color: Color(0xff14142B))),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: Responsive.isDesktop(context)
                              ? width * 0.15
                              : width * 0.32,
                          height: height * 0.055,
                          decoration: BoxDecoration(
                            color: Color(0xffED5C62),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                            child: Text(
                              "Back",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Poppins"),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: width * 0.02),
                      InkWell(
                        onTap: () {
                          for (int i = 0; i < widget.inviteData.length; i++) {
                            String sites = widget.inviteData.elementAt(i)[1];
                            List sitess = sites.split(",");
                            List visibleto = CrudFunction()
                                .visibletoInvitations(widget.inviteData
                                    .elementAt(i)[4]
                                    .toString());

                            AuthFunctions().addUserTodb(
                                name: widget.inviteData
                                    .elementAt(i)[0]
                                    .toString(),
                                email: widget.inviteData
                                    .elementAt(i)[2]
                                    .toString(),
                                phonenumber: widget.inviteData
                                    .elementAt(i)[3]
                                    .toString(),
                                userRole: widget.inviteData
                                    .elementAt(i)[4]
                                    .toString(),
                                phoneisverified: false,
                                sites: sitess,
                                visibleto: visibleto,
                                currentSite: widget.inviteData
                                    .elementAt(i)[5]
                                    .toString());
                            fToast!.showToast(
                                child: ToastMessage().show(width, context,
                                    "Invitations Sent Successfully"),
                                gravity: ToastGravity.BOTTOM,
                                toastDuration: Duration(seconds: 3));
                            Navigator.pop(context);
                          }
                        },
                        child: Container(
                          width: Responsive.isDesktop(context)
                              ? width * 0.15
                              : width * 0.32,
                          height: height * 0.055,
                          decoration: BoxDecoration(
                            color: Color(0Xff28519D),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                            child: Text(
                              "Confirm",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Poppins"),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: customfab(width: width, text: "Send Invite", height: height),
    );
  }
}
