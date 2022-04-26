import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/UI/views/on-borading-tour/tour1.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:flutter/material.dart';

class Tour4 extends StatelessWidget {
  const Tour4({Key? key}) : super(key: key);
  getleftlength(BuildContext context, double width) {
    if (Responsive.isDesktop(context)) {
      return width * 0.35;
    } else if (Responsive.isTablet(context)) {
      return width * 0.14;
    } else {
      return width * 0.06;
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height * 1,
        width: width * 1,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Responsive.isDesktop(context)
                  ? "assets/tour4web.png"
                  : "assets/tour4.png"),
              fit: BoxFit.fill),
        ),
        child: Stack(
          children: [
            Positioned(
              top:
                  Responsive.isDesktop(context) ? height * 0.67 : height * 0.58,
              left: getleftlength(context, width),
              child: TourUpContainer(
                onnext: () {
                  Navigator.pushNamed(context, AppRoutes.tour5);
                },
                containertype: "down",
                distance: height * 0.028,
                height: height,
                width: width,
                pageno: "4",
                head:
                    "Delete users or add new users by clicking on edit employees.",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
