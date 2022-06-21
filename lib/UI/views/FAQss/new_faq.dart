import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:testttttt/Providers/user_provider.dart';
import 'package:testttttt/Services/storagemethods.dart';
import 'package:testttttt/Services/utils.dart';
import 'package:testttttt/UI/Widgets/customfab.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testttttt/UI/Widgets/customtoast.dart';
import 'package:testttttt/UI/views/FAQss/mainfaq.dart';
import 'package:testttttt/UI/views/post_auth_screens/HomeScreens/Home_screen.dart';
import 'package:testttttt/UI/views/post_auth_screens/HomeScreens/bottomNav.dart';
import 'package:testttttt/UI/views/post_auth_screens/Terminal/FAQ/addFAQ.dart';
import 'package:testttttt/UI/views/post_auth_screens/Terminal/terminalhome.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:video_player/video_player.dart';
import 'package:testttttt/Models/user.dart' as model;

class NewFaq extends StatefulWidget {
  const NewFaq({Key? key, required this.userRole}) : super(key: key);
  final String userRole;

  @override
  _NewFaqState createState() => _NewFaqState();
}

class _NewFaqState extends State<NewFaq> {
  String? title;
  List<Widget> allwidgets = [];
  // List<TextEditingController> controllers = [];

  // getController(int overall,int textt) {
  //   String namedecider = ;

  //   TextEditingController "text+${overall}+${textt}" = TextEditingController();
  // }
  List<TextEditingController> _controllers = [];
  // List<TextField> _fields = [];

  int overallitem = 0;
  // int textitem = 0;
  // int imageitem = 0;
  // int videoitem = 0;
  Map<String, dynamic> textdata = {};
  Map<String, dynamic> imagedata = {};
  Map<String, dynamic> videodata = {};
  Map<String, dynamic> finalimage = {};
  Map<String, dynamic> finalvideo = {};

  final picker = ImagePicker();
  final auth = FirebaseAuth.instance;
  final _stoarge = FirebaseStorage.instance;

  VideoPlayerController? _controller;
  FToast? fToast;

