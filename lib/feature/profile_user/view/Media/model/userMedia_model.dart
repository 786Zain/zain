// To parse this JSON data, do
//
//     final getUserMedia = getUserMediaFromJson(jsonString);

// import 'dart:convert';
//
// GetUserMedia getUserMediaFromJson(String str) => GetUserMedia.fromJson(json.decode(str));
//
// String getUserMediaToJson(GetUserMedia data) => json.encode(data.toJson());
//
// class GetUserMedia {
//     GetUserMedia({
//         this.message,
//         this.data,
//     });
//
//     String message;
//     List<Datum> data;
//
//     factory GetUserMedia.fromJson(Map<String, dynamic> json) => GetUserMedia(
//         message: json["message"],
//         data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//     );
//
//     Map<String, dynamic> toJson() => {
//         "message": message,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//     };
// }
//
// class Datum {
//     Datum({
//         this.id,
//         this.postPhoto,
//         this.like,
//         this.textFeed,
//         this.privacyState,
//         this.privacyAllowance,
//         this.commentCount,
//         this.caption,
//         this.category,
//         this.subCategory,
//         this.profileId,
//         this.repost,
//         this.userName,
//         this.name,
//         this.profilePic,
//         this.createdAt,
//     });
//
//     String id;
//     List<PostPhoto> postPhoto;
//     List<String> like;
//     bool textFeed;
//     bool privacyState;
//     List<dynamic> privacyAllowance;
//     int commentCount;
//     String caption;
//     String category;
//     String subCategory;
//     String profileId;
//     List<String> repost;
//     String userName;
//     String name;
//     String profilePic;
//     DateTime createdAt;
//
//     factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         id: json["_id"],
//         postPhoto: List<PostPhoto>.from(json["postPhoto"].map((x) => PostPhoto.fromJson(x))),
//         like: List<String>.from(json["like"].map((x) => x)),
//         textFeed: json["textFeed"],
//         privacyState: json["privacyState"],
//         privacyAllowance: List<dynamic>.from(json["privacyAllowance"].map((x) => x)),
//         commentCount: json["commentCount"],
//         caption: json["caption"],
//         category: json["category"],
//         subCategory: json["subCategory"],
//         profileId: json["profileId"],
//         repost: List<String>.from(json["repost"].map((x) => x)),
//         userName: json["userName"],
//         name: json["name"],
//         profilePic: json["profilePic"],
//         createdAt: DateTime.parse(json["createdAt"],
//         ),
//     );
//
//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "postPhoto": List<dynamic>.from(postPhoto.map((x) => x.toJson())),
//         "like": List<dynamic>.from(like.map((x) => x)),
//         "textFeed": textFeed,
//         "privacyState": privacyState,
//         "privacyAllowance": List<dynamic>.from(privacyAllowance.map((x) => x)),
//         "commentCount": commentCount,
//         "caption": caption,
//         "category": category,
//         "subCategory": subCategory,
//         "profileId": profileId,
//         "repost": List<dynamic>.from(repost.map((x) => x)),
//         "userName": userName,
//         "name": name,
//         "profilePic": profilePic,
//         "createdAt": createdAt.toIso8601String(),
//
//
//     };
// }
//
// class PostPhoto {
//     PostPhoto({
//         this.fieldname,
//         this.originalname,
//         this.encoding,
//         this.mimetype,
//         this.size,
//         this.bucket,
//         this.key,
//         this.acl,
//         this.contentType,
//         this.contentDisposition,
//         this.storageClass,
//         this.serverSideEncryption,
//         this.metadata,
//         this.location,
//         this.etag,
//         this.thumbnailUrl,
//     });
//
//     String fieldname;
//     String originalname;
//     String encoding;
//     String mimetype;
//     int size;
//     String bucket;
//     String key;
//     String acl;
//     String contentType;
//     dynamic contentDisposition;
//     String storageClass;
//     dynamic serverSideEncryption;
//     dynamic metadata;
//     String location;
//     String etag;
//     String thumbnailUrl;
//
//     factory PostPhoto.fromJson(Map<String, dynamic> json) => PostPhoto(
//         fieldname: json["fieldname"] == null ? null : json["fieldname"],
//         originalname: json["originalname"] == null ? null : json["originalname"],
//         encoding: json["encoding"] == null ? null : json["encoding"],
//         mimetype: json["mimetype"] == null ? null : json["mimetype"],
//         size: json["size"] == null ? null : json["size"],
//         bucket: json["bucket"] == null ? null : json["bucket"],
//         key: json["key"] == null ? null : json["key"],
//         acl: json["acl"] == null ? null : json["acl"],
//         contentType: json["contentType"] == null ? null : json["contentType"],
//         contentDisposition: json["contentDisposition"],
//         storageClass: json["storageClass"] == null ? null : json["storageClass"],
//         serverSideEncryption: json["serverSideEncryption"],
//         metadata: json["metadata"],
//         location: json["location"],
//         etag: json["etag"] == null ? null : json["etag"],
//         thumbnailUrl: json["thumbnailUrl"] == null ? null : json["thumbnailUrl"],
//     );
//
//     Map<String, dynamic> toJson() => {
//         "fieldname": fieldname == null ? null : fieldname,
//         "originalname": originalname == null ? null : originalname,
//         "encoding": encoding == null ? null : encoding,
//         "mimetype": mimetype == null ? null : mimetype,
//         "size": size == null ? null : size,
//         "bucket": bucket == null ? null : bucket,
//         "key": key == null ? null : key,
//         "acl": acl == null ? null : acl,
//         "contentType": contentType == null ? null : contentType,
//         "contentDisposition": contentDisposition,
//         "storageClass": storageClass == null ? null : storageClass,
//         "serverSideEncryption": serverSideEncryption,
//         "metadata": metadata,
//         "location": location,
//         "etag": etag == null ? null : etag,
//         "thumbnailUrl": thumbnailUrl == null ? null : thumbnailUrl,
//     };
// }


