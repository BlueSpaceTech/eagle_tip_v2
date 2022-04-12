import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testttttt/Providers/user_provider.dart';
import 'package:testttttt/UI/views/post_auth_screens/faq.dart';
import 'package:testttttt/Utils/common.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:testttttt/Models/user.dart' as model;

class DesktopFAQs extends StatefulWidget {
  const DesktopFAQs({Key? key}) : super(key: key);

  @override
  _DesktopFAQsState createState() => _DesktopFAQsState();
}

class _DesktopFAQsState extends State<DesktopFAQs> {
  PageController page = PageController();
  String userrOLE = "AppAdmin";
  CollectionReference faqs = FirebaseFirestore.instance.collection("faq");
  getItems(List list) {
    List<SideMenuItem> item = [];
    for (int i = 0; i < list.length; i++) {
      item.add(SideMenuItem(
          priority: i,
          title: list[i],
          onTap: () {
            page.jumpToPage(i);
          },
          icon: Icon(null)));
    }
    return item;
  }

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;
    List foradmin = [
      "General",
      "Terminal Manager",
      "Terminal User",
      "Site Owner",
      "Site Manager",
      "Site User"
    ];
    List foruser = [
      "General",
      user.userRole,
    ];
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    // model.User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        height: height,
        color: backGround_color,
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: height * 0.04),
              child: SideMenu(
                controller: page,
                style: SideMenuStyle(
                    displayMode: SideMenuDisplayMode.auto,
                    // hoverColor: Colors.blue[100],
                    selectedColor: Color(0xFF353D45),
                    selectedTitleTextStyle: TextStyle(color: Colors.white),
                    selectedIconColor: Colors.white,
                    unselectedTitleTextStyle: TextStyle(color: Colors.grey[600])
                    // backgroundColor: Colors.amber
                    // openSideMenuWidth: 200
                    ),
                title: Padding(
                  padding: EdgeInsets.only(
                      left: width * 0.025,
                      top: height * 0.05,
                      bottom: height * 0.04),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "FAQ",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        fontSize: width * 0.012,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                // items: [
                //   SideMenuItem(
                //     priority: 0,
                //     title: 'General',
                //     onTap: () {
                //       page.jumpToPage(0);
                //     },
                //     icon: Icon(null),
                //   ),
                //   SideMenuItem(
                //     priority: 1,
                //     title: 'Site Owner (You)',
                //     onTap: () {
                //       page.jumpToPage(1);
                //     },
                //     icon: Icon(null),
                //   ),
                // ],
                items: getItems(
                    user.userRole == "AppAdmin" || user.userRole == "SuperAdmin"
                        ? foradmin
                        : foruser),
              ),
            ),
            user.userRole == "AppAdmin" || user.userRole == "SuperAdmin"
                ? Expanded(
                    child: PageView(
                    controller: page,
                    children: [
                      GeneralfAQ(width: width, height: height),
                      UserRolefAQ(
                          width: width,
                          height: height,
                          userRole: "TerminalManager"),
                      UserRolefAQ(
                          width: width,
                          height: height,
                          userRole: "TerminalUser"),
                      UserRolefAQ(
                          width: width, height: height, userRole: "SiteOwner"),
                      UserRolefAQ(
                          width: width,
                          height: height,
                          userRole: "SiteManager"),
                      UserRolefAQ(
                          width: width, height: height, userRole: "SiteUser"),
                    ],
                  ))
                : Expanded(
                    child: PageView(
                    controller: page,
                    children: [
                      GeneralfAQ(width: width, height: height),
                      UserRolefAQ(
                          width: width,
                          height: height,
                          userRole: user.userRole),
                    ],
                  ))
          ],
        ),
      )),
    );
  }
}

class GeneralfAQ extends StatefulWidget {
  const GeneralfAQ({Key? key, required this.width, required this.height})
      : super(key: key);
  final double width;
  final double height;
  @override
  _GeneralfAQState createState() => _GeneralfAQState();
}

