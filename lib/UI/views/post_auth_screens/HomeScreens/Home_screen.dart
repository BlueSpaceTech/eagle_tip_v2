// ignore_for_file: prefer_const_constructors, duplicate_ignore, unused_import, prefer_const_literals_to_create_immutables, avoid_print

import 'dart:async';
import 'dart:convert';
// import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:csv/csv.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:testttttt/Models/sites.dart';
import 'package:testttttt/Providers/user_provider.dart';
import 'package:testttttt/Routes/approutes.dart';
import 'package:intl/intl.dart';
import 'package:testttttt/Services/authentication_helper.dart';
import 'package:testttttt/Services/site_call.dart';
import 'package:testttttt/UI/Widgets/customNav.dart';
import 'package:testttttt/UI/Widgets/custom_webbg.dart';
import 'package:testttttt/UI/Widgets/customappheader.dart';
import 'package:testttttt/UI/Widgets/customsubmitbutton.dart';
import 'package:testttttt/UI/Widgets/logo.dart';
import 'package:testttttt/UI/views/post_auth_screens/Sites/site_details.dart';
import 'package:testttttt/UI/views/post_auth_screens/UserProfiles/myprofile.dart';
import 'package:testttttt/Utils/common.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:firebase_messaging_platform_interface/firebase_messaging_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testttttt/Models/user.dart' as model;
import 'package:provider/provider.dart';

import '../Tanks/tanks_request.dart';

CollectionReference requestss =
    FirebaseFirestore.instance.collection("requesthistory");

