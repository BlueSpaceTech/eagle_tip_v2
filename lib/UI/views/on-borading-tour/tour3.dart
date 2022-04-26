import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/UI/views/on-borading-tour/tour1.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:flutter/material.dart';

class Tour3 extends StatelessWidget {
  const Tour3({Key? key}) : super(key: key);
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
                  ? "assets/tour3web.png"
                  : "assets/tour3.png"),
              fit: BoxFit.fill),
        ),
        child: Stack(
          children: [
            Positioned(
              top: Responsive.isDesktop(context) ? height * 0.58 : height * 0.5,
              left: getleftlength(context, width),
              child: TourUpContainer(
                onnext: () {
                  Navigator.pushNamed(context, AppRoutes.tour4);
                },
                containertype: "down",
                distance: height * 0.028,
                height: height,
                width: width,
                pageno: "3",
                head:
                    "Want to request fuel for another site? Change Sites from here.",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
