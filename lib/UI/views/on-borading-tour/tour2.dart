import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/UI/views/on-borading-tour/tour1.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:flutter/material.dart';

class Tour2 extends StatelessWidget {
  const Tour2({Key? key}) : super(key: key);

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
                  ? "assets/tour2web.png"
                  : "assets/tour2.png"),
              fit: BoxFit.fill),
        ),
        child: Stack(
          children: [
            Positioned(
              top: height * 0.43,
              left: width * 0.05,
              child: TourUpContainer(
                onnext: () {
                  Navigator.pushNamed(context, AppRoutes.tour3);
                },
                containertype: "arrowup",
                distance: height * 0.028,
                height: height,
                width: width,
                pageno: "2",
                head: "Change or adjust fuel according to your requirements.",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
