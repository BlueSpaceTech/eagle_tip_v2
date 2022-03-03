// ignore_for_file: prefer_const_constructors

import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/Utils/common.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:flutter/material.dart';

class Requests extends StatelessWidget {
  const Requests({
    Key? key,
    required this.height,
    required this.requestId,
    required this.width,
    required this.requestDate,
  }) : super(key: key);

  final double height;
  final List requestId;
  final double width;
  final List requestDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.6,
      width: width * 0.3,
      child: ListView.builder(
        itemCount: requestId.length,
        itemBuilder: (BuildContext context, int index) {
          return ReqContainer(
              width: width,
              index: index,
              height: height,
              requestId: requestId,
              requestDate: requestDate);
        },
      ),
    );
  }
}

class ReqContainer extends StatelessWidget {
  const ReqContainer({
    Key? key,
    required this.width,
    required this.height,
    required this.index,
    required this.requestId,
    required this.requestDate,
  }) : super(key: key);

  final double width;
  final double height;
  final List requestId;
  final List requestDate;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.particularRequest);
      },
      child: Container(
        width: width * 0.9,
        height: height * 0.075,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Acres Marathon #${requestId[index]}",
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Poppins",
                    color: Colors.white,
                  ),
                ),
                Text(
                  "${requestDate[index]}",
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Poppins",
                    color: Color(0xFFD9DBE9),
                  ),
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              size:
                  Responsive.isDesktop(context) ? width * 0.015 : width * 0.045,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
