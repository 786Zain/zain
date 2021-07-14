// To parse this JSON data, do
//
//     final profileUserAll = profileUserAllFromJson(jsonString);

// import 'dart:convert';
//
// ProfileUserAll profileUserAllFromJson(String str) => ProfileUserAll.fromJson(json.decode(str));
//
// String profileUserAllToJson(ProfileUserAll data) => json.encode(data.toJson());
//
// class ProfileUserAll {
//   ProfileUserAll({
//     this.message,
//     this.data,
//   });
//
//   String message;
//   List<Datum> data;
//
//   factory ProfileUserAll.fromJson(Map<String, dynamic> json) => ProfileUserAll(
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
//   List<String> like;
//   bool privacyState;
//   List<dynamic> privacyAllowance;
//   int commentCount;
//   String caption;
//   String category;
//   String subCategory;
//   String profileId;
//   List<String> repost;
//   String type;
//   Repeat repeat;
//   String userName;
//   String name;
//   String profilePic;
//   DateTime createdAt;
//
//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//     id: json["_id"],
//     postPhoto: List<PostPhoto>.from(json["postPhoto"].map((x) => PostPhoto.fromJson(x))),
//     like: List<String>.from(json["like"].map((x) => x)),
//     privacyState: json["privacyState"],
//     privacyAllowance: List<dynamic>.from(json["privacyAllowance"].map((x) => x)),
//     commentCount: json["commentCount"],
//     caption: json["caption"],
//     category: json["category"] == null ? null : json["category"],
//     subCategory: json["subCategory"] == null ? null : json["subCategory"],
//     profileId: json["profileId"],
//     repost: List<String>.from(json["repost"].map((x) => x)),
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
//     "repost": List<dynamic>.from(repost.map((x) => x)),
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

// To parse this JSON data, do
//
//     final profileUserAll = profileUserAllFromJson(jsonString);



//Previous
// import 'dart:convert';
//
// ProfileUserAll profileUserAllFromJson(String str) => ProfileUserAll.fromJson(json.decode(str));
//
// String profileUserAllToJson(ProfileUserAll data) => json.encode(data.toJson());
//
// class ProfileUserAll {
//   ProfileUserAll({
//     this.message,
//     this.data,
//   });
//
//   String message;
//   List<Datum> data;
//
//   factory ProfileUserAll.fromJson(Map<String, dynamic> json) => ProfileUserAll(
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
//     this.postPhoto,
//     this.like,
//     this.textFeed,
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
//
//   });
//
//   String id;
//   List<PostPhoto> postPhoto;
//   List<String> like;
//   bool textFeed;
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
//
//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//     id: json["_id"],
//     postPhoto: json["postPhoto"] == null ? null : List<PostPhoto>.from(json["postPhoto"].map((x) => PostPhoto.fromJson(x))),
//     like: List<String>.from(json["like"].map((x) => x)),
//     textFeed: json["textFeed"],
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
//     createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"],
//     ),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "postPhoto": postPhoto == null ? null : List<dynamic>.from(postPhoto.map((x) => x.toJson())),
//     "like": List<dynamic>.from(like.map((x) => x)),
//     "textFeed": textFeed,
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
//
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
//     this.thumbnailUrl,
//
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
//   String thumbnailUrl;
//
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
//     thumbnailUrl: json["thumbnailUrl"] == null ? null : json["thumbnailUrl"],
//
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
//     "thumbnailUrl": thumbnailUrl
//
//   };
// }
//
// class Repeat {
//   Repeat({
//     this.repeatingId,
//     this.post,
//     this.message,
//     this.like,
//     this.textFeed,
//     this.name,
//     this.userName,
//     this.profilePic,
//     this.thumbnailUrl,
//
//   });
//
//   String repeatingId;
//   String post;
//   String message;
//   bool textFeed;
//   List<String> like;
//   String name;
//   String userName;
//   String profilePic;
//   dynamic thumbnailUrl;
//
//
//
//   factory Repeat.fromJson(Map<String, dynamic> json) => Repeat(
//     repeatingId: json["repeatingId"] == null ? null : json["repeatingId"],
//     post: json["post"] == null ? null : json["post"],
//     message: json["message"] == null ? null : json["message"],
//     like: json["like"] == null ? null : List<String>.from(json["like"].map((x) => x)),
//     textFeed: json["textFeed"],
//     name: json["name"] == null ? null : json["name"],
//     userName: json["userName"] == null ? null : json["userName"],
//     profilePic: json["profilePic"] == null ? null : json["profilePic"],
//     thumbnailUrl: json["thumbnailUrl"],
//
//   );
//
//   Map<String, dynamic> toJson() => {
//     "repeatingId": repeatingId == null ? null : repeatingId,
//     "post": post == null ? null : post,
//     "message": message == null ? null : message,
//     "like": like == null ? null : List<dynamic>.from(like.map((x) => x)),
//     "textFeed":textFeed,
//     "name": name == null ? null : name,
//     "userName": userName == null ? null : userName,
//     "profilePic": profilePic == null ? null : profilePic,
//     "thumbnailUrl": thumbnailUrl,
//   };
// }


import 'dart:convert';

ProfileUserAll profileUserAllFromJson(String str) => ProfileUserAll.fromJson(json.decode(str));

String profileUserAllToJson(ProfileUserAll data) => json.encode(data.toJson());

class ProfileUserAll {
  ProfileUserAll({
    this.message,
    this.data,
  });

  String message;
  List<Datum> data;

