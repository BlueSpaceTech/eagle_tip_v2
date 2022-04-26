import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:testttttt/UI/views/post_auth_screens/Tanks/tanks_request.dart';
import 'package:testttttt/UI/views/pre_auth_screens/phone_verification.dart';
import 'package:testttttt/UI/views/pre_auth_screens/uploadimage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OtpFucnctions {
  String phononumber = "";
  sendOTP(
      String phonenumber, BuildContext context, DocumentSnapshot doc) async {
    this.phononumber = phonenumber;
    FirebaseAuth auth = FirebaseAuth.instance;
    ConfirmationResult confirmationResult = await auth.signInWithPhoneNumber(
      phonenumber,
    );

    confirmationResult != null
        ? Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VerificationScreen(
                doc: doc,
                confirmationResult: confirmationResult,
              ),
            ))
        : print("there's soem error");
    return confirmationResult;
  }

  sendOTPLogin(String phonenumber) async {
    this.phononumber = phonenumber;
    FirebaseAuth auth = FirebaseAuth.instance;
    ConfirmationResult confirmationResult = await auth.signInWithPhoneNumber(
      phonenumber,
    );

    return confirmationResult;
  }

  Future<String> authenticateMe(
    ConfirmationResult confirmationResult,
    String otp,
  ) async {
    String res = "empty field";
    if (otp.isNotEmpty) {
      res = "success";
      UserCredential userCredential =
          await confirmationResult.confirm(otp).catchError((error, stackTrace) {
        res = error.toString();
      });

      userCredential.user!.delete();
      return res;
    }
    return res;
  }

  Future<String> authenticateMeLogin(
    ConfirmationResult confirmationResult,
    String otp,
  ) async {
    String res = "success";
    if (phononumber.isNotEmpty) {
      UserCredential userCredential =
          await confirmationResult.confirm(otp).catchError((error, stackTrace) {
        res = "Some Error Occurred";
      });
      userCredential.user!.delete();
    }

    return res;
  }
}
