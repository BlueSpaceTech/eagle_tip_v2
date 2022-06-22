// ignore_for_file: prefer_const_constructors
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';
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

class SitesAdmin extends StatefulWidget {
  SitesAdmin({Key? key}) : super(key: key);

  @override
  State<SitesAdmin> createState() => _SitesAdminState();
}

class _SitesAdminState extends State<SitesAdmin> {
  List siteImg = ["site1", "site2"];

  List siteImgDesk = ["site11", "site21"];

  // List siteName = ["Acres Marathon", "Akron Marathon"];

  // List sitelocation = ["Tampa,FL", "Leesburg,FL"];
  List<SitesDetails>? allsites;
  List<SitesDetails>? sitedetails;
  final _key1 = GlobalKey();

  getData() async {
    sitedetails = await SiteCall().getSites();
    print(sitedetails);
  }

  getsitesdescrp() {
    List<SitesDetails> sitedesc = [];
    for (var element in sitedetails!) {
      sitedesc.add(element);
      print(sitedesc);
    }

    return sitedesc;
  }

  List<SitesDetails> siteelements = [];
  getsiteelement(String terminalinfo) {
    for (var document in sitedetails!) {
      if (document.terminalID + " ${document.terminalName}" == terminalinfo) {
        siteelements.add(document);
      }
    }
  }

  getsiteelementdrop(String terminalinfo) {
    siteelements.clear();
    for (var document in sitedetails!) {
      if (document.terminalID + " ${document.terminalName}" == terminalinfo) {
        siteelements.add(document);
        siteelementter.add(document);
      }
    }
  }

  List<SitesDetails> siteelementter = [];
  getsiteelementter(String terminalinfo) async {
    sitedetails = await SiteCall().getSites();
    for (var document in sitedetails!) {
      if (document.terminalID + " ${document.terminalName}" == terminalinfo) {
        siteelementter.add(document);
      }
    }
  }

  getTerminalData() async {
    sitedetails = await SiteCall().getSites();

    for (var document in sitedetails!) {
      if (terminal
          .contains(document.terminalID + " ${document.terminalName}")) {
      } else {
        terminal.insert(0, document.terminalID + " ${document.terminalName}");
        dropdownValue = terminal[0];
      }
    }
    getsiteelement(terminal[0]);

    //  print(terminal);
  }

  List<String> terminal = [""];
  String dropdownValue = "";
  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
    getTerminalData();

