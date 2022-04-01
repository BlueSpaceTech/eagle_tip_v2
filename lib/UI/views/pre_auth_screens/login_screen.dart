// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:testttttt/Providers/user_provider.dart';
import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/Services/authentication_helper.dart';
import 'package:testttttt/Services/otp_provider.dart';
import 'package:testttttt/Services/storagemethods.dart';
import 'package:testttttt/Services/utils.dart';
import 'package:testttttt/UI/Widgets/customTextField.dart';
import 'package:testttttt/UI/Widgets/custom_webbg.dart';
import 'package:testttttt/UI/Widgets/customfaqbottom.dart';
import 'package:testttttt/UI/Widgets/customsubmitbutton.dart';
import 'package:testttttt/UI/Widgets/customtoast.dart';
import 'package:testttttt/UI/Widgets/password_textfield.dart';
import 'package:testttttt/UI/views/on-borading-tour/welcome_tour.dart';
import 'package:testttttt/UI/views/post_auth_screens/HomeScreens/Home_screen.dart';
import 'package:testttttt/UI/views/post_auth_screens/HomeScreens/bottomNav.dart';
import 'package:testttttt/UI/views/post_auth_screens/Terminal/terminalhome.dart';
import 'package:testttttt/UI/views/pre_auth_screens/phone_verification.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:testttttt/Utils/detectPlatform.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FToast? fToast;
  final TextEditingController _password = TextEditingController();
  final TextEditingController _otpcode = TextEditingController();
  final TextEditingController _email = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fToast = FToast();
    fToast!.init(context);
    _email.addListener(getColor);
    _password.addListener(getColor);
  }

  bool isactive = false;
  // addData() async {
  //   UserProvider _userProvider = Provider.of(context, listen: false);

  //   await _userProvider.refreshUser();
  // }

  // route() {
  //   Responsive.isDesktop(context)
  //       ? Navigator.pushNamed(context, AppRoutes.homeScreen)
  //       : Navigator.pushReplacement(
  //           context, MaterialPageRoute(builder: (context) => BottomNav()));
  // }

  // route2() {
  //   UserProvider _userProvider = Provider.of(context, listen: false);
  //   Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) =>
  //               (_userProvider.getUser.userRole == "TerminalUser" ||
  //                       _userProvider.getUser.userRole == "TerminalManager")
  //                   ? TerminalHome()
  //                   : Responsive.isDesktop(context)
  //                       ? HomeScreen()
  //                       : BottomNav()));
  // }

  // startTime() async {
  //   var duration = new Duration(seconds: 4);
  //   return new Timer(duration, route2);
  // }
  String? pinn;

  String? verificationId;
  FirebaseAuth _auth = FirebaseAuth.instance;
  Future registerUser(String mobile, BuildContext context) async {
    await _auth.verifyPhoneNumber(
        phoneNumber: "+1 ${mobile}",
        timeout: Duration(seconds: 120),
        verificationCompleted: (uthCredential) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      //  (userRole == "TerminalUser" ||
                      //         userRole == "TerminalManager")
                      //     ? TerminalHome()
                      //     :
                      Responsive.isDesktop(context)
                          ? HomeScreen()
                          : BottomNav()));
          // FirebaseFirestore.instance
          //     .collection("users")
          //     .doc(uid)
          //     .update({"isverified": true});
        },
        verificationFailed: (authException) {
          print(authException.toString());
          fToast!.showToast(
              child: ToastMessage().show(200, context, "Verification failed"),
              gravity: ToastGravity.BOTTOM,
              toastDuration: Duration(seconds: 3));
          setState(() {
            _loading = false;
          });
        },
        codeSent: (verificationid, resendingtoken) {
          fToast!.showToast(
              child: ToastMessage()
                  .show(420, context, "Code Sent to +1 ${mobile}"),
              gravity: ToastGravity.BOTTOM,
              toastDuration: Duration(seconds: 3));
          setState(() {
            verificationId = verificationid;
            setState(() {
              _loading = false;
            });
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

  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  bool _loading = false;
  bool isverified = false;

  ConfirmationResult? ress;
  Future<void> signIn(String otp, double width) async {
    // UserProvider _userProvider = Provider.of(context, listen: false);
    String res = "success";
    try {
      await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
        verificationId: verificationId!,
        smsCode: otp,
      ));
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  (userRole == "TerminalUser" || userRole == "TerminalManager")
                      ? TerminalHome()
                      : Responsive.isDesktop(context)
                          ? HomeScreen()
                          : BottomNav()));
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

  // addData() async {
  //   UserProvider _userProvider = await Provider.of(context, listen: false);
  //   await _userProvider.refreshUser();
  // }

  String uid = "";
  String phone = "";
  String userRole = "";
  List sites = [];
  void loginuser(double width) async {
    setState(() {
      _loading = true;
    });
    String res = await AuthFunctions().loginuser(
      email: _email.text,
      password: _password.text,
    );
    print("1");

    print("2");

    // 1. Create a reference to the collection
    //  String res = "";
//     CollectionReference s = FirebaseFirestore.instance.collection("sers");

// // 2. Create a query for the user with the given email address
//     Query query = s.where("email", isEqualTo: _email.text);

// // 3. Execute the query to get the documents
//     QuerySnapshot querySnapshot = await query.get();

// // 4. Loop over the resulting document(s), since there may be multiple
//     querySnapshot.docs.forEach((doc) {
//       // 5. Update the 'Full Name' field in this document
//       setState(() {
//         phone = doc.get("phonenumber");
//         userRole = doc.get("userRole");
//         res = "success";
//       });
//     });

    if (res == "success") {
      // await addData();

      DocumentReference dbRef = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid);
      await dbRef.get().then((data) {
        if (data.exists) {
          if (mounted) {
            setState(() {
              print("fetching");
              phone = data.get("phonenumber");
              userRole = data.get("userRole");
              isverified = data.get("isverified");
              uid = data.get("uid");
              sites = data.get("sites");
              // phone = data.get("phonenumber");
            });
          }
        }
      });
      print(phone);
      print(userRole);
      addData();

      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => LoginScreen()));
      print(_auth.currentUser!.uid);
      // addData();
      print({"here "});
      print("phonenumber");
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => HomeScreen()));

      if (PlatformInfo().isWeb()) {
        print("isweb");

        AuthFunctions.signOut;
        print(phone);
        print(userRole);
        ConfirmationResult result =
            await OtpFucnctions().sendOTPLogin("+1 ${phone}");
        fToast!.showToast(
            child: ToastMessage().show(200, context, "Otp Sent ${phone}"),
            gravity: ToastGravity.BOTTOM,
            toastDuration: Duration(seconds: 3));

        setState(() {
          ress = result;
        });
        setState(() {
          _loading = false;
        });
        addData();

        print(ress);
      } else {
        registerUser(phone, context);
        addData();
      }

      try {
        if (Platform.isAndroid || Platform.isIOS) {
          final doc = await FirebaseFirestore.instance
              .collection("users")
              .doc(uid)
              .get()
              .then((value) => value);
          if (!doc["isSubscribed"]) {
            _subscribeAllUsers();
            _subscribetotopic();
            FirebaseFirestore.instance
                .collection("users")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .update({
              "isSubscribed": true,
            });
          }
        } else {
          // confirmotp();
          print("webbb");
        }
      } catch (e) {
        //  confirmotp();
        print("web");
      }
      //  ignore: unrelated_type_equality_checks

    } else {
      setState(() {
        _loading = false;
      });
      fToast!.showToast(
        child: ToastMessage().show(width, context, "There's some error"),
        gravity: ToastGravity.BOTTOM,
        toastDuration: Duration(seconds: 3),
      );
    }
  }

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  void _subscribetotopic() async {
    // List sites = widget.doc.get("sites");
    for (int i = 0; i < sites.length; i++) {
      await _fcm
          .subscribeToTopic(userRole + sites[i].toString().replaceAll(" ", ""))
          .then((value) {
        print("succesfully subscribed");
      }).catchError((onError) {
        print(onError);
      });
      FirebaseFirestore.instance.collection("users").doc(uid).update({
        "isSubscribed": true,
      });
    }
  }

  void _subscribeAllUsers() async {
    await _fcm.subscribeToTopic("AllUsers").then((value) {
      print("succesfully subscribed");
    }).catchError((onError) {
      print(onError);
    });
  }

  confirmotp() async {
    //  String role = "";
    print("confirming");
    print(ress);
    // addData();
    setState(() {
      _loading = true;
    });

    String res = await OtpFucnctions().authenticateMe(
      ress!,
      _otpcode.text,
    );
    await Future.delayed(const Duration(seconds: 3));
    print(res + "ffff");
    if (res == "success") {
      setState(() {
        _loading = false;
      });
      // FirebaseFirestore.instance
      //     .collection("users")
      //     .doc(uid)
      //     .update({"isverified": true});
      await AuthFunctions.signOut;
      String resss = await AuthFunctions().loginuser(
        email: _email.text,
        password: _password.text,
      );
      if (resss == "success") {
        // addData();

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => (userRole == "TerminalUser" ||
                        userRole == "TerminalManager")
                    ? TerminalHome()
                    : Responsive.isDesktop(context)
                        ? HomeScreen()
                        : BottomNav()));
        fToast!.showToast(
            child: ToastMessage().show(200, context, "Login Successful"),
            gravity: ToastGravity.BOTTOM,
            toastDuration: Duration(seconds: 3));
      } else {
        setState(() {
          _loading = false;
        });
        fToast!.showToast(
            child: ToastMessage().show(200, context, "Error"),
            gravity: ToastGravity.BOTTOM,
            toastDuration: Duration(seconds: 3));
      }
    } else {
      setState(() {
        _loading = false;
      });
      fToast!.showToast(
          child: ToastMessage().show(200, context, "Error in OTP"),
          gravity: ToastGravity.BOTTOM,
          toastDuration: Duration(seconds: 3));
    }
  }

  Color? getotp;
  getColor() {
    if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
      setState(() {
        getotp = Colors.blue;
      });
    } else {
      setState(() {
        getotp = Colors.grey;
      });
    }
  }

  bool isvisible = false;
  @override
  void dispose() {
    // TODO: implement dispose
    _email.dispose();
    _password.dispose();
    _otpcode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //UserProvider _userProvider = Provider.of(context, listen: false);

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xff2B343B),
      bottomNavigationBar: CustomFAQbottom(),
      body: SingleChildScrollView(
        child: Stack(children: [
          Padding(
            padding: EdgeInsets.only(
                left: width * 0.1, right: width * 0.1, top: height * 0.15),
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
                    Image.asset("assets/Logo 2 1.png"),
                    SizedBox(
                      height: height * 0.06,
                    ),
                    Text(
                      "Enter your Credentials",
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
                      controller: _email,
                      width: width,
                      height: height,
                      labelText: "Email",
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    CustomPasswordTextField(
                        width: width,
                        height: height,
                        labelText: "Password",
                        controller: _password,
                        isactive: true),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Container(
                      width: Responsive.isDesktop(context) ? 600 : width * 0.8,
                      padding: EdgeInsets.symmetric(
                          horizontal: Responsive.isDesktop(context)
                              ? width * 0.02
                              : width * 0.06),
                      height: height * 0.08,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              enabled: true,
                              controller: _otpcode,
                              style: TextStyle(fontFamily: "Poppins"),
                              cursorColor: Colors.black12,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: "Enter 6 Digits otp",
                                labelStyle: TextStyle(
                                    color: Color(0xff5e8be0),
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              loginuser(width);
                            },
                            child: Text(
                              "Get OTP",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: getotp,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    SizedBox(
                      height: height * 0.06,
                    ),
                    InkWell(
                      onTap: () {
                        try {
                          if (Platform.isAndroid || Platform.isIOS) {
                            signIn(_otpcode.text, width);
                          } else {
                            confirmotp();
                            print("webbb");
                          }
                        } catch (e) {
                          confirmotp();
                          print("web");
                        }
                        // if (PlatformInfo().isWeb()) {

                        //   print("web");
                        // } else {

                        // }
                      },
                      //   onTap: () async {
                      //   String url = await StorageMethods()
                      //     .uploadImageToStorage(
                      //       "profilePics", _image!, false);
                      //print(url);
                      //  },
                      child: CustomSubmitButton(
                        width: width,
                        title: "Login",
                      ),
                    ),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.forgetpass);
                          },
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.employercode);
/*
                        fToast!.showToast(
                          child: Toastt(width: width, message: "ff"),
                          gravity: ToastGravity.BOTTOM,
                          toastDuration: Duration(seconds: 3),
                        );
                        */
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Are you new?",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "Create Account",
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
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Visibility(
                  visible: _loading,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.grey.shade300,
                    color: Colors.blue,
                  )),
            ),
          ),
        ]),
      ),
    );
  }
}
