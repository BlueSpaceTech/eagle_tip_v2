// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/Services/authentication_helper.dart';
import 'package:testttttt/UI/Widgets/customNav.dart';
import 'package:testttttt/UI/Widgets/customTextField.dart';
import 'package:testttttt/UI/Widgets/customappheader.dart';
import 'package:testttttt/UI/Widgets/customsubmitbutton.dart';
import 'package:testttttt/UI/Widgets/customtoast.dart';
import 'package:testttttt/UI/Widgets/logo.dart';
import 'package:testttttt/UI/views/post_auth_screens/TicketHistory/ticketHistoryDetail.dart';
import 'package:testttttt/Utils/common.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Invitation extends StatefulWidget {
  Invitation({Key? key, required this.sites, required this.role})
      : super(key: key);
  List sites;
  String role;
  @override
  State<Invitation> createState() => _InvitationState();
}

class _InvitationState extends State<Invitation> {
  bool? isTapped = false;
  FToast? fToast;
  TextEditingController _name = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  TextEditingController _phone = new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fToast = FToast();
    fToast!.init(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _name.dispose();
    _email.dispose();
    _phone.dispose();
  }

  sitesgenerator(List<dynamic> sites) {
    String site = "";
    for (int i = 0; i < sites.length; i++) {
      if (i == sites.length - 1) {
        site += sites[i];
      } else {
        site += " ${sites[i]} and ";
      }
    }
    return site;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Navbar(
                width: width,
                height: height,
                text1: "Home",
                text2: "Sites",
              ),
              Container(
                height: height,
                color: backGround_color,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: width * 0.04,
                      right: width * 0.04,
                      top: height * 0.01),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: Responsive.isDesktop(context) ? 20 : 0,
                      ),
                      Visibility(
                        visible: Responsive.isDesktop(context),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "    ",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 25),
                                ),
                              ],
                            ),
                            Text(
                              "Add new Employee",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  color: Colors.white,
                                  fontSize: 20),
                            ),
                            Text("                       "),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: !Responsive.isDesktop(context),
                        child: Row(
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
                              width: width * 0.17,
                            ),
                            MenuButton(isTapped: isTapped, width: width)
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.06,
                      ),
                      Visibility(
                        visible: !Responsive.isDesktop(context),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Add new user",
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontFamily: "Poppins",
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: Responsive.isDesktop(context)
                                ? width * 0.4
                                : width * 0.8,
                            child: RichText(
                              text: TextSpan(
                                text: "New user will join",
                                style: TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                  fontFamily: "Poppins",
                                ),
                                children: [
                                  TextSpan(
                                    text: sitesgenerator(widget.sites),
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      fontFamily: "Poppins",
                                    ),
                                  ),
                                  TextSpan(
                                    text: " as",
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                      fontFamily: "Poppins",
                                    ),
                                  ),
                                  TextSpan(
                                    text: " ${widget.role}.",
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      fontFamily: "Poppins",
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        " Fill the following information related to user. The new user will recieve a link to sign up and download the app.",
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                      fontFamily: "Poppins",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.07,
                      ),
                      Container(
                        width:
                            Responsive.isDesktop(context) ? 600 : width * 0.8,
                        padding: EdgeInsets.symmetric(
                            horizontal: Responsive.isDesktop(context)
                                ? width * 0.02
                                : width * 0.06),
                        height: height * 0.08,
                        decoration: BoxDecoration(
                          color: true
                              ? Colors.white
                              : Color(0xffEFF0F6).withOpacity(0.7),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: TextField(
                          keyboardType: TextInputType.name,
                          enabled: true,
                          controller: _name,
                          style: TextStyle(fontFamily: "Poppins"),
                          cursorColor: Colors.black12,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: "Name",
                            labelStyle: TextStyle(
                                color: Color(0xff5e8be0),
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Container(
                        width:
                            Responsive.isDesktop(context) ? 600 : width * 0.8,
                        padding: EdgeInsets.symmetric(
                            horizontal: Responsive.isDesktop(context)
                                ? width * 0.02
                                : width * 0.06),
                        height: height * 0.08,
                        decoration: BoxDecoration(
                          color: true
                              ? Colors.white
                              : Color(0xffEFF0F6).withOpacity(0.7),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          enabled: true,
                          controller: _email,
                          style: TextStyle(fontFamily: "Poppins"),
                          cursorColor: Colors.black12,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: "Email",
                            labelStyle: TextStyle(
                                color: Color(0xff5e8be0),
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Container(
                        width:
                            Responsive.isDesktop(context) ? 600 : width * 0.8,
                        padding: EdgeInsets.symmetric(
                            horizontal: Responsive.isDesktop(context)
                                ? width * 0.02
                                : width * 0.06),
                        height: height * 0.08,
                        decoration: BoxDecoration(
                          color: true
                              ? Colors.white
                              : Color(0xffEFF0F6).withOpacity(0.7),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          enabled: true,
                          controller: _phone,
                          style: TextStyle(fontFamily: "Poppins"),
                          cursorColor: Colors.black12,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: "Phone number",
                            labelStyle: TextStyle(
                                color: Color(0xff5e8be0),
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      InkWell(
                        onTap: () {
                          if (_phone.text.length == 10 &&
                              _email.text.isNotEmpty &&
                              _name.text.isNotEmpty) {
                            String res = AuthFunctions().addUserTodb(
                              name: _name.text,
                              email: _email.text,
                              phonenumber: _phone.text,
                              userRole: widget.role,
                              phoneisverified: false,
                              sites: widget.sites,
                            );
                            if (res == "Invite Sent Successfully") {
                              fToast!.showToast(
                                child: ToastMessage().show(width, context, res),
                                gravity: ToastGravity.BOTTOM,
                                toastDuration: Duration(seconds: 3),
                              );
                              Responsive.isDesktop(context)
                                  ? Navigator.pushNamed(
                                      context, AppRoutes.homeScreen)
                                  : Navigator.pushNamed(
                                      context, AppRoutes.bottomNav);
                            } else {
                              fToast!.showToast(
                                child: ToastMessage()
                                    .show(width, context, "There's some error"),
                                gravity: ToastGravity.BOTTOM,
                                toastDuration: Duration(seconds: 3),
                              );
                            }
                          } else {
                            fToast!.showToast(
                              child: ToastMessage().show(width, context,
                                  "Please input all field correctly"),
                              gravity: ToastGravity.BOTTOM,
                              toastDuration: Duration(seconds: 3),
                            );
                          }
                        },
                        child: CustomSubmitButton(
                          width: width,
                          title: "Send Invitation",
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
