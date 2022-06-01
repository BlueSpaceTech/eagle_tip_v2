import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Text(
        "HEHEH",
        style: TextStyle(color: Colors.black, fontSize: 40),
      ),
    ));
  }
}
