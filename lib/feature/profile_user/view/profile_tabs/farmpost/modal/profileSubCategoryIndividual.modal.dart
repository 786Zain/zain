// // To parse this JSON data, do
// //
// //     final profileSubCategoriesDetails = profileSubCategoriesDetailsFromJson(jsonString);
//
// import 'dart:convert';
//
// ProfileSubCategoriesDetails profileSubCategoriesDetailsFromJson(String str) => ProfileSubCategoriesDetails.fromJson(json.decode(str));
//
// String profileSubCategoriesDetailsToJson(ProfileSubCategoriesDetails data) => json.encode(data.toJson());
//
// class ProfileSubCategoriesDetails {
//   ProfileSubCategoriesDetails({
//     this.message,
//     this.data,
//   });
//
//   String message;
//   List<Datums> data;
//
//   factory ProfileSubCategoriesDetails.fromJson(Map<String, dynamic> json) => ProfileSubCategoriesDetails(
//     message: json["message"],
//     data: List<Datums>.from(json["data"].map((x) => Datums.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "message": message,
//     "data": List<dynamic>.from(data.map((x) => x.toJson())),
//   };
// }
//
// class Datums {
//   Datums({
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
//     this.repeat,
//     this.userName,
//     this.name,
//     this.profilePic,
//     this.createdAt,
//   });
//
//   String id;
//   List<PostPhoto> postPhoto;
//   List<String> like;
//   bool privacyState;
//   List<dynamic> privacyAllowance;
//   int commentCount;
//   String caption;
//   String category;
//   String subCategory;
//   String profileId;
//   List<String> repost;
//   Repeat repeat;
//   String userName;
//   String name;
//   String profilePic;
//   DateTime createdAt;
//
//   factory Datums.fromJson(Map<String, dynamic> json) => Datums(
//     id: json["_id"],
//     postPhoto: List<PostPhoto>.from(json["postPhoto"].map((x) => PostPhoto.fromJson(x))),
//     like: List<String>.from(json["like"].map((x) => x)),
//     privacyState: json["privacyState"],
//     privacyAllowance: List<dynamic>.from(json["privacyAllowance"].map((x) => x)),
//     commentCount: json["commentCount"],
//     caption: json["caption"],
//     category: json["category"],
//     subCategory: json["subCategory"],
//     profileId: json["profileId"],
//     repost: List<String>.from(json["repost"].map((x) => x)),
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
//     "category": category,
//     "subCategory": subCategory,
//     "profileId": profileId,
//     "repost": List<dynamic>.from(repost.map((x) => x)),
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
//     this.post,
//     this.profilePic,
//   });
//
//   dynamic post;
//   dynamic profilePic;
//
//   factory Repeat.fromJson(Map<String, dynamic> json) => Repeat(
//     post: json["post"],
//     profilePic: json["profilePic"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "post": post,
//     "profilePic": profilePic,
//   };
// }

// To parse this JSON data, do
//
//     final profileSubCategoriesDetails = profileSubCategoriesDetailsFromJson(jsonString);

