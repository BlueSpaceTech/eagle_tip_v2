// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/UI/Widgets/customNav.dart';
import 'package:testttttt/UI/Widgets/customappheader.dart';
import 'package:testttttt/UI/Widgets/customfab.dart';
import 'package:testttttt/UI/Widgets/customsubmitbutton.dart';
import 'package:testttttt/UI/views/post_auth_screens/CRUD/Add%20New%20User/invitation.dart';
import 'package:testttttt/UI/views/post_auth_screens/Sites/sites.dart';
import 'package:testttttt/Utils/common.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:flutter/material.dart';

class AddNewUserByOwner extends StatefulWidget {
  AddNewUserByOwner({Key? key}) : super(key: key);

  @override
  State<AddNewUserByOwner> createState() => _AddNewUserByOwnerState();
}

class _AddNewUserByOwnerState extends State<AddNewUserByOwner> {
  bool isselect = false;

  List sites = [
    "All",
    "Acers Marathon",
    "Bridge Marathon",
    "Clarks Marathon",
    "Huntington Marathon"
  ];
  List Roles = ["SiteManager", "SiteUser"];
  String selectedrOLE = "";

  List<String> selectedsites = [];
  _buildsiteschip() {
    bool issel = false;
    List<Widget> choices = [];
    sites.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
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

  _buildRolechip() {
    bool isroleselected = false;
    List<Widget> choicess = [];
    Roles.forEach((item) {
      choicess.add(Container(
        padding: const EdgeInsets.all(2.0),
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

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    List<String> sites = [
      "All",
      "Acers Marathon",
      "Bridge Marathon",
      "Clarks Marathon",
      "Huntington Marathon"
    ];

    bool isTapped = false;
    List Roles = ["Site Manager", "Site User"];
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: backGround_color,
            child: Column(
              children: [
                Navbar(
                    width: width,
                    height: height,
                    text1: "text1",
                    text2: "text2"),
                SingleChildScrollView(
                  child: Container(
                    height: height * 1,
                    color: backGround_color,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.04,
                          right: width * 0.04,
                          top: height * 0.0),
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
                                Row(
                                  children: [
                                    Text(
                                      "    ",
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 25),
                                    ),
                                  ],
                                ),
                                Text(
                                  "Add new Employee",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      color: Colors.white,
                                      fontSize: 20),
                                ),
                                Text("                       "),
                              ],
                            ),
                          ),
                          Visibility(
                              visible: !Responsive.isDesktop(context),
                              child: CustomAppheader(width: width)),
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
                            "Site",
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
                          Wrap(
                            children: _buildsiteschip(),
                          ),
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
                            children: _buildRolechip(),
                          ),
                          SizedBox(
                            height: height * 0.32,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Invitation(
                                          sites: selectedsites,
                                          role: selectedrOLE,
                                        ),
                                      ));
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
                ),
              ],
            ),
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
