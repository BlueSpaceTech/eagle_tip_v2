import 'package:flutter/material.dart';
import 'package:testttttt/UI/views/FAQss/desktopfaq.dart';
import 'package:testttttt/UI/views/FAQss/mobilefaq.dart';
import 'package:testttttt/UI/views/post_auth_screens/faq.dart';
import 'package:testttttt/Utils/responsive.dart';

class MainFaq extends StatelessWidget {
  const MainFaq({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
          mobile: MobileFaqs(), tablet: MobileFaqs(), desktop: DesktopFAQs()),
    );
  }
}
