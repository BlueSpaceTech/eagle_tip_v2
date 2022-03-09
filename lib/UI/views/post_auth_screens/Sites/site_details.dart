// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:provider/provider.dart';
import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/UI/Widgets/customHeader2.dart';
import 'package:testttttt/UI/Widgets/customNav.dart';
import 'package:testttttt/UI/Widgets/custom_webbg.dart';
import 'package:testttttt/UI/Widgets/customappheader.dart';
import 'package:testttttt/UI/views/post_auth_screens/HomeScreens/Home_screen.dart';
import 'package:testttttt/UI/views/post_auth_screens/Request%20History/request_history.dart';
import 'package:testttttt/UI/views/post_auth_screens/Tanks/tanks_request.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:lottie/lottie.dart';
import 'package:testttttt/Utils/common.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:flutter/material.dart';

import '../../../../Providers/user_provider.dart';
import 'package:testttttt/Models/user.dart' as model;

class SiteDetails extends StatelessWidget {
  SiteDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: MobileSiteDet(),
      tablet: MobileSiteDet(),
      desktop: MobileSiteDet(),
    );
  }
}

class MobileSiteDet extends StatefulWidget {
  @override
  State<MobileSiteDet> createState() => _MobileSiteDetState();
}

class _MobileSiteDetState extends State<MobileSiteDet> {
  bool? _isTapped = false;

  bool? _requested = false;

  List requestId = [
    "345635",
    "342635",
    "345835",
    "345735",
    "345655",
  ];

  List requestDate = [
    "5/27/15",
    "10/17/14",
    "15/7/10",
    "3/7/19",
    "22/15/10",
  ];

