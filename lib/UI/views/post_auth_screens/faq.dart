// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:testttttt/Providers/user_provider.dart';
import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/UI/Widgets/customContainer.dart';
import 'package:testttttt/UI/Widgets/customNav.dart';
import 'package:testttttt/UI/Widgets/logo.dart';
import 'package:testttttt/UI/views/post_auth_screens/Support/support_desktop.dart';
import 'package:testttttt/UI/views/post_auth_screens/Terminal/FAQ/editFaq.dart';
import 'package:testttttt/Utils/common.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:testttttt/Models/user.dart' as model;

CollectionReference faqs=FirebaseFirestore.instance.collection("faq");
class FAQScreen extends StatefulWidget {
  FAQScreen({Key? key}) : super(key: key);

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Responsive(
        mobile: MobileFAQ(
          width: width,
          height: height,
        ),
        tablet: Container(),
        desktop: Container(),
        // desktop: RolefAQDesktop(
        //   width: width,
        //   height: height,
        // ),
      ),
    );
  }
}

class VideoContainer extends StatefulWidget {
  const VideoContainer({Key? key, required this.width}) : super(key: key);
  final double width;
  @override
  _VideoContainerState createState() => _VideoContainerState();
}

class _VideoContainerState extends State<VideoContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.isDesktop(context)
          ? widget.width * 0.8
          : widget.width * 0.9,
      height: 140,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: false, // new line
          // physics: NeverScrollableScrollPhysics(),
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            // final document = snapshot.data?.docs[index];
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              margin: EdgeInsets.only(right: 20),
              height: 170,
              width: 220,
            );
          }),
    );
  }
}

class MobileFAQ extends StatefulWidget {
  const MobileFAQ({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);
  final double width;
  final double height;
  @override
  _MobileFAQState createState() => _MobileFAQState();
}

class _MobileFAQState extends State<MobileFAQ> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Container(
        color: backGround_color,
        height: widget.height,
        child: Padding(
          padding: EdgeInsets.only(
              left: widget.width * 0.04, top: widget.height * 0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                      size: widget.width * 0.06,
                    ),
                  ),
                  SizedBox(
                    width: widget.width * 0.2,
                  ),
                  Logo(width: widget.width),
                ],
              ),
              SizedBox(
                height: widget.height * 0.05,
              ),
              Text(
                "FAQ",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: widget.width * 0.04,
                    fontFamily: "Poppins"),
              ),
              SizedBox(
                height: widget.height * 0.05,
              ),
              Container(
                height: widget.height * 0.6,
                child: StreamBuilder(
                  stream:
                      FirebaseFirestore.instance.collection("faq").snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    return ListView.builder(
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          final document = snapshot.data?.docs[index];
                          return FAQ(
                            widht: width,
                            id: document!.id,
                            FAQdesc: document["description"],
                            height: height,
                            FAQName: document["title"],
                            index: index,
                          );
                        });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DesktopFAQ extends StatelessWidget {
  const DesktopFAQ({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          color: backGround_color,
          child: Padding(
            padding: EdgeInsets.only(left: width * 0.04, top: height * 0.01),
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
                SizedBox(
                  height: 20,
                ),
                Row(
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
                SizedBox(
                  height: height * 0.06,
                ),
                CustomContainer(
                  opacity: 0.2,
                  topPad: 0.0,
                  width: width * 0.9,
                  height: height * 0.9,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: Responsive.isDesktop(context) ? width * 0.04 : 0.0,
                      right: Responsive.isDesktop(context) ? width * 0.04 : 0.0,
                    ),
                    child: Column(
                      children: [
                        Responsive.isMobile(context)
                            ? Row(
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
                                    width: width * 0.2,
                                  ),
                                  Image.asset(
                                      Common.assetImages + "Logo 2 2.png"),
                                ],
                              )
                            : SizedBox(),
                        SizedBox(
                          height: height * 0.05,
                        ),
                        Responsive.isDesktop(context)
                            ? Text(
                                "FAQ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: Responsive.isDesktop(context)
                                        ? width * 0.01
                                        : width * 0.023,
                                    fontFamily: "Poppins"),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: width * 0.33,
                                  ),
                                  Text(
                                    "FAQ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: Responsive.isDesktop(context)
                                            ? width * 0.01
                                            : width * 0.023,
                                        fontFamily: "Poppins"),
                                  ),
                                  SizedBox(
                                    width: width * 0.4,
                                  ),
                                ],
                              ),
                        SizedBox(
                          height: height * 0.05,
                        ),
                        Container(
                          height: height * 0.6,
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("faq")
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
                                  itemCount: snapshot.data?.docs.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final document = snapshot.data?.docs[index];
                                    return FAQ(
                                      widht: width,
                                      FAQdesc: document!["description"],
                                      height: height,
                                      FAQName: document["title"],
                                      index: index,
                                      id:document.id,
                                    );
                                  });
                            },
                          ),
                        ),
                      ],
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

