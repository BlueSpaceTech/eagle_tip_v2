// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:convert';
// import 'dart:html';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:math';
// import 'package:csv/csv.dart';
// import 'package:instant';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';
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

CollectionReference notifys =
    FirebaseFirestore.instance.collection("9pmNotifys");

class SiteDetails extends StatelessWidget {
  SiteDetails(
      {Key? key,
      // required this.requestSite,
      required this.sitedetail,
      required this.siteid,
      required this.currentSite})
      : super(key: key);
  SitesDetails sitedetail;
  // final String requestSite;
  final String siteid;
  String currentSite;
  @override
  Widget build(BuildContext context) {
    model.User? user = Provider.of<UserProvider>(context).getUser;
    return Responsive(
      mobile: MobileSiteDet(
        sitedetail: sitedetail,
        siteId: siteid,
        currentsite: currentSite,
      ),
      tablet: MobileSiteDet(
        sitedetail: sitedetail,
        currentsite: currentSite,
        siteId: siteid,
      ),
      desktop: MobileSiteDet(
        sitedetail: sitedetail,
        siteId: siteid,
        currentsite: currentSite,
      ),
    );
  }
}

class MobileSiteDet extends StatefulWidget {
  final String? restorationId = "";
  final String siteId;
  MobileSiteDet(
      {Key? key,
      // required this.reqsiteid,
      required this.sitedetail,
      required this.siteId,
      required this.currentsite})
      : super(key: key);
  SitesDetails sitedetail;
  String currentsite;
  // final String reqsiteid;
  // String reqsite;

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
      if (element.siteid == currentsite) {
        setState(() {
          sitedetail = element;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      ShowCaseWidget.of(context)!.startShowCase([key1]);
    });
  }

  final key1 = GlobalKey();

  @override
  Widget build(BuildContext context) {
    model.User? user = Provider.of<UserProvider>(context).getUser;
    final width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Responsive.isDesktop(context) || Responsive.isTablet(context)
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
                        Showcase(
                          key: key1,
                          disposeOnTap: true,
                          onTargetClick: () {
                            Navigator.pop(context);
                          },
                          title: "Order Fuel",
                          description:
                              "You can order fuel by tapping on the tank box",
                          titleTextStyle: TextStyle(
                            fontSize: 17.0,
                            color: Colors.white,
                          ),
                          descTextStyle: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                          shapeBorder: RoundedRectangleBorder(),
                          overlayPadding: EdgeInsets.all(8.0),
                          showcaseBackgroundColor: Color(0xFF5081DB),
                          contentPadding: EdgeInsets.all(8.0),
                          child: Padding(
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
                                                reqsite: widget.siteId,
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
                                              reqsite: widget.siteId,
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
                                          "History",
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
                                child: Showcase(
                                  key: key1,
                                  showArrow: false,
                                  disposeOnTap: true,
                                  onTargetClick: () {
                                    Navigator.pop(context);
                                  },
                                  title: "Order Fuel",
                                  description:
                                      "You can order fuel by tapping on the tank box",
                                  titleTextStyle: TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.white,
                                  ),
                                  descTextStyle: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                  ),
                                  shapeBorder: RoundedRectangleBorder(),
                                  overlayPadding: EdgeInsets.all(8.0),
                                  showcaseBackgroundColor: Color(0xFF5081DB),
                                  contentPadding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Tanks",
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Poppins"),
                                  ),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  "History",
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
                              reqsite: widget.siteId,
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
    required this.reqsite,
  }) : super(key: key);

  final double width;
  final SitesDetails sitedetail;
  final double height;
  final ValueChanged valueChanged;
  final String reqsite;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: width * 0.05, right: width * 0.03, top: height * 0.03),
      child: FuelReqColumn(
        reqSite: reqsite,
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
    required this.reqSite,
  }) : super(key: key);

  final double height;
  final double width;
  final SitesDetails sitedetail;
  final ValueChanged valueChanged;
  final String reqSite;

  @override
  State<FuelReqColumn> createState() => _FuelReqColumnState();
}

