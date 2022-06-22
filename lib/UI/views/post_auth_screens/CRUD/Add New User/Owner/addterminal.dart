import 'dart:convert';
// import 'dart:io' as prefix;

import 'package:csv/csv.dart';
// import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:testttttt/Providers/user_provider.dart';
// import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/Services/Crud_functions.dart';
import 'package:testttttt/Services/site_call.dart';
// import 'package:testttttt/Services/authentication_helper.dart';
import 'package:testttttt/UI/Widgets/customNav.dart';
import 'package:testttttt/UI/Widgets/customappheader.dart';
import 'package:testttttt/UI/Widgets/customfab.dart';
import 'package:testttttt/UI/Widgets/customsubmitbutton.dart';
import 'package:testttttt/UI/Widgets/customtoast.dart';
import 'package:testttttt/UI/Widgets/logo.dart';
import 'package:testttttt/UI/views/post_auth_screens/CRUD/Add%20New%20User/invitation.dart';
import 'package:testttttt/UI/views/post_auth_screens/CRUD/crudmain.dart';
import 'package:testttttt/UI/views/post_auth_screens/Notifications/createNotification.dart';
// import 'package:testttttt/UI/views/post_auth_screens/Sites/sites.dart';
// import 'package:testttttt/Utils/common.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:testttttt/Models/user.dart' as model;
import 'package:testttttt/Utils/InviteCSV.dart';
// import 'package:universal_html/html.dart';

import '../../../../../../Models/sites.dart';

class AddTerminalUser extends StatefulWidget {
  AddTerminalUser({Key? key}) : super(key: key);

  @override
  State<AddTerminalUser> createState() => _AddTerminalUserState();
}

class _AddTerminalUserState extends State<AddTerminalUser> {
  bool isselect = false;
  FToast? fToast;

  List Roles = ["SiteManager", "SiteUser"];
  String selectedrOLE = "";

  List<dynamic> selectedsites = [];
  List<SitesDetails>? sitedetails;
  List allsitename = [];

  getData() async {
    sitedetails = await SiteCall().getSites();

    for (var document in sitedetails!) {
      allsitename.add(document.sitename);
    }
    print(allsitename);
  }

  List terminal = [];
  getTerminalData() async {
    sitedetails = await SiteCall().getSites();

    for (var document in sitedetails!) {
      if (terminal
          .contains(document.terminalID + " ${document.terminalName}")) {
      } else {
        terminal.add(document.terminalID + " ${document.terminalName}");
      }
    }

    print(terminal);
  }

