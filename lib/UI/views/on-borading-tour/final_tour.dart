import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/UI/views/on-borading-tour/tour1.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:flutter/material.dart';

class FinalTour extends StatelessWidget {
  const FinalTour({Key? key}) : super(key: key);

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
                  ? "webtour/tourlastweb.png"
                  : "assets/retour.png"),
              fit: BoxFit.fill),
        ),
        child: Stack(
          children: [
            Positioned(
              top: height * 0.12,
              left: width * 0.05,
              child: TourUpContainer(
                onnext: () {
                  Responsive.isDesktop(context)
                      ? Navigator.pushNamed(context, AppRoutes.homeScreen)
                      : Navigator.pushNamed(context, AppRoutes.bottomNav);
                },
                containertype: "right",
                distance: height * 0.028,
                height: height,
                width: width,
                pageno: "6",
                head:
                    "You can rewatch the tour anytime by clicking on the help icon.",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TourUpContainer1 extends StatelessWidget {
  const TourUpContainer1({
    Key? key,
    required this.height,
    required this.width,
    required this.pageno,
    required this.head,
    required this.distance,
    required this.containertype,
    required this.onnext,
  }) : super(key: key);

  final double height;
  final double width;
  final String pageno;
  final String head;
  final double distance;
  final String containertype;
  final Function onnext;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: pageno == "5" ? height * 0.21 : height * 0.19,
      width: Responsive.isDesktop(context) ? width * 0.4 : width * 0.9,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Responsive.isDesktop(context)
              ? "assets/${containertype}1.png"
              : "assets/${containertype}container.png"),
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
            horizontal: containertype == "down" && Responsive.isDesktop(context)
                ? width * 0.1
                : width * 0.08),
        child: Column(
          children: [
            SizedBox(
                height:
                    containertype == "down" ? height * 0.014 : height * 0.05),
            Text(
              head,
              style: TextStyle(
                fontSize: 14,
                fontFamily: "Poppins",
              ),
            ),
            SizedBox(
              height: distance,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  pageno == "6" ? "" : '${pageno}/5',
                  style: TextStyle(
                    color: Color(0xffB8B8B8),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (pageno == "6") ...[
                      Text(
                        "   ",
                      ),
                    ] else if (pageno == "5") ...[
                      Text(
                        "   ",
                      ),
                    ] else ...[
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.finaltour);
                        },
                        child: Text(
                          "skip",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                    SizedBox(
                      width: width * 0.04,
                    ),
                    GestureDetector(
                      onTap: () {
                        onnext();
                      },
                      child: Container(
                        height: 30,
                        width: 60,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color(0xff5081DB),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Text(
                          pageno == "6"
                              ? "Ok"
                              : pageno == "5"
                                  ? "Done"
                                  : "Next",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
