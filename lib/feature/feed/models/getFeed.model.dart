// // To parse this JSON data, do
// //
// //     final feedPostsModel = feedPostsModelFromJson(jsonString);
//
// import 'dart:convert';
//
// FeedPostsModel feedPostsModelFromJson(String str) => FeedPostsModel.fromJson(json.decode(str));
//
// String feedPostsModelToJson(FeedPostsModel data) => json.encode(data.toJson());
//
// class FeedPostsModel {
//   FeedPostsModel({
//     this.message,
//     this.data,
//   });
//
//   String message;
//   List<FeedDetail> data;
//
//   factory FeedPostsModel.fromJson(Map<String, dynamic> json) => FeedPostsModel(
//     message: json["message"],
//     data: List<FeedDetail>.from(json["data"].map((x) => FeedDetail.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "message": message,
//     "data": List<dynamic>.from(data.map((x) => x.toJson())),
//   };
// }
//
// class FeedDetail {
//   FeedDetail({
//     this.postPhoto,
//     this.postVideo,
//     this.like,
//     this.privacyState,
//     this.privacyAllowance,
//     this.commentCount,
//     this.id,
//     this.caption,
//     this.profileId,
//     this.profilePic,
//     this.userName,
//     this.createdAt,
//     this.v,
//   });
//
//   List<PostPhoto> postPhoto;
//   List<dynamic> postVideo;
//   List<dynamic> like;
//   bool privacyState;
//   List<dynamic> privacyAllowance;
//   int commentCount;
//   String id;
//   String caption;
//   String profileId;
//   String profilePic;
//   String userName;
//   DateTime createdAt;
//   int v;
//
//   factory FeedDetail.fromJson(Map<String, dynamic> json) => FeedDetail(
//     postPhoto: List<PostPhoto>.from(json["postPhoto"].map((x) => PostPhoto.fromJson(x))),
//     postVideo: List<dynamic>.from(json["postVideo"].map((x) => x)),
//     like: List<dynamic>.from(json["like"].map((x) => x)),
//     privacyState: json["privacyState"],
//     privacyAllowance: List<dynamic>.from(json["privacyAllowance"].map((x) => x)),
//     commentCount: json["commentCount"],
//     id: json["_id"],
//     caption: json["caption"],
//     profileId: json["profileId"],
//     profilePic: json["profilePic"],
//     userName: json["userName"],
//     createdAt: DateTime.parse(json["createdAt"]),
//     v: json["__v"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "postPhoto": List<dynamic>.from(postPhoto.map((x) => x.toJson())),
//     "postVideo": List<dynamic>.from(postVideo.map((x) => x)),
//     "like": List<dynamic>.from(like.map((x) => x)),
//     "privacyState": privacyState,
//     "privacyAllowance": List<dynamic>.from(privacyAllowance.map((x) => x)),
//     "commentCount": commentCount,
//     "_id": id,
//     "caption": caption,
//     "profileId": profileId,
//     "profilePic": profilePic,
//     "userName": userName,
//     "createdAt": createdAt.toIso8601String(),
//     "__v": v,
//   };
// }
//
// class PostPhoto {
//   PostPhoto({
//     this.fieldname,
//     this.originalname,
//     this.encoding,
//     this.mimetype,
//     this.size,
//     this.bucket,
//     this.key,
//     this.acl,
//     this.contentType,
//     this.contentDisposition,
//     this.storageClass,
//     this.serverSideEncryption,
//     this.metadata,
//     this.location,
//     this.etag,
//   });
//
//   String fieldname;
//   String originalname;
//   String encoding;
//   String mimetype;
//   int size;
//   String bucket;
//   String key;
//   String acl;
//   String contentType;
//   dynamic contentDisposition;
//   String storageClass;
//   dynamic serverSideEncryption;
//   dynamic metadata;
//   String location;
//   String etag;
//
//   factory PostPhoto.fromJson(Map<String, dynamic> json) => PostPhoto(
//     fieldname: json["fieldname"],
//     originalname: json["originalname"],
//     encoding: json["encoding"],
//     mimetype: json["mimetype"],
//     size: json["size"],
//     bucket: json["bucket"],
//     key: json["key"],
//     acl: json["acl"],
//     contentType: json["contentType"],
//     contentDisposition: json["contentDisposition"],
//     storageClass: json["storageClass"],
//     serverSideEncryption: json["serverSideEncryption"],
//     metadata: json["metadata"],
//     location: json["location"],
//     etag: json["etag"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "fieldname": fieldname,
//     "originalname": originalname,
//     "encoding": encoding,
//     "mimetype": mimetype,
//     "size": size,
//     "bucket": bucket,
//     "key": key,
//     "acl": acl,
//     "contentType": contentType,
//     "contentDisposition": contentDisposition,
//     "storageClass": storageClass,
//     "serverSideEncryption": serverSideEncryption,
//     "metadata": metadata,
//     "location": location,
//     "etag": etag,
//   };
// }

