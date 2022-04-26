import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testttttt/Providers/user_provider.dart';
import 'package:testttttt/UI/views/FAQss/desktopfaq.dart';
import 'package:testttttt/UI/views/FAQss/mobilefaq.dart';
import 'package:testttttt/UI/views/post_auth_screens/faq.dart';
import 'package:testttttt/Utils/responsive.dart';
import 'package:testttttt/Models/user.dart' as model;

class MainFaq extends StatelessWidget {
  const MainFaq({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      body: Responsive(
          mobile: MobileFaqs(userrOLE: user.userRole), tablet: MobileFaqs(userrOLE: user.userRole,), desktop: DesktopFAQs(
            userrOLE: user.userRole,
          )),
    );
  }
}
