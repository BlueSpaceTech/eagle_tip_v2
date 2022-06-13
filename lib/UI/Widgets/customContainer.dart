import 'package:testttttt/UI/Widgets/custom_webbg.dart';
import 'package:testttttt/UI/Widgets/customappheader.dart';
import 'package:testttttt/Utils/common.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    Key? key,
    required this.child,
    required this.width,
    required this.topPad,
    required this.height,
    required this.opacity,
  }) : super(key: key);
  final double width;
  final Widget child;
  final double height;
  final double topPad;
  final double opacity;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: backGround_color,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Opacity(opacity: opacity, child: WebBg()),
          Padding(
            padding: EdgeInsets.only(
                left: Responsive.isDesktop(context) ||
                        Responsive.isTablet(context)
                    ? width * 0.08
                    : width * 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: Responsive.isDesktop(context) ||
                          Responsive.isTablet(context)
                      ? width * 0.02
                      : 0.0,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                      padding: EdgeInsets.only(top: 20),
                      width: Responsive.isDesktop(context)
                          ? width * 0.45
                          : width * 0.9,
                      height: height * 0.85,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(
                              Responsive.isDesktop(context) ||
                                      Responsive.isTablet(context)
                                  ? 0.6
                                  : 0),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: child),
                ),
                SizedBox(
                  width: Responsive.isDesktop(context) ||
                          Responsive.isTablet(context)
                      ? width * 0.14
                      : width * 0.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
