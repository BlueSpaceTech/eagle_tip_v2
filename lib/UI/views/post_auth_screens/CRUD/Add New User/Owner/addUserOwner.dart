// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:testttttt/Providers/user_provider.dart';
import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/Services/Crud_functions.dart';
import 'package:testttttt/UI/Widgets/customNav.dart';
import 'package:testttttt/UI/Widgets/customappheader.dart';
import 'package:testttttt/UI/Widgets/customfab.dart';
import 'package:testttttt/UI/Widgets/customsubmitbutton.dart';
import 'package:testttttt/UI/Widgets/customtoast.dart';
import 'package:testttttt/UI/views/post_auth_screens/CRUD/Add%20New%20User/invitation.dart';
import 'package:testttttt/UI/views/post_auth_screens/Sites/sites.dart';
import 'package:testttttt/Utils/common.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:testttttt/Models/user.dart' as model;

class AddNewUserByOwner extends StatefulWidget {
  AddNewUserByOwner({Key? key}) : super(key: key);

  @override
  State<AddNewUserByOwner> createState() => _AddNewUserByOwnerState();
}

class _AddNewUserByOwnerState extends State<AddNewUserByOwner> {
  bool isselect = false;
  FToast? fToast;

  List Roles = ["SiteManager", "SiteUser"];
  String selectedrOLE = "";

  List<dynamic> selectedsites = [];

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fToast = FToast();
    fToast!.init(context);
  }

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    List sites;
    sites = user.sites;

    bool isTapped = false;
    List Roles = ["Site Manager", "Site User"];
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: backGround_color,
          child: Column(
            children: [
              Navbar(
                  width: width, height: height, text1: "text1", text2: "text2"),
              Container(
                height: height * 1,
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
                      Row(
                        children: [
                          Wrap(
                            children: _buildall(sites),
                          ),
                          Wrap(
                            children: _buildsiteschip(sites),
                          ),
                        ],
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
                        children:
                            _buildRolechip(CrudFunction().visibleRole(user)),
                      ),
                      SizedBox(
                        height: Responsive.isDesktop(context)
                            ? height * 0.28
                            : height * 0.2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              if (selectedrOLE == "" || selectedsites.isEmpty) {
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
                                        sites: selectedsites,
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
