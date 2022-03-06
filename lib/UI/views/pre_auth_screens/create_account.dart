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
import 'package:flutter_sms/flutter_sms.dart';

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
  void _sendSMS(String message, List<String> recipents) async {
    String _result = await sendSMS(message: message, recipients: recipents)
        .catchError((onError) {
      print(onError);
    });
    print(_result);
  }

  @override
  void initState() {
    // TODO: implement initState
    name.text = widget.doc.get("name");
    email.text = widget.doc.get("email");
    phoneno.text = widget.doc.get("phonenumber");
    super.initState();
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
                      onTap: () {
                        ConfirmationResult res;

                        PlatformInfo().isWeb()
                            ? res = OtpFucnctions()
                                .sendOTP("+91 92052 60904", context, widget.doc)
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VerificationMobScreen(
                                    doc: widget.doc,
                                  ),
                                ));
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
