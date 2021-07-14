// To parse this JSON data, do
//
//     final subCategoryDiscover = subCategoryDiscoverFromJson(jsonString);

// import 'dart:convert';
//
// SubCategoryDiscover subCategoryDiscoverFromJson(String str) => SubCategoryDiscover.fromJson(json.decode(str));
//
// String subCategoryDiscoverToJson(SubCategoryDiscover data) => json.encode(data.toJson());
//
// class SubCategoryDiscover {
//     SubCategoryDiscover({
//         this.message,
//         this.data,
//     });
//
//     String message;
//     Data data;
//
//     factory SubCategoryDiscover.fromJson(Map<String, dynamic> json) => SubCategoryDiscover(
//         message: json["message"],
//         data: Data.fromJson(json["data"]),
//     );
//
//     Map<String, dynamic> toJson() => {
//         "message": message,
//         "data": data.toJson(),
//     };
// }
//
// class Data {
//     Data({
//         this.subCategoryList,
//         this.feeds,
//     });
//
//     List<SubCategoryList> subCategoryList;
//     List<Feed> feeds;
//
//     factory Data.fromJson(Map<String, dynamic> json) => Data(
//         subCategoryList: List<SubCategoryList>.from(json["subCategoryList"].map((x) => SubCategoryList.fromJson(x))),
//         feeds: List<Feed>.from(json["feeds"].map((x) => Feed.fromJson(x))),
//     );
//
//     Map<String, dynamic> toJson() => {
//         "subCategoryList": List<dynamic>.from(subCategoryList.map((x) => x.toJson())),
//         "feeds": List<dynamic>.from(feeds.map((x) => x.toJson())),
//     };
// }
//
// class Feed {
//     Feed({
//         this.id,
//         this.postCount,
//         this.subCategoryName,
//         this.postFeeds,
//     });
//
//     String id;
//     int postCount;
//     String subCategoryName;
//     List<PostFeed> postFeeds;
//
//     factory Feed.fromJson(Map<String, dynamic> json) => Feed(
//         id: json["_id"],
//         postCount: json["postCount"],
//         subCategoryName: json["subCategoryName"],
//         postFeeds: List<PostFeed>.from(json["postFeeds"].map((x) => PostFeed.fromJson(x))),
//     );
//
//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "postCount": postCount,
//         "subCategoryName": subCategoryName,
//         "postFeeds": List<dynamic>.from(postFeeds.map((x) => x.toJson())),
//     };
// }
//
// class PostFeed {
//     PostFeed({
//         this.id,
//         this.postPhoto,
//         this.caption,
//         this.createdAt,
//     });
//
//     String id;
//     List<PostPhoto> postPhoto;
//     String caption;
//     DateTime createdAt;
//
//     factory PostFeed.fromJson(Map<String, dynamic> json) => PostFeed(
//         id: json["_id"],
//         postPhoto: List<PostPhoto>.from(json["postPhoto"].map((x) => PostPhoto.fromJson(x))),
//         caption: json["caption"],
//         createdAt: DateTime.parse(json["createdAt"]),
//     );
//
//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "postPhoto": List<dynamic>.from(postPhoto.map((x) => x.toJson())),
//         "caption": caption,
//         "createdAt": createdAt.toIso8601String(),
//     };
// }
//
// class PostPhoto {
//     PostPhoto({
//         this.location,
//     });
//
//     String location;
//
//     factory PostPhoto.fromJson(Map<String, dynamic> json) => PostPhoto(
//         location: json["location"],
//     );
//
//     Map<String, dynamic> toJson() => {
//         "location": location,
//     };
// }
//
// class SubCategoryList {
//     SubCategoryList({
//         this.id,
//         this.subCategoryName,
//     });
//
//     String id;
//     String subCategoryName;
//
//     factory SubCategoryList.fromJson(Map<String, dynamic> json) => SubCategoryList(
//         id: json["_id"],
//         subCategoryName: json["subCategoryName"],
//     );
//
//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "subCategoryName": subCategoryName,
//     };
// }

//Latest One with thumbnail

// To parse this JSON data, do
//
//     final subCategoryDiscover = subCategoryDiscoverFromJson(jsonString);

