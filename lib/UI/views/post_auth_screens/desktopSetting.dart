// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:testttttt/Providers/user_provider.dart';
import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/Services/authentication_helper.dart';
import 'package:testttttt/Services/storagemethods.dart';
import 'package:testttttt/Services/utils.dart';
import 'package:testttttt/UI/Widgets/customNav.dart';
import 'package:testttttt/UI/Widgets/customtoast.dart';
import 'package:testttttt/Utils/common.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:testttttt/Models/user.dart' as model;

class DesktopSetting extends StatefulWidget {
  @override
  State<DesktopSetting> createState() => _DesktopSettingState();
}

class _DesktopSettingState extends State<DesktopSetting> {
  PageController page = PageController();

  bool? switchVal1 = false;
  Uint8List? _image;
  bool? switchVal2 = false;
  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  updatedpURL(double width) async {
    String photourl = await StorageMethods()
        .uploadImageToStorage("profilePics", _image!, false);
    FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .update({'dpUrl': photourl});
    addData();
    fToast!.showToast(
      child: ToastMessage().show(width, context, "Image Updated"),
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 3),
    );
  }

  FToast? fToast;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fToast = FToast();
    fToast!.init(context);
  }

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: height,
          color: backGround_color,
          width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: height * 0.04),
                child: SideMenu(
                  controller: page,
                  style: SideMenuStyle(
                      displayMode: SideMenuDisplayMode.auto,
                      // hoverColor: Colors.blue[100],
                      selectedColor: Color(0xFF353D45),
                      selectedTitleTextStyle: TextStyle(color: Colors.white),
                      selectedIconColor: Colors.white,
                      unselectedTitleTextStyle:
                          TextStyle(color: Colors.grey[600])
                      // backgroundColor: Colors.amber
                      // openSideMenuWidth: 200
                      ),
                  title: Padding(
                    padding: EdgeInsets.only(
                        left: width * 0.025,
                        top: height * 0.05,
                        bottom: height * 0.04),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "SETTINGS",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                          fontSize: width * 0.012,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  items: [
                    SideMenuItem(
                      priority: 0,
                      title: 'Account',
                      onTap: () {
                        page.jumpToPage(0);
                      },
                      icon: Icon(null),
                    ),
                    SideMenuItem(
                      priority: 1,
                      title: 'Preferences',
                      onTap: () {
                        page.jumpToPage(1);
                      },
                      icon: Icon(null),
                    ),
                    SideMenuItem(
                      priority: 2,
                      title: 'About',
                      onTap: () {
                        page.jumpToPage(2);
                      },
                      icon: Icon(null),
                    ),
                  ],
                  footer: Padding(
                    padding: EdgeInsets.only(
                      left: width * 0.025,
                      // top: height * 0.02,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: () {
                          AuthFunctions.signOut();
                          Navigator.pushNamedAndRemoveUntil(
                              context, AppRoutes.loginscreen, (route) => false);
                        },
                        child: Text(
                          "Logout",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500,
                              fontSize: width * 0.012,
                              color: Color(0xFF92B8FF)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: PageView(
                  controller: page,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.04, top: height * 0.02),
                      child: Column(
                        crossAxisAlignment: Responsive.isDesktop(context)
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: height * 0.06,
                          ),
                          Text(
                            "Account",
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Poppins"),
                          ),
                          SizedBox(
                            height: height * 0.06,
                          ),
                          Text(
                            "Change profile picture",
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Poppins"),
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          _image == null
                              ? Container(
                                  alignment: Alignment.bottomRight,
                                  width: Responsive.isDesktop(context)
                                      ? width * 0.1
                                      : width * 0.38,
                                  height: height * 0.18,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(user.dpurl),
                                    ),
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: Responsive.isDesktop(context)
                                            ? height * 0.13
                                            : 0.0,
                                        left: Responsive.isDesktop(context)
                                            ? width * 0.05
                                            : 0.0),
                                    child: InkWell(
                                      onTap: () {
                                        selectImage();
                                      },
                                      child: Image.asset(
                                        "assets/editImg.png",
                                        width: width * 0.12,
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  alignment: Alignment.bottomRight,
                                  width: Responsive.isDesktop(context)
                                      ? width * 0.1
                                      : width * 0.38,
                                  height: height * 0.18,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: MemoryImage(_image!),
                                    ),
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: Responsive.isDesktop(context)
                                            ? height * 0.13
                                            : 0.0,
                                        left: Responsive.isDesktop(context)
                                            ? width * 0.05
                                            : 0.0),
                                    child: InkWell(
                                      onTap: () {
                                        selectImage();
                                      },
                                      child: Image.asset(
                                        "assets/editImg.png",
                                        width: width * 0.12,
                                      ),
                                    ),
                                  ),
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          Visibility(
                            visible: _image != null,
                            child: InkWell(
                              onTap: () {
                                updatedpURL(width);
                              },
                              child: Container(
                                width: Responsive.isDesktop(context)
                                    ? width * 0.18
                                    : width * 0.3,
                                height: height * 0.05,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                  color: Color(0xFF5081DB),
                                ),
                                child: Center(
                                  child: Text(
                                    "Upload Image",
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Poppins"),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.08,
                          ),
                          Text(
                            "Change password",
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Poppins"),
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          /*
                                      ChangePassField(
                                          labelText: "Current Password"),
                                      SizedBox(
                                        height: height * 0.02,
                                      ),
                                      ChangePassField(labelText: "New Password"),
                                      SizedBox(
                                        height: height * 0.02,
                                      ),
                                      ChangePassField(
                                          labelText: "Re-enter New Password"),
                                      SizedBox(
                                        height: height * 0.03,
                                      ),
                                      */
                          InkWell(
                            onTap: () {
                              AuthFunctions().resetpassword(user.email);
                            },
                            child: Container(
                              width: Responsive.isDesktop(context)
                                  ? width * 0.23
                                  : width * 0.9,
                              height: height * 0.07,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0),
                                color: Color(0xFF5081DB),
                              ),
                              child: Center(
                                child: Text(
                                  "Send Reset Password Link ",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Poppins"),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      // padding: const EdgeInsets.all(8.0),
                      padding: EdgeInsets.only(
                          left: width * 0.07, top: height * 0.06),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Preferences",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Poppins"),
                          ),
                          SizedBox(
                            height: height * 0.07,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Text(
                                "Messages",
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
                          Container(
                            width: width * 0.4,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Push Notifications",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Poppins"),
                                ),
                                Row(
                                  children: [
                                    FlutterSwitch(
                                      height: 30,
                                      width: 60,
                                      padding: 2.0,
                                      toggleSize: 27,
                                      activeColor: Color(0xFF5081db),
                                      inactiveColor: Color(0xFFd9dbe9),
                                      value: switchVal1!,
                                      onToggle: (val) {
                                        setState(() {
                                          switchVal1 = val;
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      width: 40.0,
                                    ),
                                    Image.asset(
                                      Common.assetImages + "Group 2889.png",
                                      width: width * 0.02,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Container(
                            width: width * 0.4,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "In-App Notifications",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Poppins"),
                                ),
                                Row(
                                  children: [
                                    FlutterSwitch(
                                      height: 30,
                                      width: 60,
                                      padding: 2.0,
                                      toggleSize: 27,
                                      activeColor: Color(0xFF5081db),
                                      inactiveColor: Color(0xFFd9dbe9),
                                      value: switchVal2!,
                                      onToggle: (val) {
                                        setState(() {
                                          switchVal2 = val;
                                        });
                                      },
                                    ),
                                    // SizedBox(
                                    //   width: width * 0.08,
                                    // ),
                                    SizedBox(
                                      width: 40.0,
                                    ),
                                    Image.asset(
                                      Common.assetImages + "Group 2889.png",
                                      width: width * 0.02,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.17,
                          ),
                          Text(
                            "Site",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Poppins"),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Container(
                            height: height * 0.072,
                            width: width * 0.3,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: width * 0.02, right: width * 0.02),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Acres Marathon",
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Poppins"),
                                  ),
                                  Image.asset(
                                    Common.assetImages + "down_black.png",
                                    width: width * 0.02,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: width * 0.07,
                          left: width * 0.04,
                          top: height * 0.06),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "About",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Poppins"),
                          ),
                          SizedBox(
                            height: height * 0.04,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Eagle Tip",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Poppins"),
                              ),
                              SizedBox(
                                height: height * 0.04,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: width * 0.45,
                                    child: Text(
                                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Amet blandit id nulla quisque. Senectus ut odio blandit parturient amet vitae neque, mattis. Viverra cras ut turpis aliquet suspendisse feugiat ipsum. Enim, mi diam at lorem non a. Ornare nisl mollis in amet. Vel sit felis sollicitudin leo vitae ultrices a. Pharetra, molestie turpis condimentum proin natoque auctor felis. Sed id varius sit elementum est vel bibendum.",
                                      style: TextStyle(
                                          color: Color(0xFFD4D6D9),
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Poppins"),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.03,
                                  ),
                                  Image.asset(
                                    Common.assetImages + "Layer 1.png",
                                    width: width * 0.2,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.05,
                          ),
                          Divider(
                            color: Color(0xFF8C8C8C),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          CustomColumn(
                              color1: Colors.white,
                              text3: "Email",
                              text1: "You can contact us at - ",
                              text2: " eagletip@company.com",
                              height: height),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Divider(
                            color: Color(0xFF8C8C8C),
                          ),
                          SizedBox(
                            height: height * 0.04,
                          ),
                          CustomColumn(
                              color1: Color(0xFF5081DB),
                              text3: "Terms and Conditions",
                              text1: "Read Eagle Tip's Terms and conditions",
                              text2: " here .",
                              height: height),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Divider(
                            color: Color(0xFF8C8C8C),
                          ),
                          SizedBox(
                            height: height * 0.04,
                          ),
                          SizedBox(
                            height: height * 0.04,
                          ),
                          CustomColumn(
                              color1: Color(0xFFD4D6D9),
                              text3: "App Version",
                              text1: "",
                              text2: "02.00.01",
                              height: height),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Divider(
                            color: Color(0xFF8C8C8C),
                          ),
                          SizedBox(
                            height: height * 0.04,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// Read Eagle Tip’s Terms and conditions

class CustomColumn extends StatelessWidget {
  CustomColumn({
    Key? key,
    required this.text1,
    required this.text2,
    required this.text3,
    required this.height,
    required this.color1,
  }) : super(key: key);

  final double height;
  final String text1;
  final String text3;
  final String text2;
  final Color color1;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text3,
          style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: "Poppins"),
        ),
        SizedBox(
          height: height * 0.04,
        ),
        RichText(
          text: TextSpan(
            text: text1,
            style: TextStyle(
                color: Color(0xFFD4D6D9),
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
                fontFamily: "Poppins"),
            children: [
              TextSpan(
                text: text2,
                style: TextStyle(
                    color: color1,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Poppins"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
