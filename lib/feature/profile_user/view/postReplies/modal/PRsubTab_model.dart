//To parse this JSON data, do

  //  final profilePostRepliesDetails = profilePostRepliesDetailsFromJson(jsonString);

import 'dart:convert';

PostRepliesDetails profilePostRepliesDetailsFromJson(String str) => PostRepliesDetails.fromJson(json.decode(str));

String profilePostRepliesDetailsToJson(PostRepliesDetails data) => json.encode(data.toJson());

class PostRepliesDetails {
  PostRepliesDetails({
    this.message,
    this.data,
  });

  String message;
  List<PostReplySubTab> data;

  factory PostRepliesDetails.fromJson(Map<String, dynamic> json) => PostRepliesDetails(
    message: json["message"],
    data: List<PostReplySubTab>.from(json["data"].map((x) => PostReplySubTab.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class PostReplySubTab {
  PostReplySubTab({
    this.id,
    this.like,
    this.userId,
    this.parentId,
    this.commentMessage,
    this.replyCount,
    this.commentCheck,
    this.repost,
    this.createdAt,
    this.userName,
    this.userFullname,
    this.userPic,
    this.commentMedia,
    this.commentMediaThumbnail,
  });

  String id;
  List<String> like;
  String userId;
  String parentId;
  String commentMessage;
  int replyCount;
  List<String> commentCheck;
  List<String> repost;
  DateTime createdAt;
  String userName;
  String userFullname;
  String userPic;
  String commentMedia;
  String commentMediaThumbnail;

  factory PostReplySubTab.fromJson(Map<String, dynamic> json) => PostReplySubTab(
    id: json["_id"],
    like: List<String>.from(json["like"].map((x) => x)),
    userId: json["userId"],
    parentId: json["parentId"],
    commentMessage: json["commentMessage"],
    replyCount: json["replyCount"],
    commentCheck: List<String>.from(json["commentCheck"].map((x) => x)),
    repost: List<String>.from(json["repost"].map((x) => x)),
    createdAt: DateTime.parse(json["createdAt"]),
    userName: json["userName"],
    userFullname: json["userFullname"],
    userPic: json["userPic"],
    commentMedia: json["commentMedia"] == null ? null : json["commentMedia"],
    commentMediaThumbnail: json["commentMediaThumbnail"] == null ? null : json["commentMediaThumbnail"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "like": List<dynamic>.from(like.map((x) => x)),
    "userId": userId,
    "parentId": parentId,
    "commentMessage": commentMessage,
    "replyCount": replyCount,
    "commentCheck": List<dynamic>.from(commentCheck.map((x) => x)),
    "repost": List<dynamic>.from(repost.map((x) => x)),
    "createdAt": createdAt.toIso8601String(),
    "userName": userName,
    "userFullname": userFullname,
    "userPic": userPic,
    "commentMedia": commentMedia == null ? null : commentMedia,
    "commentMediaThumbnail": commentMediaThumbnail == null ? null : commentMediaThumbnail,
  };
}
