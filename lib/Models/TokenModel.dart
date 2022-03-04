import 'package:cloud_firestore/cloud_firestore.dart';

class TokenModel {
  String token;
  FieldValue createdAt;

  TokenModel({required this.createdAt, required this.token});

  TokenModel.fromData(Map<String, dynamic> data)
      : token = data["token"],
        createdAt = data["createdAt"];

  static TokenModel? fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return TokenModel(createdAt: map["token"], token: map["createdAt"]);
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'createdAt': createdAt,
    };
  }
}