class _FuelReqColumnState extends State<FuelReqColumn>
    with TickerProviderStateMixin {
  AnimationController? _controller;
  bool? isTapped = false;
  DateTime datetime = DateTime.now();
  // dateTimeToZone(zone: "EST", datetime: datetime);
  var date = DateFormat('yyyy-MM-dd').format(DateTime.now());
  var time = DateFormat().add_Hms().format(DateTime.now());
  // TimeOfDay selectedtime = TimeOfDay.now();

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
    super.initState();
    _controller = AnimationController(vsync: this);
    fuelvals(widget.sitedetail.products.length);
    fuels(widget.sitedetail.products.length);
    sorttt(tanks);
    sorttt(sortedvals);
    sftpdatasort(sortedvals, widget.sitedetail.products);
    sorttanks();
    // tour();
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
  final key1 = GlobalKey();

  List vals = [];
  List values = [];
  List cons = [];
  List prdnos = [];
  List tankqlr = [];
  void fuels(int len) {
    for (int i = 0; i < len; i++) {
      vals.add("0");
      values.add("0");
      cons.add("0");
      prdnos.add("0");
      tankqlr.add("0");
    }
  }

  List tanks = [];
  List sortedvals = [];
  void fuelvals(int len) {
    for (int i = 0; i < widget.sitedetail.products.length; i++) {
      tanks.add(widget.sitedetail.products[i]["TANK_PRD_DESC"]);
      sortedvals.add(widget.sitedetail.products[i]["TANK_PRD_DESC"]);
    }
    // print(tanks);
    // print(sortedvals);
  }

  void sorttt(List products) {
    for (int i = 0; i < products.length; i++) {
      int index = 0;
      String product = "";
      if (products.contains("REG")) {
        if (products.indexOf("REG") != i) {
          index = products.indexOf("REG");
//     print(index.runtimeType);
          product = products[i];
          products[i] = "REG";
          products[index] = product;
        }
      }
      if (products.contains("REG TANK 1")) {
        if (products.indexOf("REG TANK 1") != i) {
          index = products.indexOf("REG TANK 1");
//     print(index.runtimeType);
          product = products[i];
          products[i] = "REG TANK 1";
          products[index] = product;
        }
      }
      if (products.contains("REG TANK 2")) {
        if (products.indexOf("REG TANK 2") != i) {
          index = products.indexOf("REG TANK 2");
//     print(index.runtimeType);
          product = products[i];
          products[i] = "REG TANK 2";
          products[index] = product;
        }
      }
      if (products.contains("MID")) {
        if (products.indexOf("MID") != i) {
          index = products.indexOf("MID");
//     print(index.runtimeType);
          product = products[i];
          products[i] = "MID";
          products[index] = product;
        }
      }
      if (products.contains("PREM")) {
        if (products.indexOf("PREM") != i) {
          index = products.indexOf("PREM");
//     print(index.runtimeType);
          product = products[i];
          products[i] = "PREM";
          products[index] = product;
        }
      }
      if (products.contains("DYED ULSD")) {
        if (products.indexOf("DYED ULSD") != i) {
          index = products.indexOf("DYED ULSD");
//     print(index.runtimeType);
          product = products[i];
          products[i] = "DYED ULSD";
          products[index] = product;
        }
      }
      if (products.contains("ULSD-15PPM")) {
        if (products.indexOf("ULSD-15PPM") != i) {
          index = products.indexOf("ULSD-15PPM");
//     print(index.runtimeType);
          product = products[i];
          products[i] = "ULSD-15PPM";
          products[index] = product;
        }
      }
      if (products.contains("90 REC")) {
        if (products.indexOf("90 REC") != i) {
          index = products.indexOf("90 REC");
//     print(index.runtimeType);
          product = products[i];
          products[i] = "90 REC";
          products[index] = product;
        }
      }
    }
    // print(tanks);
  }

  String timezone = (DateTime.now().isUtc) ? "Z" : "L";

  String tanktype(String prdno) {
    String? type;
    switch (prdno) {
      case "114":
        type = "ULSD-15PPM";
        break;
      case "132":
        type = "REG";
        break;
      case "131":
        type = "MID";
        break;
      case "133":
        type = "PREM";
        break;
    }
    return type ?? "";
  }

  void sftpdatasort(List sortedprod, List products) {
    // for (int )
    for (int i = 0; i < products.length; i++) {
      for (int j = 0; j < sortedprod.length; j++) {
        if (products[i]["TANK_PRD_DESC"] == sortedprod[j]) {
          cons[j] = products[i]["CONSNO"];
          prdnos[j] = products[i]["PRDNO"];
          tankqlr[j] = products[i]["TNKQLR"];
        }
      }
    }
    //   print(tankqlr);
  }

  List sftpdata(int len) {
    List data = [];
    for (int i = 0; i < len; i++) {
      data.add({
        "Site ID": cons[i],
        "Tank Product": prdnos[i],
        "Tank Qualifier": tankqlr[i],
        // "Tank_PRD_DESC": widget.sitedetail.products[i]["TANK_PRD_DESC"],
        "Timestamp": date + "T" + time + timezone,
        "Inventory gallons": vals[i].toString()
      });
    }
    return data;
  }

  // Future<void> _selectTime(BuildContext context) async {
  //   final TimeOfDay? picked_s = await showTimePicker(
  //       context: context,
  //       initialTime: selectedtime,
  //       builder: (BuildContext context, Widget? child) {
  //         return MediaQuery(
  //           data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
  //           child: child!,
  //         );
  //       });

  //   if (picked_s != null && picked_s != selectedtime) {
  //     setState(() {
  //       selectedtime = picked_s;
  //     });
  //   }
  // }

  // void tour(){
  //   tanks[0]= Showcase(key: key1, child: tanks[0], description: "testing");
  // }

  List backenddata(int len) {
    List data = [];
    for (int i = 0; i < len; i++) {
      data.add({
        "amount": vals[i],
        "tanknumber": tankqlr[i],
        "productName": sortedvals[i],
      });
    }
    return data;
  }

  var val1 = "";
  void sorttanks() {
    for (int i = 0; i < widget.sitedetail.products.length; i++) {
      // print("tank$i");
      for (int j = 0; j < tanks.length; j++) {
        if (widget.sitedetail.products[i]["TANK_PRD_DESC"] == tanks[j]) {
          tanks[j] = Tank(
            productname: widget.sitedetail.products[i]["TANK_PRD_DESC"],
            valueChanged2: (val) {
              // vals.insert(j, val);
              vals[j] = val;
              // values[j] = ({
              //   val.toString(): widget.sitedetail.products[i]["TANK_PRD_DESC"]
              // });
              print(values);
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
            tankType: "Tank:${j + 1} " +
                " Capacity:" +
                widget.sitedetail.products[i]["TANK_SIZE"].replaceAllMapped(
                    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                    (Match m) => '${m[1]},') +
                " Gal",
          );
          break;
        }
      }

      // print(widget.sitedetail.products[i]["TANK_PRD_DESC"]);
    }

    // print(tanks);
  }

  @override
  Widget build(BuildContext context) {
    model.User? user = Provider.of<UserProvider>(context).getUser;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: Responsive.isDesktop(context) || Responsive.isMobile(context)
              ? widget.width * 1.12
              : widget.width * 1.2,
          height: Responsive.isDesktop(context) || Responsive.isTablet(context)
              ? widget.height * 0.3
              : widget.height * 0.35,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [for (int i = 0; i < tanks.length; i++) tanks[i]],
          ),
        ),
        SizedBox(
          height: widget.height * 0.06,
        ),
        // Row(
        //   mainAxisAlignment: Responsive.isDesktop(context)
        //       ? MainAxisAlignment.start
        //       : MainAxisAlignment.center,
        //   children: [
        //     Text(
        //       "Timestamp: " +
        //           date +
        //           " " +
        //           selectedtime
        //               .toString()
        //               .replaceAll("TimeOfDay(", "")
        //               .toString()
        //               .replaceAll(")", "") +
        //           ":00" +
        //           " CST",
        //       style: TextStyle(
        //           fontSize: 14.0,
        //           color: Colors.white,
        //           fontWeight: FontWeight.w400,
        //           fontFamily: "Poppins"),
        //     ),
        //     SizedBox(
        //       width: 40.0,
        //     ),
        //     InkWell(
        //         onTap: () {
        //           _selectTime(context);
        //           print(selectedtime);
        //         },
        //         child: Icon(Icons.edit, color: Colors.white, size: 20.0)),
        //   ],
        // ),
        SizedBox(
          height: widget.height * 0.06,
        ),
        InkWell(
          onTap: () {
            // print(regularVal);
            if (isTapped!) {
              print(sortedvals);
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  title: Text(
                    'Confirmation',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: Responsive.isDesktop(context) ||
                              Responsive.isTablet(context)
                          ? widget.width * 0.05
                          : 23.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Poppins",
                      color: Colors.black,
                    ),
                  ),
                  content: Container(
                    height: Responsive.isDesktop(context) ||
                            Responsive.isTablet(context)
                        ? widget.height * 0.33
                        : widget.height * 0.405,
                    child: Column(
                      children: [
                        Text(
                          "Date/Time for the inventory: " "Timestamp: " +
                              date +
                              " " +
                              time +
                              "L",
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Poppins"),
                        ),
                        SizedBox(
                          height: Responsive.isDesktop(context) ||
                                  Responsive.isTablet(context)
                              ? widget.height * 0.02
                              : widget.height * 0.05,
                        ),
                        Text(
                          "Are you sure you want to request:",
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Poppins"),
                        ),
                        SizedBox(
                          height: Responsive.isDesktop(context) ||
                                  Responsive.isTablet(context)
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
                                // "test",
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
                                sortedvals[i],
                                style: TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Poppins",
                                ),
                              ),
                            ],
                          ),
                        SizedBox(
                          height: Responsive.isDesktop(context) ||
                                  Responsive.isTablet(context)
                              ? widget.height * 0.006
                              : 8.0,
                        ),
                        SizedBox(
                          height: widget.height * 0.02,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: Responsive.isDesktop(context) ? 0.0 : 0.0,
                              right: Responsive.isDesktop(context) ? 0.0 : 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  width: Responsive.isDesktop(context) ||
                                          Responsive.isTablet(context)
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
                              // SizedBox(
                              //   width: Responsive.isDesktop(context)
                              //       ? widget.width * 0.23
                              //       : 12.0,
                              // ),
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
                                      "date": DateTime.now(),
                                      "id":
                                          Random().nextInt(10000000).toString(),
                                      "requestby": user?.name,
                                      "site": widget.reqSite,
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
                                                                        context) ||
                                                                    Responsive
                                                                        .isTablet(
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
                                                      BorderRadius.circular(
                                                          10.0),
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
                                  await notifys.doc("notifs").update({
                                    'sites': FieldValue.arrayUnion(
                                        [user?.currentsite])
                                  });
                                },
                                child: Container(
                                  width: Responsive.isDesktop(context) ||
                                          Responsive.isTablet(context)
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
                right: Responsive.isDesktop(context) ||
                        Responsive.isTablet(context)
                    ? 0.0
                    : widget.width * 0.1),
            child: Container(
              height:
                  Responsive.isDesktop(context) || Responsive.isTablet(context)
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
