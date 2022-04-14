import 'dart:html';

import 'package:flutter/material.dart';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:testttttt/Providers/user_provider.dart';
import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/Services/utils.dart';
import 'package:testttttt/UI/Widgets/customfab.dart';
import 'package:testttttt/UI/Widgets/customsubmitbutton.dart';
import 'package:testttttt/UI/Widgets/customtoast.dart';
import 'package:testttttt/UI/views/post_auth_screens/Terminal/FAQ/addFAQ.dart';
import 'package:testttttt/UI/views/post_auth_screens/faq.dart';
import 'package:testttttt/Utils/common.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:testttttt/Models/user.dart' as model;

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class AddVideo extends StatefulWidget {
  AddVideo({Key? key, required this.userRole}) : super(key: key);
  String userRole;
  @override
  _AddVideoState createState() => _AddVideoState();
}

class _AddVideoState extends State<AddVideo> {
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

  File? _video;
  final picker = ImagePicker;
  String downloadurl = "";
  // void _pickFile() async {
  //   // opens storage to pick files and the picked file or files
  //   // are assigned into result and if no file is chosen result is null.
  //   // you can also toggle "allowMultiple" true or false depending on your need
  //   final result = await FilePicker.platform.pickFiles(allowMultiple: false);

  //   // if no file is picked
  //   if (result == null) return;

  //   // we get the file from result object
  //   final file = result.files.first;

  //   _openFile(file);
  // }

  // void _openFile(PlatformFile file) {
  //   OpenFile.open(file.path);
  // }

  // _pickVideo() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ["mp4"],
  //   );
  //   // _video =result!.files.first;
  //   _videoPlayerController = VideoPlayerController.file(result.);
  //     ..initialize().then((_) {
  //       setState(() {});
  //       _videoPlayerController.play();
  //     });
  // }

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
            child: ToastMessage()
                .show(300, context, "Now, select a suitable title for video"),
            gravity: ToastGravity.BOTTOM,
            toastDuration: Duration(seconds: 3),
          );
          setState(() {
            isuploading = false;
            downloadurl = attchurl;
          });
          setState(() {});
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
  String title = "";

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: width * 0.2),
        height: height * 1,
        width: width * 1,
        color: backGround_color,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () {
                      uploadfileee();
                    },
                    child: customfab(
                        width: width, text: "Upload Video", height: height)),
                SizedBox(
                  width: 20,
                ),
                task != null && isuploading
                    ? buildUploadStatus(task!)
                    : Container()
              ],
            ),
            SizedBox(
              height: 20,
            ),
            AddFAQTextField(
              labelText: "Add title",
              valueChanged: (val) {
                setState(() {
                  title = val;
                });
              },
              isactive: true,
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
                onTap: () {
                  if (downloadurl == "") {
                    fToast!.showToast(
                      child: ToastMessage()
                          .show(300, context, "Please upload a video first"),
                      gravity: ToastGravity.BOTTOM,
                      toastDuration: Duration(seconds: 3),
                    );
                  } else if (title == "") {
                    fToast!.showToast(
                      child: ToastMessage()
                          .show(300, context, "Select a title first"),
                      gravity: ToastGravity.BOTTOM,
                      toastDuration: Duration(seconds: 3),
                    );
                  } else {
                    FirebaseFirestore.instance.collection("faqvideos").add({
                      "videourl": downloadurl,
                      "userRole": widget.userRole,
                      "title": title,
                    }).then((value) {
                      fToast!.showToast(
                        child: ToastMessage()
                            .show(300, context, "Video Uploaded successfully"),
                        gravity: ToastGravity.BOTTOM,
                        toastDuration: Duration(seconds: 3),
                      );
                      Navigator.pop(context);
                    });
                  }
                },
                child: CustomSubmitButton(width: width, title: "Done")),
          ],
        ),
      ),
    );
  }
}
