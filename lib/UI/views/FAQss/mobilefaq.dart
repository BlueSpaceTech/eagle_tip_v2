import 'package:flutter/material.dart';
import 'package:testttttt/UI/Widgets/customHeader2.dart';
import 'package:testttttt/UI/Widgets/logo.dart';
import 'package:testttttt/UI/views/FAQss/desktopfaq.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:testttttt/Utils/responsive.dart';

class MobileFaqs extends StatefulWidget {
  const MobileFaqs({Key? key}) : super(key: key);

  @override
  _MobileFaqsState createState() => _MobileFaqsState();
}

class _MobileFaqsState extends State<MobileFaqs> {
  String userRole = "AppAdmin";
  getItems(List list) {
    List<Widget> item = [];
    for (int i = 0; i < list.length; i++) {
      item.add(Tab(
        child: Text(
          list[i],
          style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w600,
              fontFamily: "Poppins"),
        ),
      ));
    }
    return item;
  }

  @override
  Widget build(BuildContext context) {
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
      userRole,
    ];
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: userRole == "AppAdmin" || userRole == "SuperAdmin" ? 6 : 2,
      child: Scaffold(
        body: Container(
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
                        "If you cannot find an answer to your question in FAQ, you can take help of our support team.",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: width * 0.03,
                            fontFamily: "Poppins"),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: width * 0.2,
                      height: 35,
                      decoration: BoxDecoration(
                          color: Color(0xff5081DB),
                          borderRadius: BorderRadius.circular(15)),
                      child: Text(
                        "Support",
                        style: TextStyle(color: Colors.white),
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
                    tabs: getItems(
                        userRole == "AppAdmin" || userRole == "SuperAdmin"
                            ? foradmin
                            : foruser),
                  ),
                ),
              ),
              userRole == "AppAdmin" || userRole == "SuperAdmin"
                  ? Expanded(
                      child: TabBarView(
                        children: [
                          GeneralfAQ(width: width, height: height),
                          UserRolefAQ(
                              width: width,
                              height: height,
                              userRole: "Terminal Manager"),
                          UserRolefAQ(
                              width: width,
                              height: height,
                              userRole: "Terminal User"),
                          UserRolefAQ(
                              width: width,
                              height: height,
                              userRole: "Site Owner"),
                          UserRolefAQ(
                              width: width,
                              height: height,
                              userRole: "Site Manager"),
                          UserRolefAQ(
                              width: width,
                              height: height,
                              userRole: "Site User"),
                        ],
                      ),
                    )
                  : Expanded(
                      child: TabBarView(
                        children: [
                          GeneralfAQ(width: width, height: height),
                          UserRolefAQ(
                              width: width,
                              height: height,
                              userRole: "Site Owner"),
                        ],
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
