import 'package:fluttertoast/fluttertoast.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:testttttt/Utils/detectPlatform.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/Services/otp_provider.dart';
import 'package:testttttt/UI/Widgets/custom_webbg.dart';
import 'package:testttttt/UI/Widgets/customfaqbottom.dart';
import 'package:testttttt/UI/Widgets/customsubmitbutton.dart';
import 'package:testttttt/UI/Widgets/customtoast.dart';
import 'package:testttttt/UI/views/pre_auth_screens/uploadimage.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:testttttt/Utils/detectPlatform.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:testttttt/Utils/detectPlatform.dart';

class VerificationMobScreen extends StatefulWidget {
  VerificationMobScreen({Key? key, required this.doc, required this.phone})
      : super(key: key);
  DocumentSnapshot doc;
  String phone;

  @override
  _VerificationMobScreenState createState() => _VerificationMobScreenState();
}

class _VerificationMobScreenState extends State<VerificationMobScreen> {
  final OtpFieldController _otp = new OtpFieldController();
  FToast? fToast;
  Future<void> signIn(String otp, double width) async {
    String res = "success";
    try {
      await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
        verificationId: "",
        smsCode: otp,
      ));
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UploadImage(
              doc: widget.doc,
            ),
          ));
      fToast!.showToast(
          child: ToastMessage().show(width, context, "success"),
          gravity: ToastGravity.BOTTOM,
          toastDuration: Duration(seconds: 3));
    } catch (err) {
      res = err.toString();
      fToast!.showToast(
          child: ToastMessage().show(width, context, res),
          gravity: ToastGravity.BOTTOM,
          toastDuration: Duration(seconds: 3));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fToast = FToast();
    fToast!.init(context);
    registerUser(widget.phone, context);
  }

  String? pinn;

  String? verificationId;
  FirebaseAuth _auth = FirebaseAuth.instance;
  Future registerUser(String mobile, BuildContext context) async {
    await _auth.verifyPhoneNumber(
        phoneNumber: "+1 ${mobile}",
        timeout: Duration(seconds: 120),
        verificationCompleted: (uthCredential) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UploadImage(doc: widget.doc),
              ));
        },
        verificationFailed: (authException) {
          print(authException.toString());
          fToast!.showToast(
              child: ToastMessage().show(200, context, "Verification failed"),
              gravity: ToastGravity.BOTTOM,
              toastDuration: Duration(seconds: 3));
        },
        codeSent: (verificationid, resendingtoken) {
          fToast!.showToast(
              child: ToastMessage()
                  .show(420, context, "Code Sent to +1 ${mobile}"),
              gravity: ToastGravity.BOTTOM,
              toastDuration: Duration(seconds: 3));
          setState(() {
            verificationId = verificationid;
          });
        },
        codeAutoRetrievalTimeout: (verificationid) {
          verificationId = verificationid;
          print(verificationId);
          print("Timout");
          fToast!.showToast(
              child: ToastMessage().show(300, context, "Time Out"),
              gravity: ToastGravity.BOTTOM,
              toastDuration: Duration(seconds: 3));
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _otp.clear();
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
                left: width * 0.1, right: width * 0.05, top: height * 0.08),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: Responsive.isDesktop(context) ? false : true,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.06,
                    ),
                    SvgPicture.asset("assets/newLogo.svg"),
                    SizedBox(
                      height: height * 0.08,
                    ),
                    Text(
                      "Verification",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    Container(
                      width: width * 0.75,
                      alignment: Alignment.center,
                      child: Text(
                        "Enter the OTP code sent to your phone",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OTPTextField(
                          controller: _otp,
                          keyboardType: TextInputType.number,
                          length: 6,
                          width: Responsive.isDesktop(context)
                              ? width * 0.3
                              : width * 0.8,
                          fieldWidth: 50,
                          style: TextStyle(fontSize: 17),
                          textFieldAlignment: MainAxisAlignment.spaceAround,
                          fieldStyle: FieldStyle.box,
                          otpFieldStyle:
                              OtpFieldStyle(backgroundColor: Colors.white),
                          onCompleted: (pin) {
                            print("Completed: " + pin);
                            setState(() {
                              pinn = pin;
                            });
                            //OtpFucnctions().authenticateMe(confirmationResult, _otp)
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    InkWell(
                      onTap: () {
                        //    signIn(_otp.toString(), width);
                        _auth
                            .signInWithCredential(PhoneAuthProvider.credential(
                                verificationId: verificationId!,
                                smsCode: pinn!))
                            .then((value) {
                          value.user!.delete();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    UploadImage(doc: widget.doc),
                              ));
                        }).catchError((e) {
                          fToast!.showToast(
                              child: ToastMessage()
                                  .show(width, context, "There's some error"),
                              gravity: ToastGravity.BOTTOM,
                              toastDuration: Duration(seconds: 3));
                        });
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => UploadImage(
                        //         doc: widget.doc,
                        //       ),
                        //     ));
                      },
                      child: CustomSubmitButton(
                        width: width,
                        title: "Continue",
                      ),
                    ),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Text(
                            "Didn???t receive any code?",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Send new code",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
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
}
