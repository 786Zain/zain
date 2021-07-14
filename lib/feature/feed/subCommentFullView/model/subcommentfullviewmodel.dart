// To parse this JSON data, do
//
//     final commentPostFullView = commentPostFullViewFromJson(jsonString);

import 'dart:convert';

CommentPostFullView commentPostFullViewFromJson(String str) => CommentPostFullView.fromJson(json.decode(str));

String commentPostFullViewToJson(CommentPostFullView data) => json.encode(data.toJson());

class CommentPostFullView {
  CommentPostFullView({
    this.message,
    this.data,
  });

  String message;
  List<Datum> data;

  factory CommentPostFullView.fromJson(Map<String, dynamic> json) => CommentPostFullView(
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.like,
    this.repost,
    this.replyCount,
    this.parentId,
    this.userId,
    this.commentMessage,
    this.media,
    this.createdAt,
    this.replyingUser1,
    this.replyingUser2,
    this.commentCheck,
    this.userName,
    this.userFullname,
    this.userPic,
  });

  String id;
  List<dynamic> like;
  List<dynamic> repost;
  int replyCount;
  String parentId;
  String userId;
  String commentMessage;
  String media;
  DateTime createdAt;
  String replyingUser1;
  String replyingUser2;
  List<dynamic> commentCheck;
  String userName;
  String userFullname;
  String userPic;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    like: List<dynamic>.from(json["like"].map((x) => x)),
    repost: List<dynamic>.from(json["repost"].map((x) => x)),
    replyCount: json["replyCount"],
    parentId: json["parentId"],
    userId: json["userId"],
    commentMessage: json["commentMessage"],
    media: json["Media"] == null ? null : json["Media"],
    createdAt: DateTime.parse(json["createdAt"]),
    replyingUser1: json["replyingUser1"],
    replyingUser2: json["replyingUser2"],
    commentCheck: json["commentCheck"] == null ? null : List<dynamic>.from(json["commentCheck"].map((x) => x)),
    userName: json["userName"],
    userFullname: json["userFullname"],
    userPic: json["userPic"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "like": List<dynamic>.from(like.map((x) => x)),
    "repost": List<dynamic>.from(repost.map((x) => x)),
    "replyCount": replyCount,
    "parentId": parentId,
    "userId": userId,
    "commentMessage": commentMessage,
    "Media": media == null ? null : media,
    "createdAt": createdAt.toIso8601String(),
    "replyingUser1": replyingUser1,
    "replyingUser2": replyingUser2,
    "commentCheck": commentCheck == null ? null : List<dynamic>.from(commentCheck.map((x) => x)),
    "userName": userName,
    "userFullname": userFullname,
    "userPic": userPic,
  };
}
