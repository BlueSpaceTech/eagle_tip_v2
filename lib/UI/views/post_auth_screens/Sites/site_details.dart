// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:convert';
// import 'dart:html';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:math';
// import 'package:csv/csv.dart';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:testttttt/Models/sites.dart';
import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/Services/site_call.dart';
import 'package:testttttt/UI/Widgets/customHeader2.dart';
import 'package:testttttt/UI/Widgets/customNav.dart';
import 'package:testttttt/UI/Widgets/custom_webbg.dart';
import 'package:testttttt/UI/Widgets/customappheader.dart';
// import 'package:testttttt/UI/Widgets/customfab.dart';
import 'package:testttttt/UI/views/post_auth_screens/HomeScreens/Home_screen.dart';
import 'package:testttttt/UI/views/post_auth_screens/HomeScreens/bottomNav.dart';
import 'package:testttttt/UI/views/post_auth_screens/Request%20History/request_history.dart';
import 'package:testttttt/UI/views/post_auth_screens/Tanks/tanks_request.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:lottie/lottie.dart';
import 'package:testttttt/Utils/common.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:testttttt/Models/user.dart' as model;
import '../../../../Providers/user_provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class SiteDetails extends StatelessWidget {
  SiteDetails({Key? key, required this.sitedetail, required this.currentSite})
      : super(key: key);
  SitesDetails sitedetail;
  String currentSite;
  @override
  Widget build(BuildContext context) {
    model.User? user = Provider.of<UserProvider>(context).getUser;
    return Responsive(
      mobile: MobileSiteDet(
        sitedetail: sitedetail,
        currentsite: currentSite,
      ),
      tablet: MobileSiteDet(
        sitedetail: sitedetail,
        currentsite: currentSite,
      ),
      desktop: MobileSiteDet(
        sitedetail: sitedetail,
        currentsite: currentSite,
      ),
    );
  }
}

class MobileSiteDet extends StatefulWidget {
  final String? restorationId = "";

  MobileSiteDet({Key? key, required this.sitedetail, required this.currentsite})
      : super(key: key);
  SitesDetails sitedetail;
  String currentsite;

  @override
  State<MobileSiteDet> createState() => _MobileSiteDetState();
}

class _MobileSiteDetState extends State<MobileSiteDet> {
  bool? reqSent = false;
  List<SitesDetails>? sitedetails;
  List allsitename = [];
  String siteId = "";
  SitesDetails? sitedetail;
  getData(String currentsite) async {
    sitedetails = await SiteCall().getSites() ?? [];
    for (var element in sitedetails ?? []) {
      if (element.sitename == currentsite) {
        setState(() {
          sitedetail = element;
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    // getData(widget.currentsite);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    model.User? user = Provider.of<UserProvider>(context).getUser;
    final width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Responsive.isDesktop(context)
        ? Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.startFloat,
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
                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {},
                                      child: Text(
                                        widget.sitedetail.sitename,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "Poppins"),
                                      ),
                                    ),
                                    Text(
                                      widget.sitedetail.sitelocation,
                                      style: TextStyle(
                                          color: Color(0xFF6E7191),
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Poppins"),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: width * 0.1,
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
                                    user?.userRole == "SiteUser"
                                        ? Center(
                                            child: FuelRequestPart(
                                              sitedetail: widget.sitedetail,
                                              valueChanged: (val) {
                                                setState(() {
                                                  reqSent = val;
                                                });
                                              },
                                              width: width * 0.23,
                                              height: height,
                                            ),
                                          )
                                        : FuelRequestPart(
                                            sitedetail: widget.sitedetail,
                                            valueChanged: (val) {
                                              setState(() {
                                                reqSent = val;
                                              });
                                            },
                                            width: width * 0.23,
                                            height: height,
                                          ),
                                  ],
                                ),
                                SizedBox(
                                  width: width * 0.05,
                                ),
                                Visibility(
                                  visible: user?.userRole != "SiteUser",
                                  child: VerticalDivider(
                                    color: Colors.white,
                                    thickness: 1.0,
                                    endIndent: 100,
                                    indent: 1,
                                  ),
                                ),
                                Visibility(
                                  visible: user?.userRole != "SiteUser",
                                  child: SizedBox(
                                    width: width * 0.05,
                                  ),
                                ),
                                Visibility(
                                  visible: user?.userRole != "SiteUser",
                                  child: Column(
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
                                        currentSite: widget.currentsite,
                                        width: width * 0.65,
                                        height: height * 0.9,
                                      ),
                                    ],
                                  ),
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
                        widget.sitedetail.sitename,
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
                        widget.sitedetail.sitelocation,
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
                              sitedetail: widget.sitedetail,
                              valueChanged: (val) {
                                setState(() {
                                  reqSent = val;
                                });
                              },
                              width: width,
                              height: height,
                            ),
                            Visibility(
                              visible: user?.userRole != "SiteUser",
                              child: RequestHistoryPart(
                                currentSite: widget.currentsite,
                                width: width,
                                height: height,
                              ),
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
    required this.valueChanged,
    required this.sitedetail,
  }) : super(key: key);

  final double width;
  final SitesDetails sitedetail;
  final double height;
  final ValueChanged valueChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: width * 0.05, right: width * 0.03, top: height * 0.03),
      child: FuelReqColumn(
        sitedetail: sitedetail,
        valueChanged: (val) {
          valueChanged(val);
        },
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
    required this.currentSite,
  }) : super(key: key);

  final double width;
  final double height;
  final String currentSite;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: width * 0.04, right: width * 0.04, top: height * 0.03),
      child: Requests(
        height: height,
        currentSite: currentSite,
        width: width,
      ),
    );
  }
}

