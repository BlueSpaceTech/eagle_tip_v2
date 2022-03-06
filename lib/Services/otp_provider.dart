import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
    ConfirmationResult confirmationResult =
        await auth.signInWithPhoneNumber(phonenumber);

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

  authenticateMe(
    ConfirmationResult confirmationResult,
    String otp,
    BuildContext context,
    DocumentSnapshot doc,
  ) async {
    String res = "success";
    UserCredential userCredential =
        await confirmationResult.confirm(otp).catchError((error, stackTrace) {
      res = "Some Error Occurred";
      return res;
    });

    userCredential.user!.delete();
    return res;
  }
}
