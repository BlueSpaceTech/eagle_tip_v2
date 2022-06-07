// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:testttttt/Providers/user_provider.dart';
import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/Services/Crud_functions.dart';
import 'package:testttttt/UI/Widgets/customNav.dart';
import 'package:testttttt/UI/Widgets/custom_webbg.dart';
import 'package:testttttt/UI/Widgets/customappheader.dart';
import 'package:testttttt/UI/Widgets/customfab.dart';
import 'package:testttttt/UI/Widgets/logo.dart';

import 'package:testttttt/UI/views/post_auth_screens/UserProfiles/myprofile.dart';
import 'package:testttttt/UI/views/post_auth_screens/UserProfiles/userProfile.dart';
import 'package:testttttt/Utils/common.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:provider/provider.dart';
import 'package:testttttt/Models/user.dart' as model;
import 'package:firestore_search/firestore_search.dart';

class SentTo extends StatefulWidget {
  const SentTo({Key? key}) : super(key: key);

  @override
  _SentToState createState() => _SentToState();
}

class _SentToState extends State<SentTo> {
  LinkedScrollControllerGroup? _controllers;
  ScrollController? _letters;
  ScrollController? _numbers;
  late ScrollController SCROL;

  deletUserDialog(double height, double width, String name, String employer) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        title: Center(
          child: Text(
            'Delete User',
            style: TextStyle(
              fontSize: 23.0,
              fontWeight: FontWeight.bold,
              fontFamily: "Poppins",
              color: Colors.black,
            ),
          ),
        ),
        content: Container(
          width: Responsive.isDesktop(context) ? width * 0.38 : width * 0.8,
          height: height * 0.2,
          child: Column(
            children: [
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Are you sure you want to delete',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Poppins",
                            color: Color(0xff14142B))),
                    TextSpan(
                        text: ' ${name} ?',
                        style: TextStyle(
                            color: Color(0xff14142B),
                            fontSize: 18,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              Text(
                  "After deleting the user will no longer be able to login the app",
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Poppins",
                      color: Color(0xff14142B))),
              SizedBox(
                height: height * 0.04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: Responsive.isDesktop(context)
                          ? width * 0.15
                          : width * 0.32,
                      height: height * 0.055,
                      decoration: BoxDecoration(
                        color: Color(0xffED5C62),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Text(
                          "Back",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13.0,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Poppins"),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: width * 0.02),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      FirebaseFirestore.instance
                          .collection("invitations")
                          .doc(employer)
                          .delete();
                    },
                    child: Container(
                      width: Responsive.isDesktop(context)
                          ? width * 0.15
                          : width * 0.32,
                      height: height * 0.055,
                      decoration: BoxDecoration(
                        color: Color(0Xff28519D),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Text(
                          "Confirm",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13.0,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Poppins"),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String selectedrOLE = "";
  String userRole = "";
  List<dynamic> selectedsites = [];
  getCurrentUserRole() async {
    DocumentReference dbRef = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    await dbRef.get().then((data) {
      if (data.exists) {
        if (mounted) {
          setState(() {
            print("fetching");

            userRole = data.get("userRole");
            // email = data.get("email");
            // phone = data.get("phonenumber");
          });
        }
      }
    });
  }

  callUserInfoScreen(String name, String email, String userRole, List sites,
      String phonenumber) {
    Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => UserProfile(
                  name: name,
                  email: email,
                  userRole: userRole,
                  dpUrl: "sentto",
                  sites: sites,
                  phonenumber: phonenumber,
                  uid: "ff",
                  fromsentto: true,
                )));
  }

  @override
  void initState() {
    super.initState();
    getCurrentUserRole();
    _controllers = LinkedScrollControllerGroup();
    _letters = _controllers!.addAndGet();
    _numbers = _controllers!.addAndGet();
    _search.addListener(_onsearchange);
  }

  @override
  void dispose() {
    _letters!.dispose();
    _numbers!.dispose();
    _search.removeListener(_onsearchange);
    _search.dispose();
    super.dispose();
  }

  Future? resultsloaded;

  List _allResults = [];
  List _resultList = [];
  TextEditingController _search = TextEditingController();

  getUserdetails(List sites, String uid, model.User user) async {
    var data = user.userRole == "AppAdmin" || user.userRole == "SuperAdmin"
        ? await FirebaseFirestore.instance
            .collection("invitations")
            .where("visibleto", arrayContains: user.userRole)
            // .where("sites", arrayContains: user.sites)
            // .where("userRole", whereIn: CrudFunction().visibleRole(user))
            .get()
        : await FirebaseFirestore.instance
            .collection("invitations")
            // .where("visibleto", arrayContains: user.userRole)
            .where("sites", arrayContainsAny: user.sites)
            // .where("userRole", whereIn: CrudFunction().visibleRole(user))
            .get();

    setState(() {
      _allResults = data.docs;
    });
    // print(CrudFunction().visibleRole(user));
    // print(_allResults.length);
    // _allResults.removeWhere(
    //     (element) => element["userRole"] != CrudFunction().visibleRole(user));
    // for (var element = 0; element < _allResults.length; element++) {
    //   print(element);
    //   if (CrudFunction()
    //       .visibleRole(user)
    //       .contains(_allResults[element]["userRole"])) {
    //     print(_allResults[element]["name"] +
    //         "contains" +
    //         _allResults[element]["userRole"]);
    //   } else {
    //     _allResults.removeAt(element);
    //     print(_allResults[element]["name"] +
    //         "removed" +
    //         _allResults[element]["userRole"]);
    //   }
    // }
    // print(_allResults.length);
    // for (var ele in _allResults) {
    //   print(ele["name"]);
    // }

    searchresult();
    return "done";
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    model.User? user = Provider.of<UserProvider>(context).getUser;
    resultsloaded = getUserdetails(user!.sites, user.uid, user);
  }

  _onsearchange() {
    searchresult();
  }

  searchresult() {
    // model.User user = Provider.of<UserProvider>(context).getUser;
    var showResults = [];
    if (_search.text != "") {
      //we have a search parameter
      for (var usersnap in _resultList) {
        var name = model.User.fromSnap(usersnap).name.toLowerCase();

        if (name.contains(_search.text.toLowerCase())) {
          showResults.add(usersnap);
        }

        /*
        if (sites.contains(selectedsites)) {
          showResults.add(usersnap);
        }
        */

      }
    } else if (selectedrOLE != "") {
      for (var usersnap in _resultList) {
        var userRole = model.User.fromSnap(usersnap).userRole;
        if (userRole.contains(selectedrOLE)) {
          showResults.add(usersnap);
        }
      }
    } else if (selectedsites.isNotEmpty) {
      for (var usersnap in _resultList) {
        var sites = model.User.fromSnap(usersnap).sites;
        if (selectedsites.every((item) => sites.contains(item))) {
          showResults.add(usersnap);
        }
      }
    } else {
      // for (var usersnap in _allResults) {
      //   //   var role = model.User.fromSnap(usersnap).userRole;
      //   //   var user = model.User.fromSnap(usersnap);
      //   //   List visiblefor = CrudFunction().visibleRole2(userRole);
      //   //   // List visiblefor = ["SiteManager", "SiteUser"];
      //   //   if (visiblefor.contains(usersnap["userRole"])) {
      //   //     print("contains");
      //   //     showResults.add(usersnap);
      //   //   } else {
      //   //     // _allResults.remove(user);
      //   //     print("removed");
      //   //   }
      //   // }
      // }

      showResults = List.from(_allResults);
    }
    setState(() {
      _resultList = showResults;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool? isTapped = false;
    model.User? user = Provider.of<UserProvider>(context).getUser;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        floatingActionButton: Visibility(
          visible: !Responsive.isDesktop(context),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.addUserOwner);
            },
            child: customfab(
              width: width,
              text: "Add new user",
              height: height,
            ),
          ),
        ),
        backgroundColor: Color(0xff2B343B),
        body: Column(
          children: [
            Navbar(
                width: width, height: height, text1: "text1", text2: "text2"),
            Expanded(
              child: Stack(clipBehavior: Clip.none, children: [
                //  WebBg(),
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal:
                            Responsive.isDesktop(context) ? width * 0.1 : 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: height * 0.05,
                        ),
                        Visibility(
                          visible: !Responsive.isDesktop(context),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: Responsive.isDesktop(context)
                                    ? 0
                                    : width * 0.01,
                                right: Responsive.isDesktop(context)
                                    ? 0
                                    : width * 0.01,
                                top: Responsive.isDesktop(context)
                                    ? height * 0.015
                                    : height * 0.04),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.08),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Responsive.isDesktop(context)
                              ? height * 0.076
                              : height * 0.02,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Responsive.isDesktop(context)
                                  ? 0
                                  : width * 0.04),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Visibility(
                                visible: Responsive.isDesktop(context),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "         ",
                                          style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 25),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "Invitations",
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          color: Colors.white,
                                          fontSize: 20),
                                    ),
                                    Text("                       "),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 60,
                              ),
                              Row(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.only(
                                        left: width * 0.06,
                                        right: width * 0.06),
                                    height: height * 0.064,
                                    width: Responsive.isDesktop(context)
                                        ? width * 0.6
                                        : width * 0.9,
                                    decoration: BoxDecoration(
                                      color: Color(0xff535C65),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: TextField(
                                      controller: _search,
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          color: Colors.white),
                                      cursorColor: Colors.white,
                                      decoration: InputDecoration(
                                        hintText: "Search by name",
                                        hintStyle: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.5)),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  // Visibility(
                                  //   visible: Responsive.isDesktop(context),
                                  //   child: InkWell(
                                  //       onTap: () {
                                  //         Navigator.pushNamed(
                                  //             context, AppRoutes.addUserOwner);
                                  //       },
                                  //       child: customfab(
                                  //         height: height,
                                  //         width: width,
                                  //         text: "Add new user",
                                  //       )),
                                  // ),
                                ],
                              ),
                              // SizedBox(height: height * 0.02),
                              // Text(
                              //   "Site",
                              //   style: TextStyle(
                              //       color: Colors.white,
                              //       fontFamily: "Poppins",
                              //       fontSize: 15),
                              // ),
                              // SizedBox(
                              //   height: height * 0.02,
                              // ),
                              // Row(
                              //   children: [
                              //     Wrap(
                              //       children: _buildall(user.sites),
                              //     ),
                              //     Wrap(
                              //       children: _buildsiteschip(user.sites),
                              //     ),
                              //   ],
                              // ),
                              // SizedBox(
                              //   height: height * 0.02,
                              // ),
                              // Text(
                              //   "Role",
                              //   style: TextStyle(
                              //       color: Colors.white,
                              //       fontFamily: "Poppins",
                              //       fontSize: 15),
                              // ),
                              // SizedBox(
                              //   height: height * 0.02,
                              // ),
                              // Wrap(
                              //   children: _buildRolechip(
                              //       CrudFunction().visibleRole(user)),
                              // ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        SingleChildScrollView(
                          controller: _letters,
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            height: 40,
                            color: Color(0xff2B343B),
                            child: Row(
                              children: [
                                Container(
                                  width: Responsive.isDesktop(context)
                                      ? width * 0.08
                                      : width * 0.16,
                                  child: Text(
                                    "",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white.withOpacity(0.5),
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Container(
                                  width: Responsive.isDesktop(context)
                                      ? width * 0.22
                                      : width * 0.4,
                                  child: Text(
                                    "Name",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white.withOpacity(0.5),
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Container(
                                  width: Responsive.isDesktop(context)
                                      ? width * 0.12
                                      : width * 0.24,
                                  child: Text(
                                    "Role",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white.withOpacity(0.5),
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Container(
                                  width: Responsive.isDesktop(context)
                                      ? width * 0.32
                                      : width * 0.52,
                                  child: Text(
                                    "Sites",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white.withOpacity(0.5),
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Container(
                                  width: width * 0.2,
                                  child: Text(
                                    "Profile Info",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white.withOpacity(0.5),
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.white.withOpacity(0.5),
                        ),
                        // FirestoreSearchResults.builder(
                        //   tag: 'example',
                        //   firestoreCollectionName: 'users',
                        //   searchBy: 'name',
                        //   initialBody: const Center(
                        //     child: Text('Initial body'),
                        //   ),
                        //   dataListFromSnapshot:
                        //       model.User.dataListFromSnapshot,
                        //   builder: (context, snapshot) {
                        //     if (snapshot.hasData) {
                        //       final List<model.User>? dataList =
                        //           snapshot.data;
                        //       if (dataList!.isEmpty) {
                        //         return const Center(
                        //           child: Text('No Results Returned'),
                        //         );
                        //       }
                        //       return ListView.builder(
                        //           itemCount: dataList.length,
                        //           itemBuilder: (context, index) {
                        //             final model.User data = dataList[index];

                        //             return Column(
                        //               mainAxisSize: MainAxisSize.min,
                        //               mainAxisAlignment:
                        //                   MainAxisAlignment.center,
                        //               crossAxisAlignment:
                        //                   CrossAxisAlignment.start,
                        //               children: [
                        //                 Padding(
                        //                   padding:
                        //                       const EdgeInsets.all(8.0),
                        //                   child: Text(
                        //                     '${""}',
                        //                     style: Theme.of(context)
                        //                         .textTheme
                        //                         .headline6,
                        //                   ),
                        //                 ),
                        //                 Padding(
                        //                   padding: const EdgeInsets.only(
                        //                       bottom: 8.0,
                        //                       left: 8.0,
                        //                       right: 8.0),
                        //                   child: Text('${""}',
                        //                       style: Theme.of(context)
                        //                           .textTheme
                        //                           .bodyText1),
                        //                 )
                        //               ],
                        //             );
                        //           });
                        //     }

                        //     if (snapshot.connectionState ==
                        //         ConnectionState.done) {
                        //       if (!snapshot.hasData) {
                        //         return const Center(
                        //           child: Text('No Results Returned'),
                        //         );
                        //       }
                        //     }
                        //     return const Center(
                        //       child: CircularProgressIndicator(),
                        //     );
                        //   },
                        // ),
                        _resultList.isEmpty
                            ? Center(
                                child: Text(
                                  "No Invitations to display",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            : ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.only(top: 0),
                                shrinkWrap: true,
                                itemCount: _resultList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final document = _resultList[index];
                                  List site = document!["sites"];

                                  return SingleChildScrollView(
                                    physics: Responsive.isDesktop(context)
                                        ? NeverScrollableScrollPhysics()
                                        : BouncingScrollPhysics(),
                                    controller: _numbers,
                                    scrollDirection: Axis.horizontal,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: index % 2 == 0
                                            ? Color(0xff2B343B)
                                            : Color(0xff24292E),
                                      ),
                                      height: 60,
                                      child: Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              deletUserDialog(
                                                  height,
                                                  width,
                                                  document["name"],
                                                  document["employercode"]);
                                            },
                                            child: Container(
                                                width: Responsive.isDesktop(
                                                        context)
                                                    ? width * 0.08
                                                    : width * 0.16,
                                                child: Image.asset(
                                                    "assets/delete.png")),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              callUserInfoScreen(
                                                  document["name"],
                                                  document["email"],
                                                  userRole,
                                                  document["sites"],
                                                  document["phonenumber"]);
                                            },
                                            child: Container(
                                              width:
                                                  Responsive.isDesktop(context)
                                                      ? width * 0.22
                                                      : width * 0.4,
                                              child: Text(
                                                '${index + 1}. ${document["name"]}',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "Poppins"),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: Responsive.isDesktop(context)
                                                ? width * 0.12
                                                : width * 0.24,
                                            child: Text(document["userRole"],
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "Poppins")),
                                          ),
                                          Container(
                                            width: Responsive.isDesktop(context)
                                                ? width * 0.32
                                                : width * 0.52,
                                            child: Text(site.join(", "),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "Poppins")),
                                          ),
                                          SizedBox(
                                            width: width * 0.04,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                        SizedBox(
                          height: height * 0.1,
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ));
  }
}