//Chnaged


// To parse this JSON data, do
//
//     final feedPostsModel = feedPostsModelFromJson(jsonString);
//
// import 'dart:convert';
//
// FeedPostsModel feedPostsModelFromJson(String str) => FeedPostsModel.fromJson(json.decode(str));
//
// String feedPostsModelToJson(FeedPostsModel data) => json.encode(data.toJson());
//
// class FeedPostsModel {
//   FeedPostsModel({
//     this.message,
//     this.data,
//   });
//
//   String message;
//   List<FeedDetail> data;
//
//   factory FeedPostsModel.fromJson(Map<String, dynamic> json) => FeedPostsModel(
//     message: json["message"],
//     data: List<FeedDetail>.from(json["data"].map((x) => FeedDetail.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "message": message,
//     "data": List<dynamic>.from(data.map((x) => x.toJson())),
//   };
// }
//
// class FeedDetail {
//   FeedDetail({
//     this.id,
//     this.postPhoto,
//     this.like,
//     this.privacyState,
//     this.privacyAllowance,
//     this.commentCount,
//     this.caption,
//     this.category,
//     this.subCategory,
//     this.profileId,
//     this.repost,
//     this.type,
//     this.repeat,
//     this.userName,
//     this.name,
//     this.profilePic,
//     this.createdAt,
//   });
//
//   String id;
//   List<PostPhoto> postPhoto;
//   List<dynamic> like;
//   bool privacyState;
//   List<dynamic> privacyAllowance;
//   int commentCount;
//   String caption;
//   String category;
//   String subCategory;
//   String profileId;
//   List<dynamic> repost;
//   String type;
//   Repeat repeat;
//   String userName;
//   String name;
//   String profilePic;
//   DateTime createdAt;
//
//   factory FeedDetail.fromJson(Map<String, dynamic> json) => FeedDetail(
//     id: json["_id"],
//     postPhoto: List<PostPhoto>.from(json["postPhoto"].map((x) => PostPhoto.fromJson(x))),
//     like: List<dynamic>.from(json["like"].map((x) => x)),
//     privacyState: json["privacyState"],
//     privacyAllowance: List<dynamic>.from(json["privacyAllowance"].map((x) => x)),
//     commentCount: json["commentCount"],
//     caption: json["caption"],
//     category: json["category"] == null ? null : json["category"],
//     subCategory: json["subCategory"] == null ? null : json["subCategory"],
//     profileId: json["profileId"],
//     repost: json["repost"] == null ? null : List<dynamic>.from(json["repost"].map((x) => x)),
//     type: json["type"] == null ? null : json["type"],
//     repeat: Repeat.fromJson(json["repeat"]),
//     userName: json["userName"],
//     name: json["name"],
//     profilePic: json["profilePic"],
//     createdAt: DateTime.parse(json["createdAt"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "postPhoto": List<dynamic>.from(postPhoto.map((x) => x.toJson())),
//     "like": List<dynamic>.from(like.map((x) => x)),
//     "privacyState": privacyState,
//     "privacyAllowance": List<dynamic>.from(privacyAllowance.map((x) => x)),
//     "commentCount": commentCount,
//     "caption": caption,
//     "category": category == null ? null : category,
//     "subCategory": subCategory == null ? null : subCategory,
//     "profileId": profileId,
//     "repost": repost == null ? null : List<dynamic>.from(repost.map((x) => x)),
//     "type": type == null ? null : type,
//     "repeat": repeat.toJson(),
//     "userName": userName,
//     "name": name,
//     "profilePic": profilePic,
//     "createdAt": createdAt.toIso8601String(),
//   };
// }
//
// class PostPhoto {
//   PostPhoto({
//     this.fieldname,
//     this.originalname,
//     this.encoding,
//     this.mimetype,
//     this.size,
//     this.bucket,
//     this.key,
//     this.acl,
//     this.contentType,
//     this.contentDisposition,
//     this.storageClass,
//     this.serverSideEncryption,
//     this.metadata,
//     this.location,
//     this.etag,
//   });
//
//   String fieldname;
//   String originalname;
//   String encoding;
//   String mimetype;
//   int size;
//   String bucket;
//   String key;
//   String acl;
//   String contentType;
//   dynamic contentDisposition;
//   String storageClass;
//   dynamic serverSideEncryption;
//   dynamic metadata;
//   String location;
//   String etag;
//
//   factory PostPhoto.fromJson(Map<String, dynamic> json) => PostPhoto(
//     fieldname: json["fieldname"],
//     originalname: json["originalname"],
//     encoding: json["encoding"],
//     mimetype: json["mimetype"],
//     size: json["size"],
//     bucket: json["bucket"],
//     key: json["key"],
//     acl: json["acl"],
//     contentType: json["contentType"],
//     contentDisposition: json["contentDisposition"],
//     storageClass: json["storageClass"],
//     serverSideEncryption: json["serverSideEncryption"],
//     metadata: json["metadata"],
//     location: json["location"],
//     etag: json["etag"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "fieldname": fieldname,
//     "originalname": originalname,
//     "encoding": encoding,
//     "mimetype": mimetype,
//     "size": size,
//     "bucket": bucket,
//     "key": key,
//     "acl": acl,
//     "contentType": contentType,
//     "contentDisposition": contentDisposition,
//     "storageClass": storageClass,
//     "serverSideEncryption": serverSideEncryption,
//     "metadata": metadata,
//     "location": location,
//     "etag": etag,
//   };
// }
//
// class Repeat {
//   Repeat({
//     this.repeatingId,
//     this.post,
//     this.message,
//     this.like,
//     this.replyCount,
//     this.name,
//     this.userName,
//     this.profilePic,
//   });
//
//   String repeatingId;
//   dynamic post;
//   String message;
//   List<dynamic> like;
//   int replyCount;
//   String name;
//   String userName;
//   String profilePic;
//
//   factory Repeat.fromJson(Map<String, dynamic> json) => Repeat(
//     repeatingId: json["repeatingId"],
//     post: json["post"],
//     message: json["message"] == null ? null : json["message"],
//     like: json["like"] == null ? null : List<dynamic>.from(json["like"].map((x) => x)),
//     replyCount: json["replyCount"] == null ? null : json["replyCount"],
//     name: json["name"] == null ? null : json["name"],
//     userName: json["userName"] == null ? null : json["userName"],
//     profilePic: json["profilePic"] == null ? null : json["profilePic"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "repeatingId": repeatingId,
//     "post": post,
//     "message": message == null ? null : message,
//     "like": like == null ? null : List<dynamic>.from(like.map((x) => x)),
//     "replyCount": replyCount == null ? null : replyCount,
//     "name": name == null ? null : name,
//     "userName": userName == null ? null : userName,
//     "profilePic": profilePic == null ? null : profilePic,
//   };
// }
// To parse this JSON data, do
//
//     final feedPostsModel = feedPostsModelFromJson(jsonString);

