// To parse this JSON data, do
//
//     final repeatFromPost = repeatFromPostFromJson(jsonString);

import 'dart:convert';

RepeatFromPost repeatFromPostFromJson(String str) => RepeatFromPost.fromJson(json.decode(str));

String repeatFromPostToJson(RepeatFromPost data) => json.encode(data.toJson());

class RepeatFromPost {
  RepeatFromPost({
    this.message,
  });

  String message;

  factory RepeatFromPost.fromJson(Map<String, dynamic> json) => RepeatFromPost(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}