// import 'dart:convert';
//
// SubCategoryDiscover subCategoryDiscoverFromJson(String str) => SubCategoryDiscover.fromJson(json.decode(str));
//
// String subCategoryDiscoverToJson(SubCategoryDiscover data) => json.encode(data.toJson());
//
// class SubCategoryDiscover {
//     SubCategoryDiscover({
//         this.message,
//         this.data,
//     });
//
//     String message;
//     Data data;
//
//     factory SubCategoryDiscover.fromJson(Map<String, dynamic> json) => SubCategoryDiscover(
//         message: json["message"],
//         data: Data.fromJson(json["data"]),
//     );
//
//     Map<String, dynamic> toJson() => {
//         "message": message,
//         "data": data.toJson(),
//     };
// }
//
// class Data {
//     Data({
//         this.subCategoryList,
//         this.feeds,
//     });
//
//     List<SubCategoryList> subCategoryList;
//     List<Feed> feeds;
//
//     factory Data.fromJson(Map<String, dynamic> json) => Data(
//         subCategoryList: List<SubCategoryList>.from(json["subCategoryList"].map((x) => SubCategoryList.fromJson(x))),
//         feeds: List<Feed>.from(json["feeds"].map((x) => Feed.fromJson(x))),
//     );
//
//     Map<String, dynamic> toJson() => {
//         "subCategoryList": List<dynamic>.from(subCategoryList.map((x) => x.toJson())),
//         "feeds": List<dynamic>.from(feeds.map((x) => x.toJson())),
//     };
// }
//
// class Feed {
//     Feed({
//         this.id,
//         this.postCount,
//         this.subCategoryName,
//         this.postFeeds,
//     });
//
//     String id;
//     int postCount;
//     String subCategoryName;
//     List<PostFeed> postFeeds;
//
//     factory Feed.fromJson(Map<String, dynamic> json) => Feed(
//         id: json["_id"],
//         postCount: json["postCount"],
//         subCategoryName: json["subCategoryName"],
//         postFeeds: List<PostFeed>.from(json["postFeeds"].map((x) => PostFeed.fromJson(x))),
//     );
//
//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "postCount": postCount,
//         "subCategoryName": subCategoryName,
//         "postFeeds": List<dynamic>.from(postFeeds.map((x) => x.toJson())),
//     };
// }
//
// class PostFeed {
//     PostFeed({
//         this.id,
//         this.postPhoto,
//         this.textFeed,
//         this.caption,
//         this.createdAt,
//     });
//
//     String id;
//     List<PostPhoto> postPhoto;
//     bool textFeed;
//     String caption;
//     DateTime createdAt;
//
//     factory PostFeed.fromJson(Map<String, dynamic> json) => PostFeed(
//         id: json["_id"],
//         postPhoto: List<PostPhoto>.from(json["postPhoto"].map((x) => PostPhoto.fromJson(x))),
//         textFeed: json["textFeed"],
//         caption: json["caption"],
//         createdAt: DateTime.parse(json["createdAt"]),
//     );
//
//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "postPhoto": List<dynamic>.from(postPhoto.map((x) => x.toJson())),
//         "textFeed": textFeed,
//         "caption": caption,
//         "createdAt": createdAt.toIso8601String(),
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
//
// class SubCategoryList {
//     SubCategoryList({
//         this.id,
//         this.subCategoryName,
//     });
//
//     String id;
//     String subCategoryName;
//
//     factory SubCategoryList.fromJson(Map<String, dynamic> json) => SubCategoryList(
//         id: json["_id"],
//         subCategoryName: json["subCategoryName"],
//     );
//
//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "subCategoryName": subCategoryName,
//     };
// }


import 'dart:convert';

SubCategoryDiscover subCategoryDiscoverFromJson(String str) => SubCategoryDiscover.fromJson(json.decode(str));

String subCategoryDiscoverToJson(SubCategoryDiscover data) => json.encode(data.toJson());

class SubCategoryDiscover {
    SubCategoryDiscover({
        this.message,
        this.data,
    });

    String message;
    Data data;

