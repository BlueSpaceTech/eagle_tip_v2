// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_import

import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/UI/Widgets/customContainer.dart';
import 'package:testttttt/UI/Widgets/customNav.dart';
import 'package:flutter/cupertino.dart';
// import 'package:cron/cron.dart';

import 'package:testttttt/UI/Widgets/customappheader.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class CreateNotification extends StatefulWidget {
  CreateNotification({Key? key}) : super(key: key);

  @override
  State<CreateNotification> createState() => _CreateNotificationState();
}

class _CreateNotificationState extends State<CreateNotification> {
  String dropdownvalue = 'All Users';
  // Future<void> main() async {
  //   final cron = Cron();
  //   cron.schedule(
  //       Schedule.parse("*/30 * * * * *"), () => {print("Hi every 30 seconds")});
  // }

  // List of items in our dropdown menu
  var items = [
    'All Users',
    "Managers",
    'Item 3',
    'Item 4',
    'Item 5',
  ];

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
                              labelText: "Title",
                              isactive: true,
                            ),
                            CreateNotifyTextField(
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
                                child: DropdownButton(
                                  // Initial Value
                                  value: dropdownvalue,
                                  underline: SizedBox(),
                                  itemHeight: 48.0,
                                  isExpanded: true,

                                  // Down Arrow Icon
                                  icon: Icon(Icons.keyboard_arrow_down),
                                  alignment: Alignment.center,
                                  // Array list of items
                                  items: items.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                  // After selecting the desired option,it will
                                  // change button value to selected value
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownvalue = newValue!;
                                    });
                                  },
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
                                      print('confirm ${date}');
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
                                        right: width * 0.06),
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
                                          " ${selectedTime.format(context)}",
                                          style: TextStyle(
                                              fontSize: 18.0,
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
                              onTap: () {
                                // final cron = Cron();
                                // cron.schedule(Schedule.parse("* * * * *"), () {
                                //   print("hi");
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

class CreateNotifyTextField extends StatelessWidget {
  const CreateNotifyTextField(
      {Key? key, required this.isactive, required this.labelText})
      : super(key: key);
  final bool? isactive;
  final String labelText;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    TextEditingController controller = TextEditingController();
    return Container(
      width: width * 0.2,
      padding: EdgeInsets.only(left: width * 0.01, right: width * 0.06),
      height: height * 0.06,
      decoration: BoxDecoration(
        color: isactive! ? Colors.white : Color(0xffEFF0F6).withOpacity(0.7),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: TextFormField(
        textAlign: TextAlign.left,
        enabled: isactive,
        controller: controller,
        style: TextStyle(fontFamily: "Poppins"),
        cursorColor: Colors.black12,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: labelText,
          labelStyle: TextStyle(
              color: Color(0xff6e7191),
              fontFamily: "Poppins",
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
