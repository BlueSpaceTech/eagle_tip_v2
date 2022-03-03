// ignore_for_file: prefer_const_constructors

import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/UI/Widgets/customContainer.dart';
import 'package:testttttt/UI/Widgets/customNav.dart';
import 'package:testttttt/UI/Widgets/custom_webbg.dart';
import 'package:testttttt/UI/Widgets/customappheader.dart';
import 'package:testttttt/Utils/common.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:flutter/material.dart';

class TerminalFAQ extends StatelessWidget {
  TerminalFAQ({Key? key}) : super(key: key);

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
      floatingActionButton: Responsive.isDesktop(context)
          ? MenuButton(isTapped: false, width: width)
          : SizedBox(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: height * 1.2,
            color: backGround_color,
            child: Padding(
              padding: EdgeInsets.only(left: width * 0.0, top: height * 0.01),
              child: Column(
                children: [
                  Navbar(
                    text2: "Site",
                    text1: "Home",
                    width: width,
                    height: height,
                  ),
                  SizedBox(
                    height: height * 0.06,
                  ),
                  Container(
                    color: backGround_color,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        WebBg(),
                        Padding(
                          padding: EdgeInsets.only(
                              left: Responsive.isDesktop(context)
                                  ? width * 0.08
                                  : width * 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Responsive.isDesktop(context)
                                  ? Padding(
                                      padding: EdgeInsets.only(top: 0.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.arrow_back,
                                            color: Colors.white,
                                            size: width * 0.02,
                                          ),
                                          SizedBox(
                                            width: width * 0.014,
                                          ),
                                          Text(
                                            "Back",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: width * 0.014,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "Poppins",
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : SizedBox(),
                              SizedBox(
                                width: Responsive.isDesktop(context)
                                    ? width * 0.02
                                    : 0.0,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  padding: EdgeInsets.only(top: 20),
                                  width: Responsive.isDesktop(context)
                                      ? width * 0.45
                                      : width * 0.9,
                                  height: height * 0.78,
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(
                                          Responsive.isDesktop(context)
                                              ? 0.6
                                              : 0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: Responsive.isDesktop(context)
                                          ? width * 0.04
                                          : 0.0,
                                      right: Responsive.isDesktop(context)
                                          ? width * 0.04
                                          : 0.0,
                                    ),
                                    child: Column(
                                      children: [
                                        Responsive.isDesktop(context)
                                            ? Text(
                                                "FAQ",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize:
                                                        Responsive.isDesktop(
                                                                context)
                                                            ? width * 0.01
                                                            : width * 0.023,
                                                    fontFamily: "Poppins"),
                                              )
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  // ignore: prefer_const_constructors
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
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: Responsive
                                                                .isDesktop(
                                                                    context)
                                                            ? width * 0.01
                                                            : width * 0.023,
                                                        fontFamily: "Poppins"),
                                                  ),
                                                  SizedBox(
                                                    width: Responsive.isDesktop(
                                                            context)
                                                        ? width * 0.4
                                                        : width * 0.38,
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
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return FAQTerminal(
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
                              ),
                              SizedBox(
                                width: width * 0.01,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.addFAQ);
                                },
                                child: SizedBox(
                                  width: width * 0.08,
                                  child: Container(
                                    width: width * 0.06,
                                    height: height * 0.05,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: Color(0xFF5081DB),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Add FAQ",
                                        style: TextStyle(
                                          fontSize: width * 0.008,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FAQTerminal extends StatefulWidget {
  FAQTerminal({
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
  State<FAQTerminal> createState() => _FAQTerminalState();
}

class _FAQTerminalState extends State<FAQTerminal> {
  bool? isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: isExpanded! ? widget.height * 0.26 : widget.height * 0.05,
      child: Column(
        children: [
          Container(
            width: widget.widht * 0.85,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.FAQNames[widget.index],
                  style: TextStyle(
                      fontSize: Responsive.isDesktop(context)
                          ? widget.widht * 0.01
                          : widget.widht * 0.028,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Poppins"),
                ),
                Container(
                  width: Responsive.isDesktop(context)
                      ? widget.widht * 0.045
                      : widget.widht * 0.12,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              title: Text(
                                'Delete FAQ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 23.0,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Poppins",
                                  color: Colors.black,
                                ),
                              ),
                              content: Container(
                                height: widget.height * 0.17,
                                width: widget.widht * 0.3,
                                child: Column(
                                  children: [
                                    Text(
                                      "Are you sure you want to delete Risus, adipiscing accumsan?",
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Poppins"),
                                    ),
                                    SizedBox(
                                      height: widget.height * 0.05,
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            width: widget.widht * 0.145,
                                            height: widget.height * 0.055,
                                            decoration: BoxDecoration(
                                              color: Color(0Xffed5c62),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Cancel",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13.0,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: "Poppins"),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 12.0,
                                        ),
                                        Container(
                                          width: widget.widht * 0.145,
                                          height: widget.height * 0.055,
                                          decoration: BoxDecoration(
                                            color: Color(0Xff5081db),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Yes",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "Poppins"),
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
                        },
                        child: Image.asset(
                          Common.assetImages + "trash.png",
                          width: Responsive.isDesktop(context)
                              ? widget.widht * 0.01
                              : widget.widht * 0.03,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.addFAQ);
                        },
                        child: Image.asset(
                          Common.assetImages + "edit_pen.png",
                          width: Responsive.isDesktop(context)
                              ? widget.widht * 0.01
                              : widget.widht * 0.03,
                        ),
                      ),
                      isExpanded!
                          ? InkWell(
                              onTap: () {
                                setState(() {
                                  isExpanded = !isExpanded!;
                                });
                              },
                              child: Image.asset(
                                Common.assetImages + "Forward.png",
                                width: Responsive.isDesktop(context)
                                    ? widget.widht * 0.01
                                    : widget.widht * 0.03,
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                setState(() {
                                  isExpanded = !isExpanded!;
                                });
                              },
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                                size: Responsive.isDesktop(context)
                                    ? widget.widht * 0.01
                                    : widget.widht * 0.03,
                              ),
                            ),
                    ],
                  ),
                ),
              ],
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
                            : widget.widht * 0.024,
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
