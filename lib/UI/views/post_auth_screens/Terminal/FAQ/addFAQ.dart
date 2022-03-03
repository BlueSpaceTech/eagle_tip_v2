// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/UI/Widgets/customContainer.dart';
import 'package:testttttt/UI/Widgets/customNav.dart';
import 'package:testttttt/UI/Widgets/custom_webbg.dart';
import 'package:testttttt/UI/Widgets/customappheader.dart';
import 'package:testttttt/UI/views/post_auth_screens/Notifications/createNotification.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:flutter/material.dart';

class AddFAQ extends StatelessWidget {
  String dropdownvalue = 'All Users';

  // List of items in our dropdown menu
  var items = [
    'All Users',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: Responsive.isDesktop(context)
          ? MenuButton(isTapped: false, width: width)
          : SizedBox(),
      body: SingleChildScrollView(
        child: Container(
          height: height * 1.4,
          color: backGround_color,
          child: Column(
            children: [
              Navbar(
                width: width,
                height: height,
                text1: "Home",
                text2: "Sites",
              ),
              SizedBox(
                height: height * 0.06,
              ),
              Container(
                color: backGround_color,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    WebBg(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Responsive.isDesktop(context)
                            ? Padding(
                                padding: EdgeInsets.only(top: 0.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                      size: width * 0.02,
                                    ),
                                    SizedBox(
                                      width: width * 0.014,
                                    ),
                                    Text(
                                      "Back",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: width * 0.014,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Poppins",
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox(),
                        SizedBox(
                          width: Responsive.isDesktop(context)
                              ? width * 0.02
                              : 0.0,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            padding: EdgeInsets.only(top: 20),
                            width: Responsive.isDesktop(context)
                                ? width * 0.45
                                : width * 0.9,
                            height: height * 0.78,
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(
                                    Responsive.isDesktop(context) ? 0.6 : 0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: height * 0.01,
                                  left: width * 0.02,
                                  right: width * 0.02),
                              child: Column(
                                children: [
                                  AddFAQTextField(
                                    labelText: "Question",
                                    isactive: true,
                                  ),
                                  SizedBox(
                                    height: height * 0.03,
                                  ),
                                  Container(
                                    width: width * 0.42,
                                    padding: EdgeInsets.only(
                                        left: width * 0.01,
                                        right: width * 0.06),
                                    height: height * 0.4,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                    child: TextFormField(
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontFamily: "Poppins"),
                                      cursorColor: Colors.black12,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelText: "Answer",
                                        labelStyle: TextStyle(
                                            color: Color(0xff6e7191),
                                            fontFamily: "Poppins",
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.08,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: width * 0.08,
                                        height: height * 0.058,
                                        decoration: BoxDecoration(
                                          color: Color(0XffED5C62),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Cancel",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: width * 0.008,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: "Poppins"),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.01,
                                      ),
                                      Container(
                                        width: width * 0.08,
                                        height: height * 0.058,
                                        decoration: BoxDecoration(
                                          color: Color(0Xff5081db),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Done",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: width * 0.008,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: "Poppins"),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.07,
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AddFAQTextField extends StatelessWidget {
  const AddFAQTextField(
      {Key? key, required this.isactive, required this.labelText})
      : super(key: key);
  final bool? isactive;
  final String labelText;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    TextEditingController controller = TextEditingController();
    return Container(
      width: Responsive.isDesktop(context) ? width * 0.42 : width * 0.1,
      padding: EdgeInsets.only(left: width * 0.01, right: width * 0.06),
      height: height * 0.08,
      decoration: BoxDecoration(
        color: isactive! ? Colors.white : Color(0xffEFF0F6).withOpacity(0.7),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: TextFormField(
        textAlign: TextAlign.left,
        enabled: isactive,
        controller: controller,
        style: TextStyle(fontFamily: "Poppins"),
        cursorColor: Colors.black12,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: labelText,
          labelStyle: TextStyle(
              color: Color(0xff6e7191),
              fontFamily: "Poppins",
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
