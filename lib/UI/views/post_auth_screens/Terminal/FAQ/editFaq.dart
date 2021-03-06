// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:testttttt/Providers/user_provider.dart';
import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/UI/Widgets/customContainer.dart';
import 'package:testttttt/UI/Widgets/customNav.dart';
import 'package:testttttt/UI/Widgets/custom_webbg.dart';
import 'package:testttttt/UI/Widgets/customappheader.dart';
import 'package:testttttt/UI/Widgets/customtoast.dart';
import 'package:testttttt/UI/views/post_auth_screens/Notifications/createNotification.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:testttttt/Models/user.dart' as model;

class EditFAQ extends StatefulWidget {
  late final String answertext;
  final String docid;
  late final String questiontext;

  EditFAQ({
    Key? key,
    required this.answertext,
    required this.docid,
    required this.questiontext,
  }) : super(key: key);
  @override
  State<EditFAQ> createState() => _EditFAQState();
}

class _EditFAQState extends State<EditFAQ> {
  String dropdownvalue = 'All Users';

  FToast? fToast;

  CollectionReference faqs = FirebaseFirestore.instance.collection("faq");

  TextEditingController _questionController = TextEditingController();
  TextEditingController _answerController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _answerController.text = widget.answertext;
    _questionController.text = widget.questiontext;
    fToast = FToast();
    fToast!.init(context);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    model.User? user = Provider.of<UserProvider>(context).getUser;
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
                        SizedBox(),
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
                                    controller: _questionController,
                                    labelText: "Question",
                                    valueChanged: (val) {
                                      setState(() {
                                        // question = val;
                                      });
                                    },
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
                                      controller: _answerController,
                                      maxLines: 5,
                                      textAlign: TextAlign.left,
                                      onChanged: (value) {
                                        setState(() {
                                          // answer = value;
                                        });
                                      },
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
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Container(
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
                                      ),
                                      SizedBox(
                                        width: width * 0.01,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          faqs.doc(widget.docid).update({
                                            "id": user!.uid,
                                            "title": _questionController.text,
                                            "description":
                                                _answerController.text,
                                          });
                                          fToast!.showToast(
                                            child: ToastMessage().show(
                                                width,
                                                context,
                                                "Faq Edited successfully"),
                                            gravity: ToastGravity.BOTTOM,
                                            toastDuration: Duration(seconds: 3),
                                          );
                                          Navigator.pop(context);
                                        },
                                        child: Container(
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

class AddFAQTextField extends StatefulWidget {
  const AddFAQTextField(
      {Key? key,
      required this.isactive,
      required this.controller,
      required this.labelText,
      required this.valueChanged})
      : super(key: key);
  final bool? isactive;
  final ValueChanged valueChanged;
  final String labelText;
  final TextEditingController controller;

  @override
  State<AddFAQTextField> createState() => _AddFAQTextFieldState();
}

class _AddFAQTextFieldState extends State<AddFAQTextField> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: Responsive.isDesktop(context) ? width * 0.42 : width * 0.1,
      padding: EdgeInsets.only(left: width * 0.01, right: width * 0.06),
      height: height * 0.08,
      decoration: BoxDecoration(
        color: widget.isactive!
            ? Colors.white
            : Color(0xffEFF0F6).withOpacity(0.7),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: TextFormField(
        textAlign: TextAlign.left,
        controller: widget.controller,
        enabled: widget.isactive,
        style: TextStyle(fontFamily: "Poppins"),
        cursorColor: Colors.black12,
        onChanged: (value) {
          setState(() {
            widget.valueChanged(value);
          });
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: widget.labelText,
          labelStyle: TextStyle(
              color: Color(0xff6e7191),
              fontFamily: "Poppins",
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
