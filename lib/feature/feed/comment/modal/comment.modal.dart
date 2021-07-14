// To parse this JSON data, do
//
//     final commentPostDetail = commentPostDetailFromJson(jsonString);

import 'dart:convert';

CommentPostDetail commentPostDetailFromJson(String str) => CommentPostDetail.fromJson(json.decode(str));

String commentPostDetailToJson(CommentPostDetail data) => json.encode(data.toJson());

class CommentPostDetail {
  CommentPostDetail({
    this.message,
  });

  String message;

  factory CommentPostDetail.fromJson(Map<String, dynamic> json) => CommentPostDetail(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}
