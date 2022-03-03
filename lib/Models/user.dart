import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class User {
  final String name;
  final String email;
  final String Phonenumber;
  final String userRole;
  final List sites;
  final String employerCode;
  final bool phoneisverified;
  final String dpurl;
  final String uid;
  final String tokenID;

  const User({
    required this.name,
    required this.email,
    required this.userRole,
    required this.Phonenumber,
    required this.tokenID,
    required this.employerCode,
    required this.dpurl,
    required this.phoneisverified,
    required this.sites,
    required this.uid,
  });
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "token": tokenID,
      "email": email,
      "dpUrl": dpurl,
      "employerCode": employerCode,
      "uid": uid,
      "phonenumber": Phonenumber,
      "userRole": userRole,
      "isverified": phoneisverified,
      "sites": sites,
    };
  }

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      tokenID: snapshot["token"],
      name: snapshot["name"],
      email: snapshot["email"],
      Phonenumber: snapshot["phonenumber"],
      employerCode: snapshot["employerCode"],
      phoneisverified: snapshot["isverified"],
      sites: snapshot["sites"],
      userRole: snapshot["userRole"],
      uid: snapshot["uid"],
      dpurl: snapshot["dpurl"],
    );
  }
}