List<List<dynamic>> csvdata = <List<dynamic>>[];
List rowHeader = [
  "Name",
  "Site",
  "Order id",
  "Date",
  "Tank 1",
  "Tank 2",
  "Tank 3",
  "Tank 4"
];

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key, required this.showdialog, required this.sites})
      : super(key: key);
  bool showdialog;
  final List sites;
  get restorationId => null;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with RestorationMixin {
  bool? isTapped = false;

  bool isLoading = false;
  List<SitesDetails>? sitedetails;
  List allsitename = [];
  String siteId = "";
  getData() async {
    sitedetails = await SiteCall().getSites() ?? [];
  }

  final _key1 = GlobalKey();

  @override
  String? get restorationId => widget.restorationId;

  final RestorableDateTimeN _startDate = RestorableDateTimeN(
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day));
  final RestorableDateTimeN _endDate = RestorableDateTimeN(
      DateTime(DateTime.now().year, DateTime.now().month, 15));
  late final RestorableRouteFuture<DateTimeRange?>
      _restorableDateRangePickerRouteFuture =
      RestorableRouteFuture<DateTimeRange?>(
    onComplete: _selectDateRange,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator
          .restorablePush(_dateRangePickerRoute, arguments: <String, dynamic>{
        'initialStartDate': _startDate.value?.millisecondsSinceEpoch,
        'initialEndDate': _endDate.value?.millisecondsSinceEpoch,
      });
    },
  );
  List getDaysInBeteween(DateTime startDate, DateTime endDate) {
    List days = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      days.add(
          DateFormat('yyyy-MM-dd').format(startDate.add(Duration(days: i))));
    }
    return days;
  }

  void _selectDateRange(DateTimeRange? newSelectedDate) async {
    if (newSelectedDate != null) {
      setState(() {
        _startDate.value = newSelectedDate.start;
        _endDate.value = newSelectedDate.end;
      });
      List days = getDaysInBeteween(_startDate.value!, _endDate.value!);
      print(days);

      if (csvdata.isEmpty) {
        csvdata.add(rowHeader);
      }
      // print(csvdata);
      final docss = await requestss.get().then(
            (value) => value.docs.where(
              (element) => (days.contains(DateFormat('yyyy-MM-dd')
                      .format(element["date"].toDate())) &&
                  widget.sites.contains(element["site"])),
            ),
          );

      print(docss.length);
      for (var element in docss) {
        List row = [];
        List data = element.get("data");
        // print(DateFormat('yyyy-MM-dd').format(element["date"].toDate()));
        row.add(element.get("requestby"));
        row.add(element.get("site"));
        row.add(element.get("id"));
        row.add(element.get("date").toDate());
        row.add(data[0]);
        row.add(data[1]);
        row.add(data[2]);
        row.add(data[3]);
        csvdata.add(row);
        // print(csvdata.length);
      }
      // print(csvdata);
      // print(csvdata.length);
      String csv = ListToCsvConverter().convert(csvdata);
      final bytes = utf8.encode(csv);
      final text = utf8.decode(bytes);
      // final blob = Blob([text]);
      final blob = html.Blob([text]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      html.AnchorElement(href: url)
        ..setAttribute("download", "file.csv")
        ..click();
      csvdata.clear();
    }
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_startDate, 'start_date');
    registerForRestoration(_endDate, 'end_date');
    registerForRestoration(
        _restorableDateRangePickerRouteFuture, 'date_picker_route_future');
  }

  static Route<DateTimeRange?> _dateRangePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTimeRange?>(
      context: context,
      builder: (BuildContext context) {
        return DateRangePickerDialog(
          restorationId: 'date_picker_dialog',
          initialDateRange:
              _initialDateTimeRange(arguments! as Map<dynamic, dynamic>),
          firstDate: DateTime(DateTime.now().year, 1),
          currentDate: DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day),
          lastDate: DateTime(DateTime.now().year, 12, 30),
        );
      },
    );
  }

  static DateTimeRange? _initialDateTimeRange(Map<dynamic, dynamic> arguments) {
    if (arguments['initialStartDate'] != null &&
        arguments['initialEndDate'] != null) {
      return DateTimeRange(
        start: DateTime.fromMillisecondsSinceEpoch(
            arguments['initialStartDate'] as int),
        end: DateTime.fromMillisecondsSinceEpoch(
            arguments['initialEndDate'] as int),
      );
    }

    return null;
  }

  @override
  void initState() {
    super.initState();
    getData();
    addData();
    checkupdateTC();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      ShowCaseWidget.of(context)!.startShowCase([_key1, key2]);
    });
  }

  List? check;
  final key2 = GlobalKey();

  getsiteID(String currentsite) {
    String siteID = "";
    for (var element in sitedetails ?? []) {
      if (element.sitename == currentsite) {
        setState(() {
          siteID = element.siteid;
        });
      }
    }
    return siteID;
  }

  getsiteloc(String currentsite) {
    String siteloc = "";
    for (var element in sitedetails ?? []) {
      if (element.sitename == currentsite) {
        setState(() {
          siteloc = element.sitelocation;
        });
      }
    }
    return siteloc;
  }

  sendsitedetails(String currentsite) {
    SitesDetails? sitedetail;
    for (var element in sitedetails ?? []) {
      if (element.sitename == currentsite) {
        sitedetail = element;
      }
    }
    return sitedetail;
  }

  DocumentReference dialog = FirebaseFirestore.instance
      .collection('termconditions')
      .doc("k5c1eJ3DFh3P9IO7HEAA")
      .collection("dialog")
      .doc("yFXxdJGVDUkgU8o8hCUU");
  // bool showdilog = false;
  final FirebaseAuth auth = FirebaseAuth.instance;
  checkupdateTC() async {
    // print("inside");
    if (widget.showdialog) {
      DocumentReference dbRef = await FirebaseFirestore.instance
          .collection('termconditions')
          .doc("k5c1eJ3DFh3P9IO7HEAA")
          .collection("dialog")
          .doc("yFXxdJGVDUkgU8o8hCUU");
      // print("inside2");

      await dbRef.get().then((data) {
        if (data.exists) {
          setState(() {
            check = data.get("viewedby");
          });
          print("dataexts");

          if (check!.contains(auth.currentUser!.uid)) {
            // print("already viewed");
          } else {
            WidgetsBinding.instance?.addPostFrameCallback((_) async {
              if (true) {
                await _showDialog();
              }
            });
          }
        }
      });
    } else {
      print("no need to show diloag");
    }

    // return showdilogg;
  }

  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  _showDialog() {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              padding: EdgeInsets.all(20),
              width: Responsive.isDesktop(context) ? 600 : 400,
              height: Responsive.isDesktop(context) ? 350 : 350,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                          onTap: () {
                            AuthFunctions.signOut();
                            Navigator.pushNamed(context, AppRoutes.loginscreen);
                          },
                          child: Icon(Icons.close)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Terms and conditions Updated",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: "Poppins",
                            fontSize: Responsive.isDesktop(context) ? 24 : 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "use the link below to view updated Terms and Conditions. Once you have read the content, acknowledge you understand and agree by clicking the ${"agree"} button.",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: Responsive.isDesktop(context) ? 18 : 13,
                            fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.displayTerms);
                          },
                          child: Text(
                            "https://link-of-terms&conditions",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff5081DB),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ]),
                  SizedBox(
                    height: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () {
                            check!.add(auth.currentUser!.uid);
                            print(check);
                            dialog.update({"viewedby": check}).then(
                                (value) => Navigator.pop(context));
                          },
                          child:
                              CustomSubmitButton(width: 1000, title: "Agree")),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  void didChangeDependencies() {
    addData();
    super.didChangeDependencies();
    print(Uri.base);
  }

  final _key2 = GlobalKey();

  @override
  Widget build(BuildContext context) {
    model.User? user = Provider.of<UserProvider>(context).getUser;

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton:
          Responsive.isDesktop(context) || Responsive.isTablet(context)
              ? Showcase(
                  key: _key2,
                  description: "test",
                  child: MenuButton(isTapped: false, width: width))
              : SizedBox(),
      body: user == null
          ? Container(
              height: height,
              color: backGround_color,
              width: width,
              child: Center(child: CircularProgressIndicator()))
          : SingleChildScrollView(
              child: Container(
                height: Responsive.isDesktop(context) ||
                        Responsive.isTablet(context)
                    ? height
                    : height * 1.5,
                color: backGround_color,
                child: Responsive.isDesktop(context) ||
                        Responsive.isTablet(context)
                    ? Stack(
                        children: [
                          Opacity(opacity: 0.2, child: WebBg()),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // TermConditions(width, height, showdilog),
                              Navbar(
                                width: width,
                                height: height,
                              ),
                              SizedBox(
                                height: height * 0.05,
                              ),
                              Visibility(
                                visible: user.userRole != "AppAdmin" &&
                                    user.userRole != "SuperAdmin",
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {},
                                          child: Text(
                                            user.currentsite,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17.0,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "Poppins"),
                                          ),
                                        ),
                                        Text(
                                          getsiteloc(user.currentsite) ?? "",
                                          style: TextStyle(
                                              color: Color(0xFF6E7191),
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "Poppins"),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 30.0,
                                    ),
                                    Text(
                                      getsiteID(user.currentsite) ?? "",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Poppins"),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: height * 0.05,
                              ),
                              Showcase(
                                key: _key1,
                                disposeOnTap: true,
                                onTargetClick: () {
                                  user.userRole == "SiteUser"
                                      ? Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ShowCaseWidget(
                                              builder: Builder(
                                                  builder: (context) =>
                                                      SiteDetails(
                                                          sitedetail:
                                                              sendsitedetails(user
                                                                  .currentsite),
                                                          currentSite: user
                                                              .currentsite)),
                                            ),
                                          ))
                                      : Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ShowCaseWidget(
                                              builder: Builder(
                                                  builder: (context) =>
                                                      SiteDetails(
                                                          sitedetail:
                                                              sendsitedetails(user
                                                                  .currentsite),
                                                          currentSite: user
                                                              .currentsite)),
                                            ),
                                          )).then((_) {
                                          setState(() {
                                            ShowCaseWidget.of(context)!
                                                .startShowCase([key2, _key2]);
                                          });
                                        });
                                },
                                title: "Submit Inventory",
                                description: "Tap on this button to order",
                                titleTextStyle: TextStyle(
                                  fontSize: 17.0,
                                  color: Colors.white,
                                ),
                                descTextStyle: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.white,
                                ),
                                shapeBorder: CircleBorder(),
                                overlayPadding: EdgeInsets.all(8.0),
                                showcaseBackgroundColor: Color(0xFF5081DB),
                                contentPadding: EdgeInsets.all(8.0),
                                child: Visibility(
                                  visible: user.userRole == "SiteOwner" ||
                                      user.userRole == "SiteManager" ||
                                      user.userRole == "SiteUser",
                                  child: InkWell(
                                    onTap: () {},
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Image.asset(
                                          Common.assetImages + "Ellipse 49.png",
                                          width: width * 0.16,
                                        ),
                                        SizedBox(
                                          width: width * 0.08,
                                          child: Text(
                                            "Submit Inventory",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: width * 0.0135,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                                fontFamily: "Poppins"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.07,
                              ),
                              Visibility(
                                visible: user.userRole != "SiteUser",
                                child: InkWell(
                                    onTap: () {
                                      // user.userRole == "AppAdmin" ||
                                      //         user.userRole == "SuperAdmin"
                                      //     ? Navigator.pushNamed(context,
                                      //         AppRoutes.sitescreenadmin)
                                      //     : Navigator.pushNamed(
                                      //         context, AppRoutes.siteScreen);
                                    },
                                    child: Showcase(
                                      key: key2,
                                      description: "test1",
                                      child: SiteContainer(
                                          width: width,
                                          text: "Sites",
                                          height: height),
                                    )),
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Visibility(
                                visible: user.userRole != "SiteUser",
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, AppRoutes.crudscreen);
                                  },
                                  child: SiteContainer(
                                      width: width,
                                      text: "Edit Employees",
                                      height: height),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Visibility(
                                visible: user.userRole != "SiteUser",
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, AppRoutes.createNotification);
                                  },
                                  child: SiteContainer(
                                      width: width,
                                      text: "Create Notifications",
                                      height: height),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Visibility(
                                visible: user.userRole == "SuperAdmin" ||
                                    user.userRole == "AppAdmin" ||
                                    user.userRole == "TerminalManager" ||
                                    user.userRole == "TerminalUser",
                                child: InkWell(
                                  onTap: () {
                                    _restorableDateRangePickerRouteFuture
                                        .present();
                                  },
                                  child: SiteContainer(
                                      width: width,
                                      text: "Create Report",
                                      height: height),
                                ),
                              ),
                            ],
                          ),
                          /*
                    Positioned(
                      bottom: height * 0.02,
                      right: width * 0.03,
                      child:
                          MenuButton(isTapped: !isTapped!, width: width * 0.34),
                    ),
                    */
                        ],
                      )
                    : Padding(
                        padding: EdgeInsets.only(top: height * 0.1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomAppheader(width: width),
                            SizedBox(
                              height: height * 0.05,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {},
                                      child: Text(
                                        user.currentsite,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "Poppins"),
                                      ),
                                    ),
                                    Text(
                                      getsiteloc(user.currentsite) ?? "",
                                      style: TextStyle(
                                          color: Color(0xFF6E7191),
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Poppins"),
                                    ),
                                  ],
                                ),
                                Text(
                                  getsiteID(user.currentsite) ?? "",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Poppins"),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.05,
                            ),
                            Visibility(
                              visible: user.userRole == "SiteOwner" ||
                                  user.userRole == "SiteManager" ||
                                  user.userRole == "SiteUser",
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SiteDetails(
                                          currentSite: user.currentsite,
                                          sitedetail:
                                              sendsitedetails(user.currentsite),
                                        ),
                                      ));
                                },
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image.asset(
                                      Common.assetImages + "Ellipse 49.png",
                                      width: width * 0.7,
                                    ),
                                    SizedBox(
                                      width: width * 0.4,
                                      child: Text(
                                        "Submit   Inventories",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 34.0,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                            fontFamily: "Poppins"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.07,
                            ),
                            Visibility(
                              visible: user.userRole != "SiteUser",
                              child: InkWell(
                                  onTap: () {
                                    user.userRole == "AppAdmin" ||
                                            user.userRole == "SuperAdmin"
                                        ? Navigator.pushNamed(
                                            context, AppRoutes.sitescreenadmin)
                                        : Navigator.pushNamed(
                                            context, AppRoutes.siteScreen);
                                  },
                                  child: SiteContainer(
                                      width: width,
                                      text: "Sites",
                                      height: height)),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Visibility(
                              visible: user.userRole != "SiteUser",
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.crudscreen);
                                },
                                child: SiteContainer(
                                    width: width,
                                    text: "Edit Employees",
                                    height: height),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Visibility(
                              visible: user.userRole != "SiteUser",
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.notifications);
                                },
                                child: SiteContainer(
                                    width: width,
                                    text: "Create Notifications",
                                    height: height),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Visibility(
                              visible: (user.userRole == "SuperAdmin" ||
                                  user.userRole == "AppAdmin" ||
                                  user.userRole == "TerminalManager" ||
                                  user.userRole == "TerminalUser"),
                              child: InkWell(
                                onTap: () {},
                                child: SiteContainer(
                                    width: width,
                                    text: "Create Report",
                                    height: height),
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

class SiteNameAndLocation extends StatelessWidget {
  const SiteNameAndLocation({
    Key? key,
    required this.fontSize,
    required this.fontSize2,
    required this.currentsitename,
    required this.currensitelocation,
  }) : super(key: key);

  final double fontSize;
  final double fontSize2;
  final String currentsitename;
  final String currensitelocation;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {},
          child: Text(
            currentsitename,
            style: TextStyle(
                color: Colors.white,
                fontSize: 17.0,
                fontWeight: FontWeight.w400,
                fontFamily: "Poppins"),
          ),
        ),
        Text(
          currensitelocation,
          style: TextStyle(
              color: Color(0xFF6E7191),
              fontSize: 13.0,
              fontWeight: FontWeight.w500,
              fontFamily: "Poppins"),
        ),
      ],
    );
  }
}

class SiteContainer extends StatelessWidget {
  const SiteContainer({
    Key? key,
    required this.width,
    required this.text,
    required this.height,
  }) : super(key: key);

  final double width;
  final String text;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.isDesktop(context) || Responsive.isTablet(context)
          ? width * 0.25
          : width * 0.72,
      height: height * 0.062,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
            Responsive.isDesktop(context) || Responsive.isTablet(context)
                ? 14.0
                : 16.0),
        color: Color(0xFF5081DB),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              fontSize: 17.0,
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontFamily: "Poppins"),
        ),
      ),
    );
  }
}
