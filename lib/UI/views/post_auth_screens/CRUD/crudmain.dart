// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:testttttt/Models/sites.dart';
import 'package:testttttt/Providers/user_provider.dart';
import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/Services/Crud_functions.dart';
import 'package:testttttt/Services/site_call.dart';
import 'package:testttttt/UI/Widgets/customNav.dart';
import 'package:testttttt/UI/Widgets/customTextField.dart';
import 'package:testttttt/UI/Widgets/custom_webbg.dart';
import 'package:testttttt/UI/Widgets/customappheader.dart';
import 'package:testttttt/UI/Widgets/customfab.dart';
import 'package:testttttt/UI/Widgets/logo.dart';
import 'package:testttttt/UI/views/post_auth_screens/CRUD/Add%20New%20User/Owner/addUserOwner.dart';
import 'package:testttttt/UI/views/post_auth_screens/CRUD/sent_to.dart';
import 'package:testttttt/UI/views/post_auth_screens/Chat/chatting.dart';
import 'package:testttttt/UI/views/post_auth_screens/Chat/message_main.dart';
import 'package:testttttt/UI/views/post_auth_screens/Chat/web_chatting.dart';
import 'package:testttttt/UI/views/post_auth_screens/Notifications/createNotification.dart';

import 'package:testttttt/UI/views/post_auth_screens/UserProfiles/myprofile.dart';
import 'package:testttttt/UI/views/post_auth_screens/UserProfiles/userProfile.dart';
import 'package:testttttt/Utils/common.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:provider/provider.dart';
import 'package:testttttt/Models/user.dart' as model;
import 'package:firestore_search/firestore_search.dart';
// import 'package:universal_html/html.dart';

class CrudScreen extends StatefulWidget {
  const CrudScreen({Key? key}) : super(key: key);

  @override
  _CrudScreenState createState() => _CrudScreenState();
}

class _CrudScreenState extends State<CrudScreen> {
  LinkedScrollControllerGroup? _controllers;
  ScrollController? _letters;
  ScrollController? _numbers;
  late ScrollController SCROL;

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
            //  print("fetching");

