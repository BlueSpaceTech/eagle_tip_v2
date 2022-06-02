import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:testttttt/UI/views/post_auth_screens/HomeScreens/Home_screen.dart';
import 'package:testttttt/UI/views/post_auth_screens/HomeScreens/bottomNav.dart';
import 'package:testttttt/UI/views/pre_auth_screens/deciding_screen.dart';
import 'package:testttttt/UI/views/pre_auth_screens/login_screen.dart';
import 'package:testttttt/Utils/responsive.dart';

class AuthHandling extends StatefulWidget {
  const AuthHandling({Key? key}) : super(key: key);

  @override
  State<AuthHandling> createState() => _AuthHandlingState();
}

class _AuthHandlingState extends State<AuthHandling> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  getScreen() {
    if (_auth.currentUser == null) {
      return DecidingScreen();
    } else {
      if (Responsive.isDesktop(context)) {
        return HomeScreen(
          showdialog: true,
          sites: [],
        );
      } else {
        return BottomNav();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getScreen(),
    );
  }
}