class FAQ extends StatefulWidget {
  FAQ({
    Key? key,
    required this.index,
    required this.FAQName,
    required this.widht,
    required this.FAQdesc,
    required this.height,
    required this.id,
  }) : super(key: key);

  final String FAQName;
  final int index;
  final String id;
  final String FAQdesc;
  final double widht;
  final double height;

  @override
  State<FAQ> createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  bool? isExpanded = false;
  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(border: Border.all(color: Colors.white)),
      // height: isExpanded! ? widget.height * 0.26 : widget.height * 0.08,
      child: Column(
        children: [
          Container(
            // width: widget.widht * 0.85,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.FAQName,
                  style: TextStyle(
                      fontSize: Responsive.isDesktop(context)
                          ? widget.widht * 0.01
                          : widget.widht * 0.034,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Poppins"),
                ),
                isExpanded!
                    ? Row(
                      children: [
                        InkWell(
                          onTap: (){
                              faqs.doc(widget.id).delete();
                            },
                          child: Visibility(
                            visible: user.userRole=="AppAdmin",
                            child: Image.asset(
                            Common.assetImages + "trash.png",
                            width: Responsive.isDesktop(context)
                                ? widget.widht * 0.012
                                : 15.0,
                                                  ),
                          ),
                        ),
                        SizedBox(
                          width: widget.widht*0.01,
                        ),
                        InkWell(
                          onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                                return EditFAQ(answertext: widget.FAQdesc, docid: widget. id, questiontext: widget.FAQName);
                              }));
                            },
                          child: Visibility(
                            visible: user.userRole=="AppAdmin",
                            child: Image.asset(
                            Common.assetImages + "edit_pen.png",
                            width: Responsive.isDesktop(context)
                                ? widget.widht * 0.012
                                : 15.0,
                                                  ),
                          ),
                        ),
                        SizedBox(
                          width: widget.widht*0.01,
                        ),
                      InkWell(
                        onTap: (){
                          isExpanded=!isExpanded!;
                        },
                        child: Image.asset(
                          Common.assetImages + "Forward.png",
                          width: Responsive.isDesktop(context)
                              ? widget.widht * 0.01
                              : 15.0,
                        ),
                      ),
                      ],
                    )
                    : Row(
                      children: [
                        InkWell(
                          onTap: (){
                              faqs.doc(widget.id).delete();
                            },
                          child: Visibility(
                            visible: user.userRole=="AppAdmin",
                            child: Image.asset(
                            Common.assetImages + "trash.png",
                            width: Responsive.isDesktop(context)
                                ? widget.widht * 0.012
                                : 15.0,
                                                  ),
                          ),
                        ),SizedBox(
                          width: widget.widht*0.01,
                        ),
                        InkWell(
                          onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                                return EditFAQ(answertext: widget.FAQdesc, docid: widget. id, questiontext: widget.FAQName);
                              }));
                            },
                          child: Visibility(
                            visible: user.userRole=="AppAdmin",
                            child: Image.asset(
                            Common.assetImages + "edit_pen.png",
                            width: Responsive.isDesktop(context)
                                ? widget.widht * 0.012
                                : 15.0,
                                                  ),
                          ),
                        ),
                        SizedBox(
                          width: widget.widht*0.01,
                        ),
                      InkWell(
                        onTap: (){
                          isExpanded=!isExpanded!;
                        },
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: Responsive.isDesktop(context)
                              ? widget.widht * 0.01
                              : 15.0,
                        ),
                      ),
                      ],
                    )
              ],
            ),
          ),
          // SizedBox(
          //   height: 10.0,
          // ),
          Visibility(
            visible: isExpanded!,
            child: Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Container(
                  width: widget.widht * 0.85,
                  child: Text(
                    widget.FAQdesc,
                    style: TextStyle(
                        fontSize: Responsive.isDesktop(context)
                            ? widget.widht * 0.008
                            : widget.widht * 0.03,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Poppins"),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