// import 'dart:convert';
//
// ProfileSubCategoriesDetails profileSubCategoriesDetailsFromJson(String str) => ProfileSubCategoriesDetails.fromJson(json.decode(str));
//
// String profileSubCategoriesDetailsToJson(ProfileSubCategoriesDetails data) => json.encode(data.toJson());
//
// class ProfileSubCategoriesDetails {
//   ProfileSubCategoriesDetails({
//     this.message,
//     this.data,
//   });
//
//   String message;
//   List<Datums> data;
//
//   factory ProfileSubCategoriesDetails.fromJson(Map<String, dynamic> json) => ProfileSubCategoriesDetails(
//     message: json["message"],
//     data: List<Datums>.from(json["data"].map((x) => Datums.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "message": message,
//     "data": List<dynamic>.from(data.map((x) => x.toJson())),
//   };
// }
//
// class Datums {
//   Datums({
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
//     this.repeat,
//     this.userName,
//     this.name,
//     this.profilePic,
//     this.createdAt,
//   });
//
//   String id;
//   List<PostPhoto> postPhoto;
//   List<String> like;
//   bool privacyState;
//   List<dynamic> privacyAllowance;
//   int commentCount;
//   String caption;
//   String category;
//   String subCategory;
//   String profileId;
//   List<String> repost;
//   Repeat repeat;
//   String userName;
//   String name;
//   String profilePic;
//   DateTime createdAt;
//
//   factory Datums.fromJson(Map<String, dynamic> json) => Datums(
//     id: json["_id"],
//     postPhoto: List<PostPhoto>.from(json["postPhoto"].map((x) => PostPhoto.fromJson(x))),
//     like: List<String>.from(json["like"].map((x) => x)),
//     privacyState: json["privacyState"],
//     privacyAllowance: List<dynamic>.from(json["privacyAllowance"].map((x) => x)),
//     commentCount: json["commentCount"],
//     caption: json["caption"],
//     category: json["category"],
//     subCategory: json["subCategory"],
//     profileId: json["profileId"],
//     repost: List<String>.from(json["repost"].map((x) => x)),
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
//     "category": category,
//     "subCategory": subCategory,
//     "profileId": profileId,
//     "repost": List<dynamic>.from(repost.map((x) => x)),
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

// To parse this JSON data, do
//
//     final profileSubCategoriesDetails = profileSubCategoriesDetailsFromJson(jsonString);

//Most Recent
// import 'dart:convert';
//
// ProfileSubCategoriesDetails profileSubCategoriesDetailsFromJson(String str) => ProfileSubCategoriesDetails.fromJson(json.decode(str));
//
// String profileSubCategoriesDetailsToJson(ProfileSubCategoriesDetails data) => json.encode(data.toJson());
//
// class ProfileSubCategoriesDetails {
//   ProfileSubCategoriesDetails({
//     this.message,
//     this.data,
//   });
//
//   String message;
//   List<Datums> data;
//
//   factory ProfileSubCategoriesDetails.fromJson(Map<String, dynamic> json) => ProfileSubCategoriesDetails(
//     message: json["message"],
//     data: List<Datums>.from(json["data"].map((x) => Datums.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "message": message,
//     "data": List<dynamic>.from(data.map((x) => x.toJson())),
//   };
// }
//
// class Datums {
//   Datums({
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
//     this.repeat,
//     this.userName,
//     this.name,
//     this.profilePic,
//     this.createdAt,
//   });
//
//   String id;
//   List<PostPhoto> postPhoto;
//   List<String> like;
//   bool privacyState;
//   List<dynamic> privacyAllowance;
//   int commentCount;
//   String caption;
//   String category;
//   String subCategory;
//   String profileId;
//   List<String> repost;
//   Repeat repeat;
//   String userName;
//   String name;
//   String profilePic;
//   DateTime createdAt;
//
//   factory Datums.fromJson(Map<String, dynamic> json) => Datums(
//     id: json["_id"],
//     postPhoto: json["postPhoto"] == null ? null : List<PostPhoto>.from(json["postPhoto"].map((x) => PostPhoto.fromJson(x))),
//     like: List<String>.from(json["like"].map((x) => x)),
//     privacyState: json["privacyState"] == null ? null : json["privacyState"],
//     privacyAllowance: json["privacyAllowance"] == null ? null : List<dynamic>.from(json["privacyAllowance"].map((x) => x)),
//     commentCount: json["commentCount"],
//     caption: json["caption"] == null ? null : json["caption"],
//     category: json["category"] == null ? null : json["category"],
//     subCategory: json["subCategory"] == null ? null : json["subCategory"],
//     profileId: json["profileId"] == null ? null : json["profileId"],
//     repost: List<String>.from(json["repost"].map((x) => x)),
//     repeat: Repeat.fromJson(json["repeat"]),
//     userName: json["userName"] == null ? null : json["userName"],
//     name: json["name"] == null ? null : json["name"],
//     profilePic: json["profilePic"] == null ? null : json["profilePic"],
//     createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "postPhoto": postPhoto == null ? null : List<dynamic>.from(postPhoto.map((x) => x.toJson())),
//     "like": List<dynamic>.from(like.map((x) => x)),
//     "privacyState": privacyState == null ? null : privacyState,
//     "privacyAllowance": privacyAllowance == null ? null : List<dynamic>.from(privacyAllowance.map((x) => x)),
//     "commentCount": commentCount,
//     "caption": caption == null ? null : caption,
//     "category": category == null ? null : category,
//     "subCategory": subCategory == null ? null : subCategory,
//     "profileId": profileId == null ? null : profileId,
//     "repost": List<dynamic>.from(repost.map((x) => x)),
//     "repeat": repeat.toJson(),
//     "userName": userName == null ? null : userName,
//     "name": name == null ? null : name,
//     "profilePic": profilePic == null ? null : profilePic,
//     "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
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
//     this.post,
//     this.message,
//     this.like,
//     this.replyCount,
//     this.name,
//     this.userName,
//     this.profilePic,
//   });
//
//   String post;
//   String message;
//   List<dynamic> like;
//   int replyCount;
//   String name;
//   String userName;
//   String profilePic;
//
//   factory Repeat.fromJson(Map<String, dynamic> json) => Repeat(
//     post: json["post"] == null ? null : json["post"],
//     message: json["message"] == null ? null : json["message"],
//     like: json["like"] == null ? null : List<dynamic>.from(json["like"].map((x) => x)),
//     replyCount: json["replyCount"] == null ? null : json["replyCount"],
//     name: json["name"] == null ? null : json["name"],
//     userName: json["userName"] == null ? null : json["userName"],
//     profilePic: json["profilePic"] == null ? null : json["profilePic"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "post": post == null ? null : post,
//     "message": message == null ? null : message,
//     "like": like == null ? null : List<dynamic>.from(like.map((x) => x)),
//     "replyCount": replyCount == null ? null : replyCount,
//     "name": name == null ? null : name,
//     "userName": userName == null ? null : userName,
//     "profilePic": profilePic == null ? null : profilePic,
//   };
// }
//


