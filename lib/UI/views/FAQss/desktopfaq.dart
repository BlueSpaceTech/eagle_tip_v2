import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:testttttt/Providers/user_provider.dart';
import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/Services/utils.dart';
import 'package:testttttt/UI/Widgets/customNav.dart';
import 'package:testttttt/UI/Widgets/customfab.dart';
import 'package:testttttt/UI/Widgets/customtoast.dart';
import 'package:testttttt/UI/views/FAQss/addvideo.dart';
import 'package:testttttt/UI/views/FAQss/displayfaqs.dart';
import 'package:testttttt/UI/views/FAQss/new_faq.dart';
import 'package:testttttt/UI/views/FAQss/newfaq2.dart';
import 'package:testttttt/UI/views/FAQss/player_screen.dart';
import 'package:testttttt/UI/views/post_auth_screens/Terminal/FAQ/addFAQ.dart';
import 'package:testttttt/UI/views/post_auth_screens/faq.dart';
import 'package:testttttt/Utils/common.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:testttttt/Utils/detectPlatform.dart';
import 'package:testttttt/Utils/responsive.dart';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:testttttt/Models/user.dart' as model;

class DesktopFAQs extends StatefulWidget {
  final String userrOLE;
  const DesktopFAQs({Key? key, required this.userrOLE}) : super(key: key);

  @override
  _DesktopFAQsState createState() => _DesktopFAQsState();
}

class _DesktopFAQsState extends State<DesktopFAQs> {
  PageController page = PageController();
  // String userrOLE = "AppAdmin";
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
    // model.User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        height: height * 1.2,
        color: backGround_color,
        width: width,
        child: Column(
          children: [
            Navbar(
              width: width,
              height: height,
              text1: "Home",
              text2: "Chat",
            ),
            SizedBox(
              height: height,
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
                          selectedTitleTextStyle:
                              TextStyle(color: Colors.white),
                          selectedIconColor: Colors.white,
                          unselectedTitleTextStyle:
                              TextStyle(color: Colors.grey[600])
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
                          child: Row(children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "FAQ",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: width * 0.012,
                                color: Colors.white,
                              ),
                            ),
                          ]),
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
                      items: getItems(widget.userrOLE == "AppAdmin" ||
                              widget.userrOLE == "SuperAdmin"
                          ? foradmin
                          : foruser),
                    ),
                  ),
                  // Text(widget.userrOLE),
                  widget.userrOLE == "AppAdmin" ||
                          widget.userrOLE == "SuperAdmin"
                      ? Expanded(
                          child: PageView(
                          controller: page,
                          children: [
                            GeneralfAQ(
                              width: width,
                              height: height,
                              userrole: widget.userrOLE,
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
                        ))
                      : Expanded(
                          child: PageView(
                          controller: page,
                          children: [
                            GeneralfAQ(
                              width: width,
                              height: height,
                              userrole: widget.userrOLE,
                            ),
                            UserRolefAQ(
                                width: width,
                                height: height,
                                userRole: widget.userrOLE),
                          ],
                        ))
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}

class GeneralfAQ extends StatefulWidget {
  const GeneralfAQ(
      {Key? key,
      required this.width,
      required this.height,
      required this.userrole})
      : super(key: key);
  final double width;
  final double height;
  final String userrole;
  @override
  _GeneralfAQState createState() => _GeneralfAQState();
}

class _GeneralfAQState extends State<GeneralfAQ> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    model.User? user = Provider.of<UserProvider>(context).getUser;
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
              // Visibility(
              //   visible: Responsive.isDesktop(context),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: [
              //       InkWell(
              //         onTap: () {
              //           Navigator.pop(context);
              //         },
              //         child: Icon(
              //           Icons.arrow_back,
              //           color: Colors.white,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(
                height: Responsive.isDesktop(context) ||
                        Responsive.isTablet(context)
                    ? widget.height * 0.06
                    : 10,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: Responsive.isDesktop(context) ||
                          Responsive.isTablet(context)
                      ? widget.width * 0.04
                      : 0.0,
                  right: Responsive.isDesktop(context) ||
                          Responsive.isTablet(context)
                      ? widget.width * 0.04
                      : 0.0,
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
                      height: Responsive.isDesktop(context) ||
                              Responsive.isTablet(context)
                          ? widget.height * 0.05
                          : widget.height * 0.01,
                    ),
                    Responsive.isDesktop(context) ||
                            Responsive.isTablet(context)
                        ? Text(
                            "FAQ",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: Responsive.isDesktop(context) ||
                                        Responsive.isTablet(context)
                                    ? widget.width * 0.01
                                    : widget.width * 0.023,
                                fontFamily: "Poppins"),
                          )
                        : Container(),
                    SizedBox(
                      height: Responsive.isDesktop(context) ||
                              Responsive.isTablet(context)
                          ? 10
                          : 0,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "General",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 23),
                            ),
                            Row(
                              children: [
                                Visibility(
                                  visible: user!.userRole == "AppAdmin" ||
                                      user.userRole == "SuperAdmin",
                                  child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  NewFaq2(userRole: "general"),
                                            ));
                                      },
                                      child: customfab(
                                          width: widget.width,
                                          text: "Add Faq",
                                          height: widget.height)),
                                ),
                                // SizedBox(
                                //   width: 20,
                                // ),
                                // task != null && isuploading
                                //     ? buildUploadStatus(task!)
                                //     : Container()
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        Text(
                            "We have created a some FAQs that will guide you to help you understand application better.",
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
                        // VideoContainer(
                        //     width: widget.width, userRole: "general"),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   children: [
                        //     Visibility(
                        //       visible: user.userRole == "AppAdmin" ||
                        //           user.userRole == "SuperAdmin",
                        //       child: InkWell(
                        //           onTap: () {
                        //             Navigator.push(
                        //                 context,
                        //                 MaterialPageRoute(
                        //                   builder: (context) => AddFAQ(
                        //                     userRole: "general",
                        //                   ),
                        //                 ));
                        //           },
                        //           child: customfab(
                        //               width: widget.width,
                        //               text: "Add FAQ",
                        //               height: widget.height)),
                        //     ),
                        //   ],
                        // ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("FAQs")
                                .where("visibleto", arrayContains: "General")
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                              if (snapshot.hasData) {
                                return ListView.builder(
                                    physics: PlatformInfo().isWeb()
                                        ? BouncingScrollPhysics()
                                        : NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: snapshot.data?.docs.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final document =
                                          snapshot.data?.docs[index];
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DisplayFaq(
                                                  docid: document!.id,
                                                  title: document["title"],
                                                ),
                                              ));
                                        },
                                        child: FAQ(
                                          userrOLE: widget.userrole,
                                          widht: widget.width,
                                          //  FAQdesc: document!["description"],
                                          id: document!.id,
                                          height: widget.height,
                                          FAQName: document["title"],
                                          index: index,
                                        ),
                                      );
                                    });
                              }
                              if (snapshot.hasData) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return Center(
                                child: Text(""),
                              );
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