class FuelReqColumn extends StatefulWidget {
  FuelReqColumn({
    Key? key,
    required this.height,
    required this.width,
    required this.sitedetail,
    required this.valueChanged,
  }) : super(key: key);

  final double height;
  final double width;
  final SitesDetails sitedetail;
  final ValueChanged valueChanged;

  @override
  State<FuelReqColumn> createState() => _FuelReqColumnState();
}

class _FuelReqColumnState extends State<FuelReqColumn>
    with TickerProviderStateMixin {
  AnimationController? _controller;
  bool? isTapped = false;
  var date = DateFormat('yyyy-MM-dd').format(DateTime.now().toUtc());
  var time = DateFormat().add_Hms().format(DateTime.now());

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

  // void playsound() {
  //   final player = AudioCache();
  //   player.play('pop-sound.mp3');
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.sitedetail.products);
    _controller = AnimationController(vsync: this);
    fuelvals(widget.sitedetail.products.length);
  }

  // sendsitedetails(String currentsite) {
  //   SitesDetails? sitedetail;
  //   sitedetails!.forEach((element) {
  //     if (element.sitename == currentsite) {
  //       sitedetail = element;
  //     }
  //   });
  //   return sitedetail;
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller!.dispose();
  }

  String? fuelVal = "0";

  List vals = [];
  void fuelvals(int len) {
    for (int i = 0; i < len; i++) {
      vals.add("0");
    }
    // return vals;
  }

  String timezone = (DateTime.now().isUtc) ? "Z" : "L";

  String tanktype(int max) {
    String? type;
    switch (max) {
      case 6000:
        type = "Regular";
        break;
      case 9684:
        type = "Midgrade";
        break;
      case 12000:
        type = "Premium";
        break;
      case 20000:
        type = "ULSD";
        break;
    }
    return type!;
  }

  List sftpdata(int len) {
    List data = [];
    for (int i = 0; i < len; i++) {
      data.add({
        "Site ID": widget.sitedetail.products[i]["CONSNO"],
        "Tank Product": widget.sitedetail.products[i]["PRDNO"],
        "Tank Quality": i + 1,
        "Timestamp": date + "T" + time + timezone,
        "Inventory gallons": vals[i].toString()
      });
    }
    return data;
  }

  List backenddata(int len) {
    List data = [];
    for (int i = 0; i < len; i++) {
      data.add({
        "amount": vals[i],
        "tanknumber": i + 1,
        "tankid": widget.sitedetail.products[i]["PRDNO"],
      });
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    model.User? user = Provider.of<UserProvider>(context).getUser;
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
              for (int i = 0; i < widget.sitedetail.products.length; i++)
                Tank(
                  valueChanged2: (val) {
                    setState(() {
                      vals[i] = val;
                    });
                    // print(val);
                    print(vals[i]);
                  },
                  tankNumber: int.parse(widget.sitedetail.products[i]["PRDNO"]),
                  valueChanged: (val) {
                    setState(() {
                      isTapped = val;
                    });
                  },
                  width: widget.width,
                  max: int.parse(widget.sitedetail.products[i]["TANK_SIZE"]),
                  height: widget.height,
                  tankType: "Tank: " +
                      widget.sitedetail.products[i]["PRDNO"] +
                      " Max " +
                      widget.sitedetail.products[i]["TANK_SIZE"],
                ),
            ],
          ),
        ),
        SizedBox(
          height: widget.height * 0.06,
        ),
        InkWell(
          onTap: () {
            // print(regularVal);
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
                        for (var i = 0;
                            i < widget.sitedetail.products.length;
                            i++)
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
                                vals[i].toString().replaceAllMapped(
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
                                widget.sitedetail.products[i]["PRDNO"],
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
                              onTap: () async {
                                await http.post(
                                  Uri.parse(
                                      "https://aa4f9r6r3m.execute-api.us-east-1.amazonaws.com/default/inventory_requests"),
                                  headers: <String, String>{
                                    'x-api-key':
                                        'xTBUwqVQCjCroKgTTYxp4Ec5PheG1FAKu2viC100',
                                  },
                                  body: jsonEncode(sftpdata(
                                      widget.sitedetail.products.length)),
                                );
                                widget.valueChanged(reqSent);
                                print(reqSent);
                                Navigator.pop(context);
                                requests.doc().set(
                                  {
                                    "data": backenddata(
                                        widget.sitedetail.products.length),
                                    "date": DateTime(
                                        DateTime.now().year,
                                        DateTime.now().month,
                                        DateTime.now().day),
                                    "id": Random().nextInt(10000000).toString(),
                                    "requestby": user?.name,
                                    "site": user?.currentsite,
                                  },
                                );

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
                                              _controller!.duration =
                                                  Duration(seconds: 1);
                                              playLocal();
                                              Vibrate.vibrate();
                                            },
                                            width: widget.width * 0.22,
                                          ),
                                          SizedBox(
                                            height: widget.height * 0.08,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Responsive.isDesktop(
                                                                  context)
                                                              ? HomeScreen(
                                                                  showdialog:
                                                                      false,
                                                                  sites: user!
                                                                      .sites,
                                                                )
                                                              : BottomNav()));
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