            userRole = data.get("userRole");
            // email = data.get("email");
            // phone = data.get("phonenumber");
          });
        }
      }
    });
  }

  _buildsiteschip(List site) {
    bool issel = false;

    List<Widget> choices = [];
    site.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(3),
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
              _onsearchange();
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
            _onsearchange();
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
              _onsearchange();
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
    super.initState();
    if (mounted) {
      getCurrentUserRole();
    }

    getData();

    _controllers = LinkedScrollControllerGroup();
    _letters = _controllers!.addAndGet();
    _numbers = _controllers!.addAndGet();
    _search.addListener(_onsearchange);
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      ShowCaseWidget.of(context)!.startShowCase([_key1, _key2, _key3]);
    });
  }

  @override
  void dispose() {
    _letters!.dispose();
    _numbers!.dispose();
    _search.removeListener(_onsearchange);
    _search.dispose();

    super.dispose();
  }

  List<SitesDetails>? sitedetails;
  List allsitename = [];

  getData() async {
    sitedetails = await SiteCall().getSites();

    for (var document in sitedetails!) {
      allsitename.add(document.sitename);
    }
    // print(allsitename);
  }

  callUserInfoScreen(String name, String email, String userRole, String dpUrl,
      List sites, String phonenumber, String uid) {
    Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => UserProfile(
                  name: name,
                  email: email,
                  userRole: userRole,
                  dpUrl: dpUrl,
                  sites: sites,
                  phonenumber: phonenumber,
                  uid: uid,
                  fromsentto: false,
                )));
  }

  Future? resultsloaded;

  List _allResults = [];
  List _resultList = [];
  TextEditingController _search = TextEditingController();

  getUserdetails(List sites, String uid, model.User user) async {
    var data;
    userRole == "AppAdmin" || userRole == "SuperAdmin"
        ? data = await FirebaseFirestore.instance
            .collection("users")
            .where("uid", isNotEqualTo: uid)
            .where("userRole", whereIn: CrudFunction().visibleRole(user))
            .get()
        : data = await FirebaseFirestore.instance
            .collection("users")
            .where("sites", arrayContainsAny: sites)
            .where("uid", isNotEqualTo: uid)
            // .where("userRole", whereIn: CrudFunction().visibleRole(user))
            .get();
    if (mounted) {
      setState(() {
        _allResults = data.docs;
      });
    }

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
    model.User? user = Provider.of<UserProvider>(context).getUser;
    resultsloaded = getUserdetails(user!.sites, user.uid, user);
    super.didChangeDependencies();
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
      for (var usersnap in _allResults) {
        var role = model.User.fromSnap(usersnap).userRole;
        var user = model.User.fromSnap(usersnap);
        List visiblefor = CrudFunction().visibleRole2(userRole);
        // List visiblefor = ["SiteManager", "SiteUser"];
        if (visiblefor.contains(usersnap["userRole"])) {
          showResults.add(usersnap);
        } else {
          // _allResults.remove(user);

        }
      }

      // showResults = List.from(_allResults);
    }
    if (mounted) {
      setState(() {
        _resultList = showResults;
      });
    }
  }

  final _key1 = GlobalKey();
  final _key2 = GlobalKey();
  final _key3 = GlobalKey();
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
            child: Showcase(
              description: "Tap to go to Invitation screen",
              key: _key2,
              disposeOnTap: true,
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
              onTargetClick: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShowCaseWidget(
                        builder:
                            Builder(builder: (context) => AddNewUserByOwner()),
                      ),
                    )).then((_) {
                  setState(() {
                    ShowCaseWidget.of(context)!.startShowCase([_key3]);
                  });
                });
              },
              child: customfab(
                width: width,
                text: "Add new user",
                height: height,
              ),
            ),
          ),
        ),
        backgroundColor: Color(0xff2B343B),
        body: Column(
          children: [
            Navbar(
              width: width,
              height: height,
            ),
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
                                          "Edit Users",
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
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
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
                                                color: Colors.white
                                                    .withOpacity(0.5)),
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Visibility(
                                        visible: Responsive.isDesktop(context),
                                        child: InkWell(
                                            onTap: () {
                                              Navigator.pushNamed(context,
                                                  AppRoutes.addUserOwner);
                                            },
                                            child: Showcase(
                                              key: _key2,
                                              description:
                                                  "Tap to go to Invitation screen",
                                              disposeOnTap: true,
                                              titleTextStyle: TextStyle(
                                                fontSize: 17.0,
                                                color: Colors.white,
                                              ),
                                              descTextStyle: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.white,
                                              ),
                                              shapeBorder:
                                                  RoundedRectangleBorder(),
                                              overlayPadding:
                                                  EdgeInsets.all(8.0),
                                              showcaseBackgroundColor:
                                                  Color(0xFF5081DB),
                                              contentPadding:
                                                  EdgeInsets.all(8.0),
                                              onTargetClick: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ShowCaseWidget(
                                                        builder: Builder(
                                                            builder: (context) {
                                                          return AddNewUserByOwner();
                                                        }),
                                                      ),
                                                    )).then((_) {
                                                  setState(() {
                                                    ShowCaseWidget.of(context)!
                                                        .startShowCase([_key3]);
                                                  });
                                                });
                                              },
                                              child: customfab(
                                                height: height,
                                                width: width,
                                                text: "Add new user",
                                              ),
                                            )),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
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
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Visibility(
                                        visible: Responsive.isDesktop(context),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, AppRoutes.sentto);
                                          },
                                          child: Showcase(
                                            key: _key3,
                                            description:
                                                "Tap to view Invitations sent by you",
                                            disposeOnTap: true,
                                            titleTextStyle: TextStyle(
                                              fontSize: 17.0,
                                              color: Colors.white,
                                            ),
                                            descTextStyle: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.white,
                                            ),
                                            shapeBorder:
                                                RoundedRectangleBorder(),
                                            overlayPadding: EdgeInsets.all(8.0),
                                            showcaseBackgroundColor:
                                                Color(0xFF5081DB),
                                            contentPadding: EdgeInsets.all(8.0),
                                            onTargetClick: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        (SentTo()),
                                                  ));
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              width:
                                                  Responsive.isDesktop(context)
                                                      ? width * 0.13
                                                      : width * 0.42,
                                              height: height * 0.064,
                                              decoration: BoxDecoration(
                                                color: Color(0xff5081DB),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Sent Invitations",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.white,
                                                        fontFamily: "Poppins",
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  SizedBox(
                                                    width: width * 0.012,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: height * 0.02),
                                  Showcase(
                                    key: _key1,
                                    // disposeOnTap: true,
                                    showArrow: false,
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

                                    description:
                                        "You can search users according to their sites and roles by selecting site and role",
                                    child: Text(
                                      "Site",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Poppins",
                                          fontSize: 15),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.02,
                                  ),
                                  Wrap(
                                    children: [
                                      Wrap(
                                        children: [
                                          user?.userRole == "AppAdmin" ||
                                                  user?.userRole == "SuperAdmin"
                                              //     ||
                                              // user.userRole ==
                                              //     "TerminalManager" ||
                                              // user.userRole ==
                                              //     "TerminalUser"
                                              ? Wrap(
                                                  runSpacing: 10,
                                                  children:
                                                      _buildall(allsitename),
                                                )
                                              : Wrap(
                                                  children:
                                                      _buildall(user!.sites),
                                                ),
                                          user?.userRole == "AppAdmin" ||
                                                  user?.userRole == "SuperAdmin"
                                              //      ||
                                              // user.userRole ==
                                              //     "TerminalManager" ||
                                              // user.userRole ==
                                              //     "TerminalUser"
                                              ? Wrap(
                                                  runSpacing: 10,
                                                  children: _buildsiteschip(
                                                      allsitename),
                                                )
                                              : Wrap(
                                                  children: _buildsiteschip(
                                                      user!.sites),
                                                ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.04,
                                  ),
                                  Text(
                                    "Role",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Poppins",
                                        fontSize: 15),
                                  ),
                                  SizedBox(
                                    height: height * 0.02,
                                  ),
                                  Wrap(
                                    children: _buildRolechip(
                                        CrudFunction().visibleRole(user!)),
                                  ),
                                ])),

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
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.only(top: 0),
                            shrinkWrap: true,
                            itemCount: _resultList.length,
                            itemBuilder: (BuildContext context, int index) {
                              final document = _resultList[index];
                              List site = document!["sites"];
                              // double hh = 0;

                              return CRUDtile(
                                  numbers: _numbers,
                                  width: width,
                                  document: document,
                                  site: site,
                                  index: index,
                                  allsitename: allsitename,
                                  height: height,
                                  opendelete: () {
                                    // deletUserDialog(height, width,
                                    //     document["name"], document["uid"]);
                                  },
                                  openchat: () {
                                    // callChatScreen(
                                    //   document.id,
                                    //   document["name"],
                                    //   user.name,
                                    //   document["dpUrl"],
                                    //   user.dpurl,
                                    // );
                                  });
                            }),
                        SizedBox(
                          height: height * 0.1,
                        ),
                      ],
                    ),
                  ),
                ),
                // Positioned.fill(
                //   child: Align(
                //     alignment: Alignment.center,
                //     child: Visibility(
                //         visible: _loading,
                //         child: CircularProgressIndicator(
                //           backgroundColor: Colors.grey.shade300,
                //           color: Colors.blue,
                //         )),
                //   ),
                // ),
              ]),
            ),
          ],
        ));
  }
}

