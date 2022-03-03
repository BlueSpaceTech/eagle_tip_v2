import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/Services/authentication_helper.dart';
import 'package:testttttt/Services/storagemethods.dart';
import 'package:testttttt/Services/utils.dart';
import 'package:testttttt/UI/Widgets/customTextField.dart';
import 'package:testttttt/UI/Widgets/custom_webbg.dart';
import 'package:testttttt/UI/Widgets/customfaqbottom.dart';
import 'package:testttttt/UI/Widgets/customsubmitbutton.dart';
import 'package:testttttt/UI/Widgets/customtoast.dart';
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
  }

  void loginuser(double width) async {
    String res = await AuthFunctions()
        .loginuser(email: _email.text, password: _password.text);
    if (res == "success") {
      Navigator.pushNamed(context, AppRoutes.homeScreen);
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

  Uint8List? _image;
  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
    print("image is added");
    print(_image);
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
                    GestureDetector(
                        onTap: () {
                          selectImage();
                        },
                        child: Image.asset("assets/Logo 2 1.png")),
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
                    CustomTextField(
                      isactive: true,
                      controller: _password,
                      width: width,
                      height: height,
                      labelText: "Password",
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    CustomTextField(
                      isactive: true,
                      controller: _employercode,
                      width: width,
                      height: height,
                      labelText: "Employer Code",
                    ),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    SizedBox(
                      height: height * 0.06,
                    ),
                    GestureDetector(
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
                    GestureDetector(
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
