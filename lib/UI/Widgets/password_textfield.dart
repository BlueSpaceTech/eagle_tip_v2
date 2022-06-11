import 'package:testttttt/Utils/responsive.dart';
import 'package:flutter/material.dart';

class CustomPasswordTextField extends StatefulWidget {
  const CustomPasswordTextField({
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
  State<CustomPasswordTextField> createState() =>
      _CustomPasswordTextFieldState();
}

bool showPassword = true;

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.isDesktop(context) || Responsive.isTablet(context)
          ? 600
          : widget.width * 0.8,
      padding: EdgeInsets.symmetric(
          horizontal:
              Responsive.isDesktop(context) || Responsive.isTablet(context)
                  ? widget.width * 0.02
                  : widget.width * 0.06),
      height: widget.height * 0.08,
      decoration: BoxDecoration(
        color:
            widget.isactive ? Colors.white : Color(0xffEFF0F6).withOpacity(0.7),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: TextField(
        obscureText: showPassword,
        enabled: widget.isactive,
        controller: widget.controller,
        style: TextStyle(fontFamily: "Poppins"),
        cursorColor: Colors.black12,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: showPassword
                ? Icon(Icons.visibility_off)
                : Icon(Icons.visibility), //for show and hide password
            onPressed: () {
              setState(() {
                showPassword = !showPassword;
              });
            },
          ),
          border: InputBorder.none,
          labelText: widget.labelText,
          labelStyle: TextStyle(
              color: Color(0xff5e8be0),
              fontFamily: "Poppins",
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
