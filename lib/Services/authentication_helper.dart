//import 'dart:ffi';
import 'dart:math';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:testttttt/Models/TokenModel.dart';

import 'package:testttttt/Services/storagemethods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testttttt/Models/user.dart' as Model;
import 'package:onesignal_flutter/onesignal_flutter.dart';

class AuthFunctions {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //fetch user
  Future<Model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot? snapp;
    try {
      snapp = await _firestore.collection("users").doc(currentUser.uid).get();
    } catch (e) {
      print("error in provider");
    }
    return Model.User.fromSnap(snapp!);
  }

  static genrateemployercode() {
    final _random = Random();
    const _availableChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
    final randomString = List.generate(6,
            (index) => _availableChars[_random.nextInt(_availableChars.length)])
        .join();

    return randomString;
  }

  Future<String> resetpassword(String email) async {
    String res = "Link sent to your email!";
    try {
      if (email.isNotEmpty) {
        _auth.sendPasswordResetEmail(email: email);
        return res;
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> signupuser({
    required String email,
    required String password,
    required String username,
    required String phoneno,
    required String role,
    // required String token,
    required List Sites,
    required String employercode,
    required bool isverified,
    required Uint8List file,
  }) async {
    /*
    var status = await OneSignal.shared.getDeviceState();
    String? tokenId = status?.userId;
    */
    String res = "Some error occured";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          phoneno.toString().isNotEmpty ||
          role.isNotEmpty ||
          Sites.isNotEmpty ||
          employercode.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String photoUrl = await StorageMethods()
            .uploadImageToStorage("profilePics", file, false);

        //add user to database
        Model.User user = Model.User(
          name: username,
          email: email,
          Phonenumber: phoneno,
          uid: cred.user!.uid,
          sites: Sites,
          employerCode: employercode,
          phoneisverified: isverified,
          dpurl: photoUrl,
          userRole: role,
        );
        _firestore.collection("users").doc(cred.user!.uid).set(user.toJson());
        final fcmToken = await _fcm.getToken(
            vapidKey:
                "BLNGqXgTqC0begtlTvH532MHDnIiL7zOQwIIqj8QbEM5qZWGejX0GsMbejbqPRSDnxzRnu0STkU0AN4asyC8ujI");
        await _firestore
            .collection("users")
            .doc(cred.user!.uid)
            .collection("tokens")
            .doc(fcmToken)
            .set(TokenModel(
                    createdAt: FieldValue.serverTimestamp(), token: fcmToken!)
                .toJson());

        res = "success";
        _firestore.collection("users").doc(employercode).delete();
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == "invalid-email") {
        res = "The email is not valid";
      } else if (err.code == "weak-password") {
        res = "Password is weak";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

//login in user
  Future<String> loginuser(
      {required String email, required String password}) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == "user-not-found") {
        res = "Account not available";
      } else if (err.code == "wrong-password") {
        res = "Wrong Password entered";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  sendinvite() {}
  static String addUserTodb(String name, String email, String phonenumber,
      String userRole, String dpUrl, bool phoneisverified, List sites) {
    String code = genrateemployercode();
    String res = "Successfully added";
    if (name.isNotEmpty || email.isNotEmpty || phonenumber.isNotEmpty) {
      FirebaseFirestore.instance.collection("users").doc(code).set({
        "name": name,
        "email": email,
        "phonenumber": phonenumber,
        "userRole": userRole,
        "isverified": phoneisverified,
        "sites": sites,
        "employercode": code,
      });
      return res;
    } else {
      res = "Please input all fields";
    }
    return res;
  }

  //SIGN UP METHOD
  static Future signUp({String? email, String? password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN OUT METHOD
  static Future signOut() async {
    await _auth.signOut();

    print('signout');
  }

  //add imageurl
  static adddpUrl(String employercode) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(employercode)
        .set({'dpUrl': 'value'}, SetOptions(merge: true)).then((value) {
      //Do your stuff.
    });
  }
}
