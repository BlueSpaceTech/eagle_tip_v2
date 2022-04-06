import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/Services/otp_provider.dart';
import 'package:testttttt/UI/Widgets/customTextField.dart';
import 'package:testttttt/UI/Widgets/custom_webbg.dart';
import 'package:testttttt/UI/Widgets/customfaqbottom.dart';
import 'package:testttttt/UI/Widgets/customsubmitbutton.dart';
import 'package:testttttt/UI/views/pre_auth_screens/phone_verification.dart';
import 'package:testttttt/UI/views/pre_auth_screens/phoneverificationmob.dart';
import 'package:testttttt/UI/views/pre_auth_screens/uploadimage.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:testttttt/Utils/detectPlatform.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter/foundation.dart';

class CreateAccount extends StatefulWidget {
  CreateAccount({
    Key? key,
    required this.doc,
  }) : super(key: key);
  DocumentSnapshot doc;

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phoneno = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? verifiyme;
  String? phoneNumber, verificationId;
  String? otp, authStatus = "";

  @override
  void initState() {
    // TODO: implement initState
    name.text = widget.doc.get("name");
    email.text = widget.doc.get("email");
    phoneno.text = widget.doc.get("phonenumber");
    super.initState();
  }

  TermConditions(double widht, double height) {
    return showDialog(
      context: context,
      builder: (ctx) => Dialog(
        child: Container(
          padding: EdgeInsets.all(20),
          width: widht * 0.7,
          height: height * 0.9,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.close)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Terms and conditions",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: "Poppins",
                        fontSize: 24),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Before we send you an OTP on your phone number, use the link below to view Terms and Conditions. Once you have read the content, acknowledge you understand and agree by clicking the ${"agree"} button.",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: Responsive.isDesktop(context) ? 18 : 15,
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
              Container(
                height:
                    Responsive.isDesktop(context) ? height * 0.5 : height * 0.4,
                child: SingleChildScrollView(
                    child: Column(children: [
                  Container(
                    height: height * 0.7,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                            "This agreement, effective from _____________ is between the service providing company Eagle Transport that works through the app Eagle Transport Inventory Program that works its for smooth distribution of gas to various gas stations associated with it inside the USA"),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                            "1. Whereas it is an important responsibility of the Eagle Transport Inventory app launching this app to protect data of its customers, nevertheless, for its smooth functioning, this provision will not preclude it from obtaining the email addresses, phone numbers, tracking cookies data, locations, and other important details of the gas stations it is working with"),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                            "2. Whereas the customer’s privacy and data protection will be protected under the relevant federal and state laws, yet the online access of this service by any gas station will allow the owners of this app to collect their information for advertising purposes"),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                            "3. Whereas the consumer data present on this app, including the chat and messaging service on it, will be protected, however, it can be disclosed for law enforcement purposes, business transactions, or any other such reason in the due course of time"),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                            "4. Whereas the Eagle Transport Inventory Program app will ascertain data security for its clients, nevertheless, the service providers are not responsible for any breach of privacy or misuse of private data if it is unintentionally misused"),
                      ],
                    ),
                  ),
                ])),
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.displayTerms);
                  },
                  child: Text(
                    "https://link-of-terms&conditions",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff5081DB),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ]),
              SizedBox(
                height: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                      onTap: () async {
                        if (PlatformInfo().isWeb()) {
                          ConfirmationResult res = await OtpFucnctions()
                              .sendOTP(
                                  "+1 ${phoneno.text}", context, widget.doc);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VerificationScreen(
                                  doc: widget.doc,
                                  confirmationResult: res,
                                ),
                              ));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VerificationMobScreen(
                                    doc: widget.doc, phone: phoneno.text),
                              ));
                        }
                      },
                      child: CustomSubmitButton(width: widht, title: "Agree")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    name.dispose();
    email.dispose();
    phoneno.dispose();
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
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
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
                      "Get Otp on this mobile number",
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
                        isactive: false,
                        controller: name,
                        width: width,
                        height: height,
                        labelText: "Name"),
                    SizedBox(height: height * 0.01),
                    CustomTextField(
                        isactive: false,
                        controller: email,
                        width: width,
                        height: height,
                        labelText: "Email"),
                    SizedBox(height: height * 0.01),
                    CustomTextField(
                        isactive: false,
                        controller: phoneno,
                        width: width,
                        height: height,
                        labelText: "Phone"),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    InkWell(
                      onTap: () async {
                        TermConditions(width, height);
                        // if (PlatformInfo().isWeb()) {
                        //   ConfirmationResult res = await OtpFucnctions()
                        //       .sendOTP(
                        //           "+1 ${phoneno.text}", context, widget.doc);
                        //   Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //         builder: (context) => VerificationScreen(
                        //           doc: widget.doc,
                        //           confirmationResult: res,
                        //         ),
                        //       ));
                        // } else {
                        //   Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //         builder: (context) => VerificationMobScreen(
                        //             doc: widget.doc, phone: phoneno.text),
                        //       ));
                        // }
                      },
                      /*
                        await FirebaseAuth.instance.verifyPhoneNumber(
                          phoneNumber: "+919813382163",
                          timeout: const Duration(seconds: 30),
                          verificationCompleted: (PhoneAuthCredential) {
                            setState(() {
                              authStatus =
                                  "Your account is successfully verified";
                            });
                          },
                          verificationFailed: (verificationFailed) {
                            setState(() {
                              authStatus = "Authentication failed";
                            });
                          },
                          codeSent: (verificationID, resendingToken) {
                            setState(() {
                              authStatus = "Code Sent!";
                              verificationId = verificationID;
                            });
                          },
                          codeAutoRetrievalTimeout: (verId) {
                            setState(() {
                              authStatus = "TIMEOUT";
                              verificationId = verId;
                            });
                          },
                        );
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VerificationScreen(
                                doc: widget.doc,
                                verid: verificationId != null
                                    ? verificationId!
                                    : "ff",
                              ),
                            ));
                            */

                      child: CustomSubmitButton(
                        width: width,
                        title: "Send OTP",
                      ),
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

  _verifyphonenumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+919813382163",
      verificationCompleted: (Credential) async {},
      verificationFailed: (e) {
        print(e.message);
      },
      codeSent: (verificationId, resendToken) {
        /*
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VerificationScreen(
                doc: widget.doc,
                verid: "ff",
              ),
            ));
            */
      },
      codeAutoRetrievalTimeout: (verificationId) {
        setState(() {
          verifiyme = verificationId;
        });
      },
      timeout: Duration(seconds: 60),
    );
  }
}
