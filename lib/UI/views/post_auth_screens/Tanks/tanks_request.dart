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

CollectionReference requests =
    FirebaseFirestore.instance.collection("requesthistory");

class Tank extends StatefulWidget {
  const Tank({
    Key? key,
    required this.width,
    required this.tankType,
    required this.valueChanged,
    required this.valueChanged2,
    required this.height,
    required this.max,
    required this.productname,
    required this.tankNumber,
  }) : super(key: key);

  final double width;
  final String tankType;
  final double height;
  final int tankNumber;
  final int max;
  final ValueChanged valueChanged;
  final ValueChanged valueChanged2;
  final String productname;

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
        Container(
          width: 80.0,
          child: Text(
            widget.productname,
            style: TextStyle(
                fontSize: 13.0,
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontFamily: "Poppins"),
          ),
        ),
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
            width: Responsive.isDesktop(context)
                ? widget.width * 0.72
                : widget.width * 0.52,
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
                          fontSize: 12.0,
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
                          widget.tankType,
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
                                  FilteringTextInputFormatter.digitsOnly,
                                  CustomRangeTextInputFormatter(
                                      maxvalue: widget.max.toString()),
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

class CustomRangeTextInputFormatter extends TextInputFormatter {
  final String maxvalue;

  CustomRangeTextInputFormatter({required this.maxvalue});
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text == '') {
      return TextEditingValue();
    } else if (int.parse(newValue.text) < 1) {
      return TextEditingValue().copyWith(text: '0');
    }

    return int.parse(newValue.text) > int.parse(maxvalue)
        ? TextEditingValue().copyWith(text: maxvalue)
        : newValue;
  }
}
