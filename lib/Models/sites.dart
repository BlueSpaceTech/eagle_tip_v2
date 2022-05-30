import 'package:flutter/material.dart';
import 'dart:convert';

List<SitesDetails> sitesfromjson(String st) => List<SitesDetails>.from(
    json.decode(st).map((x) => SitesDetails.fromJson(x)));

class SitesDetails {
  final String sitename;
  final String siteid;
  final String sitelocation;
  final List products;
  SitesDetails({
    required this.sitename,
    required this.siteid,
    required this.sitelocation,
    required this.products,
  });
  factory SitesDetails.fromJson(Map<String, dynamic> json) => SitesDetails(
        sitename: json["CONNAM"],
        siteid: json["CONSNO"],
        sitelocation: json["CONCIT"],
        products: json["PRODUCTS"],
      );
}
