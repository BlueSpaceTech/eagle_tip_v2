import 'package:testttttt/Utils/responsive.dart';
import 'package:flutter/material.dart';

class customfab extends StatelessWidget {
  const customfab({
    Key? key,
    required this.width,
    required this.text,
    required this.height,
  }) : super(key: key);

  final double width;
  final String text;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: Responsive.isDesktop(context) ? width * 0.13 : width * 0.42,
      height: height * 0.064,
      decoration: BoxDecoration(
        color: Color(0xff5081DB),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: width * 0.018,
          ),
          Icon(Icons.add, color: Colors.white),
        ],
      ),
    );
  }
}