  void _showSiteSelect(List allsitename) async {
    final List _items = allsitename;

    for (var element in _items) {
      element = element.toString().replaceAll(" ", "");
    }

    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SiteSelectCrud(items: _items);
      },
    );

    // Update UI
    if (results != null) {
      setState(() {
        _selectedItems2.addAll(results);
      });
    }
  }

  searchSites(String terminalname) {
    List siteslist = [];
    for (var doc in sitedetails!) {
      if (doc.terminalID + " ${doc.terminalName}" == terminalname) {
        siteslist.add(doc.siteid + " ${doc.sitename}");
      }
    }
    return siteslist;
  }

  getsitesdescrp(List sites) {
    List sitedesc = [];
    for (var element in sitedetails ?? []) {
      for (var site in sites) {
        if (element.sitename == site) {
          sitedesc.add(element.siteid + " ${element.sitename}");
        }
      }
    }
    return sitedesc;
  }

  _buildsiteschip(List site) {
    bool issel = false;

    List<Widget> choices = [];
    site.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(3.0),
        child: ChoiceChip(
          label: Text(
            item,
            style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
                fontFamily: "Poppins"),
          ),
          selectedColor: Color(0xFF5081db),
          disabledColor: Color(0xFF535c65),
          backgroundColor: Color(0xFF535c65),
          selected: selectedsites.contains(item),
          onSelected: (selected) {
            setState(() {
              issel = selected;

              print("else");
              selectedsites.contains(item)
                  ? selectedsites.remove(item)
                  : selectedsites.add(item);
              print(selectedsites);

              // +added
            });
          },
        ),
      ));
    });
    return choices;
  }

  List<String> _selectedItems2 = [];

  _buildall(List site) {
    bool issel = false;
    List items = ["All"];

    List<Widget> choices = [];
    items.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(3.0),
        child: ChoiceChip(
          label: Text(
            item,
            style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
                fontFamily: "Poppins"),
          ),
          selectedColor: Color(0xFF5081db),
          disabledColor: Color(0xFF535c65),
          backgroundColor: Color(0xFF535c65),
          selected: issel,
          onSelected: (selected) {
            setState(() {
              issel != selected;
              if (selectedsites.length == site.length) {
                selectedsites.clear();
                print(selectedsites.length);
                print(site.length);
              } else {
                selectedsites = List.from(site);
              }

              print(selectedsites);
              // +added
            });
          },
        ),
      ));
    });
    return choices;
  }

  _buildRolechip(List role) {
    bool isroleselected = false;
    List<Widget> choicess = [];
    role.forEach((item) {
      choicess.add(Container(
        padding: const EdgeInsets.all(3.0),
        child: ChoiceChip(
          label: Text(
            item,
            style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
                fontFamily: "Poppins"),
          ),
          selectedColor: Color(0xFF5081db),
          disabledColor: Color(0xFF535c65),
          backgroundColor: Color(0xFF535c65),
          selected: selectedrOLE == item,
          onSelected: (selected) {
            setState(() {
              isroleselected = selected;
              selectedrOLE = item;
              print(selectedrOLE);
              // +added
            });
          },
        ),
      ));
    });
    return choicess;
  }

  late Future<ListResult> file;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fToast = FToast();
    fToast!.init(context);
    file = FirebaseStorage.instance.ref('/Templates').list();
    getData();
    getTerminalData();
  }

  List inviteData = [];
  @override
  Widget build(BuildContext context) {
    model.User? user = Provider.of<UserProvider>(context).getUser;
    // _showSiteSelect() async {
    //   final List _items =
    //       user!.userRole == "AppAdmin" || user.userRole == "SuperAdmin"
    //           ? allsitename
    //           : user.sites;
    //   for (var element in _items) {
    //     element = element.toString().replaceAll(" ", "");
    //   }

    //   final List<String>? results = await showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return SiteSelect(items: _items);
    //     },
    //   );

    //   // Update UI
    //   if (results != null) {
    //     setState(() {
    //       _selectedItems2 = results;
    //     });
    //   }
    // }

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    List sites;
    sites = user!.sites;

    bool isTapped = false;
    List Roles = ["Site Manager", "Site User"];
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: backGround_color,
          child: Column(
            children: [
              Navbar(width: width, height: height),
              Container(
                height: height * 1.4,
                color: backGround_color,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: width * 0.04,
                      right: width * 0.04,
                      top: Responsive.isDesktop(context)
                          ? height * 0.01
                          : height * 0.08),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Responsive.isDesktop(context) ? 20 : 0,
                      ),
                      Visibility(
                        visible: Responsive.isDesktop(context),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: width * 0.24,
                            ),
                            Text(
                              "Add new Terminal User",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  color: Colors.white,
                                  fontSize: 20),
                            ),
                            InkWell(
                              onTap: () async {
                                FilePickerResult? csvFile =
                                    await FilePicker.platform.pickFiles(
                                        allowedExtensions: ['csv'],
                                        type: FileType.custom,
                                        allowMultiple: false);
                                if (csvFile != null) {
                                  final bytes = utf8
                                      .decode(csvFile.files[0].bytes!.toList());
                                  List<List<dynamic>> rowsAsListOfValues =
                                      const CsvToListConverter().convert(bytes);
                                  for (int i = 1;
                                      i < rowsAsListOfValues.length;
                                      i++) {
                                    setState(() {
                                      inviteData
                                          .add(rowsAsListOfValues.elementAt(i));
                                    });
                                  }
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return OpenCSV(inviteData: inviteData);
                                  }));
                                }
                              },
                              child: customfab(
                                  width: width,
                                  text: "Import CSV",
                                  height: height),
                            ),
                            InkWell(
                                onTap: () async {
                                  // we will declare the list of headers that we want

                                  var downloadURL = await FirebaseStorage
                                      .instance
                                      .ref()
                                      .child("/Templates")
                                      .child("Template.csv")
                                      .getDownloadURL();
                                  print(downloadURL);
                                  // AnchorElement anchorElement =
                                  //     AnchorElement(href: downloadURL);
                                  // anchorElement.download = downloadURL;
                                  // anchorElement.click();
                                },
                                child: Container(
                                  // alignment: Alignment.center,
                                  width: Responsive.isDesktop(context)
                                      ? width * 0.13
                                      : width * 0.42,
                                  height: height * 0.064,
                                  decoration: BoxDecoration(
                                    color: Color(0xff5081DB),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Download CSV Template",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontFamily: "Poppins",
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Visibility(
                          visible: !Responsive.isDesktop(context),
                          child: Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.08),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                    )),
                                Logo(width: width),
                                MenuButton(isTapped: isTapped, width: width),
                              ],
                            ),
                          )),
                      SizedBox(
                        height: height * 0.06,
                      ),
                      Visibility(
                        visible: !Responsive.isDesktop(context),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Add new user",
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontFamily: "Poppins",
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      Text(
                        "Select the Site and Role for your new user",
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          fontFamily: "Poppins",
                        ),
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      // Row(
                      //   children: [
                      //     InkWell(
                      //       onTap: _showSiteSelect,
                      //       child: Container(
                      //         alignment: Alignment.center,
                      //         width: Responsive.isDesktop(context)
                      //             ? width * 0.13
                      //             : width * 0.42,
                      //         height: height * 0.064,
                      //         decoration: BoxDecoration(
                      //           color: Color(0xff5081DB),
                      //           borderRadius:
                      //               BorderRadius.all(Radius.circular(10)),
                      //         ),
                      //         child: Row(
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           children: [
                      //             Text(
                      //               "View All Sites",
                      //               style: TextStyle(
                      //                   fontSize: 15,
                      //                   color: Colors.white,
                      //                   fontFamily: "Poppins",
                      //                   fontWeight: FontWeight.w600),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       width: 20,
                      //     ),
                      //     Row(
                      //       children: [
                      //         for (var name in _selectedItems2)
                      //           Container(
                      //             padding: const EdgeInsets.all(3.0),
                      //             child: ChoiceChip(
                      //               label: Text(
                      //                 name + " ",
                      //                 style: TextStyle(
                      //                     color: Colors.white,
                      //                     fontSize: 14.0,
                      //                     fontWeight: FontWeight.w400,
                      //                     fontFamily: "Poppins"),
                      //               ),
                      //               selectedColor: Color(0xFF5081db),
                      //               disabledColor: Color(0xFF535c65),
                      //               backgroundColor: Color(0xFF535c65),
                      //               selected: true,
                      //             ),
                      //           )
                      //       ],
                      //     ),
                      //   ],
                      // ),
                      Text(
                        "Assign Terminal",
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          fontFamily: "Poppins",
                        ),
                      ),

                      SizedBox(
                        height: height * 0.04,
                      ),
                      SizedBox(
                        height: 50,
                        width: width * 0.5,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: terminal.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  _showSiteSelect(terminal);
                                },
                                child: Container(
                                  width: 150,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      border: Border.all(),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Select Terminals",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Icon(
                                            Icons.keyboard_arrow_down_outlined),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      Wrap(
                        children: [
                          for (var name in _selectedItems2)
                            Container(
                              //color: Color(0xFF5081db),
                              padding: EdgeInsets.all(3.0),
                              child: ChoiceChip(
                                label: Text(
                                  name + " ",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Poppins"),
                                ),
                                selectedColor: Color(0xFF5081db),
                                // disabledColor: Color(0xFF535c65),
                                // backgroundColor: Color(0xFF535c65),
                                selected: true,
                              ),
                            )
                        ],
                      ),

                      SizedBox(
                        height: height * 0.04,
                      ),

                      /*
                      ChipsChoice<String>.multiple(
                        wrapped: true,
                        choiceStyle: C2ChoiceStyle(color: Colors.black),
                        choiceActiveStyle: C2ChoiceStyle(color: Colors.blue),
                        value: selectedsites,
                        onChanged: (val) =>
                            setState(() => selectedsites = val),
                        choiceItems: C2Choice.listFrom<String, String>(
                          source: sites,
                          value: (i, v) => v,
                          label: (i, v) => v,
                        ),
                      ),
                      */
                      // Wrap(
                      //   children: [
                      //     user.userRole == "AppAdmin" ||
                      //             user.userRole == "SuperAdmin"
                      //         // ||
                      //         // user.userRole == "TerminalManager" ||
                      //         // user.userRole == "TerminalUser"
                      //         ? Wrap(
                      //             runSpacing: 10,
                      //             children: _buildall(allsitename),
                      //           )
                      //         : Wrap(
                      //             children: _buildall(sites),
                      //           ),
                      //     user.userRole == "AppAdmin" ||
                      //             user.userRole == "SuperAdmin"
                      //         // ||
                      //         // user.userRole == "TerminalManager" ||
                      //         // user.userRole == "TerminalUser"
                      //         ? Wrap(
                      //             runSpacing: 10,
                      //             children: _buildsiteschip(allsitename),
                      //           )
                      //         : Wrap(
                      //             children: _buildsiteschip(sites),
                      //           ),
                      //   ],
                      // ),

                      /*
                      Wrap(
                        runSpacing: 10,
                        children: [
                          for (int i = 0; i < sites.length; i++) ...{
                            InkWell(
                              onTap: () {},
                              child: SiteChip(
                                function: () {
                                  selectedsitess.contains(sites[i])
                                      ? selectedsitess.remove(sites[i])
                                      : selectedsitess.add(sites[i]);
                                  print(selectedsitess);
                                  print("Rr");
                                },
                                siteName: sites[i],
                                height: height,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                          },
                        ],
                      ),
                      */
                      SizedBox(
                        height: height * 0.04,
                      ),
                      Text(
                        "Role",
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          fontFamily: "Poppins",
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      /*
                      Wrap(
                        runSpacing: 10,
                        children: [
                          for (int i = 0; i < Roles.length; i++) ...{
                            SiteChip(
                              function: () {},
                              siteName: Roles[i],
                              height: height,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                          },
                        ],
                      ),
                      */
                      Wrap(
                        children:
                            _buildRolechip(["TerminalManager", "TerminalUser"]),
                      ),
                      SizedBox(
                        height: Responsive.isDesktop(context)
                            ? height * 0.08
                            : height * 0.08,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              if (selectedrOLE == "" ||
                                  _selectedItems2.isEmpty) {
                                fToast!.showToast(
                                    child: ToastMessage().show(width, context,
                                        "Please select the site and Role for your new user"),
                                    gravity: ToastGravity.BOTTOM,
                                    toastDuration: Duration(seconds: 3));
                              } else if (selectedrOLE == "SiteUser" &&
                                  selectedsites.length > 1) {
                                fToast!.showToast(
                                    child: ToastMessage().show(width, context,
                                        "Mutiple sites selected for Site User"),
                                    gravity: ToastGravity.BOTTOM,
                                    toastDuration: Duration(seconds: 3));
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Invitation(
                                        sites: _selectedItems2,
                                        role: selectedrOLE,
                                      ),
                                    ));
                              }
                            },
                            child: Card(
                              elevation: 5.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Responsive.isDesktop(context)
                                  ? customfab(
                                      width: width,
                                      text: "Next",
                                      height: height,
                                    )
                                  : CustomSubmitButton(
                                      width: width, title: "Next"),
                            ),
                          ),
                        ],
                      ),
                    ],
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

class SiteChip extends StatefulWidget {
  SiteChip({
    Key? key,
    required this.height,
    required this.siteName,
    required this.function,
  }) : super(key: key);

  final String siteName;
  final double height;
  final Function function;

  @override
  State<SiteChip> createState() => _SiteChipState();
}

class _SiteChipState extends State<SiteChip> {
  bool? isSelected = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.function;
      },
      child: InkWell(
        onTap: () {
          setState(() {
            isSelected = !isSelected!;
            //  print(widget.siteName);
          });
        },
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isSelected! ? Color(0xFF5081db) : Color(0xFF535c65),
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Text(
            widget.siteName,
            style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
                fontFamily: "Poppins"),
          ),
        ),
      ),
    );
  }
}
