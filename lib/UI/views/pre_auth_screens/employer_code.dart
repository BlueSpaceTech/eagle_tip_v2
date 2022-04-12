// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

/*
DocumentReference dbRef = FirebaseFirestore.instance
                        .collection('users')
                        .doc("ABC121");

                    dbRef.get().then((data) {
                      if (data.exists) {
                        setState(() {
                          name.text = data.get("name");
                          email.text = data.get("email");
                          password.text = data.get("password");
                          url.text = data.get("dpurl");
                        });
                      } else {
                        print("not");

                        SnackBar(content: Text("f"));
                      }
                    });
                     FirebaseFirestore.instance
                        .collection("users")
                        .doc("df")
                        .set({"name": "f"}, SetOptions(merge: true));
*/
import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/UI/Widgets/customTextField.dart';
import 'package:testttttt/UI/Widgets/custom_webbg.dart';
import 'package:testttttt/UI/Widgets/customfaqbottom.dart';
import 'package:testttttt/UI/Widgets/customsubmitbutton.dart';
import 'package:testttttt/UI/Widgets/customtoast.dart';
import 'package:testttttt/UI/views/pre_auth_screens/create_account.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EmployerCode extends StatefulWidget {
  const EmployerCode({Key? key}) : super(key: key);

  @override
  State<EmployerCode> createState() => _EmployerCodeState();
}

class _EmployerCodeState extends State<EmployerCode> {
  FToast? fToast;
  String? name;
  String? phone;
  String? email;

  final TextEditingController _emoloyercode = TextEditingController();
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
    _emoloyercode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xff2B343B),
      bottomNavigationBar: CustomFAQbottom(),
      body: SingleChildScrollView(
        child: Stack(children: [
          WebBg(),
          Padding(
            padding: EdgeInsets.only(
                left: width * 0.1, right: width * 0.1, top: height * 0.08),
            child: Align(
              alignment: Alignment.center,
              child: Container(
                padding: EdgeInsets.only(top: 20),
                width: Responsive.isDesktop(context) ? width * 0.6 : width * 1,
                height: height * 0.8,
                decoration: BoxDecoration(
                    color: Colors.black
                        .withOpacity(Responsive.isDesktop(context) ? 0.6 : 0),
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Visibility(
                          visible: Responsive.isDesktop(context) ? false : true,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.06,
                    ),
                    Image.asset("assets/Logo 2 1.png"),
                    SizedBox(
                      height: height * 0.1,
                    ),
                    Text(
                      "Enter New User Code",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    CustomTextField(
                        isactive: true,
                        controller: _emoloyercode,
                        width: width,
                        height: height,
                        labelText: "Code"),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    InkWell(
                      onTap: () {
                        // TermConditions(width, height);
                        String res = "Data Fetched";
                        DocumentReference dbRef = FirebaseFirestore.instance
                            .collection('invitations')
                            .doc(_emoloyercode.text);

                        dbRef.get().then((data) {
                          if (data.exists) {
                            setState(() {
                              // name = data.get("name");
                              // email = data.get("email");
                              // phone = data.get("phonenumber");
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CreateAccount(
                                    doc: data,
                                  ),
                                ));
                            fToast!.showToast(
                              child: ToastMessage().show(
                                  width, context, "Data fetched Successfully"),
                              gravity: ToastGravity.BOTTOM,
                              toastDuration: Duration(seconds: 3),
                            );
                          } else {
                            fToast!.showToast(
                              child: ToastMessage()
                                  .show(width, context, "User not exists"),
                              gravity: ToastGravity.BOTTOM,
                              toastDuration: Duration(seconds: 3),
                            );
                          }
                        });
                      },
                      child: CustomSubmitButton(
                        width: width,
                        title: "Next",
                      ),
                    ),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          " Input here the code in your invitation email.",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Poppins",
                          ),
                        ),
                        Text(
                          " If you can't find your invitation email, please look into your spam folder.",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Poppins",
                          ),
                        ),
                        Text(
                          " If you can't find your invitation email, contact your supervisor.",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Poppins",
                          ),
                        ),
                        Text(
                          " For more information visit our FAQ section below.",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
