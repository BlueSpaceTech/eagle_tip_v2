import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:testttttt/Models/faq.dart';
import 'package:testttttt/Services/Crud_functions.dart';
import 'package:testttttt/Services/storagemethods.dart';
import 'package:testttttt/Services/utils.dart';
import 'package:testttttt/UI/Widgets/customNav.dart';
import 'package:testttttt/UI/Widgets/customfab.dart';
import 'package:testttttt/UI/Widgets/customtoast.dart';
import 'package:testttttt/UI/views/post_auth_screens/Terminal/FAQ/addFAQ.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:video_player/video_player.dart';

import '../post_auth_screens/CRUD/crudmain.dart';
import 'mainfaq.dart';

class NewADDfaq extends StatefulWidget {
  const NewADDfaq({Key? key}) : super(key: key);

  @override
  _NewADDfaqState createState() => _NewADDfaqState();
}

class _NewADDfaqState extends State<NewADDfaq> {
  int overallitem = 0;
  int textitem = 0;
  // int textitem = 0;
  // int imageitem = 0;
  // int videoitem = 0;
  List allwidgets = [];
  List selectedroles2 = [];
  final _stoarge = FirebaseStorage.instance;

  void _showroleSelect(List allsitename) async {
    final List _items = allsitename;

    for (var element in _items) {
      element = element.toString().replaceAll(" ", "");
    }

    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SiteSelectCrud(items: _items);
      },
    );

    // Update UI
    if (results != null) {
      setState(() {
        selectedroles2 = results;
      });
    }
  }

  List Role = [
    "General",
    "AppAdmin",
    "TerminalManager",
    "TerminalUser",
    "SiteOwner",
    "SiteManager",
    "SiteUser"
  ];

  VideoPlayerController? _controller;
  final picker = ImagePicker();
  Map<String, dynamic> textdata = {};
  Map<String, dynamic> imagedata = {};
  Map<String, dynamic> videodata = {};
  Map<String, dynamic> finalimage = {};
  Map<String, dynamic> finalvideo = {};
  bool textvalid = true;
  Future<Uint8List> selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    return im;
  }

  bool _loading = false;

  TextEditingController title = TextEditingController();
  String titletext = "";
  FToast? fToast;
  UploadTask? task;
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
  void initState() {
    // TODO: implement initState
    fToast = FToast();
    fToast!.init(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(children: [
        Container(
          child: Column(
            children: [
              Navbar(
                width: width,
                height: height,
              ),
              Expanded(
                  child: Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Container(
                        color: Color(0xff20272C),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                final controller = TextEditingController();
                                setState(() {
                                  // _controllers.add(controller);

                                  // textitem++;
                                  textvalid = false;
                                  overallitem++;
                                  allwidgets.add(FAQfield(
                                      overallindex: overallitem,
                                      controllerr: controller,
                                      type: "field",
                                      isreadonly: false));
                                });
                              },
                              child: customfab(
                                width: width,
                                text: 'Add Text',
                                height: height,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            InkWell(
                              onTap: () async {
                                Uint8List im = await selectImage();
                                //print(im);
                                // Widget imagewidget = Container(
                                //   width: 700,
                                //   height: 500,
                                //   decoration: BoxDecoration(
                                //     image: DecorationImage(
                                //       image: MemoryImage(im),
                                //     ),
                                //   ),
                                // );
                                // await Future.delayed(const Duration(seconds: 3));
                                setState(() {
                                  overallitem++;
                                  allwidgets.add(FAQimage(
                                      overallindex: overallitem,
                                      image: im,
                                      categoryindex: 2,
                                      type: "image"));

                                  imagedata["image${overallitem}"] = im;
                                });
                              },
                              child: customfab(
                                width: width,
                                text: 'Add Image',
                                height: height,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            InkWell(
                              onTap: () async {
                                final pickedVideo = await picker.pickVideo(
                                    source: ImageSource.gallery,
                                    maxDuration: Duration(seconds: 60));
                                //   .then(((value) {

                                // _video.add(File(pickedVideo!.path));
                                setState(() {
                                  overallitem++;
                                  _controller = VideoPlayerController.network(
                                      pickedVideo!.path);
                                  _controller!.initialize();
                                  _controller!.play();
                                  pickedVideo.readAsBytes().then((value) {
                                    videodata["video$overallitem"] = value;
                                    // print(videodata);
                                  });
                                });
                                allwidgets.add(FAQVideo(
                                    overallindex: overallitem,
                                    controller: _controller!,
                                    categoryindex: 2,
                                    type: "video",
                                    path: ""));

                                //  final result = await FilePicker.platform.pickFiles(
                                //         type: FileType.custom,
                                //         allowedExtensions: ["mp4"],
                                //       );
                                //        Uint8List? uploadfile = result!.files.single.bytes;
                              },
                              child: customfab(
                                width: width,
                                text: 'Add Video',
                                height: height,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  allwidgets.clear();
                                  textdata.clear();
                                  imagedata.clear();
                                  videodata.clear();
                                });

                                //  final result = await FilePicker.platform.pickFiles(
                                //         type: FileType.custom,
                                //         allowedExtensions: ["mp4"],
                                //       );
                                //        Uint8List? uploadfile = result!.files.single.bytes;
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: Responsive.isDesktop(context) ||
                                        Responsive.isTablet(context)
                                    ? width * 0.13
                                    : width * 0.42,
                                height: height * 0.064,
                                decoration: BoxDecoration(
                                  color: Color(0xff5081DB),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Reset",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                  Expanded(
                      flex: 5,
                      child: Container(
                        child: DefaultTabController(
                          length: 2,
                          child: Column(
                            children: [
                              Container(
                                height: height * 0.07,
                                child: Material(
                                  color: Color(0xFF2E3840),
                                  child: TabBar(
                                    tabs: [
                                      Tab(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.edit),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Editing",
                                              style: TextStyle(
                                                  fontSize: 13.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "Poppins"),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Tab(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.remove_red_eye),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Viewing",
                                              style: TextStyle(
                                                  fontSize: 13.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "Poppins"),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: TabBarView(children: [
                                Container(
                                  color: Color(0xff2B343B),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 20, bottom: 20),
                                          child: AddFAQTextField(
                                            labelText: "Title",
                                            text: title,
                                            valueChanged: (val) {
                                              setState(() {
                                                titletext = val;
                                              });
                                            },
                                            isactive: true,
                                          ),
                                        ),
                                        Visibility(
                                          visible: allwidgets.isEmpty,
                                          child: Text(
                                            "Click on left panel buttons to add items here: ",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: "Poppins",
                                                fontSize: 21,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        ListView.separated(
                                            separatorBuilder:
                                                ((context, index) {
                                              return SizedBox(
                                                height: 20,
                                              );
                                            }),
                                            shrinkWrap: true,
                                            itemCount: allwidgets.length,
                                            itemBuilder: (context, index) {
                                              if (allwidgets[index].type ==
                                                  "field") {
                                                return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      width: width * 0.05,
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          bottom: 5),
                                                      width: Responsive
                                                                  .isDesktop(
                                                                      context) ||
                                                              Responsive
                                                                  .isTablet(
                                                                      context)
                                                          ? width * 0.42
                                                          : width * 0.6,
                                                      padding: EdgeInsets.only(
                                                          left: width * 0.01,
                                                          right: width * 0.06,
                                                          bottom: 10,
                                                          top: 10),
                                                      height: 5 * 18.0,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    15)),
                                                      ),
                                                      child: TextFormField(
                                                        maxLines: 5,
                                                        readOnly:
                                                            allwidgets[index]
                                                                .isreadonly,
                                                        controller:
                                                            allwidgets[index]
                                                                .controllerr,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Poppins"),
                                                        cursorColor:
                                                            Colors.black12,
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          labelText:
                                                              "Description",
                                                          labelStyle: TextStyle(
                                                              color: Color(
                                                                  0xff6e7191),
                                                              fontFamily:
                                                                  "Poppins",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Visibility(
                                                      visible:
                                                          !allwidgets[index]
                                                              .isreadonly,
                                                      child: InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            // textitem++;
                                                            textvalid = true;
                                                            allwidgets[index]
                                                                    .isreadonly =
                                                                true;

                                                            // allwidgets.add(FAQtext(
                                                            //     overallindex: overallitem,
                                                            //     data: allwidgets[index].controller.text,
                                                            //     type: "text",
                                                            //     categoryindex: textitem));
                                                            // allwidgets[index].controllerr.text =
                                                            //     controller.text;
                                                            textdata[
                                                                    "text${allwidgets[index].overallindex}"] =
                                                                allwidgets[
                                                                        index]
                                                                    .controllerr
                                                                    .text;

                                                            // controller.clear();
                                                            print(textdata);

                                                            // print(finaldata);
                                                          });
                                                        },
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: Responsive
                                                                      .isDesktop(
                                                                          context) ||
                                                                  Responsive
                                                                      .isTablet(
                                                                          context)
                                                              ? width * 0.04
                                                              : width * 0.3,
                                                          height:
                                                              height * 0.064,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xff5081DB),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10)),
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                "Done",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    color: Colors
                                                                        .white,
                                                                    fontFamily:
                                                                        "Poppins",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Visibility(
                                                      visible: allwidgets[index]
                                                          .isreadonly,
                                                      child: InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              allwidgets[index]
                                                                      .isreadonly =
                                                                  false;
                                                            });

                                                            // allwidgets.removeAt(
                                                            //     allwidgets.indexOf(Text("f")));
                                                          },
                                                          child: Icon(
                                                            Icons.edit,
                                                            color: Colors.white,
                                                            size: 35,
                                                          )),
                                                    ),
                                                    // Visibility(
                                                    //   visible: true,
                                                    //   child: InkWell(
                                                    //       onTap: () {
                                                    //         allwidgets.removeAt(index);
                                                    //         // allwidgets.removeAt(
                                                    //         //     allwidgets.indexOf(Text("f")));
                                                    //       },
                                                    //       child: Icon(
                                                    //         Icons.delete,
                                                    //         color: Colors.white,
                                                    //         size: 35,
                                                    //       )),
                                                    // ),
                                                  ],
                                                );
                                              } else if (allwidgets[index]
                                                      .type ==
                                                  "image") {
                                                return Container(
                                                  width: 600,
                                                  height: 500,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: MemoryImage(
                                                          allwidgets[index]
                                                              .image),
                                                    ),
                                                  ),
                                                );
                                              } else if (allwidgets[index]
                                                      .type ==
                                                  "video") {
                                                return Container(
                                                    padding: EdgeInsets.only(
                                                        top: 30, bottom: 30),
                                                    width: width * 0.4,
                                                    height: height * 0.6,
                                                    child: VideoPlayer(
                                                        allwidgets[index]
                                                            .controller));
                                              }

                                              return Container();
                                            }),
                                        InkWell(
                                          onTap: () async {
                                            // finaldata["count"] = finaldata.length;

                                            // FirebaseFirestore.instance.collection("FAQs").add(finaldata);

                                            // FirebaseFirestore.instance.collection("FAQs").add(finaldata);
                                            // print(imagedata.length);
                                            setState(() {
                                              _loading = true;
                                            });
                                            DocumentReference? docid;
                                            int count = imagedata.length +
                                                textdata.length +
                                                videodata.length;

                                            if (title.text == null ||
                                                title.text == "") {
                                              fToast!.showToast(
                                                child: ToastMessage().show(
                                                    width,
                                                    context,
                                                    "Please enter some title first"),
                                                gravity: ToastGravity.BOTTOM,
                                                toastDuration:
                                                    Duration(seconds: 3),
                                              );
                                              setState(() {
                                                _loading = false;
                                              });
                                            } else if (count == 0) {
                                              fToast!.showToast(
                                                child: ToastMessage().show(
                                                    width,
                                                    context,
                                                    "Add Text, Image or Video first"),
                                                gravity: ToastGravity.BOTTOM,
                                                toastDuration:
                                                    Duration(seconds: 3),
                                              );
                                              setState(() {
                                                _loading = false;
                                              });
                                            } else if (selectedroles2.isEmpty) {
                                              fToast!.showToast(
                                                child: ToastMessage().show(
                                                    width,
                                                    context,
                                                    "Please select at least one user role"),
                                                gravity: ToastGravity.BOTTOM,
                                                toastDuration:
                                                    Duration(seconds: 3),
                                              );
                                              setState(() {
                                                _loading = false;
                                              });
                                            } else {
                                              textdata["count"] = count;
                                              textdata["visibleto"] =
                                                  selectedroles2;
                                              textdata["title"] = title.text;
                                              await FirebaseFirestore.instance
                                                  .collection("FAQs")
                                                  .add(textdata)
                                                  .then((valuee) {
                                                setState(() {
                                                  docid = valuee;
                                                });
                                              });
                                              if (videodata.isEmpty &&
                                                  imagedata.isEmpty) {
                                                setState(() {
                                                  _loading = false;
                                                });
                                                fToast!.showToast(
                                                  child: ToastMessage().show(
                                                      width,
                                                      context,
                                                      "FAQ added successfully"),
                                                  gravity: ToastGravity.BOTTOM,
                                                  toastDuration:
                                                      Duration(seconds: 3),
                                                );
                                                WidgetsBinding.instance!
                                                    .addPostFrameCallback((_) {
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              MainFaq()));
                                                });
                                              } else if (videodata.isEmpty) {
                                                imagedata.forEach(
                                                    (key, value) async {
                                                  // print(key);

                                                  String photoUrl =
                                                      await StorageMethods()
                                                          .uploadfaqimage(
                                                              "faqimages",
                                                              value,
                                                              false,
                                                              key);

                                                  setState(() {
                                                    finalimage[key] = photoUrl;
                                                  });

                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('FAQs')
                                                      .doc(docid!.id)
                                                      .update(finalimage);
                                                  // finaldata["count"] = finaldata.length;
                                                  if (imagedata.length ==
                                                          finalimage.length &&
                                                      videodata.length ==
                                                          finalvideo.length) {
                                                    setState(() {
                                                      _loading = false;
                                                    });
                                                    fToast!.showToast(
                                                      child: ToastMessage().show(
                                                          width,
                                                          context,
                                                          "FAQ added successfully"),
                                                      gravity:
                                                          ToastGravity.BOTTOM,
                                                      toastDuration:
                                                          Duration(seconds: 3),
                                                    );
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    MainFaq()));
                                                  }

                                                  // print(finaldata);
                                                });
                                              } else if (imagedata.isEmpty) {
                                                videodata.forEach(
                                                    (key, value) async {
                                                  var _ref = _stoarge
                                                      .ref()
                                                      .child("faqvideo")
                                                      .child(DateTime.now()
                                                              .toString() +
                                                          ".mp4");

                                                  // await _ref.putFile(File(value.path));
                                                  // String url = await _ref.getDownloadURL();
                                                  final UploadTask uploadTask =
                                                      _ref.putData(value!);
                                                  setState(() {
                                                    task = uploadTask;
                                                  });

                                                  final TaskSnapshot
                                                      downloadUrl =
                                                      await uploadTask;
                                                  // setState(() {
                                                  //   task = uploadTask;
                                                  // });

                                                  final String attchurl =
                                                      (await downloadUrl.ref
                                                          .getDownloadURL());
                                                  setState(() {
                                                    finalvideo[key] = attchurl;
                                                  });

                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('FAQs')
                                                      .doc(docid!.id)
                                                      .update(finalvideo);
                                                  if (imagedata.length ==
                                                          finalimage.length &&
                                                      videodata.length ==
                                                          finalvideo.length) {
                                                    setState(() {
                                                      _loading = false;
                                                    });
                                                    fToast!.showToast(
                                                      child: ToastMessage().show(
                                                          width,
                                                          context,
                                                          "FAQ added successfully"),
                                                      gravity:
                                                          ToastGravity.BOTTOM,
                                                      toastDuration:
                                                          Duration(seconds: 3),
                                                    );
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    MainFaq()));
                                                  }
                                                });
                                                fToast!.showToast(
                                                  child: ToastMessage().show(
                                                      width,
                                                      context,
                                                      "Uploading..."),
                                                  gravity: ToastGravity.BOTTOM,
                                                  toastDuration:
                                                      Duration(seconds: 3),
                                                );
                                              } else {
                                                imagedata.forEach(
                                                    (key, value) async {
                                                  // print(key);

                                                  String photoUrl =
                                                      await StorageMethods()
                                                          .uploadfaqimage(
                                                              "faqimages",
                                                              value,
                                                              false,
                                                              key);

                                                  setState(() {
                                                    finalimage[key] = photoUrl;
                                                  });

                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('FAQs')
                                                      .doc(docid!.id)
                                                      .update(finalimage);
                                                  // finaldata["count"] = finaldata.length;

                                                  // print(finaldata);
                                                });
                                                videodata.forEach(
                                                    (key, value) async {
                                                  fToast!.showToast(
                                                    child: ToastMessage().show(
                                                        width,
                                                        context,
                                                        "Uploading..."),
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    toastDuration:
                                                        Duration(seconds: 3),
                                                  );
                                                  var _ref = _stoarge
                                                      .ref()
                                                      .child("faqvideo")
                                                      .child(DateTime.now()
                                                              .toString() +
                                                          ".mp4");

                                                  // await _ref.putFile(File(value.path));
                                                  // String url = await _ref.getDownloadURL();
                                                  final UploadTask uploadTask =
                                                      _ref.putData(value!);
                                                  setState(() {
                                                    task = uploadTask;
                                                  });

                                                  final TaskSnapshot
                                                      downloadUrl =
                                                      await uploadTask;
                                                  // setState(() {
                                                  //   task = uploadTask;
                                                  // });

                                                  final String attchurl =
                                                      (await downloadUrl.ref
                                                          .getDownloadURL());
                                                  setState(() {
                                                    finalvideo[key] = attchurl;
                                                  });

                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('FAQs')
                                                      .doc(docid!.id)
                                                      .update(finalvideo);
                                                  if (imagedata.length ==
                                                          finalimage.length &&
                                                      videodata.length ==
                                                          finalvideo.length) {
                                                    setState(() {
                                                      _loading = false;
                                                    });
                                                    fToast!.showToast(
                                                      child: ToastMessage().show(
                                                          width,
                                                          context,
                                                          "FAQ added successfully"),
                                                      gravity:
                                                          ToastGravity.BOTTOM,
                                                      toastDuration:
                                                          Duration(seconds: 3),
                                                    );
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    MainFaq()));
                                                  }
                                                });
                                              }
                                            }
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.symmetric(
                                                vertical: 20),
                                            width: Responsive.isDesktop(
                                                        context) ||
                                                    Responsive.isTablet(context)
                                                ? width * 0.42
                                                : width * 0.1,
                                            height: height * 0.08,
                                            decoration: BoxDecoration(
                                              color: Color(0xff5081DB),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)),
                                            ),
                                            child: Text(
                                              "Submit",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 17.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "Poppins"),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  color: Color(0xff2B343B),
                                  child: SingleChildScrollView(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 25,
                                          ),
                                          Text(
                                            titletext,
                                            style: TextStyle(
                                                fontSize: 21,
                                                color: Colors.white,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          ListView.separated(
                                              separatorBuilder:
                                                  ((context, index) {
                                                return SizedBox(
                                                  height: 20,
                                                );
                                              }),
                                              shrinkWrap: true,
                                              itemCount: allwidgets.length,
                                              itemBuilder: (context, index) {
                                                if (allwidgets[index].type ==
                                                    "field") {
                                                  return Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        allwidgets[index]
                                                            .controllerr
                                                            .text,
                                                        style: TextStyle(
                                                            fontSize: 17,
                                                            color: Colors.white,
                                                            fontFamily:
                                                                "Poppins",
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ],
                                                  );
                                                } else if (allwidgets[index]
                                                        .type ==
                                                    "image") {
                                                  return Container(
                                                    width: 700,
                                                    height: 500,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: MemoryImage(
                                                            allwidgets[index]
                                                                .image),
                                                      ),
                                                    ),
                                                  );
                                                } else if (allwidgets[index]
                                                        .type ==
                                                    "video") {
                                                  return Container(
                                                      padding: EdgeInsets.only(
                                                          top: 30, bottom: 30),
                                                      width: width * 0.4,
                                                      height: height * 0.6,
                                                      child: VideoPlayer(
                                                          allwidgets[index]
                                                              .controller));
                                                }

                                                return Container();
                                              }),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ]),
                                  ),
                                ),
                              ])),
                            ],
                          ),
                        ),
                      )),
                  Expanded(
                      flex: 2,
                      child: Container(
                        color: Color(0xff20272C),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 40,
                            ),
                            InkWell(
                              onTap: () {
                                _showroleSelect(Role);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: width * 0.18,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    border: Border.all(),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Assign To:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Icon(Icons.keyboard_arrow_down_outlined),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Wrap(
                              children: [
                                for (var name in selectedroles2)
                                  Container(
                                    //color: Color(0xFF5081db),
                                    padding: EdgeInsets.all(3.0),
                                    child: ChoiceChip(
                                      label: Text(
                                        name + " ",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "Poppins"),
                                      ),
                                      selectedColor: Color(0xFF5081db),
                                      // disabledColor: Color(0xFF535c65),
                                      // backgroundColor: Color(0xFF535c65),
                                      selected: true,
                                    ),
                                  )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            task != null
                                ? buildUploadStatus(task!)
                                : Container()
                          ],
                        ),
                      )),
                ],
              )),
            ],
          ),
        ),
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
