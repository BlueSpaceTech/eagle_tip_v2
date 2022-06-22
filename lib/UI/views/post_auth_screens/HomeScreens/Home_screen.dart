// ignore_for_file: prefer_const_constructors, duplicate_ignore, unused_import, prefer_const_literals_to_create_immutables, avoid_print, deprecated_member_use

import 'dart:async';
import 'dart:convert';
// import 'dart:convert';
import 'dart:html' as html;
import 'package:universal_html/html.dart' as htm1;
import 'dart:typed_data';
import 'package:badges/badges.dart';

import 'package:csv/csv.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
import 'package:testttttt/UI/views/post_auth_screens/CRUD/crudmain.dart';
import 'package:testttttt/UI/views/post_auth_screens/Chat/chatting.dart';
import 'package:testttttt/UI/views/post_auth_screens/Chat/message_main.dart';
import 'package:testttttt/UI/views/post_auth_screens/Notifications/createNotification.dart';
import 'package:testttttt/UI/views/post_auth_screens/Sites/site_details.dart';
import 'package:testttttt/UI/views/post_auth_screens/Sites/sites.dart';
import 'package:testttttt/UI/views/post_auth_screens/Sites/sites_admin.dart';
import 'package:testttttt/UI/views/post_auth_screens/UserProfiles/myprofile.dart';
import 'package:testttttt/Utils/common.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:testttttt/Utils/detectPlatform.dart';
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
      DateTime(DateTime.now().year, DateTime.now().month, 30));
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
        for (int i = 0; i < data.length; i++) {
          row.add(data[i]);
        }
        csvdata.add(row);
        // print(csvdata.length);
      }
      // print(csvdata);
      // print(csvdata.length);
      String csv = ListToCsvConverter().convert(csvdata);
      final bytes = utf8.encode(csv);
      final text = utf8.decode(bytes);
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

  final keyIsFirstLoaded = "is_first_loaded";

  @override
  void initState() {
    super.initState();
    getData();
    addData();
    // showDialogIfFirstLoaded(context);
    checkupdateTC();
    _showDialog1();

    // showupdatedialogue();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      ShowCaseWidget.of(context)!
          .startShowCase([_key1, _key2, _key3, _key4, _key5]);
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

  _showDialog1() async {
    var dbRef = await FirebaseFirestore.instance
        .collection('updates')
        .doc("3WDuJB2PqMU7kot0fn6I")
        .get();
    List visibles = await dbRef.get("isVisible");
    print(visibles);
    if (!visibles.contains(auth.currentUser!.uid + "Web")) {
      WidgetsBinding.instance?.addPostFrameCallback((_) async {
        if (true && PlatformInfo().isWeb()) {
          // await _showDialog1();
          visibles.add(auth.currentUser!.uid + "Web");
          FirebaseFirestore.instance
              .collection("updates")
              .doc("3WDuJB2PqMU7kot0fn6I")
              .update({"isVisible": visibles});
          return showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    width: Responsive.isDesktop(context) ? 400 : 400,
                    height: Responsive.isDesktop(context) ? 300 : 350,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Website Updated",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: "Poppins",
                              fontSize:
                                  Responsive.isDesktop(context) ? 24 : 20),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Some changes have been done in the website. Kindly press on Reload button to see the live changes.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            // decoration: TextDecoration.underline,
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        InkWell(
                            onTap: () {
                              htm1.window.location.reload();
                            },
                            child: CustomSubmitButton(
                              width: 200,
                              title: "Reload",
                            )),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                );
              });
        }
      });
    }
    if (!visibles.contains(auth.currentUser!.uid + "Phone")) {
      WidgetsBinding.instance?.addPostFrameCallback((_) async {
        if (true && PlatformInfo().isAppOS()) {
          // await _showDialog1();
          visibles.add(auth.currentUser!.uid + "Phone");
          FirebaseFirestore.instance
              .collection("updates")
              .doc("3WDuJB2PqMU7kot0fn6I")
              .update({"isVisible": visibles});
          return showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    width: Responsive.isDesktop(context) ? 400 : 300,
                    height: Responsive.isDesktop(context) ? 300 : 300,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "App Updated",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: "Poppins",
                              fontSize:
                                  Responsive.isDesktop(context) ? 24 : 20),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Some changes have been done in the App. Kindly press on Update button to update the app.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            // decoration: TextDecoration.underline,
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              // htm1.window.location.reload();
                            },
                            child: CustomSubmitButton(
                              width: 200,
                              title: "Update",
                            )),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                );
              });
        }
      });
    }
  }

  @override
  void didChangeDependencies() {
    addData();
    super.didChangeDependencies();
    print(Uri.base);
  }

  final _key2 = GlobalKey();
  final _key3 = GlobalKey();
  final _key4 = GlobalKey();
  final _key5 = GlobalKey();
  bool isvisible = true;
  @override
  Widget build(BuildContext context) {
    model.User? user = Provider.of<UserProvider>(context).getUser;
    // Future.delayed(Duration.zero, () => showDialogIfFirstLoaded(context));
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton:
          Responsive.isDesktop(context) || Responsive.isTablet(context)
              ? MenuButton(isTapped: false, width: width)
              : Container(),
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
                child:
                    Responsive.isDesktop(context) ||
                            Responsive.isTablet(context)
                        ? Stack(
                            children: [
                              Opacity(opacity: 0.2, child: WebBg()),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // TermConditions(width, height, showdilog),
                                  Visibility(
                                    visible: Responsive.isDesktop(context) ||
                                        Responsive.isTablet(context),
                                    child: Container(
                                      color: Color(0xFF2B343B),
                                      width: width,
                                      height: height * 0.1,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: Responsive.isDesktop(context)
                                                ? width * 0.42
                                                : width * 0.6,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: width * 0.03,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: ((context) =>
                                                            HomeScreen(
                                                                showdialog:
                                                                    false,
                                                                sites: user
                                                                    .sites)),
                                                      ),
                                                    );
                                                  },
                                                  child: SvgPicture.asset(
                                                    "assets/newLogo.svg",
                                                    width: width * 0.15,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: height * 0.024),
                                                  child: Container(
                                                    width: Responsive.isDesktop(
                                                            context)
                                                        ? width * 0.15
                                                        : width * 0.27,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            Navigator
                                                                .pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: ((context) =>
                                                                    HomeScreen(
                                                                        showdialog:
                                                                            true,
                                                                        sites: user
                                                                            .sites)),
                                                              ),
                                                            );
                                                            setState(() {
                                                              index = 0;
                                                            });
                                                          },
                                                          child: Navtext(
                                                            color: index == 0
                                                                ? Colors.white
                                                                : Color(
                                                                    0xFFA0A3BD),
                                                            width: width,
                                                            text: "Home",
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            Navigator
                                                                .pushReplacementNamed(
                                                                    context,
                                                                    AppRoutes
                                                                        .messagemain);
                                                            setState(() {
                                                              index = 1;
                                                            });
                                                          },
                                                          child: StreamBuilder(
                                                            stream: FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "chats")
                                                                .where(
                                                                    "between",
                                                                    arrayContainsAny: [
                                                                  user.uid
                                                                ]).snapshots(),
                                                            builder: (context,
                                                                AsyncSnapshot<
                                                                        QuerySnapshot>
                                                                    snapshot) {
                                                              if (snapshot
                                                                  .hasData) {
                                                                List docsss =
                                                                    snapshot
                                                                        .data!
                                                                        .docs;
                                                                List docs2 = [];
                                                                for (var ele
                                                                    in docsss) {
                                                                  if (ele["isNew"] !=
                                                                          user
                                                                              .uid &&
                                                                      ele["isNew"] !=
                                                                          "constant") {
                                                                    docs2.add(
                                                                        ele);
                                                                  }
                                                                }

                                                                return Showcase(
                                                                  disposeOnTap:
                                                                      true,
                                                                  onTargetClick:
                                                                      () {
                                                                    Navigator
                                                                        .push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                ShowCaseWidget(
                                                                          builder:
                                                                              Builder(
                                                                            builder: (context) =>
                                                                                MessageMain(
                                                                              Chatscreen: ChatScreenn(
                                                                                photourlfriend: "",
                                                                                photourluser: "",
                                                                                currentusername: "",
                                                                                index: 0,
                                                                                friendname: "Start chat by clicking on user",
                                                                                frienduid: "",
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                  titleTextStyle:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        17.0,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  descTextStyle:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        16.0,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  shapeBorder:
                                                                      CircleBorder(),
                                                                  overlayPadding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              8.0),
                                                                  showcaseBackgroundColor:
                                                                      Color(
                                                                          0xFF5081DB),
                                                                  contentPadding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              8.0),
                                                                  description:
                                                                      "Tap this button to go to chat screen",
                                                                  key: user.userRole ==
                                                                          "SiteUser"
                                                                      ? _key2
                                                                      : user.userRole == "SiteManager" ||
                                                                              user.userRole == "SiteOwner"
                                                                          ? _key5
                                                                          : _key5,
                                                                  child: Badge(
                                                                    showBadge: docs2
                                                                        .isNotEmpty,
                                                                    badgeContent:
                                                                        Text(
                                                                      docs2
                                                                          .length
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                    child:
                                                                        Navtext(
                                                                      color: index == 1
                                                                          ? Colors
                                                                              .white
                                                                          : Color(
                                                                              0xFFA0A3BD),
                                                                      text:
                                                                          "Chat",
                                                                      width:
                                                                          width,
                                                                    ),
                                                                    // );
                                                                    // },
                                                                  ),
                                                                );
                                                              } else {
                                                                //   return
                                                                return Text(
                                                                    "Chat",
                                                                    style: TextStyle(
                                                                        color: index == 2 ? Colors.white : Color(0xFFA0A3BD),
                                                                        // fontSize: Responsive.isDesktop(context) ? width * 0.01 : width * 0.02,
                                                                        fontSize: width * 0.01,
                                                                        fontWeight: FontWeight.w500,
                                                                        fontFamily: "Poppins"));
                                                              }
                                                            },
                                                          ),
                                                        ),
                                                        // ),
                                                        MouseRegion(
                                                          cursor:
                                                              SystemMouseCursors
                                                                  .click,
                                                          child: InkWell(
                                                              onTap: () {
                                                                Navigator.pushReplacementNamed(
                                                                    context,
                                                                    AppRoutes
                                                                        .notifications);
                                                                setState(() {
                                                                  index = 2;
                                                                });
                                                              },
                                                              child:
                                                                  StreamBuilder(
                                                                      stream: FirebaseFirestore
                                                                          .instance
                                                                          .collection(
                                                                              "pushNotifications")
                                                                          .where(
                                                                              "visibleto",
                                                                              arrayContainsAny: [
                                                                            user.userRole
                                                                          ])
                                                                          // .where("isNew", ar: true)
                                                                          .snapshots(),
                                                                      builder: (context,
                                                                          AsyncSnapshot<QuerySnapshot>
                                                                              snapshot) {
                                                                        if (snapshot.connectionState ==
                                                                            ConnectionState.waiting) {
                                                                          return Navtext(
                                                                            color: index == 2
                                                                                ? Colors.white
                                                                                : Color(0xFFA0A3BD),
                                                                            text:
                                                                                "Notifications",
                                                                            width:
                                                                                width,
                                                                          );
                                                                        }

                                                                        if (snapshot
                                                                            .hasData) {
                                                                          final documents =
                                                                              [];
                                                                          final docs = snapshot
                                                                              .data!
                                                                              .docs;
                                                                          if (docs
                                                                              .isNotEmpty) {
                                                                            for (var element
                                                                                in docs) {
                                                                              List notify = element["isNew"];
                                                                              List siites = element["sites"];
                                                                              istrue() {
                                                                                for (int i = 0; i < user.sites.length; i++) {
                                                                                  for (int j = 0; j < siites.length; j++) {
                                                                                    if (user.sites[i] == siites[j]) {
                                                                                      return true;
                                                                                    }
                                                                                  }
                                                                                }
                                                                                return false;
                                                                              }

                                                                              // print(siites);
                                                                              // if(){}
                                                                              if (!notify.contains(FirebaseAuth.instance.currentUser!.uid) && istrue()) {
                                                                                documents.add(element);
                                                                              }
                                                                            }
                                                                          }
                                                                          return Badge(
                                                                            showBadge:
                                                                                documents.isNotEmpty,
                                                                            badgeContent:
                                                                                Text(
                                                                              documents.length.toString(),
                                                                              // "0",
                                                                              style: TextStyle(color: Colors.white),
                                                                            ),
                                                                            child:
                                                                                Navtext(
                                                                              color: index == 2 ? Colors.white : Color(0xFFA0A3BD),
                                                                              text: "Notifications",
                                                                              width: width,
                                                                            ),
                                                                          );
                                                                        }
                                                                        return Navtext(
                                                                          color: index == 2
                                                                              ? Colors.white
                                                                              : Color(0xFFA0A3BD),
                                                                          text:
                                                                              "Notifications",
                                                                          width:
                                                                              width,
                                                                        );
                                                                      })),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: width * 0.07),
                                            child: Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(""),
                                                  SizedBox(
                                                    width: width * 0.02,
                                                  ),
                                                  PopupMenuButton(
                                                    padding: EdgeInsets.only(
                                                        bottom: 500.0),
                                                    onSelected: (value) {
                                                      print(value);
                                                      Navigator.pushNamed(
                                                          context,
                                                          ScreeRoutes[value]);
                                                      // print("hi");
                                                      // print(user.uid);
                                                      // print("hello");
                                                    },
                                                    color: Color(0xFF3f4850),
                                                    child: user.dpurl != ""
                                                        ? CircleAvatar(
                                                            radius: 22,
                                                            backgroundColor:
                                                                backGround_color,
                                                            backgroundImage:
                                                                NetworkImage(
                                                                    user.dpurl),
                                                          )
                                                        : ClipRRect(
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    backGround_color,
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child: Icon(
                                                                Icons.person,
                                                                size: 35,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                    itemBuilder: (context) => [
                                                      PopupMenuItem(
                                                        child: Text(
                                                          "My Profile",
                                                          style: TextStyle(
                                                              fontSize: 13.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  "Poppins"),
                                                        ),
                                                        value: 1,
                                                      ),
                                                      PopupMenuItem(
                                                        child: Text(
                                                          "Settings",
                                                          style: TextStyle(
                                                              fontSize: 13.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  "Poppins"),
                                                        ),
                                                        value: 2,
                                                      ),
                                                      PopupMenuItem(
                                                        child: TextButton(
                                                          onPressed: () {
                                                            showDialog(
                                                              context: context,
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  AlertDialog(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20.0)),
                                                                title: Text(
                                                                  'Request Confirmation',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize: Responsive.isDesktop(
                                                                            context)
                                                                        ? 23.0
                                                                        : 23.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        "Poppins",
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                                content:
                                                                    Container(
                                                                  height: Responsive.isDesktop(
                                                                              context) ||
                                                                          Responsive.isTablet(
                                                                              context)
                                                                      ? height *
                                                                          0.18
                                                                      : height *
                                                                          0.23,
                                                                  child: Column(
                                                                    children: [
                                                                      Text(
                                                                        "Are you sure you want to Logout ?",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                18.0,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            fontFamily: "Poppins"),
                                                                      ),
                                                                      SizedBox(
                                                                        height: Responsive.isDesktop(context) || Responsive.isTablet(context)
                                                                            ? height *
                                                                                0.02
                                                                            : height *
                                                                                0.05,
                                                                      ),
                                                                      SizedBox(
                                                                        height: Responsive.isDesktop(context) || Responsive.isTablet(context)
                                                                            ? height *
                                                                                0.006
                                                                            : 8.0,
                                                                      ),
                                                                      SizedBox(
                                                                        height: height *
                                                                            0.02,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          InkWell(
                                                                            onTap:
                                                                                () {
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              width: Responsive.isDesktop(context) || Responsive.isTablet(context) ? width * 0.1 : width * 0.32,
                                                                              height: height * 0.055,
                                                                              decoration: BoxDecoration(
                                                                                color: Color(0Xffed5c62),
                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                              ),
                                                                              child: Center(
                                                                                child: Text(
                                                                                  "Cancel",
                                                                                  style: TextStyle(color: Colors.white, fontSize: 13.0, fontWeight: FontWeight.w600, fontFamily: "Poppins"),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width: Responsive.isDesktop(context) || Responsive.isTablet(context)
                                                                                ? 15.0
                                                                                : 12.0,
                                                                          ),
                                                                          InkWell(
                                                                            onTap:
                                                                                () async {
                                                                              if (PlatformInfo().isWeb()) {
                                                                                SharedPreferences.getInstance().then((prefs) {
                                                                                  prefs.setBool("remember_me", false);
                                                                                });
                                                                              }
                                                                              AuthFunctions.signOut();
                                                                              Navigator.pushNamed(context, AppRoutes.loginscreen);
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              width: Responsive.isDesktop(context) || Responsive.isTablet(context) ? width * 0.1 : width * 0.32,
                                                                              height: height * 0.055,
                                                                              decoration: BoxDecoration(
                                                                                color: Color(0Xff5081db),
                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                              ),
                                                                              child: Center(
                                                                                child: Text(
                                                                                  "Logout",
                                                                                  style: TextStyle(color: Colors.white, fontSize: 13.0, fontWeight: FontWeight.w600, fontFamily: "Poppins"),
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
                                                          },
                                                          child: Container(
                                                            width: 100,
                                                            child: Text(
                                                              "Logout",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      13.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colors
                                                                      .white,
                                                                  fontFamily:
                                                                      "Poppins"),
                                                            ),
                                                          ),
                                                        ),
                                                        // value: 3,
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.05,
                                  ),
                                  Visibility(
                                    visible: user.userRole != "AppAdmin" &&
                                        user.userRole != "SuperAdmin",
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                              getsiteloc(user.currentsite) ??
                                                  "",
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
                                                  sitedetail: sendsitedetails(
                                                      user.currentsite),
                                                  currentSite:
                                                      user.currentsite)),
                                        );
                                      },
                                      child: Showcase(
                                        key: _key1,
                                        disposeOnTap: true,
                                        onTargetClick: () {
                                          user.userRole == "SiteUser"
                                              ? Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ShowCaseWidget(
                                                      builder: Builder(
                                                          builder: (context) => SiteDetails(
                                                              sitedetail:
                                                                  sendsitedetails(user
                                                                      .currentsite),
                                                              currentSite: user
                                                                  .currentsite)),
                                                    ),
                                                  )).then((_) {
                                                  setState(() {
                                                    ShowCaseWidget.of(context)!
                                                        .startShowCase([
                                                      _key2,
                                                      _key3,
                                                      _key4,
                                                      _key5,
                                                    ]);
                                                  });
                                                })
                                              : Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ShowCaseWidget(
                                                      builder: Builder(
                                                          builder: (context) => SiteDetails(
                                                              sitedetail:
                                                                  sendsitedetails(user
                                                                      .currentsite),
                                                              currentSite: user
                                                                  .currentsite)),
                                                    ),
                                                  )).then((_) {
                                                  setState(() {
                                                    ShowCaseWidget.of(context)!
                                                        .startShowCase([
                                                      _key2,
                                                      _key3,
                                                      _key4,
                                                      _key5,
                                                    ]);
                                                  });
                                                });
                                        },
                                        title: "Submit Inventory",
                                        description:
                                            "Tap on this button to order",
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
                                        showcaseBackgroundColor:
                                            Color(0xFF5081DB),
                                        contentPadding: EdgeInsets.all(8.0),
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Image.asset(
                                              Common.assetImages +
                                                  "Ellipse 49.png",
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
                                        user.userRole == "AppAdmin" ||
                                                user.userRole == "SuperAdmin" ||
                                                user.userRole ==
                                                    "TerminalUser" ||
                                                user.userRole ==
                                                    "TerminalManager"
                                            ? Navigator.pushNamed(context,
                                                AppRoutes.sitescreenadmin)
                                            : Navigator.pushNamed(
                                                context, AppRoutes.siteScreen);
                                      },
                                      child: Showcase(
                                        key: user.userRole == "SiteManager" ||
                                                user.userRole == "SiteOwner"
                                            ? _key2
                                            : _key1,
                                        disposeOnTap: true,
                                        description:
                                            "You can view all your assigned sites here",
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
                                        showcaseBackgroundColor:
                                            Color(0xFF5081DB),
                                        contentPadding: EdgeInsets.all(8.0),
                                        onTargetClick: () {
                                          user.userRole == "AppAdmin" ||
                                                  user.userRole == "SuperAdmin"
                                              ? Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: ((context) =>
                                                          ShowCaseWidget(
                                                            builder: Builder(
                                                                builder:
                                                                    (context) =>
                                                                        SitesAdmin()),
                                                          )))).then((value) {
                                                  setState(() {
                                                    user.userRole ==
                                                                "SiteManager" ||
                                                            user.userRole ==
                                                                "SiteOwner"
                                                        ? ShowCaseWidget.of(
                                                                context)!
                                                            .startShowCase([
                                                            _key3,
                                                            _key4,
                                                            _key5
                                                          ])
                                                        : ShowCaseWidget.of(
                                                                context)!
                                                            .startShowCase([
                                                            _key2,
                                                            _key3,
                                                            _key4,
                                                            _key5
                                                          ]);
                                                  });
                                                })
                                              : Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: ((context) =>
                                                          ShowCaseWidget(
                                                            builder: Builder(
                                                                builder:
                                                                    (context) =>
                                                                        Sites()),
                                                          )))).then((_) {
                                                  setState(() {
                                                    user.userRole ==
                                                                "SiteManager" ||
                                                            user.userRole ==
                                                                "SiteOwner"
                                                        ? ShowCaseWidget.of(
                                                                context)!
                                                            .startShowCase([
                                                            _key3,
                                                            _key4,
                                                            _key5
                                                          ])
                                                        : ShowCaseWidget.of(
                                                                context)!
                                                            .startShowCase([
                                                            _key2,
                                                            _key3,
                                                            _key4,
                                                            _key5
                                                          ]);
                                                  });
                                                });
                                        },
                                        child: SiteContainer(
                                            width: width,
                                            text: "Sites",
                                            height: height),
                                      ),
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
                                            context, AppRoutes.crudscreen);
                                      },
                                      child: Showcase(
                                        key: user.userRole == "SiteManager" ||
                                                user.userRole == "SiteOwner"
                                            ? _key3
                                            : _key2,
                                        description:
                                            "Click this button to go to Users Screen",
                                        disposeOnTap: true,
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
                                        showcaseBackgroundColor:
                                            Color(0xFF5081DB),
                                        contentPadding: EdgeInsets.all(8.0),
                                        onTargetClick: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ShowCaseWidget(
                                                  builder: Builder(
                                                      builder: (context) =>
                                                          CrudScreen()),
                                                ),
                                              )).then((_) {
                                            setState(() {
                                              user.userRole == "SiteManager" ||
                                                      user.userRole ==
                                                          "SiteOwner"
                                                  ? ShowCaseWidget.of(context)!
                                                      .startShowCase(
                                                          [_key4, _key5])
                                                  : ShowCaseWidget.of(context)!
                                                      .startShowCase([
                                                      _key3,
                                                      _key4,
                                                      _key5
                                                    ]);
                                            });
                                          });
                                        },
                                        child: SiteContainer(
                                            width: width,
                                            text: "Edit Users",
                                            height: height),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.02,
                                  ),
                                  Visibility(
                                    visible: user.userRole != "SiteUser",
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(context,
                                            AppRoutes.createNotification);
                                      },
                                      child: Showcase(
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
                                        showcaseBackgroundColor:
                                            Color(0xFF5081DB),
                                        contentPadding: EdgeInsets.all(8.0),
                                        disposeOnTap: true,
                                        onTargetClick: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ShowCaseWidget(
                                                  builder: Builder(
                                                      builder: (context) =>
                                                          CreateNotification()),
                                                ),
                                              )).then((_) {
                                            setState(() {
                                              user.userRole == "SiteManager" ||
                                                      user.userRole ==
                                                          "SiteOwner"
                                                  ? ShowCaseWidget.of(context)!
                                                      .startShowCase([_key5])
                                                  : ShowCaseWidget.of(context)!
                                                      .startShowCase(
                                                          [_key4, _key5]);
                                            });
                                          });
                                        },
                                        key: user.userRole == "SiteManager" ||
                                                user.userRole == "SiteOwner"
                                            ? _key4
                                            : _key3,
                                        description:
                                            "Tap here to go to Create Notifications Screen",
                                        child: SiteContainer(
                                            width: width,
                                            text: "Create Notifications",
                                            height: height),
                                      ),
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
                                      child: Showcase(
                                        key: user.userRole == "SiteManager" ||
                                                user.userRole == "SiteOwner"
                                            ? _key5
                                            : _key4,
                                        description:
                                            "You can download the Inventory Report by pressing this button",
                                        disposeOnTap: true,
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
                                        showcaseBackgroundColor:
                                            Color(0xFF5081DB),
                                        contentPadding: EdgeInsets.all(8.0),
                                        onTargetClick: () {
                                          setState(() {
                                            ShowCaseWidget.of(context)!
                                                .startShowCase([_key5]);
                                          });
                                        },
                                        child: SiteContainer(
                                            width: width,
                                            text: "Create Report",
                                            height: height),
                                      ),
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
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.08),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(""),
                                      Logo(width: width),
                                      Showcase(
                                          key: user.userRole == "SiteManager" ||
                                                  user.userRole == "SiteOwner"
                                              ? _key4
                                              : _key3,
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
                                          showcaseBackgroundColor:
                                              Color(0xFF5081DB),
                                          contentPadding: EdgeInsets.all(8.0),
                                          description:
                                              "You can re-watch the tour here",
                                          child: MenuButton(
                                              isTapped: isTapped,
                                              width: width)),
                                    ],
                                  ),
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
                                              sitedetail: sendsitedetails(
                                                  user.currentsite),
                                            ),
                                          ));
                                    },
                                    child: Showcase(
                                      key: _key1,
                                      disposeOnTap: true,
                                      onTargetClick: () {
                                        user.userRole == "SiteUser"
                                            ? Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ShowCaseWidget(
                                                    builder: Builder(
                                                        builder: (context) => SiteDetails(
                                                            sitedetail:
                                                                sendsitedetails(user
                                                                    .currentsite),
                                                            currentSite: user
                                                                .currentsite)),
                                                  ),
                                                )).then((_) {
                                                setState(() {
                                                  ShowCaseWidget.of(context)!
                                                      .startShowCase([
                                                    _key2,
                                                    _key3,
                                                    _key4,
                                                    _key5,
                                                  ]);
                                                });
                                              })
                                            : Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ShowCaseWidget(
                                                    builder: Builder(
                                                        builder: (context) => SiteDetails(
                                                            sitedetail:
                                                                sendsitedetails(user
                                                                    .currentsite),
                                                            currentSite: user
                                                                .currentsite)),
                                                  ),
                                                )).then((_) {
                                                setState(() {
                                                  ShowCaseWidget.of(context)!
                                                      .startShowCase([
                                                    _key2,
                                                    _key3,
                                                    _key4,
                                                    _key5,
                                                  ]);
                                                });
                                              });
                                      },
                                      title: "Submit Inventory",
                                      description:
                                          "Tap on this button to order",
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
                                      showcaseBackgroundColor:
                                          Color(0xFF5081DB),
                                      contentPadding: EdgeInsets.all(8.0),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Image.asset(
                                            Common.assetImages +
                                                "Ellipse 49.png",
                                            width: width * 0.7,
                                          ),
                                          SizedBox(
                                            width: width * 0.4,
                                            child: Text(
                                              "Submit Inventory",
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
                                ),
                                SizedBox(
                                  height: height * 0.07,
                                ),
                                Visibility(
                                  visible: user.userRole != "SiteUser",
                                  child: InkWell(
                                      onTap: () {
                                        user.userRole == "AppAdmin" ||
                                                user.userRole == "SuperAdmin" ||
                                                user.userRole ==
                                                    "TerminalUser" ||
                                                user.userRole ==
                                                    "TerminalManager"
                                            ? Navigator.pushNamed(context,
                                                AppRoutes.sitescreenadmin)
                                            : Navigator.pushNamed(
                                                context, AppRoutes.siteScreen);
                                      },
                                      child: Showcase(
                                        key: user.userRole == "SiteManager" ||
                                                user.userRole == "SiteOwner"
                                            ? _key2
                                            : _key1,
                                        disposeOnTap: true,
                                        description:
                                            "You can view all your assigned sites here",
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
                                        showcaseBackgroundColor:
                                            Color(0xFF5081DB),
                                        contentPadding: EdgeInsets.all(8.0),
                                        onTargetClick: () {
                                          user.userRole == "AppAdmin" ||
                                                  user.userRole ==
                                                      "SuperAdmin" ||
                                                  user.userRole ==
                                                      "TerminalUser" ||
                                                  user.userRole ==
                                                      "TerminalManager"
                                              ? Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: ((context) =>
                                                          ShowCaseWidget(
                                                            builder: Builder(
                                                                builder:
                                                                    (context) =>
                                                                        SitesAdmin()),
                                                          )))).then((_) {
                                                  setState(() {
                                                    user.userRole ==
                                                                "SiteManager" ||
                                                            user.userRole ==
                                                                "SiteOwner"
                                                        ? ShowCaseWidget.of(
                                                                context)!
                                                            .startShowCase([
                                                            _key3,
                                                            _key4,
                                                            _key5
                                                          ])
                                                        : ShowCaseWidget.of(
                                                                context)!
                                                            .startShowCase([
                                                            _key2,
                                                            _key3,
                                                            _key4,
                                                            _key5
                                                          ]);
                                                  });
                                                })
                                              : Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: ((context) =>
                                                          ShowCaseWidget(
                                                            builder: Builder(
                                                                builder:
                                                                    (context) =>
                                                                        Sites()),
                                                          )))).then((_) {
                                                  setState(() {
                                                    user.userRole ==
                                                                "SiteManager" ||
                                                            user.userRole ==
                                                                "SiteOwner"
                                                        ? ShowCaseWidget.of(
                                                                context)!
                                                            .startShowCase([
                                                            _key3,
                                                            _key4,
                                                            _key5
                                                          ])
                                                        : ShowCaseWidget.of(
                                                                context)!
                                                            .startShowCase([
                                                            _key2,
                                                            _key3,
                                                            _key4,
                                                            _key5
                                                          ]);
                                                  });
                                                });
                                        },
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
                                    child: Showcase(
                                      key: user.userRole == "SiteManager" ||
                                              user.userRole == "SiteOwner"
                                          ? _key3
                                          : _key2,
                                      description:
                                          "Click this button to go to Users Screen",
                                      disposeOnTap: true,
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
                                      showcaseBackgroundColor:
                                          Color(0xFF5081DB),
                                      contentPadding: EdgeInsets.all(8.0),
                                      onTargetClick: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ShowCaseWidget(
                                                builder: Builder(
                                                    builder: (context) =>
                                                        CrudScreen()),
                                              ),
                                            )).then((_) {
                                          setState(() {
                                            user.userRole == "SiteManager" ||
                                                    user.userRole == "SiteOwner"
                                                ? ShowCaseWidget.of(context)!
                                                    .startShowCase(
                                                        [_key4, _key5])
                                                : ShowCaseWidget.of(context)!
                                                    .startShowCase(
                                                        [_key3, _key4, _key5]);
                                          });
                                        });
                                      },
                                      child: SiteContainer(
                                          width: width,
                                          text: "Edit Employees",
                                          height: height),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                Visibility(
                                  visible: (user.userRole == "SuperAdmin" ||
                                          user.userRole == "AppAdmin" ||
                                          user.userRole == "TerminalManager" ||
                                          user.userRole == "TerminalUser") &&
                                      (Responsive.isDesktop(context) ||
                                          Responsive.isTablet(context)),
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
                                          user.userRole == "TerminalUser") &&
                                      (Responsive.isDesktop(context) ||
                                          Responsive.isTablet(context)),
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
