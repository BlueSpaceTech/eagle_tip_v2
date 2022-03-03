import 'package:cloud_firestore/cloud_firestore.dart';
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
//verid: confirmationResult,
              ),
            ))
        : print("there's soem error");
    return confirmationResult;
  }

  authenticateMe(ConfirmationResult confirmationResult, String otp,
      BuildContext context, DocumentSnapshot doc) async {
    UserCredential userCredential = await confirmationResult.confirm(otp);

    userCredential.additionalUserInfo!.isNewUser
        ? Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UploadImage(
                doc: doc,
              ),
            ))
        : print("err");
    userCredential.user!.delete();
  }
}