  bool? reqSent = false;

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;
    final width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Responsive.isDesktop(context)
        ? Scaffold(
            floatingActionButton: Responsive.isDesktop(context)
                ? MenuButton(isTapped: false, width: width)
                : SizedBox(),
            body: SingleChildScrollView(
              child: Container(
                height: height * 1.19,
                color: backGround_color,
                child: Column(
                  children: [
                    Navbar(
                      width: width,
                      height: height,
                      text1: "Home",
                      text2: "Sites",
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Stack(
                      children: [
                        Opacity(opacity: 0.2, child: WebBg()),
                        Padding(
                          padding: EdgeInsets.only(
                            left: width * 0.05,
                          ),
                          child: SizedBox(
                            width: width * 0.87,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: reqSent! ? width * 0.36 : width * 0.19,
                                ),
                                SiteNameAndLocation(
                                    fontSize: 17.0, fontSize2: 13.0),
                                SizedBox(
                                  width: width * 0.18,
                                ),
                                reqSent!
                                    ? Image.asset(
                                        Common.assetImages +
                                            "requestIndicator.png",
                                        width: width * 0.18,
                                      )
                                    : SizedBox(),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: height * 0.1),
                          child: IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "Tanks",
                                      style: TextStyle(
                                          fontSize: width * 0.012,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                          fontFamily: "Poppins"),
                                    ),
                                    FuelRequestPart(
                                      valueChanged: (val) {
                                        setState(() {
                                          reqSent = val;
                                        });
                                      },
                                      width: width * 0.23,
                                      height: height,
                                      requestDate: requestDate,
                                      requestId: requestId,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: width * 0.05,
                                ),
                                VerticalDivider(
                                  color: Colors.white,
                                  thickness: 1.0,
                                  endIndent: 100,
                                  indent: 1,
                                ),
                                SizedBox(
                                  width: width * 0.05,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "Request History",
                                      style: TextStyle(
                                          fontSize: width * 0.012,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                          fontFamily: "Poppins"),
                                    ),
                                    SizedBox(
                                      height: height * 0.047,
                                    ),
                                    RequestHistoryPart(
                                        width: width * 0.65,
                                        height: height * 0.9,
                                        requestId: requestId,
                                        requestDate: requestDate),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        : DefaultTabController(
            length: 2,
            child: Scaffold(
              body: SingleChildScrollView(
                child: Container(
                  height: height,
                  color: backGround_color,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: width * 0.04, top: height * 0.1),
                        child: CustomHeader2(),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Text(
                        "Acres Marathon",
                        style: TextStyle(
                            fontSize: 17.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Poppins"),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Text(
                        "Tampa,FL",
                        style: TextStyle(
                            fontSize: 13.0,
                            color: Color(0xFF6E7191),
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins"),
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Container(
                        height: height * 0.07,
                        child: Material(
                          color: Color(0xFF2E3840),
                          child: TabBar(
                            tabs: [
                              Tab(
                                child: Text(
                                  "Tanks",
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Poppins"),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  "Request History",
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Poppins"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            FuelRequestPart(
                              valueChanged: (val) {
                                setState(() {
                                  reqSent = val;
                                });
                              },
                              width: width,
                              height: height,
                              requestDate: requestDate,
                              requestId: requestId,
                            ),
                            Visibility(
                              visible: user.userRole != "SiteUser",
                              child: RequestHistoryPart(
                                  width: width,
                                  height: height,
                                  requestId: requestId,
                                  requestDate: requestDate),
                            )
                          ],
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

class FuelRequestPart extends StatelessWidget {
  const FuelRequestPart({
    Key? key,
    required this.width,
    required this.height,
    required this.requestDate,
    required this.requestId,
    required this.valueChanged,
  }) : super(key: key);

  final double width;
  final double height;
  final List requestDate;
  final List requestId;
  final ValueChanged valueChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: width * 0.05, right: width * 0.03, top: height * 0.03),
      child: FuelReqColumn(
        valueChanged: (val) {
          valueChanged(val);
        },
        requestDate: requestDate,
        requestId: requestId,
        height: height,
        width: width,
      ),
    );
  }
}

class RequestHistoryPart extends StatelessWidget {
  const RequestHistoryPart({
    Key? key,
    required this.width,
    required this.height,
    required this.requestId,
    required this.requestDate,
  }) : super(key: key);

  final double width;
  final double height;
  final List requestId;
  final List requestDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: width * 0.04, right: width * 0.04, top: height * 0.03),
      child: Requests(
          height: height,
          requestId: requestId,
          width: width,
          requestDate: requestDate),
    );
  }
}

class FuelReqColumn extends StatefulWidget {
  FuelReqColumn({
    Key? key,
    required this.height,
    required this.width,
    required this.requestId,
    required this.requestDate,
    required this.valueChanged,
  }) : super(key: key);

  final double height;
  final double width;
  final List requestId;
  final List requestDate;

  final ValueChanged valueChanged;

  @override
  State<FuelReqColumn> createState() => _FuelReqColumnState();
}

class _FuelReqColumnState extends State<FuelReqColumn>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  bool? isTapped = false;

  AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);
  playLocal() async {
    int result = await audioPlayer.play("assets/pop-sound.mp3", isLocal: true);
  }

  bool? reqSent = false;
  void off() {
    Timer(Duration(seconds: 1), () {
      setState(() {
        reqSent = false;
      });
    });
  }

  void trigger() {
    setState(() {
      reqSent = true;
    });
  }

  void playsound() {
    final player = AudioCache();
    player.play('pop-sound.mp3');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  String? regularVal = "0";

  String? midgradeVal = "0";

  String? premiumVal = "0";

  String? ulsdVal = "0";

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: widget.width * 0.86,
          height: Responsive.isDesktop(context)
              ? widget.height * 0.3
              : widget.height * 0.35,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Tank(
                valueChanged2: (val) {
                  setState(() {
                    regularVal = val;
                  });
                },
                tankNumber: 1,
                valueChanged: (val) {
                  setState(() {
                    isTapped = val;
                  });
                },
                max: 8000,
                width: widget.width,
                height: widget.height,
                tankType: "Tank 1: Regular (132)",
              ),
              Tank(
                valueChanged2: (val) {
                  setState(() {
                    midgradeVal = val;
                  });
                },
                tankNumber: 2,
                valueChanged: (val) {
                  setState(() {
                    isTapped = val;
                  });
                },
                width: widget.width,
                max: 12000,
                height: widget.height,
                tankType: "Tank 2: Midgrade (131)",
              ),
              Tank(
                valueChanged2: (val) {
                  setState(() {
                    premiumVal = val;
                  });
                },
                tankNumber: 3,
                valueChanged: (val) {
                  setState(() {
                    isTapped = val;
                  });
                },
                width: widget.width,
                max: 16000,
                height: widget.height,
                tankType: "Tank 3: Premium (133)",
              ),
              Tank(
                valueChanged2: (val) {
                  setState(() {
                    ulsdVal = val;
                  });
                },
                tankNumber: 4,
                valueChanged: (val) {
                  setState(() {
                    isTapped = val;
                  });
                },
                width: widget.width,
                max: 20000,
                height: widget.height,
                tankType: "Tank 4: ULSD (134)",
              ),
            ],
          ),
        ),
        SizedBox(
          height: widget.height * 0.06,
        ),
        InkWell(
          onTap: () {
            print(regularVal);
            if (isTapped!) {
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  title: Text(
                    'Request Confirmation',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: Responsive.isDesktop(context)
                          ? widget.width * 0.05
                          : 23.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Poppins",
                      color: Colors.black,
                    ),
                  ),
                  content: Container(
                    height: Responsive.isDesktop(context)
                        ? widget.height * 0.3
                        : widget.height * 0.37,
                    child: Column(
                      children: [
                        Text(
                          "Are you sure you want to request:",
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Poppins"),
                        ),
                        SizedBox(
                          height: Responsive.isDesktop(context)
                              ? widget.height * 0.02
                              : widget.height * 0.05,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 5.0,
                              height: 5.0,
                              child: CircleAvatar(
                                backgroundColor: Colors.black,
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              regularVal.toString().replaceAllMapped(
                                  RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                  (Match m) => '${m[1]},'),
                              style: TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Poppins"),
                            ),
                            Text(
                              " Gal of ",
                              style: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Poppins",
                              ),
                            ),
                            Text(
                              "Regular",
                              style: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Poppins",
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Responsive.isDesktop(context)
                              ? widget.height * 0.006
                              : 8.0,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 5.0,
                              height: 5.0,
                              child: CircleAvatar(
                                backgroundColor: Colors.black,
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              midgradeVal.toString().replaceAllMapped(
                                  RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                  (Match m) => '${m[1]},'),
                              style: TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Poppins"),
                            ),
                            Text(
                              " Gal of ",
                              style: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Poppins",
                              ),
                            ),
                            Text(
                              "Midgrade",
                              style: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Poppins",
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Responsive.isDesktop(context)
                              ? widget.height * 0.006
                              : 8.0,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 5.0,
                              height: 5.0,
                              child: CircleAvatar(
                                backgroundColor: Colors.black,
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              premiumVal.toString().replaceAllMapped(
                                  RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                  (Match m) => '${m[1]},'),
                              style: TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Poppins"),
                            ),
                            Text(
                              " Gal of ",
                              style: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Poppins",
                              ),
                            ),
                            Text(
                              "Premium",
                              style: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Poppins",
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Responsive.isDesktop(context)
                              ? widget.height * 0.006
                              : 8.0,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 5.0,
                              height: 5.0,
                              child: CircleAvatar(
                                backgroundColor: Colors.black,
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              ulsdVal.toString().replaceAllMapped(
                                  RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                  (Match m) => '${m[1]},'),
                              style: TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Poppins"),
                            ),
                            Text(
                              " Gal of ",
                              style: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Poppins",
                              ),
                            ),
                            Text(
                              "ULSD",
                              style: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Poppins",
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: widget.height * 0.02,
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: Responsive.isDesktop(context)
                                    ? widget.width * 0.45
                                    : widget.width * 0.32,
                                height: widget.height * 0.055,
                                decoration: BoxDecoration(
                                  color: Color(0Xffed5c62),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Center(
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Poppins"),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Responsive.isDesktop(context)
                                  ? widget.width * 0.06
                                  : 12.0,
                            ),
                            InkWell(
                              onTap: () {
                                playsound();
                                playLocal();
                                trigger();
                                widget.valueChanged(reqSent);
                                print(reqSent);
                                Navigator.pop(context);

                                // setState(() {
                                //   _requested = true;
                                // });
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    title: Text(
                                      'Your Request has been sent!',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 23.0,
                                        height: 1.2,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Poppins",
                                        color: Colors.black,
                                      ),
                                    ),
                                    content: Container(
                                      height: widget.height * 0.25,
                                      child: Column(
                                        children: [
                                          Lottie.asset(
                                            'assets/tick_animation.json',
                                            repeat: false,
                                            onLoaded: (composition) {
                                              _controller.duration =
                                                  Duration(seconds: 1);
                                              playLocal();
                                            },
                                            width: widget.width * 0.22,
                                          ),
                                          SizedBox(
                                            height: widget.height * 0.08,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              width: widget.width * 0.32,
                                              height: widget.height * 0.055,
                                              decoration: BoxDecoration(
                                                color: Color(0Xff5081db),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Back",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 13.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: "Poppins"),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: Responsive.isDesktop(context)
                                    ? widget.width * 0.45
                                    : widget.width * 0.32,
                                height: widget.height * 0.055,
                                decoration: BoxDecoration(
                                  color: Color(0Xff5081db),
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
          },
          child: Padding(
            padding: EdgeInsets.only(
                right:
                    Responsive.isDesktop(context) ? 0.0 : widget.width * 0.1),
            child: Container(
              height: Responsive.isDesktop(context)
                  ? widget.height * 0.06
                  : widget.height * 0.075,
              width: widget.width * 0.75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: isTapped! ? Color(0xFF5081db) : Color(0xFF3d5a89),
              ),
              child: Center(
                child: Text(
                  "Submit All",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Poppins"),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
