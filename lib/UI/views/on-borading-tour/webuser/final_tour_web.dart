import 'package:provider/provider.dart';
import 'package:testttttt/Providers/user_provider.dart';
import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/UI/views/on-borading-tour/tour1.dart';
import 'package:testttttt/UI/views/post_auth_screens/HomeScreens/Home_screen.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:testttttt/Models/user.dart' as model;

class FinalTourWeb extends StatelessWidget {
  const FinalTourWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height * 1,
        width: width * 1,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Responsive.isDesktop(context)
                  ? "assets/tourlastweb.png"
                  : "assets/retour.png"),
              fit: BoxFit.fill),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: height * 0.13,
              right: -100,
              child: TourUpContainer1(
                onnext: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeScreen(
                                showdialog: false,
                                sites: user.sites,
                              )));
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
        padding: EdgeInsets.symmetric(horizontal: width * 0.1),
        child: Column(
          children: [
            SizedBox(height: height * 0.014),
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
                      InkWell(
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
                    InkWell(
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
