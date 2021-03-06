// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testttttt/Providers/user_provider.dart';
import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/UI/Widgets/customHeader2.dart';
import 'package:testttttt/UI/Widgets/logo.dart';
import 'package:testttttt/UI/views/FAQss/desktopfaq.dart';
import 'package:testttttt/UI/views/post_auth_screens/Support/support.dart';
import 'package:testttttt/UI/views/post_auth_screens/Support/support_desktop.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:testttttt/Models/user.dart' as model;

class MobileFaqs extends StatefulWidget {
  final String userrOLE;
  const MobileFaqs({Key? key, required this.userrOLE}) : super(key: key);

  @override
  _MobileFaqsState createState() => _MobileFaqsState();
}

class _MobileFaqsState extends State<MobileFaqs> {
  // String userRole = "AppAdmin";
  getItems(List list) {
    List<Widget> item = [];
    for (int i = 0; i < list.length; i++) {
      item.add(Tab(
        child: Text(
          list[i],
          style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
              fontFamily: "Poppins"),
        ),
      ));
    }
    return item;
  }

  @override
  Widget build(BuildContext context) {
    // model.User user = Provider.of<UserProvider>(context).getUser;
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
      widget.userrOLE,
    ];
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: widget.userrOLE == "AppAdmin" || widget.userrOLE == "SuperAdmin"
          ? 6
          : 2,
      child: Scaffold(
        body: SafeArea(
          child: Container(
            width: width,
            height: height,
            color: backGround_color,
            child: Column(
              //  crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: width * 0.06,
                            ),
                          ),
                          SizedBox(
                            width: width * 0.15,
                          ),
                          Logo(width: width),
                          SizedBox(
                            width: width * 0.14,
                          ),
                          Text(""),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("FAQ",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: width * 0.03,
                              fontFamily: "Poppins")),
                      SizedBox(
                        height: 10,
                      ),
                      Visibility(
                        visible: Responsive.isDesktop(context),
                        child: Text(
                          "Have a question? Look here.",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold,
                              fontSize: 21),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: width * 0.8,
                        alignment: Alignment.center,
                        child: Text(
                          "If you cannot find an answer to your question in FAQ, you can contact our Support Team.",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: width * 0.03,
                              fontFamily: "Poppins"),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: ((context) {
                              return SupportScreen(
                                isNavVisible: false,
                              );
                            })),
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(8),
                          height: 35,
                          decoration: BoxDecoration(
                              color: Color(0xff5081DB),
                              borderRadius: BorderRadius.circular(15)),
                          child: Text(
                            "Contact Support",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: height * 0.07,
                  child: Material(
                    color: Color(0xFF2E3840),
                    child: TabBar(
                      tabs: getItems(widget.userrOLE == "AppAdmin" ||
                              widget.userrOLE == "SuperAdmin"
                          ? foradmin
                          : foruser),
                    ),
                  ),
                ),
                widget.userrOLE == "AppAdmin" || widget.userrOLE == "SuperAdmin"
                    ? Expanded(
                        child: TabBarView(
                          children: [
                            GeneralfAQ(
                              width: width,
                              height: height,
                              userrole: "General",
                            ),
                            UserRolefAQ(
                                width: width,
                                height: height,
                                userRole: "TerminalManager"),
                            UserRolefAQ(
                                width: width,
                                height: height,
                                userRole: "TerminalUser"),
                            UserRolefAQ(
                                width: width,
                                height: height,
                                userRole: "SiteOwner"),
                            UserRolefAQ(
                                width: width,
                                height: height,
                                userRole: "SiteManager"),
                            UserRolefAQ(
                                width: width,
                                height: height,
                                userRole: "SiteUser"),
                          ],
                        ),
                      )
                    : Expanded(
                        child: TabBarView(
                          children: [
                            GeneralfAQ(
                              width: width,
                              height: height,
                              userrole: "General",
                            ),
                            UserRolefAQ(
                                width: width,
                                height: height,
                                userRole: widget.userrOLE),
                          ],
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
