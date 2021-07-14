// To parse this JSON data, do
//
//     final nestedReplyViews = nestedReplyViewsFromJson(jsonString);

import 'dart:convert';

NestedReplyViews nestedReplyViewsFromJson(String str) => NestedReplyViews.fromJson(json.decode(str));

String nestedReplyViewsToJson(NestedReplyViews data) => json.encode(data.toJson());

class NestedReplyViews {
  NestedReplyViews({
    this.message,
    this.data,
  });

  String message;
  List<DatumModel> data;

  factory NestedReplyViews.fromJson(Map<String, dynamic> json) => NestedReplyViews(
    message: json["message"],
    data: List<DatumModel>.from(json["data"].map((x) => DatumModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class DatumModel {
  DatumModel({
    this.id,
    this.like,
    this.repost,
    this.replyCount,
    this.parentId,
    this.userId,
    this.commentMessage,
    this.createdAt,
    this.replyingUser1,
    this.replyingUser2,
    this.commentCheck,
    this.userName,
    this.userFullname,
    this.userPic,
    this.media,
  });

  String id;
  List<dynamic> like;
  List<dynamic> repost;
  int replyCount;
  String parentId;
  String userId;
  String commentMessage;
  DateTime createdAt;
  String replyingUser1;
  String replyingUser2;
  List<dynamic> commentCheck;
  String userName;
  String userFullname;
  String userPic;
  String media;

  factory DatumModel.fromJson(Map<String, dynamic> json) => DatumModel(
    id: json["_id"],
    like: List<dynamic>.from(json["like"].map((x) => x)),
    repost: List<dynamic>.from(json["repost"].map((x) => x)),
    replyCount: json["replyCount"],
    parentId: json["parentId"],
    userId: json["userId"],
    commentMessage: json["commentMessage"],
    createdAt: DateTime.parse(json["createdAt"]),
    replyingUser1: json["replyingUser1"],
    replyingUser2: json["replyingUser2"],
    commentCheck: json["commentCheck"] == null ? null : List<dynamic>.from(json["commentCheck"].map((x) => x)),
    userName: json["userName"],
    userFullname: json["userFullname"],
    userPic: json["userPic"],
    media: json["Media"] == null ? null : json["Media"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "like": List<dynamic>.from(like.map((x) => x)),
    "repost": List<dynamic>.from(repost.map((x) => x)),
    "replyCount": replyCount,
    "parentId": parentId,
    "userId": userId,
    "commentMessage": commentMessage,
    "createdAt": createdAt.toIso8601String(),
    "replyingUser1": replyingUser1,
    "replyingUser2": replyingUser2,
    "commentCheck": commentCheck == null ? null : List<dynamic>.from(commentCheck.map((x) => x)),
    "userName": userName,
    "userFullname": userFullname,
    "userPic": userPic,
    "Media": media == null ? null : media,
  };
}