  final controller = TextEditingController();
  Future<Uint8List> selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    return im;
  }

  @override
  void initState() {
    // TODO: implement initState
    // allwidgets.add(Padding(
    //   padding: EdgeInsets.only(top: 20, bottom: 20),
    //   child: AddFAQTextField(
    //     labelText: "Title",
    //     valueChanged: (val) {
    //       setState(() {
    //         title = val;
    //       });
    //     },
    //     isactive: true,
    //   ),
    // ));
    fToast = FToast();
    fToast!.init(context);
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Uint8List? _image;
  List<File> _video = [];
  File? videoFile;

  chooseVideo() async {}

//  Future<void> retrieveLostData() async {
// final LostData response = await picker.getLostData();
// if (response.isEmpty) {
//   return;
// }
// if (response.file != null) {
//   setState(() {
//     _video.add(File(response.file.path));
//   });
// } else {
//   print(response.file);
// }
//  }

//  _uploadVideo() async {
// for (var video in _video) {
//   var _ref = _stoarge.ref().child("videos/" + Path.basename(video.path));
//   await _ref.putFile(video);
//   String url = await _ref.getDownloadURL();

//   print(url);
//   urls.add(url);
//   print(url);
// }
// print("uploading:" + urls.asMap().toString());
// await FirebaseFirestore.instance
//     .collection("users")
//     .doc(auth.currentUser.uid)
//     .update({"images": urls});
// //  .doc(auth.currentUser.uid).update({"images": FieldValue.arrayUnion(urls) });
//    }

//  }
  List selectedrole = [];

  List Role = [
    "General",
    "AppAdmin",
    "TerminalManager",
    "TerminalUser",
    "SiteOwner",
    "SiteManager",
    "SiteUser"
  ];
  _buildsiteschip() {
    bool issel = false;

    List<Widget> choices = [];
    Role.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(3),
        child: ChoiceChip(
          label: Text(
            item,
            style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
                fontFamily: "Poppins"),
          ),
          selectedColor: Color(0xFF5081db),
          disabledColor: Color(0xFF535c65),
          backgroundColor: Color(0xFF535c65),
          selected: selectedrole.contains(item),
          onSelected: (selected) {
            setState(() {
              issel = selected;

              print("else");
              selectedrole.contains(item)
                  ? selectedrole.remove(item)
                  : selectedrole.add(item);
              print(selectedrole);
              // _onsearchange();
              // +added
            });
          },
        ),
      ));
    });
    return choices;
  }

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

  startloading() {
    return showDialog(
      builder: (ctx) {
        return Center(
          child: Row(
            children: [
              CircularProgressIndicator(
                strokeWidth: 2,
              ),
              SizedBox(
                width: 10,
              ),
              buildUploadStatus(task!)
            ],
          ),
        );
      },
      context: context,
    );
  }

  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    model.User? user = Provider.of<UserProvider>(context).getUser;
    // getwidgets(List list) {
    //   for (int i = 0; i < list.length; i++) {
    //     return list[i];
    //   }
    // }

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: backGround_color,
      body: SingleChildScrollView(
        child: Stack(children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.05, vertical: height * 0.02),
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    Text(
                      "Add new Faq",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Poppins",
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(""),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Wrap(
                  runSpacing: 20,
                  children: [
                    InkWell(
                        onTap: () {
                          final field = Row(
                            children: [
                              Container(
                                width: Responsive.isDesktop(context)
                                    ? width * 0.42
                                    : width * 0.6,
                                padding: EdgeInsets.only(
                                    left: width * 0.01,
                                    right: width * 0.06,
                                    bottom: 10),
                                height: height * 0.08,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                child: TextFormField(
                                  controller: controller,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontFamily: "Poppins"),
                                  cursorColor: Colors.black12,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: "Description",
                                    labelStyle: TextStyle(
                                        color: Color(0xff6e7191),
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    overallitem++;
                                    allwidgets.removeLast();
                                    allwidgets.add(Padding(
                                      padding:
                                          EdgeInsets.only(top: 30, bottom: 30),
                                      child: Text(
                                        controller.text,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Poppins",
                                            fontSize: 18),
                                      ),
                                    ));
                                    textdata["text${overallitem}"] =
                                        controller.text;
                                    controller.clear();

                                    // print(finaldata);
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: Responsive.isDesktop(context)
                                      ? width * 0.13
                                      : width * 0.3,
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
                                        "Done",
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
                              InkWell(
                                  onTap: () {
                                    allwidgets.removeAt(
                                        allwidgets.indexOf(Text("f")));
                                  },
                                  child: Icon(Icons.edit)),
                            ],
                          );

                          setState(() {
                            // _controllers.add(controller);

                            // textitem++;
                            allwidgets.add(TextWidget(
                                key: ValueKey(overallitem),
                                data: "",
                                width: width,
                                height: height,
                                ontapdone: () {
                                  setState(() {
                                    print("yesss");
                                    overallitem++;
                                    allwidgets.removeLast();
                                    allwidgets.add(Padding(
                                      padding:
                                          EdgeInsets.only(top: 30, bottom: 30),
                                      child: Text(
                                        controller.text,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Poppins",
                                            fontSize: 18),
                                      ),
                                    ));
                                    textdata["text${overallitem}"] =
                                        controller.text;
                                    controller.clear();

                                    // print(finaldata);
                                  });
                                },
                                controller: controller));
                          });
                        },
                        child: customfab(
                            width: width, text: "Add Text", height: height)),
                    SizedBox(
                      width: 20,
                    ),
                    InkWell(
                        onTap: () async {
                          // selectImage();
                          // await Future.delayed(const Duration(seconds: 3));
                          Uint8List im = await selectImage();
                          //print(im);
                          Widget imagewidget = Container(
                            width: 700,
                            height: 500,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: MemoryImage(im),
                              ),
                            ),
                          );
                          // await Future.delayed(const Duration(seconds: 3));
                          setState(() {
                            allwidgets.add(imagewidget);
                            overallitem++;
                            imagedata["image${overallitem}"] = im;
                          });

                          // print(imagedata);
                        },
                        child: customfab(
                            width: width, text: "Add Image", height: height)),
                    SizedBox(
                      width: 20,
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
                          _controller =
                              VideoPlayerController.network(pickedVideo!.path);
                          _controller!.initialize();
                          _controller!.play();
                          pickedVideo.readAsBytes().then((value) {
                            videodata["video$overallitem"] = value;
                            // print(videodata);
                          });
                        });
                        allwidgets.add(Row(
                          children: [
                            Container(
                                padding: EdgeInsets.only(top: 30, bottom: 30),
                                width: width * 0.4,
                                height: height * 0.6,
                                child: VideoPlayer(_controller!)),
                          ],
                        ));

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
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Wrap(
                  runSpacing: 20,
                  children: _buildsiteschip(),
                ),
                SizedBox(
                  height: 20,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: allwidgets.length,
                    itemBuilder: (context, index) {
                      return allwidgets[index];
                    }),
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
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

                        if (title == null || title == "") {
                          fToast!.showToast(
                            child: ToastMessage().show(width, context,
                                "Please enter some title first"),
                            gravity: ToastGravity.BOTTOM,
                            toastDuration: Duration(seconds: 3),
                          );
                          setState(() {
                            _loading = false;
                          });
                        } else if (count == 0) {
                          fToast!.showToast(
                            child: ToastMessage().show(width, context,
                                "Add Text, Image or Video first"),
                            gravity: ToastGravity.BOTTOM,
                            toastDuration: Duration(seconds: 3),
                          );
                          setState(() {
                            _loading = false;
                          });
                        } else if (selectedrole.isEmpty) {
                          fToast!.showToast(
                            child: ToastMessage().show(width, context,
                                "Please select at least one user role"),
                            gravity: ToastGravity.BOTTOM,
                            toastDuration: Duration(seconds: 3),
                          );
                          setState(() {
                            _loading = false;
                          });
                        } else {
                          textdata["count"] = count;
                          textdata["visibleto"] = selectedrole;
                          textdata["title"] = title;
                          await FirebaseFirestore.instance
                              .collection("FAQs")
                              .add(textdata)
                              .then((valuee) {
                            setState(() {
                              docid = valuee;
                            });
                          });
                          if (videodata.isEmpty && imagedata.isEmpty) {
                            setState(() {
                              _loading = false;
                            });
                            fToast!.showToast(
                              child: ToastMessage().show(
                                  width, context, "FAQ added successfully"),
                              gravity: ToastGravity.BOTTOM,
                              toastDuration: Duration(seconds: 3),
                            );
                            WidgetsBinding.instance!.addPostFrameCallback((_) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MainFaq()));
                            });
                          } else if (videodata.isEmpty) {
                            imagedata.forEach((key, value) async {
                              // print(key);

                              String photoUrl = await StorageMethods()
                                  .uploadfaqimage(
                                      "faqimages", value, false, key);

                              setState(() {
                                finalimage[key] = photoUrl;
                              });

                              await FirebaseFirestore.instance
                                  .collection('FAQs')
                                  .doc(docid!.id)
                                  .update(finalimage);
                              // finaldata["count"] = finaldata.length;
                              if (imagedata.length == finalimage.length &&
                                  videodata.length == finalvideo.length) {
                                setState(() {
                                  _loading = false;
                                });
                                fToast!.showToast(
                                  child: ToastMessage().show(
                                      width, context, "FAQ added successfully"),
                                  gravity: ToastGravity.BOTTOM,
                                  toastDuration: Duration(seconds: 3),
                                );
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MainFaq()));
                              }

                              // print(finaldata);
                            });
                          } else if (imagedata.isEmpty) {
                            videodata.forEach((key, value) async {
                              var _ref = _stoarge
                                  .ref()
                                  .child("faqvideo")
                                  .child(DateTime.now().toString() + ".mp4");

                              // await _ref.putFile(File(value.path));
                              // String url = await _ref.getDownloadURL();
                              final UploadTask uploadTask =
                                  _ref.putData(value!);
                              setState(() {
                                task = uploadTask;
                              });

                              final TaskSnapshot downloadUrl = await uploadTask;
                              // setState(() {
                              //   task = uploadTask;
                              // });

                              final String attchurl =
                                  (await downloadUrl.ref.getDownloadURL());
                              setState(() {
                                finalvideo[key] = attchurl;
                              });

                              await FirebaseFirestore.instance
                                  .collection('FAQs')
                                  .doc(docid!.id)
                                  .update(finalvideo);
                              if (imagedata.length == finalimage.length &&
                                  videodata.length == finalvideo.length) {
                                setState(() {
                                  _loading = false;
                                });
                                fToast!.showToast(
                                  child: ToastMessage().show(
                                      width, context, "FAQ added successfully"),
                                  gravity: ToastGravity.BOTTOM,
                                  toastDuration: Duration(seconds: 3),
                                );
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MainFaq()));
                              }
                            });
                            fToast!.showToast(
                              child: ToastMessage()
                                  .show(width, context, "Uploading..."),
                              gravity: ToastGravity.BOTTOM,
                              toastDuration: Duration(seconds: 3),
                            );
                          } else {
                            imagedata.forEach((key, value) async {
                              // print(key);

                              String photoUrl = await StorageMethods()
                                  .uploadfaqimage(
                                      "faqimages", value, false, key);

                              setState(() {
                                finalimage[key] = photoUrl;
                              });

                              await FirebaseFirestore.instance
                                  .collection('FAQs')
                                  .doc(docid!.id)
                                  .update(finalimage);
                              // finaldata["count"] = finaldata.length;

                              // print(finaldata);
                            });
                            videodata.forEach((key, value) async {
                              fToast!.showToast(
                                child: ToastMessage()
                                    .show(width, context, "Uploading..."),
                                gravity: ToastGravity.BOTTOM,
                                toastDuration: Duration(seconds: 3),
                              );
                              var _ref = _stoarge
                                  .ref()
                                  .child("faqvideo")
                                  .child(DateTime.now().toString() + ".mp4");

                              // await _ref.putFile(File(value.path));
                              // String url = await _ref.getDownloadURL();
                              final UploadTask uploadTask =
                                  _ref.putData(value!);
                              setState(() {
                                task = uploadTask;
                              });

                              final TaskSnapshot downloadUrl = await uploadTask;
                              // setState(() {
                              //   task = uploadTask;
                              // });

                              final String attchurl =
                                  (await downloadUrl.ref.getDownloadURL());
                              setState(() {
                                finalvideo[key] = attchurl;
                              });

                              await FirebaseFirestore.instance
                                  .collection('FAQs')
                                  .doc(docid!.id)
                                  .update(finalvideo);
                              if (imagedata.length == finalimage.length &&
                                  videodata.length == finalvideo.length) {
                                setState(() {
                                  _loading = false;
                                });
                                fToast!.showToast(
                                  child: ToastMessage().show(
                                      width, context, "FAQ added successfully"),
                                  gravity: ToastGravity.BOTTOM,
                                  toastDuration: Duration(seconds: 3),
                                );
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MainFaq()));
                              }
                            });
                          }
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: Responsive.isDesktop(context)
                            ? width * 0.24
                            : width * 0.42,
                        height: height * 0.064,
                        decoration: BoxDecoration(
                          color: Color(0xff5081DB),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Upload FAQ",
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
                    SizedBox(
                      width: 20,
                    ),
                    task != null ? buildUploadStatus(task!) : Container()
                  ],
                ),
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
      ),
    );
  }
}

