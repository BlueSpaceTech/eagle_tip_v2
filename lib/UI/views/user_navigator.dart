import 'dart:async';

import 'package:provider/provider.dart';
import 'package:testttttt/Providers/user_provider.dart';
import 'package:testttttt/Routes/approutes.dart';
import 'package:testttttt/UI/views/post_auth_screens/HomeScreens/Home_screen.dart';
import 'package:testttttt/UI/views/post_auth_screens/HomeScreens/bottomNav.dart';
import 'package:testttttt/UI/views/post_auth_screens/settings.dart';
import 'package:testttttt/UI/views/pre_auth_screens/deciding_screen.dart';
import 'package:testttttt/UI/views/pre_auth_screens/login_screen.dart';
import 'package:testttttt/UI/views/pre_auth_screens/splashscreen.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:testttttt/Models/user.dart' as model;

class UserNavigator extends StatefulWidget {
  const UserNavigator({Key? key}) : super(key: key);

  @override
  State<UserNavigator> createState() => _UserNavigatorState();
}

class _UserNavigatorState extends State<UserNavigator> {
  Future<bool>? checkingUserDetails;
  @override
  void initState() {
    super.initState();
    // checkingUserDetails = UserProvider().fetchUserDetailsFromDatabase(context);
  }

  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: checkingUserDetails,
      builder: (context, AsyncSnapshot<bool> isUserExists) {
        if (isUserExists.connectionState == ConnectionState.none) {
          return LoginScreen();
        }
        if (isUserExists.connectionState == ConnectionState.done) {
          if (isUserExists.connectionState == ConnectionState.done) {
            addData();
            // model.User user = Provider.of<UserProvider>(context).getUser;

            // if (user.phoneisverified) {
            //   print(user.phoneisverified);
            if (Responsive.isDesktop(context)) {
              return HomeScreen(
                showdialog: true,
                sites: [],
              );
            } else {
              return BottomNav();
            }
            // } else {
            //   LoginScreen();
            // }
            //   return LoginScreen();
            // }
          }
        }
        if (isUserExists.connectionState == ConnectionState.waiting) {
          return SplashScreen();
        }
        print("loginnnnnn");
        return LoginScreen();
      },
    );
  }
}
