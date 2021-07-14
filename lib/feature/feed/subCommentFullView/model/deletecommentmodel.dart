// To parse this JSON data, do
//
//     final deleteComment = deleteCommentFromJson(jsonString);

import 'dart:convert';

DeleteComment deleteCommentFromJson(String str) => DeleteComment.fromJson(json.decode(str));

String deleteCommentToJson(DeleteComment data) => json.encode(data.toJson());

class DeleteComment {
DeleteComment({
this.message,
});

String message;

factory DeleteComment.fromJson(Map<String, dynamic> json) => DeleteComment(
message: json["message"],
);

Map<String, dynamic> toJson() => {
"message": message,
};
}