  factory ProfileUserAll.fromJson(Map<String, dynamic> json) => ProfileUserAll(
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
    this.repeat,
    this.userName,
    this.name,
    this.profilePic,
    this.createdAt,
    this.type,
    this.commentCheck,

  });

  String id;
  List<PostPhoto> postPhoto;
  List<String> like;
  bool textFeed;
  bool privacyState;
  List<dynamic> privacyAllowance;
  int commentCount;
  String caption;
  String category;
  String subCategory;
  String profileId;
  List<String> repost;
  Repeat repeat;
  String userName;
  String name;
  String profilePic;
  DateTime createdAt;
  String type;
  List<String> commentCheck;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    postPhoto: json["postPhoto"] == null ? null : List<PostPhoto>.from(json["postPhoto"].map((x) => PostPhoto.fromJson(x))),
    like: List<String>.from(json["like"].map((x) => x)),
    textFeed: json["textFeed"],
    privacyState: json["privacyState"] == null ? null : json["privacyState"],
    privacyAllowance: json["privacyAllowance"] == null ? null : List<dynamic>.from(json["privacyAllowance"].map((x) => x)),
    commentCount: json["commentCount"],
    caption: json["caption"] == null ? null : json["caption"],
    category: json["category"] == null ? null : json["category"],
    subCategory: json["subCategory"] == null ? null : json["subCategory"],
    profileId: json["profileId"] == null ? null : json["profileId"],
    repost: List<String>.from(json["repost"].map((x) => x)),
    repeat: Repeat.fromJson(json["repeat"]),
    userName: json["userName"] == null ? null : json["userName"],
    name: json["name"] == null ? null : json["name"],
    profilePic: json["profilePic"] == null ? null : json["profilePic"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"],),
    type: json["type"] == null ? null : json["type"],
    commentCheck: List<String>.from(json["commentCheck"].map((x) => x)),

  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "postPhoto": postPhoto == null ? null : List<dynamic>.from(postPhoto.map((x) => x.toJson())),
    "like": List<dynamic>.from(like.map((x) => x)),
    "textFeed": textFeed,
    "privacyState": privacyState == null ? null : privacyState,
    "privacyAllowance": privacyAllowance == null ? null : List<dynamic>.from(privacyAllowance.map((x) => x)),
    "commentCount": commentCount,
    "caption": caption == null ? null : caption,
    "category": category == null ? null : category,
    "subCategory": subCategory == null ? null : subCategory,
    "profileId": profileId == null ? null : profileId,
    "repost": List<dynamic>.from(repost.map((x) => x)),
    "repeat": repeat.toJson(),
    "userName": userName == null ? null : userName,
    "name": name == null ? null : name,
    "profilePic": profilePic == null ? null : profilePic,
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    "type": type == null ? null : type,
    "commentCheck": List<dynamic>.from(commentCheck.map((x) => x)),

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


  factory PostPhoto.fromJson(Map<String, dynamic> json) =>
      PostPhoto(
        fieldname: json["fieldname"] == null ? null : json["fieldname"],
        originalname: json["originalname"] == null
            ? null
            : json["originalname"],
        encoding: json["encoding"] == null ? null : json["encoding"],
        mimetype: json["mimetype"] == null ? null : json["mimetype"],
        size: json["size"] == null ? null : json["size"],
        bucket: json["bucket"] == null ? null : json["bucket"],
        key: json["key"] == null ? null : json["key"],
        acl: json["acl"] == null ? null : json["acl"],
        contentType: json["contentType"] == null ? null : json["contentType"],
        contentDisposition: json["contentDisposition"],
        storageClass: json["storageClass"] == null
            ? null
            : json["storageClass"],
        serverSideEncryption: json["serverSideEncryption"],
        metadata: json["metadata"],
        location: json["location"],
        etag: json["etag"] == null ? null : json["etag"],
        thumbnailUrl: json["thumbnailUrl"] == null
            ? null
            : json["thumbnailUrl"],
      );

  Map<String, dynamic> toJson() =>
      {
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
      this.name,
      this.userName,
      this.profilePic,
      this.thumbnailUrl,
      this.profileId,
    });

    String repeatingId;
    String post;
    String message;
    bool textFeed;
    List<String> like;
    String name;
    String userName;
    String profilePic;
    dynamic thumbnailUrl;
    String profileId;


    factory Repeat.fromJson(Map<String, dynamic> json) =>
        Repeat(
          repeatingId: json["repeatingId"] == null ? null : json["repeatingId"],
          post: json["post"] == null ? null : json["post"],
          message: json["message"] == null ? null : json["message"],
          like: json["like"] == null ? null : List<String>.from(
              json["like"].map((x) => x)),
          textFeed: json["textFeed"],
          name: json["name"] == null ? null : json["name"],
          userName: json["userName"] == null ? null : json["userName"],
          profilePic: json["profilePic"] == null ? null : json["profilePic"],
          thumbnailUrl: json["thumbnailUrl"],
          profileId: json["profileId"] == null ? null : json["profileId"],
        );

    Map<String, dynamic> toJson() =>
        {
          "repeatingId": repeatingId == null ? null : repeatingId,
          "post": post == null ? null : post,
          "message": message == null ? null : message,
          "like": like == null ? null : List<dynamic>.from(like.map((x) => x)),
          "textFeed": textFeed,
          "name": name == null ? null : name,
          "userName": userName == null ? null : userName,
          "profilePic": profilePic == null ? null : profilePic,
          "thumbnailUrl": thumbnailUrl,
          "profileId": profileId == null ? null : profileId,
        };
  }
