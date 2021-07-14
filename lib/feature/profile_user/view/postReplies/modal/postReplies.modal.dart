//To parse this JSON data, do

   // final profilePostRepliesDetails = profilePostRepliesDetailsFromJson(jsonString);

//Correct One
// import 'dart:convert';
//
// ProfilePostRepliesDetails profilePostRepliesDetailsFromJson(String str) => ProfilePostRepliesDetails.fromJson(json.decode(str));
//
// String profilePostRepliesDetailsToJson(ProfilePostRepliesDetails data) => json.encode(data.toJson());
//
// class ProfilePostRepliesDetails {
//   ProfilePostRepliesDetails({
//     this.message,
//     this.data,
//   });
//
//   String message;
//   List<PostReply> data;
//
//   factory ProfilePostRepliesDetails.fromJson(Map<String, dynamic> json) => ProfilePostRepliesDetails(
//     message: json["message"],
//     data: List<PostReply>.from(json["data"].map((x) => PostReply.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "message": message,
//     "data": List<dynamic>.from(data.map((x) => x.toJson())),
//   };
// }
//
// class PostReply {
//   PostReply({
//     this.id,
//     this.like,
//     this.userId,
//     this.commentMessage,
//     this.replyCount,
//     this.repost,
//     this.createdAt,
//     this.userName,
//     this.userFullname,
//     this.userPic,
//   });
//
//   String id;
//   List<dynamic> like;
//   String userId;
//   String commentMessage;
//   int replyCount;
//   List<String> repost;
//   DateTime createdAt;
//   String userName;
//   String userFullname;
//   String userPic;
//
//   factory PostReply.fromJson(Map<String, dynamic> json) => PostReply(
//     id: json["_id"],
//     like: List<dynamic>.from(json["like"].map((x) => x)),
//     userId: json["userId"],
//     commentMessage: json["commentMessage"],
//     replyCount: json["replyCount"],
//     repost: List<String>.from(json["repost"].map((x) => x)),
//     createdAt: DateTime.parse(json["createdAt"]),
//     userName: json["userName"],
//     userFullname: json["userFullname"],
//     userPic: json["userPic"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "like": List<dynamic>.from(like.map((x) => x)),
//     "userId": userId,
//     "commentMessage": commentMessage,
//     "replyCount": replyCount,
//     "repost": List<dynamic>.from(repost.map((x) => x)),
//     "createdAt": createdAt.toIso8601String(),
//     "userName": userName,
//     "userFullname": userFullname,
//     "userPic": userPic,
//   };
// }



// To parse this JSON data, do
//
//     final profilePostRepliesDetails = profilePostRepliesDetailsFromJson(jsonString);

