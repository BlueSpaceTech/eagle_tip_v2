import 'package:testttttt/Utils/responsive.dart';
import 'package:flutter/material.dart';

class CustomSubmitButton extends StatelessWidget {
  const CustomSubmitButton({
    Key? key,
    required this.width,
    required this.title,
  }) : super(key: key);

  final double width;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.isDesktop(context) ? 600 : width * 0.8,
      height: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Color(0xff5081DB),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontFamily: "Poppins",
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