import 'dart:convert';

ProfileSubCategoriesDetails profileSubCategoriesDetailsFromJson(String str) => ProfileSubCategoriesDetails.fromJson(json.decode(str));

String profileSubCategoriesDetailsToJson(ProfileSubCategoriesDetails data) => json.encode(data.toJson());

class ProfileSubCategoriesDetails {
  ProfileSubCategoriesDetails({
    this.message,
    this.data,
  });

  String message;
  List<Datums> data;

  factory ProfileSubCategoriesDetails.fromJson(Map<String, dynamic> json) => ProfileSubCategoriesDetails(
    message: json["message"],
    data: List<Datums>.from(json["data"].map((x) => Datums.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datums {
  Datums({
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
    this.type,
    this.repeat,
    this.commentCheck,
    this.textFeed,
    this.userName,
    this.name,
    this.profilePic,
    this.createdAt,
  });

  String id;
  List<PostPhoto> postPhoto;
  List<String> like;
  bool privacyState;
  List<dynamic> privacyAllowance;
  int commentCount;
  String caption;
  String category;
  String subCategory;
  String profileId;
  List<String> repost;
  String type;
  Repeat repeat;
  List<String> commentCheck;
  bool textFeed;
  String userName;
  String name;
  String profilePic;
  DateTime createdAt;

  factory Datums.fromJson(Map<String, dynamic> json) => Datums(
    id: json["_id"],
    postPhoto: json["postPhoto"] == null ? null : List<PostPhoto>.from(json["postPhoto"].map((x) => PostPhoto.fromJson(x))),
    like: List<String>.from(json["like"].map((x) => x)),
    privacyState: json["privacyState"] == null ? null : json["privacyState"],
    privacyAllowance: json["privacyAllowance"] == null ? null : List<dynamic>.from(json["privacyAllowance"].map((x) => x)),
    commentCount: json["commentCount"],
    caption: json["caption"] == null ? null : json["caption"],
    category: json["category"] == null ? null : json["category"],
    subCategory: json["subCategory"] == null ? null : json["subCategory"],
    profileId: json["profileId"] == null ? null : json["profileId"],
    repost: List<String>.from(json["repost"].map((x) => x)),
    type: json["type"] == null ? null : json["type"],
    repeat: Repeat.fromJson(json["repeat"]),
    commentCheck: List<String>.from(json["commentCheck"].map((x) => x)),
    textFeed: json["textFeed"],
    userName: json["userName"] == null ? null : json["userName"],
    name: json["name"] == null ? null : json["name"],
    profilePic: json["profilePic"] == null ? null : json["profilePic"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "postPhoto": postPhoto == null ? null : List<dynamic>.from(postPhoto.map((x) => x.toJson())),
    "like": List<dynamic>.from(like.map((x) => x)),
    "privacyState": privacyState == null ? null : privacyState,
    "privacyAllowance": privacyAllowance == null ? null : List<dynamic>.from(privacyAllowance.map((x) => x)),
    "commentCount": commentCount,
    "caption": caption == null ? null : caption,
    "category": category == null ? null : category,
    "subCategory": subCategory == null ? null : subCategory,
    "profileId": profileId == null ? null : profileId,
    "repost": List<dynamic>.from(repost.map((x) => x)),
    "type": type == null ? null : type,
    "repeat": repeat.toJson(),
    "commentCheck": List<dynamic>.from(commentCheck.map((x) => x)),
    "textFeed": textFeed,
    "userName": userName == null ? null : userName,
    "name": name == null ? null : name,
    "profilePic": profilePic == null ? null : profilePic,
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
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
    location: json["location"],
    etag: json["etag"] == null ? null : json["etag"],
    thumbnailUrl: json["thumbnailUrl"],
  );

  Map<String, dynamic> toJson() => {
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
    "location": location,
    "etag": etag == null ? null : etag,
    "thumbnailUrl": thumbnailUrl,
  };
}

class Repeat {
  Repeat({
    this.post,
    this.thumbnailUrl,
    this.profilePic,
    this.repeatingId,
    this.message,
    this.like,
    this.profileId,
    this.textFeed,
    this.name,
    this.userName,
    this.replyCount,
  });

  String post;
  dynamic thumbnailUrl;
  String profilePic;
  String repeatingId;
  String message;
  List<dynamic> like;
  String profileId;
  bool textFeed;
  String name;
  String userName;
  int replyCount;

  factory Repeat.fromJson(Map<String, dynamic> json) => Repeat(
    post: json["post"] == null ? null : json["post"],
    thumbnailUrl: json["thumbnailUrl"],
    profilePic: json["profilePic"] == null ? null : json["profilePic"],
    repeatingId: json["repeatingId"] == null ? null : json["repeatingId"],
    message: json["message"] == null ? null : json["message"],
    like: json["like"] == null ? null : List<dynamic>.from(json["like"].map((x) => x)),
    profileId: json["profileId"] == null ? null : json["profileId"],
    textFeed: json["textFeed"] == null ? null : json["textFeed"],
    name: json["name"] == null ? null : json["name"],
    userName: json["userName"] == null ? null : json["userName"],
    replyCount: json["replyCount"] == null ? null : json["replyCount"],
  );

  Map<String, dynamic> toJson() => {
    "post": post == null ? null : post,
    "thumbnailUrl": thumbnailUrl,
    "profilePic": profilePic == null ? null : profilePic,
    "repeatingId": repeatingId == null ? null : repeatingId,
    "message": message == null ? null : message,
    "like": like == null ? null : List<dynamic>.from(like.map((x) => x)),
    "profileId": profileId == null ? null : profileId,
    "textFeed": textFeed == null ? null : textFeed,
    "name": name == null ? null : name,
    "userName": userName == null ? null : userName,
    "replyCount": replyCount == null ? null : replyCount,
  };
}