class TextWidget extends StatefulWidget {
  TextWidget({
    required this.key,
    required this.data,
    required this.width,
    required this.height,
    required this.ontapdone,
    required this.controller,
  }) : super(key: key);
  final String data;
  final ValueKey key;
  final double width;
  final double height;
  final Function ontapdone;
  final TextEditingController controller;
  @override
  State<TextWidget> createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: Responsive.isDesktop(context)
              ? widget.width * 0.42
              : widget.width * 0.6,
          padding: EdgeInsets.only(
              left: widget.width * 0.01,
              right: widget.width * 0.06,
              bottom: 10),
          height: widget.height * 0.08,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: TextFormField(
            controller: widget.controller,
            textAlign: TextAlign.left,
            style: TextStyle(fontFamily: "Poppins"),
            cursorColor: Colors.black12,
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: "Description",
              labelStyle: TextStyle(
                  color: Color(0xff6e7191),
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        InkWell(
          onTap: () {
            widget.ontapdone;
          },
          child: Container(
            alignment: Alignment.center,
            width: Responsive.isDesktop(context)
                ? widget.width * 0.13
                : widget.width * 0.3,
            height: widget.height * 0.064,
            decoration: BoxDecoration(
              color: Color(0xff5081DB),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Done",
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
        InkWell(
            onTap: () {
              // allwidgets.removeAt(
              //     allwidgets.indexOf(Text("f")));
            },
            child: Icon(Icons.edit)),
      ],
    );
  }
}
