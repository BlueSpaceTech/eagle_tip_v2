import 'package:flutter/material.dart';
import 'package:testttttt/UI/views/on-borading-tour/final_tour.dart';
import 'package:testttttt/UI/views/on-borading-tour/webuser/final_tour_web.dart';
import 'package:testttttt/Utils/responsive.dart';

class FinalTourMain extends StatelessWidget {
  const FinalTourMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
          mobile: FinalTour(), tablet: FinalTour(), desktop: FinalTourWeb()),
    );
  }
}
