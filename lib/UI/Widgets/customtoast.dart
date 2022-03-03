import 'package:testttttt/Utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastMessage {
  show(double width, BuildContext context, String message) {
    return Container(
      alignment: Alignment.center,
      width: Responsive.isDesktop(context) ? 350 : width * 0.6,
      height: 40,
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Color(0xff3F4850),
      ),
      child: Container(
        child: Text(
          message,
          style: TextStyle(
              color: Colors.white,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
