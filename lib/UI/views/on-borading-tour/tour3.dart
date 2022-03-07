import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/UI/views/on-borading-tour/tour1.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:flutter/material.dart';

class Tour3 extends StatelessWidget {
  const Tour3({Key? key}) : super(key: key);

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
              top:
                  Responsive.isDesktop(context) ? height * 0.55 : height * 0.48,
              left: Responsive.isDesktop(context) ? width * 0.3 : width * 0.05,
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