import 'dart:convert';

GetUserMedia getUserMediaFromJson(String str) => GetUserMedia.fromJson(json.decode(str));

String getUserMediaToJson(GetUserMedia data) => json.encode(data.toJson());

class GetUserMedia {
    GetUserMedia({
        this.message,
        this.data,
    });

    String message;
    List<Datum> data;

    factory GetUserMedia.fromJson(Map<String, dynamic> json) => GetUserMedia(
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
        this.type,
        this.commentCheck,
        this.repost,
        this.userName,
        this.name,
        this.profilePic,
        this.parentId,
        this.createdAt,
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
    String type;
    List<String> commentCheck;
    List<String> repost;
    String userName;
    String name;
    String profilePic;
    String parentId;
    DateTime createdAt;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    postPhoto: List<PostPhoto>.from(json["postPhoto"].map((x) => PostPhoto.fromJson(x))),
    like: List<String>.from(json["like"].map((x) => x)),
    textFeed: json["textFeed"],
    privacyState: json["privacyState"],
    privacyAllowance: List<dynamic>.from(json["privacyAllowance"].map((x) => x)),
    commentCount: json["commentCount"],
    caption: json["caption"],
    category: json["category"],
    subCategory: json["subCategory"],
    profileId: json["profileId"],
    type: json["type"] == null ? null : json["type"],
    commentCheck: List<String>.from(json["commentCheck"].map((x) => x)),
    repost: List<String>.from(json["repost"].map((x) => x)),
    userName: json["userName"],
    name: json["name"],
    profilePic: json["profilePic"],
        parentId: json["parentId"] == null ? null : json["parentId"],
        createdAt: DateTime.parse(json["createdAt"],
    ),
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
        "category": category,
        "subCategory": subCategory,
        "profileId": profileId,
        "type": type == null ? null : type,
        "commentCheck": List<dynamic>.from(commentCheck.map((x) => x)),
        "repost": List<dynamic>.from(repost.map((x) => x)),
        "userName": userName,
        "name": name,
        "profilePic": profilePic,
        "parentId": parentId == null ? null : parentId,
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
        thumbnailUrl: json["thumbnailUrl"] == null ? null : json["thumbnailUrl"],
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
        "thumbnailUrl": thumbnailUrl == null ? null : thumbnailUrl,
    };
}
