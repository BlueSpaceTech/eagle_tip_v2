// ignore_for_file: prefer_const_constructors

import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/UI/Widgets/customContainer.dart';
import 'package:testttttt/UI/Widgets/customNav.dart';
import 'package:testttttt/UI/Widgets/logo.dart';
import 'package:testttttt/UI/views/post_auth_screens/Support/support_desktop.dart';
import 'package:testttttt/Utils/common.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:flutter/material.dart';

class FAQScreen extends StatefulWidget {
  FAQScreen({Key? key}) : super(key: key);

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  List FAQNames = [
    "Risus, adipiscing accumsan",
    "Eleifend tellus amet",
    "Nunc, non sagittis",
    "Proin interdum eget",
    "Felis suspendisse amet"
  ];
  List FAQdata = [
    "Risus vestibulum, risus feugiat semper velit feugiat velit. Placerat elit volutpat volutpat elit bibendum molestie eget. Convallis mattis dignissim quis tincidunt quisque. Adipiscing suspendisse faucibus aliquet a turpis odio pellentesque lectus duis. Sodales odio eu bibendum massa velit maecenas eget. Maecenas facilisis nunc tincidunt sed eget viverra porttitor feugiat. Mattis dictum sed suspendisse faucibus gravida. Id eget amet dis amet ut at in eget nam. ",
    "Risus vestibulum, risus feugiat semper velit feugiat velit. Placerat elit volutpat volutpat elit bibendum molestie eget. Convallis mattis dignissim quis tincidunt quisque. Adipiscing suspendisse faucibus aliquet a turpis odio pellentesque lectus duis. Sodales odio eu bibendum massa velit maecenas eget. Maecenas facilisis nunc tincidunt sed eget viverra porttitor feugiat. Mattis dictum sed suspendisse faucibus gravida. Id eget amet dis amet ut at in eget nam. ",
    "Risus vestibulum, risus feugiat semper velit feugiat velit. Placerat elit volutpat volutpat elit bibendum molestie eget. Convallis mattis dignissim quis tincidunt quisque. Adipiscing suspendisse faucibus aliquet a turpis odio pellentesque lectus duis. Sodales odio eu bibendum massa velit maecenas eget. Maecenas facilisis nunc tincidunt sed eget viverra porttitor feugiat. Mattis dictum sed suspendisse faucibus gravida. Id eget amet dis amet ut at in eget nam. ",
    "Risus vestibulum, risus feugiat semper velit feugiat velit. Placerat elit volutpat volutpat elit bibendum molestie eget. Convallis mattis dignissim quis tincidunt quisque. Adipiscing suspendisse faucibus aliquet a turpis odio pellentesque lectus duis. Sodales odio eu bibendum massa velit maecenas eget. Maecenas facilisis nunc tincidunt sed eget viverra porttitor feugiat. Mattis dictum sed suspendisse faucibus gravida. Id eget amet dis amet ut at in eget nam. ",
    "Risus vestibulum, risus feugiat semper velit feugiat velit. Placerat elit volutpat volutpat elit bibendum molestie eget. Convallis mattis dignissim quis tincidunt quisque. Adipiscing suspendisse faucibus aliquet a turpis odio pellentesque lectus duis. Sodales odio eu bibendum massa velit maecenas eget. Maecenas facilisis nunc tincidunt sed eget viverra porttitor feugiat. Mattis dictum sed suspendisse faucibus gravida. Id eget amet dis amet ut at in eget nam. "
  ];
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Responsive(
        mobile: MobileFAQ(
            width: width, height: height, FAQNames: FAQNames, FAQdata: FAQdata),
        tablet: Container(),
        desktop: DesktopFAQ(
            width: width, height: height, FAQNames: FAQNames, FAQdata: FAQdata),
      ),
    );
  }
}

class MobileFAQ extends StatefulWidget {
  const MobileFAQ({
    Key? key,
    required this.width,
    required this.height,
    required this.FAQNames,
    required this.FAQdata,
  }) : super(key: key);
  final double width;
  final double height;
  final List FAQNames;
  final List FAQdata;
  @override
  _MobileFAQState createState() => _MobileFAQState();
}

class _MobileFAQState extends State<MobileFAQ> {
  @override
  Widget build(BuildContext context) {
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
                child: ListView.builder(
                    itemCount: widget.FAQNames.length,
                    itemBuilder: (BuildContext context, int index) {
                      return FAQ(
                        widht: widget.width,
                        FAQdata: widget.FAQdata,
                        height: widget.height,
                        FAQNames: widget.FAQNames,
                        index: index,
                      );
                    }),
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
    required this.FAQNames,
    required this.FAQdata,
  }) : super(key: key);

  final double width;
  final double height;
  final List FAQNames;
  final List FAQdata;

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
                Responsive.isDesktop(context)
                    ? Navbar(
                        text2: "Site",
                        text1: "Home",
                        width: width,
                        height: height,
                      )
                    : SizedBox(),
                SizedBox(
                  height: height * 0.06,
                ),
                CustomContainer(
                  opacity: 0.2,
                  topPad: 0.0,
                  width: width * 0.9,
                  height: height,
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
                          child: ListView.builder(
                              itemCount: FAQNames.length,
                              itemBuilder: (BuildContext context, int index) {
                                return FAQ(
                                  widht: width,
                                  FAQdata: FAQdata,
                                  height: height,
                                  FAQNames: FAQNames,
                                  index: index,
                                );
                              }),
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
    required this.FAQNames,
    required this.widht,
    required this.FAQdata,
    required this.height,
  }) : super(key: key);

  final List FAQNames;
  final int index;
  final List FAQdata;
  final double widht;
  final double height;

  @override
  State<FAQ> createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  bool? isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: isExpanded! ? widget.height * 0.26 : widget.height * 0.05,
      child: Column(
        children: [
          Container(
            width: widget.widht * 0.85,
            child: InkWell(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded!;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.FAQNames[widget.index],
                    style: TextStyle(
                        fontSize: Responsive.isDesktop(context)
                            ? widget.widht * 0.01
                            : widget.widht * 0.034,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Poppins"),
                  ),
                  isExpanded!
                      ? Image.asset(
                          Common.assetImages + "Forward.png",
                          width: Responsive.isDesktop(context)
                              ? widget.widht * 0.01
                              : 15.0,
                        )
                      : Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: Responsive.isDesktop(context)
                              ? widget.widht * 0.01
                              : 15.0,
                        ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Visibility(
            visible: isExpanded!,
            child: Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Container(
                  width: widget.widht * 0.85,
                  child: Text(
                    widget.FAQdata[widget.index],
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
