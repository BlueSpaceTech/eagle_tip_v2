import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:testttttt/Providers/user_provider.dart';
import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/Services/authentication_helper.dart';
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
import 'package:testttttt/Utils/constants.dart';
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
  final TextEditingController _employercode = TextEditingController();
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
  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);

    await _userProvider.refreshUser();
  }

  route() {
    Responsive.isDesktop(context)
        ? Navigator.pushNamed(context, AppRoutes.homeScreen)
        : Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => BottomNav()));
  }

  route2() {
    UserProvider _userProvider = Provider.of(context, listen: false);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                (_userProvider.getUser.userRole == "TerminalUser" ||
                        _userProvider.getUser.userRole == "TerminalManager")
                    ? TerminalHome()
                    : Responsive.isDesktop(context)
                        ? HomeScreen()
                        : BottomNav()));
  }

  startTime() async {
    var duration = new Duration(seconds: 4);
    return new Timer(duration, route2);
  }

  void loginuser(double width) async {
    String res = await AuthFunctions().loginuser(
        email: _email.text,
        password: _password.text,
        EmployerCode: _employercode.text);
    if (res == "success") {
      showDialog(
        builder: (ctx) {
          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          );
        },
        context: context,
      );

      addData();
      startTime();
      // ignore: unrelated_type_equality_checks
      final doc = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) => value);
      if (!doc["isSubscribed"]) {
        FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({
          "isSubscribed": true,
        });
      }
      /*
      Responsive.isDesktop(context)
          ? Navigator.pushNamed(context, AppRoutes.homeScreen)
          : Navigator.pushNamed(context, AppRoutes.bottomNav);
*/
      fToast!.showToast(
        child: ToastMessage().show(width, context, res),
        gravity: ToastGravity.BOTTOM,
        toastDuration: Duration(seconds: 3),
      );
    }
    fToast!.showToast(
      child: ToastMessage().show(width, context, res),
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 3),
    );
  }

  Color? getotp;
  getColor() {
    if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
      setState(() {
        getotp = Colors.black;
      });
    } else {
      setState(() {
        getotp = Colors.blue;
      });
    }
  }

  bool isvisible = false;

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
                              controller: _employercode,
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
                          Text(
                            "Get OTP",
                            style: TextStyle(
                                fontSize: 15,
                                color: getotp,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w600),
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
                      onTap: () => loginuser(width),
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
        ]),
      ),
    );
  }
}
