// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:html';

import 'package:csv/csv.dart';
import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/UI/Widgets/customNav.dart';
import 'package:testttttt/UI/Widgets/customfab.dart';
import 'package:testttttt/UI/Widgets/customsubmitbutton.dart';
import 'package:testttttt/UI/views/post_auth_screens/Chat/allchats.dart';
import 'package:flutter/material.dart';
import 'package:testttttt/UI/views/post_auth_screens/Sites/site_details.dart';
import 'package:testttttt/UI/views/post_auth_screens/Tanks/tanks_request.dart';
List rowHeader=["Name","Site","Order id","Date","Tank 1","Tank 2","Tank 3","Tank 4"];
List<List<dynamic>> csvdata = <List<dynamic>>[];
class TerminalHome extends StatefulWidget {
  const TerminalHome({Key? key}) : super(key: key);

  get restorationId => null;

  @override
  _TerminalHomeState createState() => _TerminalHomeState();
}

class _TerminalHomeState extends State<TerminalHome> with RestorationMixin{
  @override
  String? get restorationId => widget.restorationId;

  final RestorableDateTimeN _startDate = RestorableDateTimeN(DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day));
  final RestorableDateTimeN _endDate =
      RestorableDateTimeN(DateTime(2022, DateTime.now().month, 30));
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
  List<DateTime> getDaysInBeteween(DateTime startDate, DateTime endDate) {
  List<DateTime> days = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      days.add(startDate.add(Duration(days: i)));
    }
    return days;
}

// String convertDateTimeDisplay(String date) {
//     final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
//     final DateFormat serverFormater = DateFormat('dd-MM-yyyy');
//     final DateTime displayDate = displayFormater.parse(date);
//     final String formatted = serverFormater.format(displayDate);
//     return formatted;
//   }

  void _selectDateRange(DateTimeRange? newSelectedDate) async{
    if (newSelectedDate != null) {
      setState(() {
        _startDate.value = newSelectedDate.start;
        _endDate.value = newSelectedDate.end;
        // print(convertDateTimeDisplay(_startDate.value.toString()));
      // print(getDaysInBeteween(_startDate.value!, _endDate.value!));
      });
      if(_endDate.value==newSelectedDate.end){
        List days=getDaysInBeteween(_startDate.value!, _endDate.value!);
                                    
                                    if(csvdata.isEmpty){
                                      csvdata.add(rowHeader);
                                    }
                                    final docss=await requests.get();
                                    for (var element in docss.docs.where((element) => days.contains(element["date"].toDate()))) { 
                                      
                                          List row=[];
                                          List data=element.get("data");
                                          print(element.get("date").runtimeType);
                                          row.add(element.get("requestby"));
                                          row.add(element.get("site"));
                                          row.add(element.get("id"));
                                          row.add(element.get("date").toDate());
                                          row.add(data[0]);
                                          row.add(data[1]);
                                          row.add(data[2]);
                                          row.add(data[3]);
                                               csvdata.add(row);
                                             
                                           
                                        
                                      
                                    }
        String csv= ListToCsvConverter().convert(csvdata);
                                    final bytes = utf8.encode(csv);
                                    final text=utf8.decode(bytes);
                                    final blob = Blob([text]);
                                    final url = Url.createObjectUrlFromBlob(blob);
                                    AnchorElement(href: url)..setAttribute("download", "file.csv")..click();
                                    csvdata.clear();
      }
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
          firstDate: DateTime(DateTime.now().year,DateTime.now().month),
          currentDate: DateTime(DateTime.now().year, DateTime.now().month,DateTime.now().day),
          lastDate: DateTime(2022,DateTime.now().month,30),
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
  List siteImg = ["site1", "site2"];
  List siteName = ["Acres Marathon", "Akron Marathon"];
  List sitelocation = ["Tampa,FL", "Leesburg,FL"];
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          
          SingleChildScrollView(
            child: Column(
              children: [
                Navbar(
            width: width,
            height: height,
            text1: "Home",
            text2: "Sites",
          ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: height * 0.9,
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        decoration: BoxDecoration(color: Color(0xff20272C)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: height * 0.2,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.crudscreen);
                              },
                              child: CustomSubmitButton(
                                  width: width, title: "Edit Employees"),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.faqTerminal);
                                },
                                child: CustomSubmitButton(
                                    width: width, title: "Edit FAQ")),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.createNotification);
                              },
                              child: CustomSubmitButton(
                                  width: width, title: "Send Notification"),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 5,
                        child: Container(
                          height: height * 0.9,
                          decoration: BoxDecoration(color: Color(0xff2B343B)),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "Order Request Status",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 32,
                                            fontFamily: "Poppins"),
                                      ),
                                      Text(
                                        "19-02-2022",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff6E7191),
                                            fontSize: 20,
                                            fontFamily: "Poppins"),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: width*0.06
                                  ),
                                  InkWell(
                                  onTap: () async {
                                    _restorableDateRangePickerRouteFuture.present();
                                    },
                                    
                                
                                  child: customfab(width: width, text: "Create Report", height: height),),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.02),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: width * 0.03),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Sites",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.white,
                                                          fontSize: 17,
                                                          fontFamily:
                                                              "Poppins"),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      "6/7",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color:
                                                              Color(0xff6E7191),
                                                          fontSize: 15,
                                                          fontFamily:
                                                              "Poppins"),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  "Send Reminder",
                                                  style: TextStyle(
                                                      decoration: TextDecoration
                                                          .underline,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color(0xff92B8FF),
                                                      fontSize: 15,
                                                      fontFamily: "Poppins"),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            width: width * 0.28,
                                            height: height * 0.6,
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black,
                                                  blurRadius: 1.0,
                                                ),
                                              ],
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)),
                                              color: Color(0xff313D47),
                                            ),
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: width * 0.01,
                                                  vertical: height * 0.02),
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return SiteDett(
                                                    width: width,
                                                    siteImg: siteImg,
                                                    index: index,
                                                    siteName: siteName,
                                                    sitelocation: sitelocation);
                                              },
                                              itemCount: siteImg.length,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.02),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: width * 0.03),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Request Recieved",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.white,
                                                          fontSize: 17,
                                                          fontFamily:
                                                              "Poppins"),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      "1/7",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color:
                                                              Color(0xff6E7191),
                                                          fontSize: 15,
                                                          fontFamily:
                                                              "Poppins"),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            width: width * 0.28,
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black,
                                                  blurRadius: 1.0,
                                                ),
                                              ],
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)),
                                              color: Color(0xff313D47),
                                            ),
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: width * 0.01,
                                                  vertical: height * 0.02),
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return SiteDett(
                                                    width: width,
                                                    siteImg: siteImg,
                                                    index: index,
                                                    siteName: siteName,
                                                    sitelocation: sitelocation);
                                              },
                                              itemCount: siteImg.length,
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
                        )),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
