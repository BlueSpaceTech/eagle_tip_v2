// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:testttttt/Providers/user_provider.dart';
import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/UI/Widgets/customappheader.dart';
import 'package:testttttt/UI/Widgets/customtoast.dart';
import 'package:testttttt/UI/Widgets/logo.dart';
import 'package:testttttt/UI/views/post_auth_screens/HomeScreens/Home_screen.dart';
import 'package:testttttt/UI/views/post_auth_screens/HomeScreens/bottomNav.dart';
import 'package:testttttt/Utils/common.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:testttttt/Utils/responsive.dart';

import '../../../Services/authentication_helper.dart';
import 'package:testttttt/Models/user.dart' as model;

class Setting extends StatefulWidget {
  Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool? switchVal1 = false;
  List<String> sitenames = [];
  bool? switchVal2 = false;
  FToast? fToast;
  // String dropdownValue = "Acers Marathon";
  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    model.User? user = Provider.of<UserProvider>(context).getUser;

    for (var site in user!.sites) {
      if (sitenames.contains(site)) {
      } else {
        sitenames.add(site);
      }
    }
    super.didChangeDependencies();
  }

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
    model.User? user = Provider.of<UserProvider>(context).getUser;
    // print(user.sites.length);
    // List<String> sitess = user.sites;
    String dropdownValue = user!.currentsite;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Responsive.isDesktop(context)
          ? MenuButton(isTapped: false, width: width)
          : SizedBox(),
      body: SingleChildScrollView(
        child: Container(
          height: height,
          width: width,
          color: backGround_color,
          child: Padding(
            padding: EdgeInsets.only(
                left: width * 0.04, right: width * 0.04, top: height * 0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: width * 0.06,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.17,
                    ),
                    Logo(width: width),
                    SizedBox(
                      width: width * 0.18,
                    ),
                    MenuButton(isTapped: false, width: width),
                  ],
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Preferences",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins"),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //       "Push Notifications",
                //       style: TextStyle(
                //           color: Colors.white,
                //           fontSize: 18.0,
                //           fontWeight: FontWeight.w400,
                //           fontFamily: "Poppins"),
                //     ),
                //     FlutterSwitch(
                //         height: 30,
                //         width: 60,
                //         padding: 2.0,
                //         toggleSize: 27,
                //         activeColor: Color(0xFF5081db),
                //         inactiveColor: Color(0xFFd9dbe9),
                //         value: switchVal1!,
                //         onToggle: (val) {
                //           setState(() {
                //             switchVal1 = val;
                //           });
                //         })
                //   ],
                // ),
                // SizedBox(
                //   height: height * 0.02,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //       "In-App Notifications",
                //       style: TextStyle(
                //           color: Colors.white,
                //           fontSize: 18.0,
                //           fontWeight: FontWeight.w400,
                //           fontFamily: "Poppins"),
                //     ),
                //     FlutterSwitch(
                //         height: 30,
                //         width: 60,
                //         padding: 2.0,
                //         toggleSize: 27,
                //         activeColor: Color(0xFF5081db),
                //         inactiveColor: Color(0xFFd9dbe9),
                //         value: switchVal2!,
                //         onToggle: (val) {
                //           setState(() {
                //             switchVal2 = val;
                //           });
                //         })
                //   ],
                // ),
                SizedBox(
                  height: height * 0.04,
                ),
                Text(
                  "Default Site",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Poppins"),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.keyboard_arrow_down_outlined),
                  iconEnabledColor: Colors.white,

                  iconSize: 24,
                  dropdownColor: Colors.black,
                  elevation: 16,
                  style: const TextStyle(color: Colors.white),
                  // underline: Container(
                  //   height: 2,
                  //   color: Colors.deepPurpleAccent,
                  // ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(user.uid)
                          .update({'currentsite': newValue});
                      addData();
                      fToast!.showToast(
                        child:
                            ToastMessage().show(width, context, "Site Updated"),
                        gravity: ToastGravity.BOTTOM,
                        toastDuration: Duration(seconds: 3),
                      );
                    });
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Responsive.isDesktop(context)
                                ? HomeScreen(
                                    showdialog: false,
                                    sites: user.sites,
                                  )
                                : BottomNav()));
                  },
                  items:
                      sitenames.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value +
                            "                                                                           ",
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
