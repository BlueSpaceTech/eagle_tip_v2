// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:testttttt/Providers/user_provider.dart';
import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/UI/Widgets/customContainer.dart';
import 'package:testttttt/UI/Widgets/customNav.dart';
import 'package:flutter/cupertino.dart';
// import 'package:cron/cron.dart';
import 'package:intl/intl.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:testttttt/Models/user.dart' as model;
import 'package:testttttt/UI/Widgets/customappheader.dart';
import 'package:testttttt/UI/views/post_auth_screens/Chat/message_model.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

DateTime scheduledDate = DateTime.now();

class CreateNotification extends StatefulWidget {
  CreateNotification({Key? key}) : super(key: key);

  @override
  State<CreateNotification> createState() => _CreateNotificationState();
}

class _CreateNotificationState extends State<CreateNotification> {
  CollectionReference notifys =
      FirebaseFirestore.instance.collection("notifications");
  List<String> _selectedItems = [];

  void _showMultiSelect() async {
    // a list of selectable items
    // these items can be hard-coded or dynamically fetched from a database/API
    final List<String> _items = [
      'All Users',
      'Managers',
      'Site Users',
      'Site Owners',
      'Item 5',
    ];

    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(items: _items);
      },
    );

    // Update UI
    if (results != null) {
      setState(() {
        _selectedItems = results;
      });
    }
  }

  String dropdownvalue = 'All Users';
  // Future<void> main() async {
  //   final cron = Cron();
  //   cron.schedule(
  //       Schedule.parse("*/30 * * * * *"), () => {print("Hi every 30 seconds")});
  // }

  // List of items in our dropdown menu
  var items = [
    'All Users',
    'Managers',
    'Site Users',
    'Site Owners',
    'Item 5',
  ];

  String? title;
  String? link;
  String? description;
  TimeOfDay selectedTime = TimeOfDay.now();
  @override
  Widget build(BuildContext context) {
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

    model.User user = Provider.of<UserProvider>(context).getUser;
    Future<void> writeMessage(String message) async {
      HttpsCallable callable =
          FirebaseFunctions.instance.httpsCallable('setdocument');
      final resp = await callable.call(<String, dynamic>{
        'role': user.userRole,
        "visibleto": _selectedItems,
        "title": title,
        "sites": user.sites,
        "description": description,
        "timenow": "DateTime.now()",
      });
      print("result: ${resp.data}");
    }

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
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
              left: Responsive.isDesktop(context) ? 0.0 : width * 0.03,
              right: Responsive.isDesktop(context) ? 0.0 : width * 0.02,
            ),
            child: Column(
              children: [
                Navbar(
                  width: width,
                  height: height,
                  text1: "Home",
                  text2: "Sites",
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CreateNotifyTextField(
                              valueChanged: ((value) {
                                setState(() {
                                  title = value;
                                });
                              }),
                              labelText: "Title",
                              isactive: true,
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
                        Container(
                          width: width * 0.42,
                          padding: EdgeInsets.only(
                              top: 10.0,
                              left: width * 0.01,
                              right: width * 0.02),
                          height: height * 0.09,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
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
                                child: TextButton(
                                  child: Text(
                                    'Select Your Audience',
                                    style: TextStyle(
                                      color: Color(0xFF6E7191),
                                    ),
                                  ),
                                  onPressed: _showMultiSelect,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        Container(
                          width: width * 0.42,
                          padding: EdgeInsets.only(
                              left: width * 0.01, right: width * 0.06),
                          height: height * 0.35,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: TextFormField(
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
                        SizedBox(
                          height: height * 0.03,
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Schedule",
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
                                      print(scheduledDate);

                                      print('confirm $date');
                                    },
                                        currentTime: DateTime.now(),
                                        locale: LocaleType.en);
                                  },
                                  child: Container(
                                    width: width * 0.13,
                                    height: height * 0.08,
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
                                            fontSize: 16.0,
                                            color: Color(0xFF6E7191),
                                          ),
                                        ),
                                        Text(
                                          DateFormat("dd-MM-yyyy")
                                              .format(scheduledDate),
                                          style: TextStyle(
                                              fontSize: width * 0.01,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Poppins"),
                                        ),
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: width * 0.05,
                            ),
                            Column(
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
                                DaysRow(width: width),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.04,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
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
                                      fontSize: width * 0.008,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Poppins"),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.01,
                            ),
                            InkWell(
                              onTap: () async {
                                print(scheduledDate);
                                // if (description != null ||
                                //     title != null ||
                                //     link != null ||
                                //     _selectedItems.isNotEmpty) {
                                //   notifys.doc().set({
                                //     "description": description,
                                //     "title": title,
                                //     "createdBy": user.employerCode,
                                //     "hyperLink": link,
                                //     "visibleto": _selectedItems,
                                //     "scheduledDateTime": scheduledDate,
                                //   }).catchError((onError) {
                                //     print(onError);
                                //   });
                                // }
                                writeMessage("message");
                                // HttpsCallable callable = FirebaseFunctions
                                //     .instance
                                //     .httpsCallable('setdocument');
                                // await callable.call(<String, dynamic>{
                                //   'time': "15 1 6 3 *",
                                //   'title': title,
                                //   'description': description,
                                //   'visibleto': _selectedItems,
                                //   'role': user.userRole,
                                //   'timenow': DateTime.now(),
                                // });
                              },
                              child: Container(
                                width: width * 0.08,
                                height: height * 0.058,
                                decoration: BoxDecoration(
                                  color: Color(0Xff5081db),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Center(
                                  child: Text(
                                    "Send",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: width * 0.008,
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
                  width: width,
                  topPad: 10.0,
                  height: height * 1.02,
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
    'Managers': 'SiteManager',
    'Site Users': 'SiteUser',
    'Site Owners': 'SiteOwner',
  };
  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems.add(topicConnect[itemValue]!);
        print(topicConnect[itemValue]);
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
      title: const Text('Select Topics'),
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
          child: const Text('Submit'),
          style: ElevatedButton.styleFrom(
            primary: Color(0Xff5081db),
          ),
          onPressed: _submit,
        ),
      ],
    );
  }
}

class DaysRow extends StatelessWidget {
  const DaysRow({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * 0.15,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Day(
            width: width,
            dayname: "S",
          ),
          Day(
            width: width,
            dayname: "M",
          ),
          Day(
            width: width,
            dayname: "T",
          ),
          Day(
            width: width,
            dayname: "W",
          ),
          Day(
            width: width,
            dayname: "T",
          ),
          Day(
            width: width,
            dayname: "F",
          ),
          Day(
            width: width,
            dayname: "S",
          ),
        ],
      ),
    );
  }
}

class Day extends StatefulWidget {
  Day({
    Key? key,
    required this.width,
    required this.dayname,
  }) : super(key: key);

  final double width;
  final String dayname;

  @override
  State<Day> createState() => _DayState();
}

class _DayState extends State<Day> {
  bool? val1 = false;

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
      height: height * 0.06,
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
