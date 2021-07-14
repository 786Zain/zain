// To parse this JSON data, do
//
//     final signUpModel = signUpModelFromJson(jsonString);

import 'dart:convert';

SignUpModel signUpModelFromJson(String str) => SignUpModel.fromJson(json.decode(str));

String signUpModelToJson(SignUpModel data) => json.encode(data.toJson());

class SignUpModel {
  SignUpModel({
    this.message,
    this.id,
  });

  String message;
  String id;

  factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
    message: json["message"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "_id": id,
  };
}
