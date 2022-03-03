import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/UI/views/on-borading-tour/tour1.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:flutter/material.dart';

class Tour5 extends StatelessWidget {
  const Tour5({Key? key}) : super(key: key);

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
                  ? "webtour/tour5web.png"
                  : "assets/tour5.png"),
              fit: BoxFit.fill),
        ),
        child: Stack(
          children: [
            Positioned(
              top: height * 0.46,
              left: width * 0.0501,
              child: TourUpContainer(
                onnext: () {
                  Responsive.isDesktop(context)
                      ? Navigator.pushNamed(context, AppRoutes.webfinaltour)
                      : Navigator.pushNamed(context, AppRoutes.finaltour);
                },
                containertype: "arrowup",
                distance: height * 0.028,
                height: height,
                width: width,
                pageno: "5",
                head:
                    "Sort employees according to sites and roles or find them by searching their names.",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