class CRUDtile extends StatefulWidget {
  const CRUDtile({
    Key? key,
    required ScrollController? numbers,
    required this.width,
    required this.document,
    required this.site,
    required this.index,
    required this.allsitename,
    required this.height,
    required this.opendelete,
    required this.openchat,
  })  : _numbers = numbers,
        super(key: key);

  final ScrollController? _numbers;
  final double width;
  final DocumentSnapshot document;
  final List site;
  final int index;
  final List allsitename;
  final double height;
  final Function opendelete;
  final Function openchat;

  @override
  State<CRUDtile> createState() => _CRUDtileState();
}

class _CRUDtileState extends State<CRUDtile> {
  bool _loading = false;
  void callChatScreen(String uid, String name, String currentusername,
      String photoUrlfriend, String photourluser) async {
    setState(() {
      _loading = true;
    });
    await getChatId(uid, name, currentusername, photoUrlfriend, photourluser);

    await Future.delayed(const Duration(seconds: 3));
    print(chatId + "gggggR");
    setState(() {
      _loading = false;
    });
    Responsive.isDesktop(context)
        ? Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => MessageMain(
                      // photourlfriend: photoUrlfriend,
                      // photourluser: photourluser,
                      // index: 0,
                      // frienduid: uid,
                      // friendname: name,
                      // currentusername: currentusername,
                      Chatscreen: WebChatScreenn(
                        photourlfriend: photoUrlfriend,
                        friendname: name,
                        chatId: chatId,
                      ),
                    )))
        : Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => ChatScreenn(
                    photourlfriend: photoUrlfriend,
                    photourluser: photourluser,
                    index: 0,
                    frienduid: uid,
                    friendname: name,
                    currentusername: currentusername)));
  }

  CollectionReference chat = FirebaseFirestore.instance.collection("chats");
  final currentUserUID = FirebaseAuth.instance.currentUser!.uid;
  var chatId;
  getChatId(String frienduid, String friendname, String currentusername,
      String photourlfriend, String photourluser) async {
    await chat
        .where("users", isEqualTo: {frienduid: null, currentUserUID: null})
        .limit(1)
        .get()
        .then((QuerySnapshot querySnapshot) {
          if (querySnapshot.docs.isNotEmpty) {
            setState(() {
              chatId = querySnapshot.docs.single.id;
            });
          } else {
            chat.add({
              'users': {frienduid: null, currentUserUID: null},
              "between": [frienduid, currentUserUID],
              "user1": friendname,
              "user2": currentusername,
              "uid1": currentUserUID,
              "uid2": frienduid,
              "photo1": photourluser,
              "photo2": photourlfriend,
              "recentTime": FieldValue.serverTimestamp(),
              "isNew": currentUserUID,
            }).then((value) => {
                  setState(() {
                    chatId = value.id;
                  })
                });
          }
        })
        .catchError((err) {});
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String selectedrOLE = "";
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

  deletUserDialog(double height, double width, String name, String uid) {
    // Future<void> del(String message) async {
    //   HttpsCallable callable =
    //       FirebaseFunctions.instance.httpsCallable('deleteUser');
    //   await callable.call(<String, dynamic>{
    //     'uid': uid,
    //   });
    // }

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
                          .collection("users")
                          .doc(uid)
                          .delete();
                      // del("message");
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

  double hh = 0;
  bool isvisibleRole = false;
  bool isvisibleSite = false;
  List<String> _selectedItems2 = [];
  @override
  Widget build(BuildContext context) {
    model.User? user = Provider.of<UserProvider>(context).getUser;
    _showSiteSelect() async {
      final List _items =
          user!.userRole == "AppAdmin" || user.userRole == "SuperAdmin"
              ? widget.allsitename
              : user.sites;
      for (var element in _items) {
        element = element.toString();
      }

      final List<String>? results = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SiteSelectCrud(items: _items);
        },
      );

      // Update UI
      if (results != null) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(widget.document.id)
            .update({'sites': results});
      }
    }

    final TextEditingController _phone =
        TextEditingController(text: widget.document["phonenumber"]);

    return SingleChildScrollView(
      physics: Responsive.isDesktop(context)
          ? NeverScrollableScrollPhysics()
          : BouncingScrollPhysics(),
      controller: widget._numbers,
      scrollDirection: Axis.horizontal,
      child: Stack(children: [
        Column(children: [
          Container(
            decoration: BoxDecoration(
              color:
                  widget.index % 2 == 0 ? Color(0xff2B343B) : Color(0xff24292E),
            ),
            height: 60,
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    deletUserDialog(widget.height, widget.width,
                        widget.document["name"], widget.document["uid"]);
                  },
                  child: Container(
                      width: Responsive.isDesktop(context)
                          ? widget.width * 0.08
                          : widget.width * 0.16,
                      child: Image.asset("assets/delete.png")),
                ),
                InkWell(
                  onTap: () {
                    // callUserInfoScreen(
                    //     document["name"],
                    //     document["email"],
                    //     document["userRole"],
                    //     document["dpUrl"],
                    //     document["sites"],
                    //     document["phonenumber"],
                    //     document["uid"]);
                  },
                  child: Container(
                    width: Responsive.isDesktop(context)
                        ? widget.width * 0.22
                        : widget.width * 0.4,
                    child: Text(
                      '${widget.index + 1}. ${widget.document["name"]}',
                      style:
                          TextStyle(color: Colors.white, fontFamily: "Poppins"),
                    ),
                  ),
                ),
                Container(
                  width: Responsive.isDesktop(context)
                      ? widget.width * 0.12
                      : widget.width * 0.24,
                  child: Text(widget.document["userRole"],
                      style: TextStyle(
                          color: Colors.white, fontFamily: "Poppins")),
                ),
                Container(
                  width: Responsive.isDesktop(context)
                      ? widget.width * 0.32
                      : widget.width * 0.52,
                  child: Text(widget.site.join(", "),
                      // "",
                      style: TextStyle(
                          color: Colors.white, fontFamily: "Poppins")),
                ),
                InkWell(
                    onTap: () {
                      // callUserInfoScreen(
                      //     document["name"],
                      //     document["email"],
                      //     document["userRole"],
                      //     document["dpUrl"],
                      //     document["sites"],
                      //     document["phonenumber"],
                      //     document["uid"]);

                      setState(() {
                        if (hh == 150) {
                          hh = 0;
                        } else {
                          hh = 150;
                        }
                      });
                    },
                    child: Image.asset("assets/info.png")),
                SizedBox(
                  width: widget.width * 0.04,
                ),
              ],
            ),
          ),
          AnimatedContainer(
            padding: EdgeInsets.symmetric(horizontal: 8),
            duration: Duration(milliseconds: 250),
            height: hh,
            width: widget.width * 0.8,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Email : ${widget.document["email"]}",
                            style: TextStyle(
                                color: Colors.white, fontFamily: "Poppins")),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: widget.width * 0.3,
                          child: Wrap(
                            children: [
                              Text("Sites : ${widget.site.join(", ")}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Poppins")),
                              SizedBox(
                                width: 5,
                              ),
                              InkWell(
                                  onTap: _showSiteSelect,
                                  child: Icon(
                                    Icons.edit,
                                    size: 20,
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: widget.width * 0.2,
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("User Role : ${widget.document["userRole"]}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Poppins")),
                              SizedBox(
                                width: 5,
                              ),
                              InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (isvisibleRole) {
                                        isvisibleRole = false;
                                      } else {
                                        isvisibleRole = true;
                                      }

                                      // isvisible != isvisible;
                                    });
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    size: 20,
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                  "Phone number : ${widget.document["phonenumber"]}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Poppins")),
                              SizedBox(
                                width: 5,
                              ),
                              InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Update Phone number'),
                                          content: Container(
                                            height: 120,
                                            decoration: BoxDecoration(),
                                            child: Container(
                                              width:
                                                  Responsive.isDesktop(context)
                                                      ? 400
                                                      : widget.width * 0.8,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: Responsive
                                                          .isDesktop(context)
                                                      ? widget.width * 0.02
                                                      : widget.width * 0.06),
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  color: Color(0xffEFF0F6)
                                                      .withOpacity(0.7),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(15)),
                                                  border: Border.all(
                                                      color: Colors.blue)),
                                              child: TextField(
                                                maxLength: 10,
                                                enabled: true,
                                                controller: _phone,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "Poppins",
                                                    fontSize: 16),
                                                cursorColor: Colors.black12,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  labelText: "",
                                                  labelStyle: TextStyle(
                                                      color: Color(0xff5e8be0),
                                                      fontFamily: "Poppins",
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              child: const Text('Cancel'),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                            ElevatedButton(
                                              child: const Text('Ok'),
                                              style: ElevatedButton.styleFrom(
                                                primary: Color(0Xff5081db),
                                              ),
                                              onPressed: () {
                                                if (_phone.text.length == 10) {
                                                  FirebaseFirestore.instance
                                                      .collection('users')
                                                      .doc(widget.document.id)
                                                      .update({
                                                    'phonenumber': _phone.text
                                                  });
                                                  Navigator.pop(context);
                                                } else {}
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    size: 20,
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                        ]),
                    SizedBox(
                      width: 20,
                    ),
                    Column(children: [
                      InkWell(
                        onTap: () {
                          callChatScreen(
                            widget.document.id,
                            widget.document["name"],
                            user!.name,
                            widget.document["dpUrl"],
                            user.dpurl,
                          );
                        },
                        child: Container(
                          width: 80,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Color(0xFF5081DB),
                          ),
                          child: Center(
                            child: Text(
                              "Chat",
                              style: TextStyle(
                                fontSize: 13.0,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                isvisibleRole
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Wrap(
                            children: _buildRolechip(
                                CrudFunction().visibleRole(user!)),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              if (selectedrOLE != "") {
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(widget.document.id)
                                    .update({'userRole': selectedrOLE});
                                setState(() {
                                  isvisibleRole = false;
                                });
                              } else {
                                setState(() {
                                  isvisibleRole = false;
                                });
                              }
                            },
                            child: Icon(
                              Icons.check,
                              size: 35,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
        ]),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: Visibility(
                visible: _loading,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey.shade300,
                  color: Colors.blue,
                )),
          ),
        ),
      ]),
    );
  }
}

class SiteSelectCrud extends StatefulWidget {
  final List<dynamic> items;
  const SiteSelectCrud({Key? key, required this.items}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SiteSelectCrudState();
}

class _SiteSelectCrudState extends State<SiteSelectCrud> {
  // this variable holds the selected items
  final List<String> _selectedItems = [];

// This function is triggered when a checkbox is checked or unchecked

  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems.add(itemValue.toString());
        // print(itemValue);
      } else {
        _selectedItems.remove(itemValue.toString());
      }
    });
  }

  // this function is called when the Cancel button is pressed
  void _cancel() {
    Navigator.pop(context);
  }

// this function is called when the Submit button is tapped
  void _submit() {
    // print(_selectedItems);
    Navigator.pop(context, _selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Sites'),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items
              .map((item) => CheckboxListTile(
                    value: _selectedItems.contains(item.toString()),
                    title: Text(item),
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (isChecked) => _itemChange(item, isChecked!),
                  ))
              .toList(),
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: _cancel,
        ),
        ElevatedButton(
          child: const Text('Ok'),
          style: ElevatedButton.styleFrom(
            primary: Color(0Xff5081db),
          ),
          onPressed: _submit,
        ),
      ],
    );
  }
}