import 'dart:convert';

FeedPostsModel feedPostsModelFromJson(String str) => FeedPostsModel.fromJson(json.decode(str));

String feedPostsModelToJson(FeedPostsModel data) => json.encode(data.toJson());

class FeedPostsModel {
  FeedPostsModel({
    this.message,
    this.data,
    this.notificationCount,
  });

  String message;
  List<FeedDetail> data;
  int notificationCount;

  factory FeedPostsModel.fromJson(Map<String, dynamic> json) => FeedPostsModel(
    message: json["message"],
    data: List<FeedDetail>.from(json["data"].map((x) => FeedDetail.fromJson(x))),
    notificationCount: json["NotificationCount"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "NotificationCount": notificationCount,
  };
}

class FeedDetail {
  FeedDetail({
    this.id,
    this.postPhoto,
    this.like,
    this.textFeed,
    this.privacyState,
    this.privacyAllowance,
    this.commentCount,
    this.caption,
    this.category,
    this.subCategory,
    this.profileId,
    this.repost,
    this.type,
    this.repeat,
    this.commentCheck,
    this.userName,
    this.name,
    this.profilePic,
    this.createdAt,
  });

  String id;
  List<PostPhoto> postPhoto;
  List<dynamic> like;
  bool textFeed;
  bool privacyState;
  List<dynamic> privacyAllowance;
  int commentCount;
  String caption;
  String category;
  String subCategory;
  String profileId;
  List<dynamic> repost;
  String type;
  Repeat repeat;
  List<dynamic> commentCheck;
  String userName;
  String name;
  String profilePic;
  DateTime createdAt;