// class VideoContainer extends StatefulWidget {
//   const VideoContainer({Key? key, required this.width, required this.userRole})
//       : super(key: key);
//   final double width;
//   final String userRole;

//   @override
//   _VideoContainerState createState() => _VideoContainerState();
// }

// class _VideoContainerState extends State<VideoContainer> {
//   // _getImage(videoPathUrl) async {
//   //   var appDocDir = await getApplicationDocumentsDirectory();
//   //   final folderPath = appDocDir.path;
//   //   String thumb = await Thumbnails.getThumbnail(
//   //       thumbnailFolder: folderPath,
//   //       videoFile: videoPathUrl,
//   //       imageType:
//   //           ThumbFormat.PNG, //this image will store in created folderpath
//   //       quality: 30);
//   //   print(thumb);
//   //   return thumb;
//   // }
//   // Uint8List? urll;

//   // getthumbnail(String url) async {
//   //   final uint8list = await VideoThumbnail.thumbnailData(
//   //     video: url,
//   //     imageFormat: ImageFormat.JPEG,
//   //     maxWidth:
//   //         128, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
//   //     quality: 25,
//   //   );
//   //   setState(() {
//   //     urll = uint8list!;
//   //   });
//   // }
//   FToast? fToast;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     fToast = FToast();
//     fToast!.init(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     model.User user = Provider.of<UserProvider>(context).getUser;
//     return Container(
//       width: Responsive.isDesktop(context)
//           ? widget.width * 0.8
//           : widget.width * 0.9,
//       height: 140,
//       child: StreamBuilder(
//           stream: FirebaseFirestore.instance
//               .collection("faqvideos")
//               .where("visibleto",
//                                     arrayContains: widget.userRole)
//               .snapshots(),
//           builder:
//               (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//             if (!snapshot.hasData) {
//               return Center(child: CircularProgressIndicator());
//             }
//             return ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 shrinkWrap: false, // new line
//                 // physics: NeverScrollableScrollPhysics(),
//                 itemCount: snapshot.data?.docs.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   final document = snapshot.data?.docs[index];

//                   // getthumbnail(document!["videourl"]);

