import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:provider/provider.dart';
import 'package:testttttt/Providers/user_provider.dart';
import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/Services/authentication_helper.dart';
import 'package:testttttt/Services/storagemethods.dart';
import 'package:testttttt/Services/utils.dart';
import 'package:testttttt/UI/Widgets/customTextField.dart';
import 'package:testttttt/UI/Widgets/custom_webbg.dart';
import 'package:testttttt/UI/Widgets/customfaqbottom.dart';
import 'package:testttttt/UI/Widgets/customsubmitbutton.dart';
import 'package:testttttt/UI/Widgets/customtoast.dart';
import 'package:testttttt/UI/Widgets/password_textfield.dart';
import 'package:testttttt/UI/views/on-borading-tour/welcome_tour.dart';
import 'package:testttttt/UI/views/post_auth_screens/HomeScreens/bottomNav.dart';
import 'package:testttttt/UI/views/post_auth_screens/Terminal/terminalhome.dart';
import 'package:testttttt/Utils/constants.dart';
import 'package:testttttt/Utils/detectPlatform.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class UploadImage extends StatefulWidget {
  UploadImage({Key? key, required this.doc}) : super(key: key);
  DocumentSnapshot doc;
  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  FToast? fToast;
  final TextEditingController _password = TextEditingController();
  Uint8List? _image;
  String? name;
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      name = widget.doc.get("name");
    });

    super.initState();
    super.initState();
    fToast = FToast();
    fToast!.init(context);
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  route() {
    Responsive.isDesktop(context)
        ? Navigator.pushNamed(context, AppRoutes.homeScreen)
        : Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => BottomNav()));
  }

  route2() {
    UserProvider _userProvider = Provider.of(context, listen: false);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                (_userProvider.getUser.userRole == "TerminalUser" ||
                        _userProvider.getUser.userRole == "TerminalManager")
                    ? TerminalHome()
                    : WelcomeTour()));
  }

  void signupUser(double width) async {
    if (_image!.isEmpty) {
      fToast!.showToast(
        child:
            ToastMessage().show(width, context, "Please select a image first"),
        gravity: ToastGravity.BOTTOM,
        toastDuration: Duration(seconds: 3),
      );
    } else if (_password.text == "") {
      fToast!.showToast(
        child:
            ToastMessage().show(width, context, "Please set a password first"),
        gravity: ToastGravity.BOTTOM,
        toastDuration: Duration(seconds: 3),
      );
    } else {
      showDialog(
        builder: (ctx) {
          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          );
        },
        context: context,
      );
      bool issubscribed = false;
      try {
        if (Platform.isAndroid || Platform.isIOS) {
          setState(() {
            issubscribed = true;
          });
        } else {
          setState(() {
            issubscribed = false;
          });
        }
      } catch (e) {
        setState(() {
          issubscribed = false;
        });
      }
      String res = await AuthFunctions().signupuser(
        // token: widget.doc.get("token"),
        email: widget.doc.get("email"),
        password: _password.text,
        username: widget.doc.get("name"),
        phoneno: widget.doc.get("phonenumber"),
        role: widget.doc.get("userRole"),
        Sites: widget.doc.get("sites"),
        employercode: widget.doc.get("employercode"),
        isverified: true,
        issubscribed: issubscribed,

        file: _image!,
      );
      startTime() async {
        var duration = new Duration(seconds: 3);
        return Timer(duration, route2);
      }

      //  StorageMethods().uploadStorageImage(_image!, "filePath");
      print(res);
      if (res == "success") {
        addData();
        startTime();

        fToast!.showToast(
          child: ToastMessage().show(width, context, "Your Account is Created"),
          gravity: ToastGravity.BOTTOM,
          toastDuration: Duration(seconds: 3),
        );
      } else {
        //Uri url = await StorageMethods().uploadImageFile(_image!);
        fToast!.showToast(
          child: ToastMessage().show(width, context, res),
          gravity: ToastGravity.BOTTOM,
          toastDuration: Duration(seconds: 3),
        );
      }
    }
  }

  void _subscribetotopic() async {
    List sites = widget.doc.get("sites");
    for (int i = 0; i < sites.length; i++) {
      await _fcm
          .subscribeToTopic(widget.doc.get("userRole") +
              sites[i].toString().replaceAll(" ", ""))
          .then((value) {
        print("succesfully subscribed");
      }).catchError((onError) {
        print(onError);
      });
      FirebaseFirestore.instance.collection("users").doc(widget.doc.id).update({
        "isSubscribed": true,
      });
    }
  }

  void _subscribeAllUsers() async {
    await _fcm.subscribeToTopic("AllUsers").then((value) {
      print("succesfully subscribed");
    }).catchError((onError) {
      print(onError);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xff2B343B),
      bottomNavigationBar: CustomFAQbottom(),
      body: SingleChildScrollView(
        child: Stack(children: [
          WebBg(),
          Padding(
            padding: EdgeInsets.only(
                left: width * 0.1, right: width * 0.1, top: height * 0.08),
            child: Container(
              child: Center(
                child: Column(
                  crossAxisAlignment: Responsive.isDesktop(context)
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: Responsive.isDesktop(context)
                            ? MainAxisAlignment.center
                            : MainAxisAlignment.start,
                        children: [
                          Visibility(
                            visible:
                                Responsive.isDesktop(context) ? false : true,
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: Responsive.isDesktop(context)
                                ? width * 0
                                : width * 0.12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Responsive.isDesktop(context)
                                  ? Image.asset("assets/Logo 2 1.png")
                                  : Image.asset("assets/Logo 2 2.png")
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.1,
                    ),
                    Text(
                      "Hey ${name},",
                      style: TextStyle(
                          fontSize: 24,
                          color: Color(0xff92B8FF),
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Upload a profile picture and set a password for your account.",
                      style: TextStyle(
                          fontSize: 16,
                          color: Color(0xffDEDEDE),
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    /*
                     _image!=null?
                    CircleAvatar(
                      radius: 64,
                      backgroundImage: MemoryImage(_image!),
                    ):
                     CircleAvatar(
                      radius: 64,
                      backgroundImage: MemoryImage(_image!),
                    ),
                    */
                    _image != null
                        ? Container(
                            alignment: Alignment.bottomRight,
                            width: Responsive.isDesktop(context)
                                ? width * 0.12
                                : width * 0.4,
                            height: height * 0.24,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: MemoryImage(_image!),
                              ),
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: InkWell(
                                onTap: selectImage,
                                child: Image.asset("assets/addblue.png")),
                          )
                        : Container(
                            alignment: Alignment.bottomRight,
                            width: Responsive.isDesktop(context)
                                ? width * 0.12
                                : width * 0.4,
                            height: height * 0.24,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/Camera.png"),
                              ),
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: InkWell(
                                onTap: selectImage,
                                child: Image.asset("assets/addblue.png")),
                          ),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    Text(
                      "Set password",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    CustomPasswordTextField(
                        isactive: true,
                        controller: _password,
                        width: width,
                        height: height,
                        labelText: "Password"),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    InkWell(
                      onTap: () async {
                        signupUser(width);
                        if (Platform.isAndroid || Platform.isIOS) {
                          _subscribetotopic();
                          _subscribeAllUsers();
                        }
                      },
                      child: CustomSubmitButton(
                        width: width,
                        title: "Done",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