class _GeneralfAQState extends State<GeneralfAQ> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: widget.height * 1,
        width: widget.width * 1,
        color: backGround_color,
        child: Padding(
          padding: EdgeInsets.only(
              left: widget.width * 0.04, top: widget.height * 0.01),
          child: Column(
            children: [
              // Responsive.isDesktop(context)
              //     ? Navbar(
              //         text2: "Site",
              //         text1: "Home",
              //         width: width,
              //         height: height,
              //       )
              //     : SizedBox(),
              // SizedBox(
              //   height: 20,
              // ),
              Visibility(
                visible: Responsive.isDesktop(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height:
                    Responsive.isDesktop(context) ? widget.height * 0.06 : 10,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left:
                      Responsive.isDesktop(context) ? widget.width * 0.04 : 0.0,
                  right:
                      Responsive.isDesktop(context) ? widget.width * 0.04 : 0.0,
                ),
                child: Column(
                  children: [
                    // Responsive.isMobile(context)
                    //     // ? Row(
                    //     //     children: [
                    //     //       InkWell(
                    //     //         onTap: () {
                    //     //           Navigator.pop(context);
                    //     //         },
                    //     //         child: Icon(
                    //     //           Icons.arrow_back,
                    //     //           color: Colors.white,
                    //     //           size: widget.width * 0.06,
                    //     //         ),
                    //     //       ),
                    //     //       SizedBox(
                    //     //         width: widget.width * 0.2,
                    //     //       ),
                    //     //       Image.asset(Common.assetImages + "Logo 2 2.png"),
                    //     //     ],
                    //     //   )
                    //     : SizedBox(),
                    SizedBox(
                      height: Responsive.isDesktop(context)
                          ? widget.height * 0.05
                          : widget.height * 0.01,
                    ),
                    Responsive.isDesktop(context)
                        ? Text(
                            "FAQ",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: Responsive.isDesktop(context)
                                    ? widget.width * 0.01
                                    : widget.width * 0.023,
                                fontFamily: "Poppins"),
                          )
                        : Container(),
                    SizedBox(
                      height: Responsive.isDesktop(context) ? 10 : 0,
                    ),
                    Text(
                      "Have a question? Look here.",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold,
                          fontSize: 23),
                    ),
                    SizedBox(
                      height: widget.height * 0.05,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "General",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold,
                              fontSize: 23),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                            "We have created a video guide to help you understand application better.",
                            style: TextStyle(
                                color: Color(0xffBABABA),
                                fontSize: 19,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500)),
                        // Container(
                        //   child: ListView.builder(
                        //       //  scrollDirection: Axis.horizontal,
                        //       // shrinkWrap: true,
                        //       itemCount: 2,
                        //       itemBuilder: (BuildContext context, int index) {
                        //         // final document = snapshot.data?.docs[index];
                        //         return Container(
                        //           height: 80,
                        //           width: 150,
                        //           decoration: BoxDecoration(
                        //             color: Colors.white,
                        //             borderRadius: BorderRadius.circular(20),
                        //           ),
                        //         );
                        //       }),
                        // ),
                        SizedBox(
                          height: 20,
                        ),
                        VideoContainer(
                          width: widget.width,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("faq")
                                .where("userRole", isEqualTo: "general")
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                              return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data?.docs.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final document = snapshot.data?.docs[index];
                                    return FAQ(
                                      widht: widget.width,
                                      FAQdesc: document!["description"],
                                      height: widget.height,
                                      FAQName: document["title"],
                                      index: index,
                                    );
                                  });
                            },
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
    );
  }
}

class UserRolefAQ extends StatefulWidget {
  const UserRolefAQ(
      {Key? key,
      required this.width,
      required this.height,
      required this.userRole})
      : super(key: key);
  final double width;
  final double height;
  final String userRole;
  @override
  _UserRolefAQState createState() => _UserRolefAQState();
}

class _UserRolefAQState extends State<UserRolefAQ> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: widget.height * 1,
        width: widget.width * 1,
        color: backGround_color,
        child: Padding(
          padding: EdgeInsets.only(
              left: widget.width * 0.04, top: widget.height * 0.01),
          child: Column(
            children: [
              // Responsive.isDesktop(context)
              //     ? Navbar(
              //         text2: "Site",
              //         text1: "Home",
              //         width: width,
              //         height: height,
              //       )
              //     : SizedBox(),

              Visibility(
                visible: Responsive.isDesktop(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height:
                    Responsive.isDesktop(context) ? widget.height * 0.06 : 10,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left:
                      Responsive.isDesktop(context) ? widget.width * 0.04 : 0.0,
                  right:
                      Responsive.isDesktop(context) ? widget.width * 0.04 : 0.0,
                ),
                child: Column(
                  children: [
                    // Responsive.isMobile(context)
                    //     ? Row(
                    //         children: [
                    //           InkWell(
                    //             onTap: () {
                    //               Navigator.pop(context);
                    //             },
                    //             child: Icon(
                    //               Icons.arrow_back,
                    //               color: Colors.white,
                    //               size: widget.width * 0.06,
                    //             ),
                    //           ),
                    //           SizedBox(
                    //             width: widget.width * 0.2,
                    //           ),
                    //           Image.asset(Common.assetImages + "Logo 2 2.png"),
                    //         ],
                    //       )
                    //     : SizedBox(),
                    SizedBox(
                      height: Responsive.isDesktop(context)
                          ? widget.height * 0.05
                          : widget.height * 0.01,
                    ),
                    Responsive.isDesktop(context)
                        ? Text(
                            "FAQ",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: Responsive.isDesktop(context)
                                    ? widget.width * 0.01
                                    : widget.width * 0.023,
                                fontFamily: "Poppins"),
                          )
                        : Container(),
                    SizedBox(
                      height: Responsive.isDesktop(context) ? 10 : 0,
                    ),
                    Text(
                      "Have a question? Look here",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold,
                          fontSize: 23),
                    ),
                    SizedBox(
                      height: widget.height * 0.05,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.userRole}",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold,
                              fontSize: 23),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                            "We have created a video guide to help you understand application better.",
                            style: TextStyle(
                                color: Color(0xffBABABA),
                                fontSize: 19,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500)),
                        // Container(
                        //   child: ListView.builder(
                        //       //  scrollDirection: Axis.horizontal,
                        //       // shrinkWrap: true,
                        //       itemCount: 2,
                        //       itemBuilder: (BuildContext context, int index) {
                        //         // final document = snapshot.data?.docs[index];
                        //         return Container(
                        //           height: 80,
                        //           width: 150,
                        //           decoration: BoxDecoration(
                        //             color: Colors.white,
                        //             borderRadius: BorderRadius.circular(20),
                        //           ),
                        //         );
                        //       }),
                        // ),
                        SizedBox(
                          height: 20,
                        ),
                        VideoContainer(
                          width: widget.width,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("faq")
                                .where("userRole", isEqualTo: widget.userRole)
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                              // if (snapshot.connectionState ==
                              //     ConnectionState.waiting) {
                              //   return Center(
                              //       child: CircularProgressIndicator());
                              // }
                              return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data?.docs.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final document = snapshot.data?.docs[index];
                                    return FAQ(
                                      widht: widget.width,
                                      FAQdesc: document!["description"],
                                      height: widget.height,
                                      FAQName: document["title"],
                                      index: index,
                                    );
                                  });
                            },
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
    );
  }
}