//                   //  print(document!["videourl"]);
//                   return Row(
//                     children: [
//                       Visibility(
//                         visible: user.userRole == "AppAdmin",
//                         child: InkWell(
//                             onTap: () {
//                               FirebaseFirestore.instance
//                                   .collection("faqvideos")
//                                   .doc(document!.id)
//                                   .delete()
//                                   .then((value) {
//                                 fToast!.showToast(
//                                   child: ToastMessage()
//                                       .show(300, context, "Video Deleted"),
//                                   gravity: ToastGravity.BOTTOM,
//                                   toastDuration: Duration(seconds: 3),
//                                 );
//                               });
//                             },
//                             child: Icon(
//                               Icons.delete_outline,
//                               color: Colors.white,
//                             )),
//                       ),
//                       InkWell(
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => VideoPlayerScreen(
//                                   videourl: document!["videourl"],
//                                   title: document["title"],
//                                 ),
//                               ));
//                         },
//                         child: Container(
//                           width: 240,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Container(
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(20),
//                                     color: Colors.white
//                                     // image: DecorationImage(
//                                     //   image: NetworkImage(document["videourl"]),
//                                     // ),
//                                     ),
//                                 margin: EdgeInsets.only(right: 20),
//                                 height: 150,
//                                 width: 220,
//                                 child: SvgPicture.asset(
//                                   "/newLogo.svg",
//                                   width: 150,
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 5,
//                               ),
//                               Text(document!["title"],
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 15,
//                                       fontFamily: "Poppins",
//                                       fontWeight: FontWeight.w500)),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   );
//                 });
//           }),
//     );
//   }
// }

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
  PlatformFile? pickedfile;
  UploadTask? task;

  FToast? fToast;
  FilePickerResult? result;
  bool isuploading = false;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    fToast = FToast();
    fToast!.init(context);
  }

  void uploadfileee() async {
    try {
      result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ["mp4"],
      );
    } catch (e) {
      print(e);
    }

    if (result != null) {
      try {
        setState(() {
          isuploading = true;
        });
        Uint8List? uploadfile = result!.files.single.bytes;

        String filename = result!.files.single.name;
        // final ref = FirebaseStorage.instance
        //   .ref()
        //   .child("video")
        //   .child(today)
        //   .child(storageId);

        final storageRef =
            FirebaseStorage.instance.ref().child('faqvideos/$filename');

        final UploadTask uploadTask = storageRef.putData(uploadfile!);
        setState(() {
          task = uploadTask;
        });

        final TaskSnapshot downloadUrl = await uploadTask;

        final String attchurl = (await downloadUrl.ref.getDownloadURL());
        final snapshot = await uploadTask.whenComplete(() {
          fToast!.showToast(
            child: ToastMessage().show(300, context, "Video Uploaded"),
            gravity: ToastGravity.BOTTOM,
            toastDuration: Duration(seconds: 3),
          );
          setState(() {
            isuploading = false;
          });
          FirebaseFirestore.instance.collection("faqvideos").add({
            "videourl": attchurl,
            "userRole": widget.userRole,
          });
        });

        // print(downloadUrl);
        print(attchurl);

        // await AttachmentService(orgid: orgID, orgname: orgName, projid: projID)
        //     .addattachmentobjs(objType, objID, attchdate, filename, attchurl);
      } catch (e) {
        print(e);
      }
    }
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);

            return Text(
              '$percentage %',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            );
          } else {
            return Container();
          }
        },
      );

  @override
  Widget build(BuildContext context) {
    model.User? user = Provider.of<UserProvider>(context).getUser;
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
              // Visibility(
              //   visible: Responsive.isDesktop(context),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: [
              //       InkWell(
              //         onTap: () {
              //           Navigator.pop(context);
              //         },
              //         child: Icon(
              //           Icons.arrow_back,
              //           color: Colors.white,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.userRole,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 23),
                            ),
                            Row(
                              children: [
                                Visibility(
                                  visible: user!.userRole == "AppAdmin" ||
                                      user.userRole == "SuperAdmin",
                                  child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => NewFaq2(
                                                  userRole: widget.userRole),
                                            ));
                                      },
                                      child: customfab(
                                          width: widget.width,
                                          text: "Add Faq",
                                          height: widget.height)),
                                ),
                                // SizedBox(
                                //   width: 20,
                                // ),
                                // task != null && isuploading
                                //     ? buildUploadStatus(task!)
                                //     : Container()
                              ],
                            ),
                          ],
                        ),

                        Text(
                            "We have created a some FAQs that will guide you to help you understand application better.",
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
                        // VideoContainer(
                        //     width: widget.width, userRole: "general"),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   children: [
                        //     Visibility(
                        //       visible: user.userRole == "AppAdmin" ||
                        //           user.userRole == "SuperAdmin",
                        //       child: InkWell(
                        //           onTap: () {
                        //             Navigator.push(
                        //                 context,
                        //                 MaterialPageRoute(
                        //                   builder: (context) => AddFAQ(
                        //                     userRole: "general",
                        //                   ),
                        //                 ));
                        //           },
                        //           child: customfab(
                        //               width: widget.width,
                        //               text: "Add FAQ",
                        //               height: widget.height)),
                        //     ),
                        //   ],
                        // ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("FAQs")
                                .where("visibleto",
                                    arrayContains: widget.userRole)
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                    physics: PlatformInfo().isWeb()
                                        ? BouncingScrollPhysics()
                                        : NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: snapshot.data?.docs.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final document =
                                          snapshot.data?.docs[index];
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DisplayFaq(
                                                  docid: document!.id,
                                                  title: document["title"],
                                                ),
                                              ));
                                        },
                                        child: FAQ(
                                          userrOLE: widget.userRole,
                                          widht: widget.width,
                                          //  FAQdesc: document!["description"],
                                          id: document!.id,
                                          height: widget.height,
                                          FAQName: document["title"],
                                          index: index,
                                        ),
                                      );
                                    });
                              }

                              return Center(
                                child: CircularProgressIndicator(),
                              );
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
