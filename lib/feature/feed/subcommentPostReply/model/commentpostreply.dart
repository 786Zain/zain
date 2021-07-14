// To parse this JSON data, do
//
//     final commentPostReply = commentPostReplyFromJson(jsonString);

import 'dart:convert';

CommentPostReply commentPostReplyFromJson(String str) => CommentPostReply.fromJson(json.decode(str));

String commentPostReplyToJson(CommentPostReply data) => json.encode(data.toJson());

class CommentPostReply {
  CommentPostReply({
    this.message,
  });

  String message;

  factory CommentPostReply.fromJson(Map<String, dynamic> json) => CommentPostReply(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}