  factory FeedDetail.fromJson(Map<String, dynamic> json) => FeedDetail(
    id: json["_id"],
    postPhoto: List<PostPhoto>.from(json["postPhoto"].map((x) => PostPhoto.fromJson(x))),
    like: List<dynamic>.from(json["like"].map((x) => x)),
    textFeed: json["textFeed"],
    privacyState: json["privacyState"],
    privacyAllowance: List<dynamic>.from(json["privacyAllowance"].map((x) => x)),
    commentCount: json["commentCount"],
    caption: json["caption"],
    category: json["category"] == null ? null : json["category"],
    subCategory: json["subCategory"] == null ? null : json["subCategory"],
    profileId: json["profileId"],
    repost: json["repost"] == null ? null : List<dynamic>.from(json["repost"].map((x) => x)),
    type: json["type"] == null ? null : json["type"],
    repeat: Repeat.fromJson(json["repeat"]),
    commentCheck: json["commentCheck"] == null ? null : List<dynamic>.from(json["commentCheck"].map((x) => x)),
    userName: json["userName"],
    name: json["name"],
    profilePic: json["profilePic"],
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "postPhoto": List<dynamic>.from(postPhoto.map((x) => x.toJson())),
    "like": List<dynamic>.from(like.map((x) => x)),
    "textFeed": textFeed,
    "privacyState": privacyState,
    "privacyAllowance": List<dynamic>.from(privacyAllowance.map((x) => x)),
    "commentCount": commentCount,
    "caption": caption,
    "category": category == null ? null : category,
    "subCategory": subCategory == null ? null : subCategory,
    "profileId": profileId,
    "repost": repost == null ? null : List<dynamic>.from(repost.map((x) => x)),
    "type": type == null ? null : type,
    "repeat": repeat.toJson(),
    "commentCheck": commentCheck == null ? null : List<dynamic>.from(commentCheck.map((x) => x)),
    "userName": userName,
    "name": name,
    "profilePic": profilePic,
    "createdAt": createdAt.toIso8601String(),
  };
}

class PostPhoto {
  PostPhoto({
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
    this.location,
    this.etag,
    this.thumbnailUrl,
  });

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
  String location;
  String etag;
  String thumbnailUrl;

  factory PostPhoto.fromJson(Map<String, dynamic> json) => PostPhoto(
    fieldname: json["fieldname"],
    originalname: json["originalname"],
    encoding: json["encoding"],
    mimetype: json["mimetype"],
    size: json["size"],
    bucket: json["bucket"],
    key: json["key"],
    acl: json["acl"],
    contentType: json["contentType"],
    contentDisposition: json["contentDisposition"],
    storageClass: json["storageClass"],
    serverSideEncryption: json["serverSideEncryption"],
    metadata: json["metadata"],
    location: json["location"],
    etag: json["etag"],
    thumbnailUrl: json["thumbnailUrl"] == null ? null : json["thumbnailUrl"],
  );

  Map<String, dynamic> toJson() => {
    "fieldname": fieldname,
    "originalname": originalname,
    "encoding": encoding,
    "mimetype": mimetype,
    "size": size,
    "bucket": bucket,
    "key": key,
    "acl": acl,
    "contentType": contentType,
    "contentDisposition": contentDisposition,
    "storageClass": storageClass,
    "serverSideEncryption": serverSideEncryption,
    "metadata": metadata,
    "location": location,
    "etag": etag,
    "thumbnailUrl": thumbnailUrl == null ? null : thumbnailUrl,
  };
}

class Repeat {
  Repeat({
    this.repeatingId,
    this.post,
    this.message,
    this.like,
    this.textFeed,
    this.replyCount,
    this.name,
    this.userName,
    this.profilePic,
    this.profileId,
    this.thumbnailUrl

  });

  String repeatingId;
  dynamic post;
  String message;
  List<dynamic> like;
  bool textFeed;
  int replyCount;
  String name;
  String userName;
  String profilePic;
  String profileId;
  String thumbnailUrl;

  factory Repeat.fromJson(Map<String, dynamic> json) => Repeat(
    repeatingId: json["repeatingId"],
    post: json["post"],
    message: json["message"] == null ? null : json["message"],
    like: json["like"] == null ? null : List<dynamic>.from(json["like"].map((x) => x)),
    textFeed: json["textFeed"],
    replyCount: json["replyCount"] == null ? null : json["replyCount"],
    name: json["name"] == null ? null : json["name"],
    userName: json["userName"] == null ? null : json["userName"],
    profilePic: json["profilePic"] == null ? null : json["profilePic"],
    profileId: json["profileId"] == null ? null : json["profileId"],
    thumbnailUrl: json["thumbnailUrl"] == null ? null : json["thumbnailUrl"],
  );

  Map<String, dynamic> toJson() => {
    "repeatingId": repeatingId,
    "post": post,
    "message": message == null ? null : message,
    "like": like == null ? null : List<dynamic>.from(like.map((x) => x)),
    "textFeed": textFeed,
    "replyCount": replyCount == null ? null : replyCount,
    "name": name == null ? null : name,
    "userName": userName == null ? null : userName,
    "profilePic": profilePic == null ? null : profilePic,
    "profileId": profileId == null ? null : profileId,
    "thumbnailUrl": thumbnailUrl == null ? null : thumbnailUrl,
  };
}