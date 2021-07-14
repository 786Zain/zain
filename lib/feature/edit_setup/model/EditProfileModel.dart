// To parse this JSON data, do
//
//     final editProfile = editProfileFromJson(jsonString);

import 'dart:convert';

EditProfile editProfileFromJson(String str) => EditProfile.fromJson(json.decode(str));

String editProfileToJson(EditProfile data) => json.encode(data.toJson());

class EditProfile {
  EditProfile({
    this.message,
  });

  String message;

  factory EditProfile.fromJson(Map<String, dynamic> json) => EditProfile(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}