    factory SubCategoryDiscover.fromJson(Map<String, dynamic> json) => SubCategoryDiscover(
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
        this.subCategoryList,
        this.feeds,
    });

    List<SubCategoryList> subCategoryList;
    List<Feed> feeds;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        subCategoryList: List<SubCategoryList>.from(json["subCategoryList"].map((x) => SubCategoryList.fromJson(x))),
        feeds: List<Feed>.from(json["feeds"].map((x) => Feed.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "subCategoryList": List<dynamic>.from(subCategoryList.map((x) => x.toJson())),
        "feeds": List<dynamic>.from(feeds.map((x) => x.toJson())),
    };
}

class Feed {
    Feed({
        this.id,
        this.postCount,
        this.subCategoryName,
        this.postFeeds,
    });

    String id;
    int postCount;
    String subCategoryName;
    List<PostFeed> postFeeds;

    factory Feed.fromJson(Map<String, dynamic> json) => Feed(
        id: json["_id"],
        postCount: json["postCount"],
        subCategoryName: json["subCategoryName"],
        postFeeds: List<PostFeed>.from(json["postFeeds"].map((x) => PostFeed.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "postCount": postCount,
        "subCategoryName": subCategoryName,
        "postFeeds": List<dynamic>.from(postFeeds.map((x) => x.toJson())),
    };
}

class PostFeed {
    PostFeed({
        this.id,
        this.postPhoto,
        this.like,
        this.repost,
        this.privacyState,
        this.privacyAllowance,
        this.commentCount,
        this.textFeed,
        this.isDeleted,
        this.caption,
        this.category,
        this.subCategory,
        this.profileId,
        this.name,
        this.userName,
        this.profilePic,
        this.createdAt,
    });

    String id;
    List<PostPhoto> postPhoto;
    List<String> like;
    List<dynamic> repost;
    bool privacyState;
    List<dynamic> privacyAllowance;
    int commentCount;
    bool textFeed;
    bool isDeleted;
    String caption;
    String category;
    String subCategory;
    String profileId;
    String name;
    String userName;
    PostPhoto profilePic;
    DateTime createdAt;

    factory PostFeed.fromJson(Map<String, dynamic> json) => PostFeed(
        id: json["_id"],
        postPhoto: List<PostPhoto>.from(json["postPhoto"].map((x) => PostPhoto.fromJson(x))),
        like: List<String>.from(json["like"].map((x) => x)),
        repost: List<dynamic>.from(json["repost"].map((x) => x)),
        privacyState: json["privacyState"],
        privacyAllowance: List<dynamic>.from(json["privacyAllowance"].map((x) => x)),
        commentCount: json["commentCount"],
        textFeed: json["textFeed"],
        isDeleted: json["isDeleted"],
        caption: json["caption"],
        category: json["category"],
        subCategory: json["subCategory"],
        profileId: json["profileId"],
        name: json["name"],
        userName: json["userName"],
        profilePic: PostPhoto.fromJson(json["profilePic"]),
        createdAt: DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "postPhoto": List<dynamic>.from(postPhoto.map((x) => x.toJson())),
        "like": List<dynamic>.from(like.map((x) => x)),
        "repost": List<dynamic>.from(repost.map((x) => x)),
        "privacyState": privacyState,
        "privacyAllowance": List<dynamic>.from(privacyAllowance.map((x) => x)),
        "commentCount": commentCount,
        "textFeed": textFeed,
        "isDeleted": isDeleted,
        "caption": caption,
        "category": category,
        "subCategory": subCategory,
        "profileId": profileId,
        "name": name,
        "userName": userName,
        "profilePic": profilePic.toJson(),
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
        this.versionId,
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
    dynamic versionId;
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
        versionId: json["versionId"],
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
        "versionId": versionId,
        "thumbnailUrl": thumbnailUrl == null ? null : thumbnailUrl,
    };
}

class SubCategoryList {
    SubCategoryList({
        this.id,
        this.subCategoryName,
    });

    String id;
    String subCategoryName;

    factory SubCategoryList.fromJson(Map<String, dynamic> json) => SubCategoryList(
        id: json["_id"],
        subCategoryName: json["subCategoryName"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "subCategoryName": subCategoryName,
    };
}
