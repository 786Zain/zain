import 'dart:convert';

PostDetailsBasedOnId postDetailsBasedOnIdFromJson(String str) =>
    PostDetailsBasedOnId.fromJson(json.decode(str));

String postDetailsBasedOnIdToJson(PostDetailsBasedOnId data) =>
    json.encode(data.toJson());

class PostDetailsBasedOnId {
  PostDetailsBasedOnId({
    this.message,
    this.data,
  });

  String message;
  Data data;

  factory PostDetailsBasedOnId.fromJson(Map<String, dynamic> json) =>
      PostDetailsBasedOnId(
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
    this.post,
    this.comments,
  });

  List<Post> post;
  List<Comment> comments;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        post: List<Post>.from(json["post"].map((x) => Post.fromJson(x))),
        comments: List<Comment>.from(
            json["comments"].map((x) => Comment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "post": List<dynamic>.from(post.map((x) => x.toJson())),
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
    this.commentCheck,
    this.userName,
    this.userFullname,
    this.userPic,
    this.media,
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
  List<dynamic> commentCheck;
  String userName;
  String userFullname;
  String userPic;
  String media;

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
        commentCheck: json["commentCheck"] == null
            ? null
            : List<dynamic>.from(json["commentCheck"].map((x) => x)),
        userName: json["userName"],
        userFullname: json["userFullname"],
        userPic: json["userPic"],
        media: json["Media"],
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
        "commentCheck": commentCheck == null
            ? null
            : List<dynamic>.from(commentCheck.map((x) => x)),
        "userName": userName,
        "userFullname": userFullname,
        "userPic": userPic,
        "Media": media,
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
    this.repeat,
    this.commentCheck,
    this.userName,
    this.name,
    this.profilePic,
    this.createdAt,
    this.textFeed,
  });

  String id;
  List<PostPhoto> postPhoto;
  List<dynamic> like;
  bool privacyState;
  List<dynamic> privacyAllowance;
  int commentCount;
  String caption;
  String category;
  String subCategory;
  String profileId;
  List<dynamic> repost;
  Repeat repeat;
  List<dynamic> commentCheck;
  String userName;
  String name;
  String profilePic;
  DateTime createdAt;
  bool textFeed;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["_id"],
        postPhoto: List<PostPhoto>.from(
            json["postPhoto"].map((x) => PostPhoto.fromJson(x))),
        like: List<dynamic>.from(json["like"].map((x) => x)),
        privacyState: json["privacyState"],
        privacyAllowance:
            List<dynamic>.from(json["privacyAllowance"].map((x) => x)),
        commentCount: json["commentCount"],
        caption: json["caption"],
        category: json["category"],
        subCategory: json["subCategory"],
        profileId: json["profileId"],
        repost: List<dynamic>.from(json["repost"].map((x) => x)),
        repeat: json["repeat"] == null ? null : Repeat.fromJson(json["repeat"]),
        commentCheck: json["commentCheck"] == null
            ? null
            : List<dynamic>.from(json["commentCheck"].map((x) => x)),
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
        "repeat": repeat.toJson(),
        "commentCheck": commentCheck == null
            ? null
            : List<dynamic>.from(commentCheck.map((x) => x)),
        "userName": userName,
        "name": name,
        "profilePic": profilePic,
        "createdAt": createdAt.toIso8601String(),
        "textFeed": textFeed,
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
        thumbnailUrl:
            json["thumbnailUrl"] == null ? null : json["thumbnailUrl"],
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
  Repeat(
      {this.post,
      this.profilePic,
      this.repeatingId,
      this.thumbnailUrl,
      this.message,
      this.textFeed,
      this.profileId,
      this.like,
      this.name,
      this.userName});

  dynamic post;
  dynamic profilePic;
  String repeatingId;
  String thumbnailUrl;
  String message;
  bool textFeed;
  String profileId;
  List<dynamic> like;
  String name;
  String userName;

  factory Repeat.fromJson(Map<String, dynamic> json) => Repeat(
      post: json["post"],
      profilePic: json["profilePic"],
      repeatingId: json["repeatingId"],
      thumbnailUrl: json["thumbnailUrl"],
      message: json["message"],
      textFeed: json["textFeed"],
      profileId: json["profileId"],
      like: json["like"] == null
          ? null
          : List<dynamic>.from(json["like"].map((x) => x)),
      name: json["name"],
      userName: json["userName"]);

  Map<String, dynamic> toJson() => {
        "post": post,
        "profilePic": profilePic,
        "repeatingId": repeatingId,
        "thumbnailUrl": thumbnailUrl,
        "message": message,
        "textFeed": textFeed,
        "profileId": profileId,
        "like": like == null ? null : List<dynamic>.from(like.map((x) => x)),
        "name": name,
        "userName": userName,
      };
}
