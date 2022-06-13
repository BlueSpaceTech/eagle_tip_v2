import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:testttttt/Providers/user_provider.dart';
import 'package:testttttt/UI/views/post_auth_screens/HomeScreens/Home_screen.dart';
import 'package:testttttt/Models/user.dart' as model;

class Tourr extends StatefulWidget {
  Tourr({Key? key}) : super(key: key);

  @override
  State<Tourr> createState() => _TourrState();
}

class _TourrState extends State<Tourr> {
  @override
  Widget build(BuildContext context) {
    model.User? user = Provider.of<UserProvider>(context).getUser;
    return ShowCaseWidget(
      builder: Builder(
          builder: (context) =>
              HomeScreen(showdialog: false, sites: user!.sites)),
    );
  }
}
