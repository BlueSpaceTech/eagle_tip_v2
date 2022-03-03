// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/UI/Widgets/customContainer.dart';
import 'package:testttttt/UI/Widgets/customHeader2.dart';
import 'package:testttttt/UI/Widgets/customNav.dart';
import 'package:testttttt/UI/Widgets/custom_webbg.dart';
import 'package:testttttt/UI/Widgets/customappheader.dart';
import 'package:testttttt/UI/Widgets/logo.dart';
import 'package:testttttt/UI/views/post_auth_screens/Notifications/particularNotification.dart';
import 'package:testttttt/UI/views/post_auth_screens/Support/support_desktop.dart';
import 'package:testttttt/Utils/common.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Notifications extends StatefulWidget {
  Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List<String> notifyNames = [
    "Hurricane Coming!",
    "Edget Iaoreet",
    "Vel mauris",
    "Dapibus massa",
    "Diam dolor"
  ];

  List<String> notifyDates = [
    "Today",
    "9/22/16",
    "6/9/14",
    "2/11/12",
    "5/7/16"
  ];

  List isNew = [true, true, false, false, false];

  int _notifyNumberGenerator() {
    int counter = 0;
    for (int i = 0; i < isNew.length; i++) {
      if (isNew[i] == true) {
        counter = counter + 1;
      }
    }
    return counter;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: Responsive.isDesktop(context)
          ? MenuButton(isTapped: false, width: width)
          : SizedBox(),
      body: SingleChildScrollView(
        child: Container(
          width: width,
          height: Responsive.isDesktop(context) ? height * 1.12 : height,
          color: backGround_color,
          child: Padding(
            padding: EdgeInsets.only(
                top: Responsive.isDesktop(context)
                    ? height * 0.02
                    : height * 0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: Responsive.isDesktop(context),
                  child: Navbar(
                    width: width,
                    height: height,
                    text1: "Home",
                    text2: "Chat",
                    /*
                    widget3: Row(
                      children: [
                        Text(
                          "Notifications",
                          style: TextStyle(
                            fontSize: Responsive.isDesktop(context)
                                ? width * 0.01
                                : width * 0.02,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins",
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Container(
                          child: CircleAvatar(
                            backgroundColor: Color(0xFFED5C62),
                            radius: 8.0,
                            child: Center(
                              child: Text(
                                _notifyNumberGenerator().toString(),
                                style: TextStyle(fontSize: 10.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    */
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.09),
                  child: Visibility(
                    visible: Responsive.isMobile(context),
                    child: CustomHeader2(),
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Visibility(
                  visible: Responsive.isMobile(context),
                  child: Padding(
                    padding: EdgeInsets.only(left: width * 0.08),
                    child: Row(
                      children: [
                        Text(
                          "Notifications",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: "Poppins",
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Container(
                          child: CircleAvatar(
                            backgroundColor: Color(0xFFED5C62),
                            radius: 8.0,
                            child: Center(
                              child: Text(
                                _notifyNumberGenerator().toString(),
                                style: TextStyle(fontSize: 10.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: Responsive.isDesktop(context),
                  child: Stack(
                    children: [
                      Opacity(opacity: 0.2, child: WebBg()),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: width * 0.15,
                          ),
                          Container(
                            width: width * 0.5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          "Acres Marathon",
                                          style: TextStyle(
                                            fontSize: width * 0.008,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "Poppins",
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          height: height * 0.003,
                                        ),
                                        Text(
                                          "Tampa,FL",
                                          style: TextStyle(
                                            fontSize: width * 0.007,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "Poppins",
                                            color: Color(0xFF6E7191),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height * 0.05,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: width * 0.05),
                                  child: Container(
                                    height: height * 0.6,
                                    width: width * 0.5,
                                    child: ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: notifyNames.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Notify(
                                              valueChanged: (val) {
                                                setState(() {
                                                  isNew[index] = val;
                                                });
                                              },
                                              width: width,
                                              isnew: isNew[index],
                                              index: index,
                                              height: height,
                                              notifyNames: notifyNames,
                                              notifyDates: notifyDates);
                                        }),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: width * 0.02,
                          ),
                          Container(
                            height: height * 0.8,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, AppRoutes.createNotification);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: width * 0.11,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Color(0xff5081DB),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Create Notification",
                                          style: TextStyle(
                                              fontSize: width * 0.008,
                                              color: Colors.white,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          width: width * 0.005,
                                        ),
                                        Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Responsive.isDesktop(context)
                      ? height * 0.06
                      : height * 0.02,
                ),
                Visibility(
                  visible: Responsive.isMobile(context),
                  child: Center(
                    child: Container(
                      height: height * 0.6,
                      width:
                          Responsive.isDesktop(context) ? width * 0.5 : width,
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: notifyNames.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Notify(
                                valueChanged: (val) {
                                  setState(() {
                                    isNew[index] = val;
                                  });
                                },
                                width: width,
                                isnew: isNew[index],
                                index: index,
                                height: height,
                                notifyNames: notifyNames,
                                notifyDates: notifyDates);
                          }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Notify extends StatefulWidget {
  const Notify({
    Key? key,
    required this.width,
    required this.height,
    required this.notifyNames,
    required this.index,
    required this.isnew,
    required this.notifyDates,
    required this.valueChanged,
  }) : super(key: key);

  final double width;
  final bool isnew;
  final double height;
  final List<String> notifyNames;
  final int index;
  final ValueChanged valueChanged;
  final List<String> notifyDates;

  @override
  State<Notify> createState() => _NotifyState();
}

class _NotifyState extends State<Notify> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final newNotify = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SpecificNotification(
                    notifyName: widget.notifyNames[widget.index],
                    notifyContent:
                        "Risus vestibulum, risus feugiat semper velit feugiat velit. Placerat elit volutpat volutpat elit bibendum molestie eget. Convallis mattis dignissim quis tincidunt quisque. Adipiscing suspendisse faucibus aliquet a turpis odio pellentesque lectus duis. Sodales odio eu bibendum massa velit maecenas eget. Maecenas facilisis nunc tincidunt sed eget viverra porttitor feugiat. Mattis dictum sed suspendisse faucibus gravida. Id eget amet dis amet ut at in eget nam. Diam aenean ullamcorper viverra sed tincidunt. Volutpat amet et scelerisque lacus, vitae rhoncus iaculis. In egestas a cras orci cras. Neque at magna nunc turpis. Leo mattis porttitor sed nisl. Tortor tincidunt et sit nullam cras fames ac. Eget ac ultrices phasellus diam nam massa. Egestas risus amet, convallis felis faucibus. Quis odio non duis sollicitudin massa urna luctus vel. Est maecenas a diam et tellus. Pellentesque lobortis tincidunt aliquet quam et turpis. Erat in eget tortor, morbi a venenatis.")));
        setState(() {
          if (newNotify != null) {
            widget.valueChanged(newNotify);
          }
        });
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 10.0, right: widget.width * 0.06),
        child: Container(
          height: widget.height * 0.06,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: Responsive.isDesktop(context)
                    ? widget.width * 0.3
                    : widget.width * 0.5,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.isnew
                        ? Image.asset(
                            Common.assetImages + "Rectangle 522.png",
                            height: Responsive.isDesktop(context)
                                ? widget.height * 0.036
                                : widget.height * 0.05,
                          )
                        : SizedBox(),
                    SizedBox(
                      width: Responsive.isDesktop(context)
                          ? widget.width * 0.01
                          : widget.width * 0.07,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.notifyNames[widget.index],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Poppins",
                          ),
                        ),
                        Text(
                          widget.notifyDates[widget.index],
                          style: TextStyle(
                            color: Color(0xFFD9DBE9),
                            fontSize: 10.0,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 17.0,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
