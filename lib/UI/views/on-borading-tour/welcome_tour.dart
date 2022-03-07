import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:flutter/material.dart';

class WelcomeTour extends StatelessWidget {
  const WelcomeTour({Key? key}) : super(key: key);

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
                  ? "assets/tour0web.png"
                  : "assets/tour0.png"),
              fit: BoxFit.fill),
        ),
        child: Stack(
          children: [
            Positioned(
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  height: height * 0.3,
                  width:
                      Responsive.isDesktop(context) ? width * 0.4 : width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/containertop.png",
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome Ben!",
                              style: TextStyle(
                                fontSize: 19,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Text(
                              "We would like to give you tour of the Eagle Tip app.",
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: "Poppins",
                              ),
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, AppRoutes.tour1);
                              },
                              child: Container(
                                height: height * 0.06,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Color(0xff5081DB),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Text(
                                  "Start Tour",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.015,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Responsive.isDesktop(context)
                                        ? Navigator.pushNamed(
                                            context, AppRoutes.webfinaltour)
                                        : Navigator.pushNamed(
                                            context, AppRoutes.finaltour);
                                  },
                                  child: Text(
                                    "I’ll explore on my own",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontFamily: "Poppins",
                                        color: Color(0xffED5C62)),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
