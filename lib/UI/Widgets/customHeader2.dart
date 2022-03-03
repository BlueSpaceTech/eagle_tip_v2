import 'package:testttttt/UI/Widgets/logo.dart';
import 'package:testttttt/Utils/common.dart';
import 'package:flutter/material.dart';

class CustomHeader2 extends StatelessWidget {
  const CustomHeader2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Row(
      children: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: width * 0.06,
          ),
        ),
        SizedBox(
          width: width * 0.15,
        ),
        Logo(width: width),
        SizedBox(
          width: width * 0.14,
        ),
        Image.asset(
          Common.assetImages + "Vector.png",
          width: width * 0.048,
        ),
      ],
    );
  }
}