    // getsiteelement(terminal[0]);
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      ShowCaseWidget.of(context)!.startShowCase([_key1]);
    });
  }

  getforterminal(model.User user) {
    for (var site in user.sites) {
      if (forterminal.contains(site)) {
      } else {
        forterminal.insert(0, site);
        dropdownValue1 = forterminal[0];
      }
    }
    getsiteelementter(terminal[0]);
  }

  List<String> forterminal = [""];
  final ScrollController _firstController = ScrollController();
  String dropdownValue1 = "";
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    model.User? user = Provider.of<UserProvider>(context).getUser;
    for (var site in user!.sites) {
      if (forterminal.contains(site)) {
        print(site);
      } else {
        print(site);
        forterminal.insert(0, site);
        dropdownValue1 = forterminal[0];
      }
    }
    // getsiteelementter(forterminal[0]);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // String dropdownValue = terminal[0];
    model.User? user = Provider.of<UserProvider>(context).getUser;

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton:
          Responsive.isDesktop(context) || Responsive.isTablet(context)
              ? MenuButton(isTapped: false, width: width)
              : SizedBox(),
      body: sitedetails == null || siteelementter == null
          ? Container(
              height: height,
              color: backGround_color,
              width: width,
              child: Center(child: CircularProgressIndicator()))
          : Container(
              color: backGround_color,
              child: Padding(
                padding: EdgeInsets.only(
                    top: Responsive.isDesktop(context) ||
                            Responsive.isTablet(context)
                        ? height * 0.04
                        : height * 0.1,
                    left: Responsive.isDesktop(context) ||
                            Responsive.isTablet(context)
                        ? 0.0
                        : width * 0.05,
                    right: Responsive.isDesktop(context) ||
                            Responsive.isTablet(context)
                        ? 0.0
                        : width * 0.05),
                child: Responsive.isDesktop(context) ||
                        Responsive.isTablet(context)
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Navbar(
                            width: width,
                            height: height,
                          ),
                          SizedBox(
                            height: height * 0.05,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: width * 0.04, right: width * 0.04),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: height * 0.05,
                                ),
                                Row(
                                  children: [
                                    Showcase(
                                      key: _key1,
                                      disposeOnTap: true,
                                      showArrow: false,
                                      onTargetClick: () {
                                        Navigator.pop(context);
                                      },
                                      description:
                                          "You can view all your assigned sites here. Tap to Continue",
                                      titleTextStyle: TextStyle(
                                        fontSize: 17.0,
                                        color: Colors.white,
                                      ),
                                      descTextStyle: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.white,
                                      ),
                                      shapeBorder: RoundedRectangleBorder(),
                                      overlayPadding: EdgeInsets.all(8.0),
                                      showcaseBackgroundColor:
                                          Color(0xFF5081DB),
                                      contentPadding: EdgeInsets.all(8.0),
                                      child: Text(
                                        "All Sites",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                            fontWeight: Responsive.isDesktop(
                                                        context) ||
                                                    Responsive.isTablet(context)
                                                ? FontWeight.w500
                                                : FontWeight.bold,
                                            fontFamily: "Poppins"),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    user!.userRole == "TerminalManager" ||
                                            user.userRole == "TerminalUser"
                                        ? DropdownButton<String>(
                                            value: dropdownValue1,
                                            icon: const Icon(Icons
                                                .keyboard_arrow_down_outlined),
                                            iconEnabledColor: Colors.white,
                                            iconSize: 24,
                                            dropdownColor: Colors.black,
                                            elevation: 16,
                                            style: const TextStyle(
                                                color: Colors.white),
                                            // underline: Container(
                                            //   height: 2,
                                            //   color: Colors.deepPurpleAccent,
                                            // ),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                dropdownValue1 = newValue!;
                                              });
                                              getsiteelementdrop(newValue!);
                                            },
                                            // items: List.generate(user.sites.length, (index) {
                                            //   return DropdownMenuItem<String>(
                                            //     child: Text(
                                            //       user.sites[index]["sitename"],
                                            //       style: TextStyle(color: Colors.white),
                                            //     ),
                                            //   );
                                            // })

                                            items: forterminal
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                              return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(
                                                    value,
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ));
                                            }).toList(),
                                          )
                                        : DropdownButton<String>(
                                            value: dropdownValue,
                                            icon: const Icon(Icons
                                                .keyboard_arrow_down_outlined),
                                            iconEnabledColor: Colors.white,
                                            iconSize: 24,
                                            dropdownColor: Colors.black,
                                            elevation: 16,
                                            style: const TextStyle(
                                                color: Colors.white),
                                            // underline: Container(
                                            //   height: 2,
                                            //   color: Colors.deepPurpleAccent,
                                            // ),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                dropdownValue = newValue!;
                                              });
                                              getsiteelementdrop(newValue!);
                                            },
                                            // items: List.generate(user.sites.length, (index) {
                                            //   return DropdownMenuItem<String>(
                                            //     child: Text(
                                            //       user.sites[index]["sitename"],
                                            //       style: TextStyle(color: Colors.white),
                                            //     ),
                                            //   );
                                            // })

                                            items: terminal
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                              return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(
                                                    value,
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ));
                                            }).toList(),
                                          )
                                  ],
                                ),
                                user.userRole == "TerminalManager" ||
                                        user.userRole == "TerminalUser"
                                    ? Padding(
                                        padding: EdgeInsets.only(
                                            top: Responsive.isDesktop(
                                                        context) ||
                                                    Responsive.isTablet(context)
                                                ? height * 0.03
                                                : 0.0),
                                        child: Container(
                                          height: Responsive.isDesktop(
                                                      context) ||
                                                  Responsive.isTablet(context)
                                              ? height * 0.7
                                              : height * 0.8,
                                          child: Scrollbar(
                                            showTrackOnHover: true,
                                            trackVisibility: true,
                                            isAlwaysShown: true,
                                            controller: _firstController,
                                            child: ListView.builder(
                                              controller: _firstController,

                                              // physics:
                                              //     NeverScrollableScrollPhysics(),
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    SiteDetails(
                                                              currentSite:
                                                                  siteelementter[
                                                                          index]
                                                                      .sitename,
                                                              sitedetail:
                                                                  siteelementter[
                                                                      index],
                                                            ),
                                                          ));
                                                    },
                                                    child: SiteDet(
                                                      width: width,
                                                      height: height,
                                                      index: index,
                                                      siteName:
                                                          siteelementter[index]
                                                              .sitename,
                                                      sitelocation:
                                                          siteelementter[index]
                                                              .sitelocation,
                                                    ));
                                              },
                                              itemCount: siteelementter.length,
                                            ),
                                          ),
                                        ),
                                      )
                                    : Padding(
                                        padding: EdgeInsets.only(
                                            top: Responsive.isDesktop(
                                                        context) ||
                                                    Responsive.isTablet(context)
                                                ? height * 0.03
                                                : 0.0),
                                        child: Container(
                                          height: Responsive.isDesktop(
                                                      context) ||
                                                  Responsive.isTablet(context)
                                              ? height * 0.7
                                              : height * 0.8,
                                          child: Scrollbar(
                                            showTrackOnHover: true,
                                            trackVisibility: true,
                                            isAlwaysShown: true,
                                            controller: _firstController,
                                            child: ListView.builder(
                                              controller: _firstController,

                                              // physics:
                                              //     NeverScrollableScrollPhysics(),
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    SiteDetails(
                                                              currentSite:
                                                                  siteelements[
                                                                          index]
                                                                      .sitename,
                                                              sitedetail:
                                                                  siteelements[
                                                                      index],
                                                            ),
                                                          ));
                                                    },
                                                    child: SiteDet(
                                                      width: width,
                                                      height: height,
                                                      index: index,
                                                      siteName:
                                                          siteelements[index]
                                                              .sitename,
                                                      sitelocation:
                                                          siteelements[index]
                                                              .sitelocation,
                                                    ));
                                              },
                                              itemCount: siteelements.length,
                                            ),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
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
                          Row(
                            children: [
                              Showcase(
                                key: _key1,
                                disposeOnTap: true,
                                showArrow: false,
                                onTargetClick: () {
                                  Navigator.pop(context);
                                },
                                description:
                                    "You can view all your assigned sites here. Tap to Continue",
                                titleTextStyle: TextStyle(
                                  fontSize: 17.0,
                                  color: Colors.white,
                                ),
                                descTextStyle: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.white,
                                ),
                                shapeBorder: RoundedRectangleBorder(),
                                overlayPadding: EdgeInsets.all(8.0),
                                showcaseBackgroundColor: Color(0xFF5081DB),
                                contentPadding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Sites Admin",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Poppins"),
                                ),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              DropdownButton<String>(
                                value: dropdownValue,
                                icon: const Icon(
                                    Icons.keyboard_arrow_down_outlined),
                                iconEnabledColor: Colors.white,
                                iconSize: 24,
                                dropdownColor: Colors.black,
                                elevation: 16,
                                style: const TextStyle(color: Colors.white),
                                // underline: Container(
                                //   height: 2,
                                //   color: Colors.deepPurpleAccent,
                                // ),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownValue = newValue!;
                                  });
                                  getsiteelementdrop(newValue!);
                                },
                                // items: List.generate(user.sites.length, (index) {
                                //   return DropdownMenuItem<String>(
                                //     child: Text(
                                //       user.sites[index]["sitename"],
                                //       style: TextStyle(color: Colors.white),
                                //     ),
                                //   );
                                // })

                                items: terminal.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(color: Colors.white),
                                      ));
                                }).toList(),
                              )
                            ],
                          ),
                          SizedBox(
                            height: height * 0.05,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: Responsive.isDesktop(context)
                                    ? height * 0.03
                                    : 0.0),
                            child: SizedBox(
                              height: Responsive.isDesktop(context)
                                  ? height * 0.7
                                  : height * 0.8,
                              child: Scrollbar(
                                showTrackOnHover: true,
                                trackVisibility: true,
                                isAlwaysShown: true,
                                controller: _firstController,
                                child: ListView.builder(
                                  controller: _firstController,
                                  // physics:
                                  // NeverScrollableScrollPhysics(),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    SiteDetails(
                                                  currentSite:
                                                      sitedetails![index]
                                                          .sitename,
                                                  sitedetail:
                                                      sitedetails![index],
                                                ),
                                              ));
                                        },
                                        child: SiteDet(
                                          width: width,
                                          height: height,
                                          index: index,
                                          siteName:
                                              sitedetails![index].sitename,
                                          sitelocation:
                                              sitedetails![index].sitelocation,
                                        ));
                                  },
                                  itemCount: sitedetails!.length,
                                ),
                              ),
                            ),
                          ),
                        ],
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
          top: Responsive.isDesktop(context) || Responsive.isTablet(context)
              ? height * 0.01
              : 0.0),
      child: Container(
        width: width * 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          border: Responsive.isDesktop(context) || Responsive.isTablet(context)
              ? Border.all(color: Colors.white)
              : null,
        ),
        child: Padding(
          padding: EdgeInsets.only(
              right:
                  Responsive.isDesktop(context) || Responsive.isTablet(context)
                      ? width * 0.01
                      : 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: width * 0.52,
                child: Row(
                  children: [
                    Image.asset(
                      Common.assetImages + "${"site1"}.png",
                      width: Responsive.isDesktop(context) ||
                              Responsive.isTablet(context)
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
                            fontSize: Responsive.isDesktop(context) ||
                                    Responsive.isTablet(context)
                                ? 17.0
                                : 14.0,
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
                width: Responsive.isDesktop(context) ||
                        Responsive.isTablet(context)
                    ? width * 0.01
                    : width * 0.04,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
