// To parse this JSON data, do
//
//     final updatedComment = updatedCommentFromJson(jsonString);

import 'dart:convert';

UpdatedComment updatedCommentFromJson(String str) => UpdatedComment.fromJson(json.decode(str));

String updatedCommentToJson(UpdatedComment data) => json.encode(data.toJson());

class UpdatedComment {
  UpdatedComment({
    this.message,
  });

  String message;

  factory UpdatedComment.fromJson(Map<String, dynamic> json) => UpdatedComment(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}
