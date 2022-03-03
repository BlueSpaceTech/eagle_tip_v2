import 'package:testttttt/Providers/user_provider.dart';
import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/UI/Widgets/customNav.dart';
import 'package:testttttt/UI/Widgets/custom_webbg.dart';
import 'package:testttttt/UI/Widgets/customappheader.dart';
import 'package:testttttt/UI/Widgets/customfab.dart';
import 'package:testttttt/UI/views/post_auth_screens/CRUD/Add%20New%20User/Owner/addUserOwner.dart';
import 'package:testttttt/UI/views/post_auth_screens/UserProfiles/myprofile.dart';
import 'package:testttttt/Utils/common.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:provider/provider.dart';
import 'package:testttttt/Models/user.dart' as model;

class CrudScreen extends StatefulWidget {
  const CrudScreen({Key? key}) : super(key: key);

  @override
  _CrudScreenState createState() => _CrudScreenState();
}

class _CrudScreenState extends State<CrudScreen> {
  LinkedScrollControllerGroup? _controllers;
  ScrollController? _letters;
  ScrollController? _numbers;
  late ScrollController SCROL;

  deletUserDialog(double height, double width) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        title: Center(
          child: Text(
            'Delete User',
            style: TextStyle(
              fontSize: 23.0,
              fontWeight: FontWeight.bold,
              fontFamily: "Poppins",
              color: Colors.black,
            ),
          ),
        ),
        content: Container(
          width: Responsive.isDesktop(context) ? width * 0.38 : width * 0.8,
          height: height * 0.2,
          child: Column(
            children: [
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Are you sure you want to delete',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Poppins",
                            color: Color(0xff14142B))),
                    TextSpan(
                        text: ' Ahmad Elizondo ?',
                        style: TextStyle(
                            color: Color(0xff14142B),
                            fontSize: 18,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.06,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: Responsive.isDesktop(context)
                          ? width * 0.15
                          : width * 0.32,
                      height: height * 0.055,
                      decoration: BoxDecoration(
                        color: Color(0xffED5C62),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Text(
                          "Back",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13.0,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Poppins"),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: width * 0.02),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: Responsive.isDesktop(context)
                          ? width * 0.15
                          : width * 0.32,
                      height: height * 0.055,
                      decoration: BoxDecoration(
                        color: Color(0Xff28519D),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Text(
                          "Confirm",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13.0,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Poppins"),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controllers = LinkedScrollControllerGroup();
    _letters = _controllers!.addAndGet();
    _numbers = _controllers!.addAndGet();
  }

  @override
  void dispose() {
    _letters!.dispose();
    _numbers!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    List Site = [
      "All",
      "Acers Marathon",
      "Bridge Marathon",
      "Clarks Marathon",
      "Huntington Marathon"
    ];
    List Roles = ["Site Manager", "Site User"];
    List name = ["rAKSHTI", "FF", "ABHISEKHUI", "rAKSHTI", "FF", "ABHISEKHUI"];

    return Scaffold(
      floatingActionButton: Visibility(
        visible: !Responsive.isDesktop(context),
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.addUserOwner);
          },
          child: customfab(
            width: width,
            text: "Add new user",
            height: height,
          ),
        ),
      ),
      backgroundColor: Color(0xff2B343B),
      body: Column(
        children: [
          Navbar(width: width, height: height, text1: "text1", text2: "text2"),
          Expanded(
            child: Stack(clipBehavior: Clip.none, children: [
              //  WebBg(),
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal:
                          Responsive.isDesktop(context) ? width * 0.1 : 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Visibility(
                        visible: !Responsive.isDesktop(context),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: Responsive.isDesktop(context)
                                  ? 0
                                  : width * 0.01,
                              right: Responsive.isDesktop(context)
                                  ? 0
                                  : width * 0.01,
                              top: Responsive.isDesktop(context)
                                  ? height * 0.015
                                  : height * 0.04),
                          child: CustomAppheader(width: width),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.076,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Responsive.isDesktop(context)
                                ? 0
                                : width * 0.04),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Visibility(
                              visible: Responsive.isDesktop(context),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "         ",
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 25),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "Edit Employers",
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        color: Colors.white,
                                        fontSize: 20),
                                  ),
                                  Text("                       "),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 60,
                            ),
                            Row(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.only(
                                      left: width * 0.06, right: width * 0.06),
                                  height: height * 0.064,
                                  width: Responsive.isDesktop(context)
                                      ? width * 0.6
                                      : width * 0.9,
                                  decoration: BoxDecoration(
                                    color: Color(0xff535C65),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: TextField(
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        color: Colors.white),
                                    cursorColor: Colors.white,
                                    decoration: InputDecoration(
                                      hintText: user.employerCode,
                                      hintStyle: TextStyle(
                                          color: Colors.white.withOpacity(0.5)),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Visibility(
                                  visible: Responsive.isDesktop(context),
                                  child: GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, AppRoutes.addUserOwner);
                                      },
                                      child: customfab(
                                        height: height,
                                        width: width,
                                        text: "Add new user",
                                      )),
                                ),
                              ],
                            ),
                            SizedBox(height: height * 0.02),
                            Text(
                              "Site",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Poppins",
                                  fontSize: 15),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Wrap(
                              runSpacing: 10,
                              children: [
                                for (int i = 0; i < Site.length; i++) ...{
                                  SiteChip(
                                    function: () {},
                                    siteName: Site[i],
                                    height: height,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                },
                              ],
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Text(
                              "Role",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Poppins",
                                  fontSize: 15),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Wrap(
                              runSpacing: 10,
                              children: [
                                for (int i = 0; i < Roles.length; i++) ...{
                                  SiteChip(
                                    function: () {},
                                    siteName: Roles[i],
                                    height: height,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                },
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      SingleChildScrollView(
                        controller: _letters,
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          height: 40,
                          color: Color(0xff2B343B),
                          child: Row(
                            children: [
                              Container(
                                width: Responsive.isDesktop(context)
                                    ? width * 0.08
                                    : width * 0.2,
                                child: Text(
                                  "",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white.withOpacity(0.5),
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Container(
                                width: Responsive.isDesktop(context)
                                    ? width * 0.22
                                    : width * 0.56,
                                child: Text(
                                  "Name",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white.withOpacity(0.5),
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Container(
                                width: Responsive.isDesktop(context)
                                    ? width * 0.2
                                    : width * 0.2,
                                child: Text(
                                  "role",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white.withOpacity(0.5),
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Container(
                                width: Responsive.isDesktop(context)
                                    ? width * 0.24
                                    : width * 0.44,
                                child: Text(
                                  "Site",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white.withOpacity(0.5),
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Container(
                                width: width * 0.2,
                                child: Text(
                                  "Profile Info",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white.withOpacity(0.5),
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.white.withOpacity(0.5),
                      ),
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.only(top: 0),
                          shrinkWrap: true,
                          itemCount: name.length,
                          itemBuilder: (BuildContext context, int index) {
                            return SingleChildScrollView(
                              physics: Responsive.isDesktop(context)
                                  ? NeverScrollableScrollPhysics()
                                  : BouncingScrollPhysics(),
                              controller: _numbers,
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: index % 2 == 0
                                      ? Color(0xff2B343B)
                                      : Color(0xff24292E),
                                ),
                                height: 60,
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        deletUserDialog(height, width);
                                      },
                                      child: Container(
                                          width: Responsive.isDesktop(context)
                                              ? width * 0.08
                                              : width * 0.2,
                                          child:
                                              Image.asset("assets/delete.png")),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, AppRoutes.useprofile);
                                      },
                                      child: Container(
                                        width: Responsive.isDesktop(context)
                                            ? width * 0.22
                                            : width * 0.56,
                                        child: Text(
                                          '${index + 1}. ${name[index]}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "Poppins"),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: Responsive.isDesktop(context)
                                          ? width * 0.2
                                          : width * 0.2,
                                      child: Text('Site User',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "Poppins")),
                                    ),
                                    Container(
                                      width: Responsive.isDesktop(context)
                                          ? width * 0.24
                                          : width * 0.44,
                                      child: Text('Acers Marathon',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "Poppins")),
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, AppRoutes.useprofile);
                                        },
                                        child: Image.asset("assets/info.png")),
                                    SizedBox(
                                      width: width * 0.04,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
