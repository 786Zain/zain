import 'dart:convert';

GetUserCategoryLikes getUserLikesFromJson(String str) => GetUserCategoryLikes.fromJson(json.decode(str));

String getUserCategoryLikesToJson(GetUserCategoryLikes data) => json.encode(data.toJson());

class GetUserCategoryLikes {
  GetUserCategoryLikes({
        this.message,
        this.data,
    });

    String message;
    List<LikeSubTab> data;

    factory GetUserCategoryLikes.fromJson(Map<String, dynamic> json) => GetUserCategoryLikes(
        message: json["message"],
        data: List<LikeSubTab>.from(json["data"].map((x) => LikeSubTab.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class LikeSubTab {
    LikeSubTab({
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
        this.userName,
        this.name,
        this.profilePic,
        this.createdAt,
        this.parentId,
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
    String type;
    Repeat repeat;
    String userName;
    String name;
    String profilePic;
    DateTime createdAt;
    String parentId;
    List<String> commentCheck;

    factory LikeSubTab.fromJson(Map<String, dynamic> json) => LikeSubTab(
        id: json["_id"],
        postPhoto: List<PostPhoto>.from(json["postPhoto"].map((x) => PostPhoto.fromJson(x))),
        like: List<String>.from(json["like"].map((x) => x)),
        textFeed: json["textFeed"] == null ? null : json["textFeed"],
        privacyState: json["privacyState"],
        privacyAllowance: List<dynamic>.from(json["privacyAllowance"].map((x) => x)),
        commentCount: json["commentCount"],
        caption: json["caption"],
        category: json["category"] == null ? null : json["category"],
        subCategory: json["subCategory"] == null ? null : json["subCategory"],
        profileId: json["profileId"],
        repost: List<String>.from(json["repost"].map((x) => x)),
        type: json["type"] == null ? null : json["type"],
        repeat: Repeat.fromJson(json["repeat"]),
        userName: json["userName"],
        name: json["name"],
        profilePic: json["profilePic"],
        createdAt: DateTime.parse(json["createdAt"]),
        parentId: json["parentId"] == null ? null : json["parentId"],
        commentCheck: List<String>.from(json["commentCheck"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "postPhoto": List<dynamic>.from(postPhoto.map((x) => x.toJson())),
        "like": List<dynamic>.from(like.map((x) => x)),
        "textFeed": textFeed == null ? null : textFeed,
        "privacyState": privacyState,
        "privacyAllowance": List<dynamic>.from(privacyAllowance.map((x) => x)),
        "commentCount": commentCount,
        "caption": caption,
        "category": category == null ? null : category,
        "subCategory": subCategory == null ? null : subCategory,
        "profileId": profileId,
        "repost": List<dynamic>.from(repost.map((x) => x)),
        "type": type == null ? null : type,
        "repeat": repeat.toJson(),
        "userName": userName,
        "name": name,
        "profilePic": profilePic,
        "createdAt": createdAt.toIso8601String(),
        "parentId": parentId == null ? null : parentId,
        "commentCheck": List<dynamic>.from(commentCheck.map((x) => x)),
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

class Repeat {
    Repeat({
        this.repeatingId,
        this.message,
        this.like,
        this.commentCount,
        this.name,
        this.userName,
        this.profilePic,
        this.post,
        this.thumbnailUrl,
        this.textFeed
    });

    String repeatingId;
    String message;
    dynamic like;
    dynamic commentCount;
    String name;
    String userName;
    String profilePic;
    String post;
    dynamic thumbnailUrl;
    bool textFeed;

    factory Repeat.fromJson(Map<String, dynamic> json) => Repeat(
        repeatingId: json["repeatingId"] == null ? null : json["repeatingId"],
        message: json["message"] == null ? null : json["message"],
        like: json["like"],
        commentCount: json["commentCount"] == null ? null : json["commentCount"],
        name: json["name"] == null ? null : json["name"],
        userName: json["userName"] == null ? null : json["userName"],
        profilePic: json["profilePic"] == null ? null : json["profilePic"],
        post: json["post"] == null ? null : json["post"],
        thumbnailUrl: json["thumbnailUrl"],
        textFeed:json["textFeed"]
    );

    Map<String, dynamic> toJson() => {
        "repeatingId": repeatingId == null ? null : repeatingId,
        "message": message == null ? null : message,
        "like": like,
        "commentCount": commentCount == null ? null : commentCount,
        "name": name == null ? null : name,
        "userName": userName == null ? null : userName,
        "profilePic": profilePic == null ? null : profilePic,
        "post": post == null ? null : post,
        "thumbnailUrl": thumbnailUrl,
        "textFeed":textFeed
    };
}
