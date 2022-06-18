// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:testttttt/Models/sites.dart';
import 'package:testttttt/Providers/user_provider.dart';
import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/Services/site_call.dart';
import 'package:testttttt/UI/Widgets/customContainer.dart';
import 'package:testttttt/UI/Widgets/customNav.dart';
import 'package:flutter/cupertino.dart';
// import 'package:cron/cron.dart';
import 'package:intl/intl.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:testttttt/Models/user.dart' as model;
import 'package:testttttt/UI/Widgets/customappheader.dart';
import 'package:testttttt/UI/Widgets/customtoast.dart';
import 'package:testttttt/UI/views/post_auth_screens/Chat/message_model.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

DateTime scheduledDate = DateTime.now();
DateTime scheduledDate2 = DateTime.now();

class CreateNotification extends StatefulWidget {
  CreateNotification({Key? key}) : super(key: key);

  @override
  State<CreateNotification> createState() => _CreateNotificationState();
}

class _CreateNotificationState extends State<CreateNotification> {
  CollectionReference notifys =
      FirebaseFirestore.instance.collection("notifications");
  List<String> _selectedItems = [];
  List<String> _selectedItems2 = [];

  void _showMultiSelect() async {
    // a list of selectable items
    // these items can be hard-coded or dynamically fetched from a database/API
    List<String> visibleRole(model.User user) {
      switch (user.userRole) {
        case "SiteUser":
          return [];
        case "SiteManager":
          return ['All Users', "SiteUser"];
        case "SiteOwner":
          return ['All Users', "SiteManager", "SiteUser"];
        case "TerminalUser":
          return ['All Users', "SiteOwner, SiteManager", "SiteUser"];
        case "TerminalManager":
          return [
            'All Users',
            "TerminalUser",
            "SiteOwner",
            "SiteManager",
            "SiteUser"
          ];
        case "AppAdmin":
          return [
            'All Users',
            "TerminalManager",
            "TerminalUser",
            "SiteOwner",
            "SiteManager",
            "SiteUser"
          ];
        case "SuperAdmin":
          return [
            'All Users',
            "AppAdmin",
            "TerminalManager",
            "TerminalUser",
            "SiteOwner",
            "SiteManager",
            "SiteUser"
          ];
      }
      return [];
    }

    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        model.User? user = Provider.of<UserProvider>(context).getUser;
        return MultiSelect(items: visibleRole(user!));
      },
    );

    // Update UI
    if (results != null) {
      setState(() {
        _selectedItems = results;
      });
    }
  }

  FToast? fToast;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fToast = FToast();
    getData();
    fToast!.init(context);
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      ShowCaseWidget.of(context)!
          .startShowCase([_key1, _key2, _key3, _key4, _key5, _key6, _key7]);
    });
  }

  List<SitesDetails>? sitedetails;
  List allsitename = [];

  getData() async {
    sitedetails = await SiteCall().getSites();

    for (var document in sitedetails!) {
      allsitename.add(document.sitename);
    }
  }

  final _key1 = GlobalKey();
  final _key2 = GlobalKey();
  final _key3 = GlobalKey();
  final _key4 = GlobalKey();
  final _key5 = GlobalKey();
  final _key6 = GlobalKey();
  final _key7 = GlobalKey();

  String? title;
  String? link;
  String? description;
  TimeOfDay selectedTime = TimeOfDay.now();
  List dates = [];

  List days = [];
  // var scheduledtime;
  List newdates = [];
  List daysname = [];
  newnotifys(List daysofweek, List dates) {
    for (int i = 0; i < dates.length; i++) {
      print(DateFormat('EEEE').format(dates[i]));
      for (int j = 0; j < daysofweek.length; j++) {
        if (DateFormat('EEEE').format(dates[i]) == daysofweek[j]) {
          newdates.add(dates[i]);
        }
      }
    }
    print(newdates);
  }

  @override
  Widget build(BuildContext context) {
    model.User? user = Provider.of<UserProvider>(context).getUser;

    void _showSiteSelect() async {
      final List _items =
          user?.userRole == "AppAdmin" || user?.userRole == "SuperAdmin"
              ? allsitename
              : user!.sites;
      for (var element in _items) {
        element = element.toString().replaceAll(" ", "");
      }

      final List<String>? results = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SiteSelect(items: _items);
        },
      );

      // Update UI
      if (results != null) {
        setState(() {
          _selectedItems2 = results;
        });
      }
    }

    _selectTime(BuildContext context) async {
      final TimeOfDay? timeOfDay = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        initialEntryMode: TimePickerEntryMode.dial,
      );
      if (timeOfDay != null && timeOfDay != selectedTime) {
        setState(() {
          selectedTime = timeOfDay;
        });
      }
    }

    List getDaysInBeteween(DateTime startDate, DateTime endDate) {
      List days = [];
      for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
        days.add(startDate.add(Duration(days: i)));
      }
      return days;
    }

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Responsive.isDesktop(context)
          ? MenuButton(isTapped: false, width: width)
          : SizedBox(),
      body: SingleChildScrollView(
        child: Container(
          height: height * 1.2,
          color: backGround_color,
          child: Padding(
            padding: EdgeInsets.only(
              top: height * 0.02,
              left:
                  Responsive.isDesktop(context) || Responsive.isTablet(context)
                      ? 0.0
                      : width * 0.03,
              right:
                  Responsive.isDesktop(context) || Responsive.isTablet(context)
                      ? 0.0
                      : width * 0.02,
            ),
            child: Column(
              children: [
                Navbar(
                  width: width,
                  height: height,
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                CustomContainer(
                  opacity: 0.2,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: height * 0.01,
                        left: width * 0.02,
                        right: width * 0.02),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: !Responsive.isTablet(context)
                              ? MainAxisAlignment.spaceBetween
                              : MainAxisAlignment.center,
                          children: [
                            Showcase(
                              key: _key1,
                              description:
                                  "Enter the title of the notification and the link(Optional)",
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
                              child: CreateNotifyTextField(
                                valueChanged: ((value) {
                                  setState(() {
                                    title = value;
                                  });
                                }),
                                labelText: "Title",
                                isactive: true,
                              ),
                            ),
                            SizedBox(
                              width: Responsive.isTablet(context) ? 10.0 : 0.0,
                            ),
                            CreateNotifyTextField(
                              valueChanged: ((value) {
                                setState(() {
                                  link = value;
                                });
                              }),
                              labelText: "Link (Optional)",
                              isactive: true,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        Showcase(
                          key: _key2,
                          description:
                              "Select which role you want to send this notification to",
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
                          child: Container(
                            width: width * 0.42,
                            padding: EdgeInsets.only(
                                top: 10.0,
                                left: width * 0.01,
                                right: width * 0.02),
                            height: height * 0.09,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Audience",
                                  style: TextStyle(
                                      color: Color(0xff6e7191),
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w500),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      TextButton(
                                        child: Text(
                                          'Select Your Audience',
                                          style: TextStyle(
                                            color: Color(0xFF6E7191),
                                          ),
                                        ),
                                        onPressed: _showMultiSelect,
                                      ),
                                      Row(
                                        children: [
                                          for (var name in _selectedItems)
                                            Text(
                                              name + " ",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w500),
                                            )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Showcase(
                          key: _key3,
                          description: "Select the sites for the roles",
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
                          child: Container(
                            width: width * 0.42,
                            padding: EdgeInsets.only(
                                top: 10.0,
                                left: width * 0.01,
                                right: width * 0.02),
                            height: height * 0.09,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Sites",
                                  style: TextStyle(
                                      color: Color(0xff6e7191),
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w500),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      TextButton(
                                        child: Text(
                                          'Select Sites',
                                          style: TextStyle(
                                            color: Color(0xFF6E7191),
                                          ),
                                        ),
                                        onPressed: _showSiteSelect,
                                      ),
                                      Row(
                                        children: [
                                          for (var name in _selectedItems2)
                                            Text(
                                              name + " ",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w500),
                                            )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Showcase(
                          key: _key4,
                          description: "Enter the description here",
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
                          child: Container(
                            width: width * 0.42,
                            padding: EdgeInsets.only(
                                left: width * 0.01, right: width * 0.06),
                            height: height * 0.35,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            child: TextFormField(
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              onChanged: ((value) {
                                setState(() {
                                  description = value;
                                });
                              }),
                              textAlign: TextAlign.left,
                              style: TextStyle(fontFamily: "Poppins"),
                              cursorColor: Colors.black12,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: "Message",
                                labelStyle: TextStyle(
                                    color: Color(0xff6e7191),
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Start Date",
                                  style: TextStyle(
                                      fontSize: width * 0.01,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                      fontFamily: "Poppins"),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                InkWell(
                                  onTap: () {
                                    // _selectTime(context);
                                    DatePicker.showDateTimePicker(context,
                                        showTitleActions: true,
                                        minTime: DateTime(2018, 3, 5),
                                        maxTime: DateTime(2019, 6, 7),
                                        onChanged: (date) {
                                      // print('change $date');
                                    }, onConfirm: (date) {
                                      setState(() {
                                        scheduledDate = date;
                                      });
                                      // print(scheduledDate);
                                    },
                                        currentTime: DateTime.now(),
                                        locale: LocaleType.en);
                                  },
                                  child: Showcase(
                                    key: _key5,
                                    description:
                                        "Select the time to schedule the notification",
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
                                    child: Container(
                                      width: width * 0.1,
                                      height: height * 0.07,
                                      padding: EdgeInsets.only(
                                          top: height * 0.01,
                                          left: width * 0.02,
                                          right: width * 0.04),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Hour",
                                            style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13.0,
                                              color: Color(0xFF6E7191),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text(
                                            DateFormat("dd-MM-yyyy")
                                                .format(scheduledDate),
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "Poppins"),
                                          ),
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Container(
                              width: width * 0.15,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "End Date",
                                    style: TextStyle(
                                        fontSize: width * 0.01,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                        fontFamily: "Poppins"),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // _selectTime(context);
                                      DatePicker.showDateTimePicker(context,
                                          showTitleActions: true,
                                          minTime: DateTime(2018, 3, 5),
                                          maxTime: DateTime(2019, 6, 7),
                                          onChanged: (date) {
                                        // print('change $date');
                                      }, onConfirm: (date) {
                                        setState(() {
                                          scheduledDate2 = date;
                                        });
                                        // print(scheduledDate2);
                                        // print(getDaysInBeteween(
                                        //     scheduledDate, scheduledDate2));
                                        days = getDaysInBeteween(
                                            scheduledDate, scheduledDate2);
                                      },
                                          currentTime: DateTime.now(),
                                          locale: LocaleType.en);
                                    },
                                    child: Container(
                                      width: width * 0.1,
                                      height: height * 0.07,
                                      padding: EdgeInsets.only(
                                          top: height * 0.01,
                                          left: width * 0.02,
                                          right: width * 0.04),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Hour",
                                            style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13.0,
                                              color: Color(0xFF6E7191),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text(
                                            DateFormat("dd-MM-yyyy")
                                                .format(scheduledDate),
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "Poppins"),
                                          ),
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Showcase(
                              key: _key6,
                              description:
                                  "You can also schedule the notifications for repetition and press send button to schedule the notification. Tap to continue"
                                  "             ",
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
                              disposeOnTap: true,
                              onTargetClick: () {
                                Navigator.pop(context);
                              },
                              showcaseBackgroundColor: Color(0xFF5081DB),
                              contentPadding: EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Days",
                                    style: TextStyle(
                                        fontSize: width * 0.01,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                        fontFamily: "Poppins"),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  DaysRow(
                                      valueChanged: (val) {
                                        setState(() {
                                          dates = val;
                                        });
                                      },
                                      valueChanged2: (val) {
                                        setState(() {
                                          daysname = val;
                                        });
                                      },
                                      width: width),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.04,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: width * 0.08,
                                height: height * 0.058,
                                decoration: BoxDecoration(
                                  color: Color(0XffED5C62),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Center(
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Poppins"),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.01,
                            ),
                            InkWell(
                              onTap: () async {
                                if (description != null ||
                                    title != null ||
                                    link != null ||
                                    _selectedItems.isNotEmpty) {
                                  notifys.doc().set({
                                    "description": description,
                                    "title": title,
                                    "createdBy": user!.uid,
                                    "hyperLink": link,
                                    "sites": _selectedItems2,
                                    "visibleto": _selectedItems,
                                    "scheduledTime": scheduledDate,
                                    "isNew": [],
                                  });
                                  // print(dates);
                                  if (scheduledDate2 == null) {
                                    if (dates.isNotEmpty) {
                                      for (var date in dates) {
                                        notifys.doc().set({
                                          "description": description,
                                          "title": title,
                                          "createdBy": user.uid,
                                          "hyperLink": link,
                                          "sites": _selectedItems2,
                                          "visibleto": _selectedItems,
                                          "scheduledTime": date,
                                          "isNew": [],
                                        });
                                      }
                                    }
                                  } else {
                                    newnotifys(daysname, days);
                                    if (newdates.isNotEmpty) {
                                      for (var date in newdates) {
                                        notifys.doc().set({
                                          "description": description,
                                          "title": title,
                                          "createdBy": user.uid,
                                          "hyperLink": link,
                                          "sites": _selectedItems2,
                                          "visibleto": _selectedItems,
                                          "scheduledTime": date,
                                          "isNew": [],
                                        });
                                      }
                                    }
                                  }
                                  fToast!.showToast(
                                    child: ToastMessage().show(width, context,
                                        "Notification Scheduled"),
                                    gravity: ToastGravity.BOTTOM,
                                    toastDuration: Duration(seconds: 3),
                                  );
                                  Navigator.pop(context);
                                } else {
                                  fToast!.showToast(
                                    child: ToastMessage().show(
                                        width, context, "There's some error"),
                                    gravity: ToastGravity.BOTTOM,
                                    toastDuration: Duration(seconds: 3),
                                  );
                                }
                                // if ((daysname.isNotEmpty && days.isNotEmpty)) {

                                // }
                                // print(daysname);
                                // print(dates);
                              },
                              child: Container(
                                width: width * 0.08,
                                height: height * 0.058,
                                decoration: BoxDecoration(
                                  color: Color(0xff5081DB),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Center(
                                  child: Text(
                                    "Send",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10.0,
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
                  width: Responsive.isTablet(context) ? width * 0.8 : width,
                  topPad: 10.0,
                  height: height * 1.1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MultiSelect extends StatefulWidget {
  final List<String> items;
  const MultiSelect({Key? key, required this.items}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  // this variable holds the selected items
  final List<String> _selectedItems = [];

// This function is triggered when a checkbox is checked or unchecked
  var topicConnect = {
    'All Users': 'AllUsers',
    'SiteManager': 'SiteManager',
    'SiteUser': 'SiteUser',
    'SiteOwner': 'SiteOwner',
    'TerminalManager': 'TerminalManager',
    'TerminalUser': 'TerminalUser',
  };
  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems.add(topicConnect[itemValue]!);
        // print(topicConnect[itemValue]);
      } else {
        _selectedItems.remove(topicConnect[itemValue]!);
      }
    });
  }

  // this function is called when the Cancel button is pressed
  void _cancel() {
    Navigator.pop(context);
  }

// this function is called when the Submit button is tapped
  void _submit() {
    Navigator.pop(context, _selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Audience'),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items
              .map((item) => CheckboxListTile(
                    value: _selectedItems.contains(topicConnect[item]),
                    title: Text(item),
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (isChecked) => _itemChange(item, isChecked!),
                  ))
              .toList(),
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: _cancel,
        ),
        ElevatedButton(
          child: const Text('Ok'),
          style: ElevatedButton.styleFrom(
            primary: Color(0Xff5081db),
          ),
          onPressed: _submit,
        ),
      ],
    );
  }
}

class SiteSelect extends StatefulWidget {
  final List<dynamic> items;
  const SiteSelect({Key? key, required this.items}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SiteSelectState();
}

class _SiteSelectState extends State<SiteSelect> {
  // this variable holds the selected items
  final List<String> _selectedItems = [];

// This function is triggered when a checkbox is checked or unchecked

  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems.add(itemValue.toString().replaceAll(" ", ""));
        // print(itemValue);
      } else {
        _selectedItems.remove(itemValue.toString().replaceAll(" ", ""));
      }
    });
  }

  // this function is called when the Cancel button is pressed
  void _cancel() {
    Navigator.pop(context);
  }

// this function is called when the Submit button is tapped
  void _submit() {
    // print(_selectedItems);
    Navigator.pop(context, _selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Sites'),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items
              .map((item) => CheckboxListTile(
                    value: _selectedItems
                        .contains(item.toString().replaceAll(" ", "")),
                    title: Text(item),
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (isChecked) => _itemChange(item, isChecked!),
                  ))
              .toList(),
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: _cancel,
        ),
        ElevatedButton(
          child: const Text('Ok'),
          style: ElevatedButton.styleFrom(
            primary: Color(0Xff5081db),
          ),
          onPressed: _submit,
        ),
      ],
    );
  }
}

class DaysRow extends StatefulWidget {
  DaysRow({
    Key? key,
    required this.valueChanged,
    required this.width,
    required this.valueChanged2,
  }) : super(key: key);

  final double width;
  final ValueChanged valueChanged;
  final ValueChanged valueChanged2;

  @override
  State<DaysRow> createState() => _DaysRowState();
}

class _DaysRowState extends State<DaysRow> {
  List days = ["M", "T", "W", "TH", "F", "S", "SU"];

  // List dates = [];
  // List daysss = [];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Responsive.isTablet(context)
          ? widget.width * 0.28
          : widget.width * 0.15,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (var day in days)
            Day(
                valueChanged: (val) {
                  setState(() {
                    widget.valueChanged(val);
                  });
                },
                valueChanged2: (val) {
                  setState(() {
                    widget.valueChanged2(val);
                    // print(val);
                  });
                },
                width: widget.width,
                dayname: day)
        ],
      ),
    );
  }
}

List scheduledDates = [];
List daysss = [];

class Day extends StatefulWidget {
  Day({
    Key? key,
    required this.width,
    required this.dayname,
    required this.valueChanged,
    required this.valueChanged2,
  }) : super(key: key);

  final double width;
  final String dayname;
  final ValueChanged valueChanged;
  final ValueChanged valueChanged2;

  @override
  State<Day> createState() => _DayState();
}

class _DayState extends State<Day> {
  bool? val1 = false;
  List days = ["M", "T", "W", "TH", "F", "S", "SU"];
  Map nextTime = {};
  DateTime currentTime = DateTime.now();
  addnextTime() {
    for (int i = 0; i < days.length; i++) {
      nextTime[DateFormat('EEEE')
          .format(currentTime.add(Duration(days: i + 1)))
          .toString()] = currentTime.add(Duration(days: i + 1));
    }
  }

  // List dayss = [];
  // adddays(){
  //    for (int i = 0; i < days.length; i++) {
  //     dayss.add(DateFormat('EEEE')
  //         .format(currentTime.add(Duration(days: i + 1))));
  //   }
  // }

  Map weekDay = {
    "M": "Monday",
    "T": "Tuesday",
    "W": "Wednesday",
    "TH": "Thursday",
    "F": "Friday",
    "S": "Saturday",
    "SU": "Sunday"
  };

  @override
  void initState() {
    addnextTime();
    // print(nextTime);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.dayname,
          style: TextStyle(
            fontSize: widget.width * 0.01,
            fontWeight: FontWeight.w500,
            color: Colors.white,
            fontFamily: "Poppins",
          ),
        ),
        Theme(
          data: ThemeData(unselectedWidgetColor: Colors.white),
          child: Checkbox(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3.0)),
              value: val1,
              onChanged: (val) {
                setState(() {
                  val1 = val;

                  if (val!) {
                    scheduledDates.add(nextTime["${weekDay[widget.dayname]}"]);
                    // print(scheduledDates);
                    daysss.add(weekDay[widget.dayname]);
                    // print(daysss);
                  } else {
                    scheduledDates
                        .remove(nextTime["${weekDay[widget.dayname]}"]);
                    daysss.remove(weekDay[widget.dayname]);
                    // print(scheduledDates);
                  }
                  // print(scheduledDates);
                  widget.valueChanged(scheduledDates);
                  widget.valueChanged2(daysss);
                });
              }),
        )
      ],
    );
  }
}

class AudienceRow extends StatefulWidget {
  AudienceRow({
    Key? key,
    required this.width,
    required this.name,
  }) : super(key: key);
  final double width;
  final String name;
  @override
  State<AudienceRow> createState() => _AudienceRowState();
}

class _AudienceRowState extends State<AudienceRow> {
  bool? val1 = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            value: val1,
            onChanged: (val) {
              setState(() {
                val1 = val;
              });
            }),
        Text(
          widget.name,
          style: TextStyle(
              fontSize: widget.width * 0.01,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontFamily: "Poppins"),
        ),
      ],
    );
  }
}

class CreateNotifyTextField extends StatefulWidget {
  const CreateNotifyTextField({
    Key? key,
    required this.isactive,
    required this.labelText,
    required this.valueChanged,
  }) : super(key: key);
  final bool? isactive;
  final ValueChanged valueChanged;
  final String labelText;

  @override
  State<CreateNotifyTextField> createState() => _CreateNotifyTextFieldState();
}

class _CreateNotifyTextFieldState extends State<CreateNotifyTextField> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.2,
      padding: EdgeInsets.only(left: width * 0.01, right: width * 0.06),
      height: height * 0.065,
      decoration: BoxDecoration(
        color: widget.isactive!
            ? Colors.white
            : Color(0xffEFF0F6).withOpacity(0.7),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: TextFormField(
        textAlign: TextAlign.left,
        onChanged: (val) {
          widget.valueChanged(val);
        },
        enabled: widget.isactive,
        style: TextStyle(fontFamily: "Poppins"),
        cursorColor: Colors.black12,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: widget.labelText,
          labelStyle: TextStyle(
              color: Color(0xff6e7191),
              fontFamily: "Poppins",
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
