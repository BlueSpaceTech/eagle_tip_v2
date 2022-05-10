// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_field, unrelated_type_equality_checks, unused_local_variable, division_optimization

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:testttttt/Providers/user_provider.dart';
import 'package:testttttt/UI/Widgets/customHeader2.dart';
import 'package:testttttt/UI/views/post_auth_screens/Tanks/product_request.dart';
import 'package:testttttt/Utils/common.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'dart:math';
import 'package:testttttt/Models/user.dart' as model;
CollectionReference requests= FirebaseFirestore.instance.collection("requesthistory");
class TanksRequest extends StatefulWidget {
  const TanksRequest({Key? key}) : super(key: key);

  @override
  State<TanksRequest> createState() => _TanksRequestState();
}

class _TanksRequestState extends State<TanksRequest> {
  bool? _isTapped = false;
  String? regularVal = "0";
  String? midgradeVal = "0";
  String? premiumVal = "0";
  String? ulsdVal = "0";
  bool? _requested = false;
  List data=[];
  fuelamounts(String amount,String fueltype,String tankid,String tanknumber){
    if(amount!=0){
      data.add({
        "amount"
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          color: backGround_color,
          child: Padding(
            padding: EdgeInsets.only(top: 10.0, left: width * 0.07),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomHeader2(),
                SizedBox(
                  height: height * 0.06,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: width * 0.1,
                    ),
                    Column(
                      children: [
                        Text(
                          "Acres Marathon",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17.0,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Poppins"),
                        ),
                        Text(
                          "Tampa, FL",
                          style: TextStyle(
                              color: Color(0xFF6E7191),
                              fontSize: 13.0,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Poppins"),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: width * 0.2,
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Image.asset(
                        Common.assetImages + "pen.png",
                        width: width * 0.045,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: height * 0.07,
                ),
                SizedBox(
                  height: height * 0.35,
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
                            _isTapped = val;
                          });
                        },
                        max: 8000,
                        width: width,
                        height: height,
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
                            _isTapped = val;
                          });
                        },
                        width: width,
                        max: 12000,
                        height: height,
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
                            _isTapped = val;
                          });
                        },
                        width: width,
                        max: 16000,
                        height: height,
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
                            _isTapped = val;
                          });
                        },
                        width: width,
                        max: 20000,
                        height: height,
                        tankType: "Tank 4: ULSD (134)",
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.025,
                ),
                InkWell(
                  onTap: () {
                    if (_isTapped!) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          title: Text(
                            'Request Confirmation',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 23.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins",
                              color: Colors.black,
                            ),
                          ),
                          content: SizedBox(
                            height: height * 0.37,
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
                                  height: height * 0.05,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      regularVal.toString().replaceAllMapped(
                                          RegExp(
                                              r'(\d{1,3})(?=(\d{3})+(?!\d))'),
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
                                  height: 8.0,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      midgradeVal.toString().replaceAllMapped(
                                          RegExp(
                                              r'(\d{1,3})(?=(\d{3})+(?!\d))'),
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
                                  height: 8.0,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      premiumVal.toString().replaceAllMapped(
                                          RegExp(
                                              r'(\d{1,3})(?=(\d{3})+(?!\d))'),
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
                                  height: 8.0,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      ulsdVal.toString().replaceAllMapped(
                                          RegExp(
                                              r'(\d{1,3})(?=(\d{3})+(?!\d))'),
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
                                  height: height * 0.02,
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        width: width * 0.32,
                                        height: height * 0.055,
                                        decoration: BoxDecoration(
                                          color: Color(0Xffed5c62),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
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
                                      width: 12.0,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        
                                        Navigator.pop(context);
                                        setState(() {
                                          _requested = true;
                                        });
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.0)),
                                            title: Text(
                                              'Your Request has been sent!',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 23.0,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: "Poppins",
                                                color: Colors.black,
                                              ),
                                            ),
                                            content: SizedBox(
                                              height: height * 0.25,
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                    Common.assetImages +
                                                        "check.png",
                                                    width: width * 0.2,
                                                  ),
                                                  SizedBox(
                                                    height: height * 0.1,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Container(
                                                      width: width * 0.32,
                                                      height: height * 0.055,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0Xff28519D),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          "Back",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 13.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontFamily:
                                                                  "Poppins"),
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
                                        width: width * 0.32,
                                        height: height * 0.055,
                                        decoration: BoxDecoration(
                                          color: Color(0Xff5081db),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
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
                    padding: EdgeInsets.only(right: width * 0.1),
                    child: Container(
                      height: height * 0.084,
                      width: width * 0.45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color:
                            _isTapped! ? Color(0xFF28519D) : Color(0xFF8D9298),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Tank extends StatefulWidget {
  const Tank({
    Key? key,
    required this.width,
    required this.tankType,
    required this.valueChanged,
    required this.valueChanged2,
    required this.height,
    required this.max,
    required this.tankNumber,
  }) : super(key: key);

  final double width;
  final String tankType;
  final double height;
  final int tankNumber;
  final int max;
  final ValueChanged valueChanged;
  final ValueChanged valueChanged2;

  @override
  State<Tank> createState() => _TankState();
}

class _TankState extends State<Tank> {
  final TextEditingController _controller = TextEditingController();
  bool? isTapped = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              if (_controller.text.isEmpty) {
                isTapped = !isTapped!;
              } else {
                isTapped = true;
              }
              // widget.valueChanged(isTapped);
            });
          },
          child: Container(
            width: widget.width * 0.72,
            height: Responsive.isDesktop(context)
                ? widget.height * 0.068
                : widget.height * 0.075,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(17.0),
              color: !isTapped! ? Color(0xff8d9298) : Colors.white,
            ),
            child: !isTapped!
                ? Center(
                    child: Text(
                      widget.tankType,
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Color(0xFF13131B),
                          fontWeight: FontWeight.w400,
                          fontFamily: "Poppins"),
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 7.0, bottom: 7.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.tankType + " Max ${widget.max}",
                          style: TextStyle(
                            color: Color(0xFF6E7191),
                            fontSize: Responsive.isDesktop(context)
                                ? widget.width * 0.025
                                : 12.0,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins",
                          ),
                        ),
                        Visibility(
                          visible: Responsive.isDesktop(context),
                          child: SizedBox(
                            height: 3.0,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: Responsive.isDesktop(context)
                                  ? widget.height * 0.012
                                  : widget.height * 0.03,
                              width: widget.width * 0.52,
                              child: TextField(
                                autofocus: true,
                                style: TextStyle(
                                  fontSize: Responsive.isDesktop(context)
                                      ? widget.width * 0.042
                                      : 15.0,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins",
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                controller: _controller,
                                onChanged: (value) {
                                  setState(() {
                                    if (_controller.text != "0") {
                                      widget.valueChanged(
                                          _controller.text.isNotEmpty);
                                    }
                                    if (value == "0") {
                                      widget.valueChanged(false);
                                    }
                                    widget.valueChanged2(_controller.text);
                                  });
                                },
                                decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    border: InputBorder.none),
                              ),
                            ),
                            Text(
                              "Gal",
                              style: TextStyle(
                                fontSize: Responsive.isDesktop(context)
                                    ? widget.width * 0.034
                                    : 15.0,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Poppins",
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
          ),
        ),
        SizedBox(
          width: widget.width * 0.05,
        ),
        InkWell(
          onTap: () async {
            final fieldVal = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductRequest(
                          tankNumber: widget.tankNumber,
                          maxVal: widget.max,
                          divisionNum: ((widget.max) / 20).toInt(),
                        )));
            setState(() {
              _controller.text = fieldVal["val"].toString();
              widget.valueChanged2(_controller.text);
              isTapped = fieldVal["bool"];
              if (_controller.text != "0") {
                widget.valueChanged(isTapped);
              }
            });
          },
          child: Image.asset(
            Common.assetImages + "Request.png",
            width: widget.width * 0.09,
          ),
        ),
      ],
    );
  }
}
