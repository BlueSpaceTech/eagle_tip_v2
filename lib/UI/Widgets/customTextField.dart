import 'package:testttttt/Utils/responsive.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.width,
    required this.height,
    required this.labelText,
    required this.controller,
    required this.isactive,
  }) : super(key: key);

  final double width;
  final double height;
  final String labelText;
  final TextEditingController controller;
  final bool isactive;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.isDesktop(context) ? 600 : width * 0.8,
      padding: EdgeInsets.symmetric(
          horizontal:
              Responsive.isDesktop(context) ? width * 0.02 : width * 0.06),
      height: height * 0.08,
      decoration: BoxDecoration(
        color: isactive ? Colors.white : Color(0xffEFF0F6).withOpacity(0.7),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: TextField(
        enabled: isactive,
        controller: controller,
        style: TextStyle(fontFamily: "Poppins"),
        cursorColor: Colors.black12,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: labelText,
          labelStyle: TextStyle(
              color: Color(0xff5e8be0),
              fontFamily: "Poppins",
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
