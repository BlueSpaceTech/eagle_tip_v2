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
  final bool isSubscribed;
  final String currentsite;

  const User(
      {required this.name,
      required this.email,
      required this.userRole,
      required this.Phonenumber,
      required this.employerCode,
      required this.dpurl,
      required this.phoneisverified,
      required this.sites,
      required this.uid,
      required this.isSubscribed,
      required this.currentsite});
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "isSubscribed": false,
      "email": email,
      "dpUrl": dpurl,
      "employerCode": employerCode,
      "uid": uid,
      "phonenumber": Phonenumber,
      "userRole": userRole,
      "isverified": phoneisverified,
      "sites": sites,
      "currentsite": currentsite,
    };
  }

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      isSubscribed: false,
      name: snapshot["name"] ?? false,
      email: snapshot["email"] ?? false,
      Phonenumber: snapshot["phonenumber"] ?? false,
      employerCode: snapshot["employerCode"] ?? false,
      phoneisverified: snapshot["isverified"] ?? false,
      sites: snapshot["sites"] ?? false,
      userRole: snapshot["userRole"] ?? false,
      uid: snapshot["uid"] ?? false,
      dpurl: snapshot["dpUrl"] ?? false,
      currentsite: snapshot["currentsite"] ?? false,
    );
  }

  // static List<User> dataListFromSnapshot(QuerySnapshot querySnapshot) {
  //   return querySnapshot.docs.map((snapshot) {
  //     final Map<String, dynamic> dataMap =
  //         snapshot.data() as Map<String, dynamic>;

  //     return User(
  //         isSubscribed: false,
  //         name: dataMap["name"],
  //         email: dataMap["email"],
  //         Phonenumber: dataMap["phonenumber"],
  //         employerCode: dataMap["employerCode"],
  //         phoneisverified: dataMap["isverified"],
  //         sites: dataMap["sites"],
  //         userRole: dataMap["userRole"],
  //         uid: dataMap["uid"],
  //         dpurl: dataMap["dpUrl"],

  //         );
  //   }).toList();
  // }
}