// import 'dart:convert';
//
// ProfilePostRepliesDetails profilePostRepliesDetailsFromJson(String str) => ProfilePostRepliesDetails.fromJson(json.decode(str));
//
// String profilePostRepliesDetailsToJson(ProfilePostRepliesDetails data) => json.encode(data.toJson());
//
// class ProfilePostRepliesDetails {
//   ProfilePostRepliesDetails({
//     this.message,
//     this.data,
//   });
//
//   String message;
//   List<Datum> data;
//
//   factory ProfilePostRepliesDetails.fromJson(Map<String, dynamic> json) => ProfilePostRepliesDetails(
//     message: json["message"],
//     data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "message": message,
//     "data": List<dynamic>.from(data.map((x) => x.toJson())),
//   };
// }
//
// class Datum {
//   Datum({
//     this.id,
//     this.like,
//     this.userId,
//     this.parentId,
//     this.commentMessage,
//     this.replyCount,
//     this.commentCheck,
//     this.repost,
//     this.createdAt,
//     this.userName,
//     this.userFullname,
//     this.userPic,
//     this.commentMedia,
//     this.commentMediaThumbnail,
//   });
//
//   String id;
//   List<String> like;
//   String userId;
//   String parentId;
//   String commentMessage;
//   int replyCount;
//   List<String> commentCheck;
//   List<String> repost;
//   DateTime createdAt;
//   String userName;
//   String userFullname;
//   String userPic;
//   String commentMedia;
//   String commentMediaThumbnail;
//
//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//     id: json["_id"],
//     like: List<String>.from(json["like"].map((x) => x)),
//     userId: json["userId"],
//     parentId: json["parentId"],
//     commentMessage: json["commentMessage"],
//     replyCount: json["replyCount"],
//     commentCheck: List<String>.from(json["commentCheck"].map((x) => x)),
//     repost: List<String>.from(json["repost"].map((x) => x)),
//     createdAt: DateTime.parse(json["createdAt"]),
//     userName: json["userName"],
//     userFullname: json["userFullname"],
//     userPic: json["userPic"],
//     commentMedia: json["commentMedia"] == null ? null : json["commentMedia"],
//     commentMediaThumbnail: json["commentMediaThumbnail"] == null ? null : json["commentMediaThumbnail"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "like": List<dynamic>.from(like.map((x) => x)),
//     "userId": userId,
//     "parentId": parentId,
//     "commentMessage": commentMessage,
//     "replyCount": replyCount,
//     "commentCheck": List<dynamic>.from(commentCheck.map((x) => x)),
//     "repost": List<dynamic>.from(repost.map((x) => x)),
//     "createdAt": createdAt.toIso8601String(),
//     "userName": userName,
//     "userFullname": userFullname,
//     "userPic": userPic,
//     "commentMedia": commentMedia == null ? null : commentMedia,
//     "commentMediaThumbnail": commentMediaThumbnail == null ? null : commentMediaThumbnail,
//   };
// }


import 'dart:convert';

ProfilePostRepliesDetails profilePostRepliesDetailsFromJson(String str) => ProfilePostRepliesDetails.fromJson(json.decode(str));

String profilePostRepliesDetailsToJson(ProfilePostRepliesDetails data) => json.encode(data.toJson());

class ProfilePostRepliesDetails {
  ProfilePostRepliesDetails({
    this.message,
    this.data,
  });

  String message;
  List<PostReply> data;

  factory ProfilePostRepliesDetails.fromJson(Map<String, dynamic> json) => ProfilePostRepliesDetails(
    message: json["message"],
    data: List<PostReply>.from(json["data"].map((x) => PostReply.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class PostReply {
  PostReply({
    this.id,
    this.like,
    this.userId,
    this.parentId,
    this.commentMessage,
    this.replyCount,
    this.replying,
    this.commentCheck,
    this.repost,
    this.createdAt,
    this.userName,
    this.userFullname,
    this.userPic,
    this.commentMedia,

  });

  String id;
  List<dynamic> like;
  String userId;
  String parentId;
  String commentMessage;
  int replyCount;
  String replying;
  List<String> commentCheck;
  List<String> repost;
  DateTime createdAt;
  String userName;
  String userFullname;
  String userPic;
  String commentMedia;


  factory PostReply.fromJson(Map<String, dynamic> json) => PostReply(
    id: json["_id"],
    like: List<dynamic>.from(json["like"].map((x) => x)),
    userId: json["userId"],
    parentId: json["parentId"],
    commentMessage: json["commentMessage"],
    replyCount: json["replyCount"],
    replying: json["replying"],
    commentCheck: List<String>.from(json["commentCheck"].map((x) => x)),
    repost: List<String>.from(json["repost"].map((x) => x)),
    createdAt: DateTime.parse(json["createdAt"]),
    userName: json["userName"],
    userFullname: json["userFullname"],
    userPic: json["userPic"],
    commentMedia: json["commentMedia"] == null ? null : json["commentMedia"],

  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "like": List<dynamic>.from(like.map((x) => x)),
    "userId": userId,
    "parentId": parentId,
    "commentMessage": commentMessage,
    "replyCount": replyCount,
    "replying": replying,
    "commentCheck": List<dynamic>.from(commentCheck.map((x) => x)),
    "repost": List<dynamic>.from(repost.map((x) => x)),
    "createdAt": createdAt.toIso8601String(),
    "userName": userName,
    "userFullname": userFullname,
    "userPic": userPic,
    "commentMedia": commentMedia == null ? null : commentMedia,

  };
}
