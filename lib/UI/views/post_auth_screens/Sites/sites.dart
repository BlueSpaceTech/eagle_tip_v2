// ignore_for_file: prefer_const_constructors

import 'package:provider/provider.dart';
import 'package:testttttt/Models/sites.dart';
import 'package:testttttt/Providers/user_provider.dart';
import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/Services/site_call.dart';
import 'package:testttttt/UI/Widgets/customHeader2.dart';
import 'package:testttttt/UI/Widgets/customNav.dart';
import 'package:testttttt/UI/Widgets/custom_webbg.dart';
import 'package:testttttt/UI/Widgets/customappheader.dart';
import 'package:testttttt/UI/views/post_auth_screens/Sites/site_details.dart';
import 'package:testttttt/Utils/common.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:testttttt/Models/user.dart' as model;

class Sites extends StatefulWidget {
  Sites({Key? key}) : super(key: key);

  @override
  State<Sites> createState() => _SitesState();
}

class _SitesState extends State<Sites> {
  List siteImg = ["site1", "site2"];

  List siteImgDesk = ["site11", "site21"];

  List siteName = ["Acres Marathon", "Akron Marathon"];

  List sitelocation = ["Tampa,FL", "Leesburg,FL"];
  List<SitesDetails>? sitedetails;

  getData() async {
    sitedetails = await SiteCall().getSites() ?? [];
  }

  getsitesdescrp(List sites) {
    List<SitesDetails> sitedesc = [];
    for (var element in sitedetails ?? []) {
      for (var site in sites) {
        if (element.sitename == site) {
          sitedesc.add(element);
        }
      }
    }
    return sitedesc;
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    model.User? user = Provider.of<UserProvider>(context).getUser;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Responsive.isDesktop(context)
          ? MenuButton(isTapped: false, width: width)
          : SizedBox(),
      body: SingleChildScrollView(
        child: Container(
          height: Responsive.isDesktop(context) ? height * 1.19 : height,
          color: backGround_color,
          child: Padding(
            padding: EdgeInsets.only(
                top: Responsive.isDesktop(context)
                    ? height * 0.04
                    : height * 0.1,
                left: Responsive.isDesktop(context) ? 0.0 : width * 0.05,
                right: Responsive.isDesktop(context) ? 0.0 : width * 0.05),
            child: Responsive.isDesktop(context)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Navbar(
                        width: width,
                        height: height,
                        text1: "Home",
                        text2: "Sites",
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Stack(
                        children: [
                          WebBg(),
                          Padding(
                            padding: EdgeInsets.only(
                                left: width * 0.04, right: width * 0.04),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: height * 0.05,
                                ),
                                Text(
                                  "Sites",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: Responsive.isDesktop(context)
                                          ? FontWeight.w500
                                          : FontWeight.bold,
                                      fontFamily: "Poppins"),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: Responsive.isDesktop(context)
                                          ? height * 0.03
                                          : 0.0),
                                  child: Container(
                                    height: Responsive.isDesktop(context)
                                        ? height * 0.6
                                        : height * 0.5,
                                    child: ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      SiteDetails(
                                                    currentSite: getsitesdescrp(
                                                            user?.sites ??
                                                                [])[index]
                                                        .sitename,
                                                    sitedetail: getsitesdescrp(
                                                        user?.sites ??
                                                            [])[index],
                                                  ),
                                                ));
                                          },
                                          child: SiteDet(
                                              width: width,
                                              height: height,
                                              index: index,
                                              siteName: getsitesdescrp(
                                                      user?.sites ?? [])[index]
                                                  .sitename,
                                              sitelocation: getsitesdescrp(
                                                      user?.sites ?? [])[index]
                                                  .sitelocation),
                                        );
                                      },
                                      itemCount:
                                          getsitesdescrp(user?.sites ?? [])
                                              .length,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomHeader2(),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Text(
                        "Sites",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Poppins"),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: Responsive.isDesktop(context)
                                ? height * 0.03
                                : 0.0),
                        child: Container(
                          height: Responsive.isDesktop(context)
                              ? height * 0.6
                              : height * 0.5,
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SiteDetails(
                                          currentSite: getsitesdescrp(
                                                  user?.sites ?? [])[index]
                                              .sitename,
                                          sitedetail: getsitesdescrp(
                                              user?.sites ?? [])[index],
                                        ),
                                      ));
                                },
                                child: SiteDet(
                                    width: width,
                                    height: height,
                                    index: index,
                                    siteName:
                                        getsitesdescrp(user?.sites ?? [])[index]
                                            .sitename,
                                    sitelocation:
                                        getsitesdescrp(user?.sites ?? [])[index]
                                            .sitelocation),
                              );
                            },
                            itemCount: siteImg.length,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

// class SiteList extends StatelessWidget {
//   const SiteList({
//     Key? key,
//     required this.height,
//     required this.width,
//     required this.siteImg,
//     required this.siteName,
//     required this.sitelocation,
//   }) : super(key: key);

//   final double height;
//   final double width;
//   final List siteImg;
//   final List siteName;
//   final List sitelocation;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(
//           top: Responsive.isDesktop(context) ? height * 0.03 : 0.0),
//       child: Container(
//         height: Responsive.isDesktop(context) ? height * 0.6 : height * 0.5,
//         child: ListView.builder(
//           physics: NeverScrollableScrollPhysics(),
//           itemBuilder: (BuildContext context, int index) {
//             return SiteDet(
//                 width: width,
//                 siteImg: siteImg,
//                 height: height,
//                 index: index,
//                 siteName: siteName,
//                 sitelocation: sitelocation);
//           },
//           itemCount: siteImg.length,
//         ),
//       ),
//     );
//   }
// }

class SiteDet extends StatelessWidget {
  const SiteDet({
    Key? key,
    required this.index,
    required this.width,
    required this.height,
    required this.siteName,
    required this.sitelocation,
  }) : super(key: key);

  final double width;

  final String siteName;
  final int index;
  final double height;
  final String sitelocation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: 10.0,
          top: Responsive.isDesktop(context) ? height * 0.01 : 0.0),
      child: Container(
        width: width * 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          border: Responsive.isDesktop(context)
              ? Border.all(color: Colors.white)
              : null,
        ),
        child: Padding(
          padding: EdgeInsets.only(
              right: Responsive.isDesktop(context) ? width * 0.01 : 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: width * 0.52,
                child: Row(
                  children: [
                    Image.asset(
                      Common.assetImages + "${"site1"}.png",
                      width: Responsive.isDesktop(context)
                          ? width * 0.05
                          : width * 0.14,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          siteName,
                          style: TextStyle(
                            fontSize:
                                Responsive.isDesktop(context) ? 17.0 : 14.0,
                            fontFamily: "Poppins",
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          sitelocation,
                          style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Poppins",
                              color: Color(0xFF6E7191)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Image.asset(
                Common.assetImages + "arrow.png",
                width:
                    Responsive.isDesktop(context) ? width * 0.01 : width * 0.04,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
