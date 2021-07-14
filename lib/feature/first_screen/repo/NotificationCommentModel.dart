// To parse this JSON data, do
//
//     final notificatinComment = notificatinCommentFromJson(jsonString);

import 'dart:convert';

NotificatinComment notificatinCommentFromJson(String str) => NotificatinComment.fromJson(json.decode(str));

String notificatinCommentToJson(NotificatinComment data) => json.encode(data.toJson());

class NotificatinComment {
  NotificatinComment({
    this.message,
    this.result,
  });

  String message;
  List<Result> result;

  factory NotificatinComment.fromJson(Map<String, dynamic> json) => NotificatinComment(
    message: json["message"],
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class Result {
  Result({
    this.id,
    this.like,
    this.replyCount,
    this.parentId,
    this.userId,
    this.commentMessage,
    this.commentCheck,
    this.category,
    this.subCategory,
    this.repost,
    this.createdAt,
    this.replying,
    this.userName,
    this.userFullname,
    this.userPic,
  });

  String id;
  List<dynamic> like;
  int replyCount;
  String parentId;
  String userId;
  String commentMessage;
  List<dynamic> commentCheck;
  String category;
  String subCategory;
  List<dynamic> repost;
  DateTime createdAt;
  String replying;
  String userName;
  String userFullname;
  String userPic;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["_id"],
    like: List<dynamic>.from(json["like"].map((x) => x)),
    replyCount: json["replyCount"],
    parentId: json["parentId"],
    userId: json["userId"],
    commentMessage: json["commentMessage"],
    commentCheck: List<dynamic>.from(json["commentCheck"].map((x) => x)),
    category: json["category"],
    subCategory: json["subCategory"],
    repost: List<dynamic>.from(json["repost"].map((x) => x)),
    createdAt: DateTime.parse(json["createdAt"]),
    replying: json["replying"],
    userName: json["userName"],
    userFullname: json["userFullname"],
    userPic: json["userPic"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "like": List<dynamic>.from(like.map((x) => x)),
    "replyCount": replyCount,
    "parentId": parentId,
    "userId": userId,
    "commentMessage": commentMessage,
    "commentCheck": List<dynamic>.from(commentCheck.map((x) => x)),
    "category": category,
    "subCategory": subCategory,
    "repost": List<dynamic>.from(repost.map((x) => x)),
    "createdAt": createdAt.toIso8601String(),
    "replying": replying,
    "userName": userName,
    "userFullname": userFullname,
    "userPic": userPic,
  };
}
