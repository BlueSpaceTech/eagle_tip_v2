import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/UI/Widgets/customTextField.dart';
import 'package:testttttt/UI/Widgets/custom_webbg.dart';
import 'package:testttttt/UI/Widgets/customfaqbottom.dart';
import 'package:testttttt/UI/Widgets/customsubmitbutton.dart';
import 'package:testttttt/UI/Widgets/customtoast.dart';
import 'package:testttttt/UI/Widgets/logo.dart';
import 'package:testttttt/UI/views/pre_auth_screens/create_account.dart';
import 'package:testttttt/UI/views/pre_auth_screens/employer_code.dart';
import 'package:testttttt/UI/views/pre_auth_screens/login_screen.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DecidingScreen extends StatefulWidget {
  const DecidingScreen({Key? key}) : super(key: key);

  @override
  State<DecidingScreen> createState() => _DecidingScreenState();
}

class _DecidingScreenState extends State<DecidingScreen> {
  FToast? fToast;
  String? name;
  String? phone;
  String? email;

  final TextEditingController _email = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fToast = FToast();
    fToast!.init(context);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        //backgroundColor: Color(0xff2B343B),
        //  bottomNavigationBar: CustomFAQbottom(),
        body: Responsive(
      desktop: DestopDeciding(),
      mobile: MobileDeciding(),
      tablet: MobileDeciding(),
    ));
  }
}

class DestopDeciding extends StatelessWidget {
  const DestopDeciding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Stack(children: [
      Expanded(
        child: Row(children: [
          Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(color: Color(0xff2B343B)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 100),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 31,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Welcome back! Click on this login button to take you to your login page.",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.loginscreen);
                        },
                        child: CustomSubmitButton(
                            width: width, title: "Take me to login page"),
                      )
                    ],
                  ),
                ),
              )),
          Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.9)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 100),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sign Up',
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 31,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Are you new here? Click on the Sign up button to create your account.",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.employercode);
                        },
                        child: CustomSubmitButton(
                            width: width, title: "Create new account"),
                      )
                    ],
                  ),
                ),
              ))
        ]),
      ),
      Positioned.fill(
          child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 40),
                child: Logo(width: width),
              ))),
    ]);
  }
}

class MobileDeciding extends StatelessWidget {
  const MobileDeciding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
