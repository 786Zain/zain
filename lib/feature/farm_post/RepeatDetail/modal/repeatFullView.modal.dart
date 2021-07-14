// To parse this JSON data, do
//
//     final repeatPostFullView = repeatPostFullViewFromJson(jsonString);

import 'dart:convert';

RepeatPostFullView repeatPostFullViewFromJson(String str) => RepeatPostFullView.fromJson(json.decode(str));

String repeatPostFullViewToJson(RepeatPostFullView data) => json.encode(data.toJson());

class RepeatPostFullView {
  RepeatPostFullView({
    this.message,
    this.data,
  });

  String message;
  Data data;

  factory RepeatPostFullView.fromJson(Map<String, dynamic> json) => RepeatPostFullView(
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.posts,
    this.comments,
  });

  List<Post> posts;
  List<Comment> comments;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    posts: List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
    comments: List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "posts": List<dynamic>.from(posts.map((x) => x.toJson())),
    "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
  };
}

class Comment {
  Comment({
    this.id,
    this.like,
    this.replyCount,
    this.parentId,
    this.userId,
    this.commentMessage,
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
  List<dynamic> repost;
  DateTime createdAt;
  String replying;
  String userName;
  String userFullname;
  String userPic;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    id: json["_id"],
    like: List<dynamic>.from(json["like"].map((x) => x)),
    replyCount: json["replyCount"],
    parentId: json["parentId"],
    userId: json["userId"],
    commentMessage: json["commentMessage"],
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
    "repost": List<dynamic>.from(repost.map((x) => x)),
    "createdAt": createdAt.toIso8601String(),
    "replying": replying,
    "userName": userName,
    "userFullname": userFullname,
    "userPic": userPic,
  };
}

class Post {
  Post({
    this.id,
    this.postPhoto,
    this.like,
    this.privacyState,
    this.privacyAllowance,
    this.commentCount,
    this.caption,
    this.category,
    this.subCategory,
    this.profileId,
    this.repost,
    this.userName,
    this.name,
    this.profilePic,
    this.createdAt,
    this.textFeed,
  });

  String id;
  List<PostPhoto> postPhoto;
  List<String> like;
  bool privacyState;
  List<dynamic> privacyAllowance;
  int commentCount;
  String caption;
  dynamic category;
  dynamic subCategory;
  String profileId;
  List<dynamic> repost;
  String userName;
  String name;
  String profilePic;
  DateTime createdAt;
  bool textFeed;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: json["_id"],
    postPhoto: List<PostPhoto>.from(json["postPhoto"].map((x) => PostPhoto.fromJson(x))),
    like: List<String>.from(json["like"].map((x) => x)),
    privacyState: json["privacyState"],
    privacyAllowance: List<dynamic>.from(json["privacyAllowance"].map((x) => x)),
    commentCount: json["commentCount"],
    caption: json["caption"],
    category: json["category"],
    subCategory: json["subCategory"],
    profileId: json["profileId"],
    repost: List<dynamic>.from(json["repost"].map((x) => x)),
    userName: json["userName"],
    name: json["name"],
    profilePic: json["profilePic"],
    createdAt: DateTime.parse(json["createdAt"]),
    textFeed: json["textFeed"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "postPhoto": List<dynamic>.from(postPhoto.map((x) => x.toJson())),
    "like": List<dynamic>.from(like.map((x) => x)),
    "privacyState": privacyState,
    "privacyAllowance": List<dynamic>.from(privacyAllowance.map((x) => x)),
    "commentCount": commentCount,
    "caption": caption,
    "category": category,
    "subCategory": subCategory,
    "profileId": profileId,
    "repost": List<dynamic>.from(repost.map((x) => x)),
    "userName": userName,
    "name": name,
    "profilePic": profilePic,
    "createdAt": createdAt.toIso8601String(),
    "textFeed": textFeed,

  };
}

class PostPhoto {
  PostPhoto({
    this.location,
    this.fieldname,
    this.originalname,
    this.encoding,
    this.mimetype,
    this.size,
    this.bucket,
    this.key,
    this.acl,
    this.contentType,
    this.contentDisposition,
    this.storageClass,
    this.serverSideEncryption,
    this.metadata,
    this.etag,
    this.thumbnailUrl,
  });

  String location;
  String fieldname;
  String originalname;
  String encoding;
  String mimetype;
  int size;
  String bucket;
  String key;
  String acl;
  String contentType;
  dynamic contentDisposition;
  String storageClass;
  dynamic serverSideEncryption;
  dynamic metadata;
  String etag;
  String thumbnailUrl;

  factory PostPhoto.fromJson(Map<String, dynamic> json) => PostPhoto(
    location: json["location"],
    fieldname: json["fieldname"] == null ? null : json["fieldname"],
    originalname: json["originalname"] == null ? null : json["originalname"],
    encoding: json["encoding"] == null ? null : json["encoding"],
    mimetype: json["mimetype"] == null ? null : json["mimetype"],
    size: json["size"] == null ? null : json["size"],
    bucket: json["bucket"] == null ? null : json["bucket"],
    key: json["key"] == null ? null : json["key"],
    acl: json["acl"] == null ? null : json["acl"],
    contentType: json["contentType"] == null ? null : json["contentType"],
    contentDisposition: json["contentDisposition"],
    storageClass: json["storageClass"] == null ? null : json["storageClass"],
    serverSideEncryption: json["serverSideEncryption"],
    metadata: json["metadata"],
    etag: json["etag"] == null ? null : json["etag"],
    thumbnailUrl: json["thumbnailUrl"] == null ? null : json["thumbnailUrl"],

  );

  Map<String, dynamic> toJson() => {
    "location": location,
    "fieldname": fieldname == null ? null : fieldname,
    "originalname": originalname == null ? null : originalname,
    "encoding": encoding == null ? null : encoding,
    "mimetype": mimetype == null ? null : mimetype,
    "size": size == null ? null : size,
    "bucket": bucket == null ? null : bucket,
    "key": key == null ? null : key,
    "acl": acl == null ? null : acl,
    "contentType": contentType == null ? null : contentType,
    "contentDisposition": contentDisposition,
    "storageClass": storageClass == null ? null : storageClass,
    "serverSideEncryption": serverSideEncryption,
    "metadata": metadata,
    "etag": etag == null ? null : etag,
    "thumbnailUrl": thumbnailUrl == null ? null : thumbnailUrl,
  };
}
