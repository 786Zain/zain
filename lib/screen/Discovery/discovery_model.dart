// // // To parse this JSON data, do
// // //
// // //     final discovery = discoveryFromJson(jsonString);

// // import 'dart:convert';

// // Discovery discoveryFromJson(String str) => Discovery.fromJson(json.decode(str));

// // String discoveryToJson(Discovery data) => json.encode(data.toJson());

// // class Discovery {
// //   Discovery({
// //     this.message,
// //     this.data,
// //   });

// //   String message;
// //   Data data;

// //   factory Discovery.fromJson(Map<String, dynamic> json) => Discovery(
// //     message: json["message"],
// //     data: Data.fromJson(json["data"]),
// //   );

// //   Map<String, dynamic> toJson() => {
// //     "message": message,
// //     "data": data.toJson(),
// //   };
// // }

// // class Data {
// //   Data({
// //     this.categoryList,
// //     this.posts,
// //   });

// //   List<CategoryList> categoryList;
// //   List<Post> posts;

// //   factory Data.fromJson(Map<String, dynamic> json) => Data(
// //     categoryList: List<CategoryList>.from(json["categoryList"].map((x) => CategoryList.fromJson(x))),
// //     posts: List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
// //   );

// //   Map<String, dynamic> toJson() => {
// //     "categoryList": List<dynamic>.from(categoryList.map((x) => x.toJson())),
// //     "posts": List<dynamic>.from(posts.map((x) => x.toJson())),
// //   };
// // }

// // class CategoryList {
// //   CategoryList({
// //     this.id,
// //     this.categoryName,
// //   });

// //   String id;
// //   String categoryName;

// //   factory CategoryList.fromJson(Map<String, dynamic> json) => CategoryList(
// //     id: json["_id"],
// //     categoryName: json["categoryName"],
// //   );

// //   Map<String, dynamic> toJson() => {
// //     "_id": id,
// //     "categoryName": categoryName,
// //   };
// // }

// // class Post {
// //   Post({
// //     this.categoryName,
// //     this.feeds,
// //   });

// //   String categoryName;
// //   List<Feed> feeds;

// //   factory Post.fromJson(Map<String, dynamic> json) => Post(
// //     categoryName: json["CategoryName"],
// //     feeds: List<Feed>.from(json["Feeds"].map((x) => Feed.fromJson(x))),
// //   );

// //   Map<String, dynamic> toJson() => {
// //     "CategoryName": categoryName,
// //     "Feeds": List<dynamic>.from(feeds.map((x) => x.toJson())),
// //   };
// // }

// // class Feed {
// //   Feed({
// //     this.id,
// //     this.postPhoto,
// //     this.caption,
// //     this.createdAt,
// //   });

// //   String id;
// //   List<PostPhoto> postPhoto;
// //   Caption caption;
// //   DateTime createdAt;

// //   factory Feed.fromJson(Map<String, dynamic> json) => Feed(
// //     id: json["_id"],
// //     postPhoto: List<PostPhoto>.from(json["postPhoto"].map((x) => PostPhoto.fromJson(x))),
// //     caption: captionValues.map[json["caption"]],
// //     createdAt: DateTime.parse(json["createdAt"]),
// //   );

// //   Map<String, dynamic> toJson() => {
// //     "_id": id,
// //     "postPhoto": List<dynamic>.from(postPhoto.map((x) => x.toJson())),
// //     "caption": captionValues.reverse[caption],
// //     "createdAt": createdAt.toIso8601String(),
// //   };
// // }

// // enum Caption { DESCRIPTION }

// // final captionValues = EnumValues({
// //   "Description": Caption.DESCRIPTION
// // });

// // class PostPhoto {
// //   PostPhoto({
// //     this.fieldname,
// //     this.originalname,
// //     this.encoding,
// //     this.mimetype,
// //     this.size,
// //     this.bucket,
// //     this.key,
// //     this.acl,
// //     this.contentType,
// //     this.contentDisposition,
// //     this.storageClass,
// //     this.serverSideEncryption,
// //     this.metadata,
// //     this.location,
// //     this.etag,
// //   });

// //   Fieldname fieldname;
// //   Originalname originalname;
// //   Encoding encoding;
// //   Mimetype mimetype;
// //   int size;
// //   Bucket bucket;
// //   String key;
// //   Acl acl;
// //   ContentType contentType;
// //   dynamic contentDisposition;
// //   StorageClass storageClass;
// //   dynamic serverSideEncryption;
// //   dynamic metadata;
// //   String location;
// //   Etag etag;

// //   factory PostPhoto.fromJson(Map<String, dynamic> json) => PostPhoto(
// //     fieldname: fieldnameValues.map[json["fieldname"]],
// //     originalname: originalnameValues.map[json["originalname"]],
// //     encoding: encodingValues.map[json["encoding"]],
// //     mimetype: mimetypeValues.map[json["mimetype"]],
// //     size: json["size"],
// //     bucket: bucketValues.map[json["bucket"]],
// //     key: json["key"],
// //     acl: aclValues.map[json["acl"]],
// //     contentType: contentTypeValues.map[json["contentType"]],
// //     contentDisposition: json["contentDisposition"],
// //     storageClass: storageClassValues.map[json["storageClass"]],
// //     serverSideEncryption: json["serverSideEncryption"],
// //     metadata: json["metadata"],
// //     location: json["location"],
// //     etag: etagValues.map[json["etag"]],
// //   );

// //   Map<String, dynamic> toJson() => {
// //     "fieldname": fieldnameValues.reverse[fieldname],
// //     "originalname": originalnameValues.reverse[originalname],
// //     "encoding": encodingValues.reverse[encoding],
// //     "mimetype": mimetypeValues.reverse[mimetype],
// //     "size": size,
// //     "bucket": bucketValues.reverse[bucket],
// //     "key": key,
// //     "acl": aclValues.reverse[acl],
// //     "contentType": contentTypeValues.reverse[contentType],
// //     "contentDisposition": contentDisposition,
// //     "storageClass": storageClassValues.reverse[storageClass],
// //     "serverSideEncryption": serverSideEncryption,
// //     "metadata": metadata,
// //     "location": location,
// //     "etag": etagValues.reverse[etag],
// //   };
// // }

// // enum Acl { PUBLIC_READ }

// // final aclValues = EnumValues({
// //   "public-read": Acl.PUBLIC_READ
// // });

// // enum Bucket { FARMSYS }

// // final bucketValues = EnumValues({
// //   "farmsys": Bucket.FARMSYS
// // });

// // enum ContentType { APPLICATION_OCTET_STREAM }

// // final contentTypeValues = EnumValues({
// //   "application/octet-stream": ContentType.APPLICATION_OCTET_STREAM
// // });

// // enum Encoding { THE_7_BIT }

// // final encodingValues = EnumValues({
// //   "7bit": Encoding.THE_7_BIT
// // });

// // enum Etag { CFBC1_D0_AA90725693_FFF5672_CF6_C684_C }

// // final etagValues = EnumValues({
// //   "\"cfbc1d0aa90725693fff5672cf6c684c\"": Etag.CFBC1_D0_AA90725693_FFF5672_CF6_C684_C
// // });

// // enum Fieldname { POST }

// // final fieldnameValues = EnumValues({
// //   "post": Fieldname.POST
// // });

// // enum Mimetype { IMAGE_JPEG }

// // final mimetypeValues = EnumValues({
// //   "image/jpeg": Mimetype.IMAGE_JPEG
// // });

// // enum Originalname { COVER_TEST_PIC1_JPG }

// // final originalnameValues = EnumValues({
// //   "CoverTestPic1.jpg": Originalname.COVER_TEST_PIC1_JPG
// // });

// // enum StorageClass { STANDARD }

// // final storageClassValues = EnumValues({
// //   "STANDARD": StorageClass.STANDARD
// // });

// // class EnumValues<T> {
// //   Map<String, T> map;
// //   Map<T, String> reverseMap;

// //   EnumValues(this.map);

// //   Map<T, String> get reverse {
// //     if (reverseMap == null) {
// //       reverseMap = map.map((k, v) => new MapEntry(v, k));
// //     }
// //     return reverseMap;
// //   }
// // }
// // To parse this JSON data, do
// //
// //     final discovery = discoveryFromJson(jsonString);

// import 'dart:convert';

// Discovery discoveryFromJson(String str) => Discovery.fromJson(json.decode(str));

// String discoveryToJson(Discovery data) => json.encode(data.toJson());

// class Discovery {
//     Discovery({
//         this.message,
//         this.data,
//     });

//     String message;
//     Data data;

//     factory Discovery.fromJson(Map<String, dynamic> json) => Discovery(
//         message: json["message"],
//         data: Data.fromJson(json["data"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "message": message,
//         "data": data.toJson(),
//     };
// }

// class Data {
//     Data({
//         this.categoryList,
//         this.posts,
//     });

//     List<CategoryList> categoryList;
//     List<Post> posts;

//     factory Data.fromJson(Map<String, dynamic> json) => Data(
//         categoryList: List<CategoryList>.from(json["categoryList"].map((x) => CategoryList.fromJson(x))),
//         posts: List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "categoryList": List<dynamic>.from(categoryList.map((x) => x.toJson())),
//         "posts": List<dynamic>.from(posts.map((x) => x.toJson())),
//     };
// }

// class CategoryList {
//     CategoryList({
//         this.id,
//         this.categoryName,
//     });

//     String id;
//     String categoryName;

//     factory CategoryList.fromJson(Map<String, dynamic> json) => CategoryList(
//         id: json["_id"],
//         categoryName: json["categoryName"],
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "categoryName": categoryName,
//     };
// }

// class Post {
//     Post({
//         this.categoryId,
//         this.categoryName,
//         this.feeds,
//     });

//     String categoryId;
//     String categoryName;
//     List<Feed> feeds;

//     factory Post.fromJson(Map<String, dynamic> json) => Post(
//         categoryId: json["CategoryId"],
//         categoryName: json["CategoryName"],
//         feeds: List<Feed>.from(json["Feeds"].map((x) => Feed.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "CategoryId": categoryId,
//         "CategoryName": categoryName,
//         "Feeds": List<dynamic>.from(feeds.map((x) => x.toJson())),
//     };
// }

// class Feed {
//     Feed({
//         this.id,
//         this.postPhoto,
//         this.caption,
//         this.createdAt,
//     });

//     String id;
//     List<PostPhoto> postPhoto;
//     String caption;
//     DateTime createdAt;

//     factory Feed.fromJson(Map<String, dynamic> json) => Feed(
//         id: json["_id"],
//         postPhoto: List<PostPhoto>.from(json["postPhoto"].map((x) => PostPhoto.fromJson(x))),
//         caption: json["caption"],
//         createdAt: DateTime.parse(json["createdAt"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "postPhoto": List<dynamic>.from(postPhoto.map((x) => x.toJson())),
//         "caption": caption,
//         "createdAt": createdAt.toIso8601String(),
//     };
// }

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
//     });

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

//     factory PostPhoto.fromJson(Map<String, dynamic> json) => PostPhoto(
//         fieldname: json["fieldname"],
//         originalname: json["originalname"],
//         encoding: json["encoding"],
//         mimetype: json["mimetype"],
//         size: json["size"],
//         bucket: json["bucket"],
//         key: json["key"],
//         acl: json["acl"],
//         contentType: json["contentType"],
//         contentDisposition: json["contentDisposition"],
//         storageClass: json["storageClass"],
//         serverSideEncryption: json["serverSideEncryption"],
//         metadata: json["metadata"],
//         location: json["location"],
//         etag: json["etag"],
//     );

//     Map<String, dynamic> toJson() => {
//         "fieldname": fieldname,
//         "originalname": originalname,
//         "encoding": encoding,
//         "mimetype": mimetype,
//         "size": size,
//         "bucket": bucket,
//         "key": key,
//         "acl": acl,
//         "contentType": contentType,
//         "contentDisposition": contentDisposition,
//         "storageClass": storageClass,
//         "serverSideEncryption": serverSideEncryption,
//         "metadata": metadata,
//         "location": location,
//         "etag": etag,
//     };
// }
// 
// To parse this JSON data, do
//
//     final disovery = disoveryFromJson(jsonString);


// //Latest
// import 'dart:convert';
//
// Disovery disoveryFromJson(String str) => Disovery.fromJson(json.decode(str));
//
// String disoveryToJson(Disovery data) => json.encode(data.toJson());
//
// class Disovery {
//     Disovery({
//         this.message,
//         this.data,
//     });
//
//     String message;
//     Data data;
//
//     factory Disovery.fromJson(Map<String, dynamic> json) => Disovery(
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
//         this.content,
//         this.categoryList,
//         this.posts,
//     });
//
//     List<Content> content;
//     List<CategoryList> categoryList;
//     List<Post> posts;
//
//     factory Data.fromJson(Map<String, dynamic> json) => Data(
//         content: List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
//         categoryList: List<CategoryList>.from(json["categoryList"].map((x) => CategoryList.fromJson(x))),
//         posts: List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
//     );
//
//     Map<String, dynamic> toJson() => {
//         "content": List<dynamic>.from(content.map((x) => x.toJson())),
//         "categoryList": List<dynamic>.from(categoryList.map((x) => x.toJson())),
//         "posts": List<dynamic>.from(posts.map((x) => x.toJson())),
//     };
// }
//
// class CategoryList {
//     CategoryList({
//         this.id,
//         this.categoryName,
//     });
//
//     String id;
//     String categoryName;
//
//     factory CategoryList.fromJson(Map<String, dynamic> json) => CategoryList(
//         id: json["_id"],
//         categoryName: json["categoryName"],
//     );
//
//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "categoryName": categoryName,
//     };
// }
//
// class Content {
//     Content({
//         this.id,
//         this.title,
//         this.bodyText,
//         this.thumbnailurl,
//         this.videoUrl,
//         this.categoryName,
//     });
//
//     String id;
//     String title;
//     String bodyText;
//     String thumbnailurl;
//     String videoUrl;
//     String categoryName;
//
//     factory Content.fromJson(Map<String, dynamic> json) => Content(
//         id: json["_id"],
//         title: json["title"],
//         bodyText: json["bodyText"],
//         thumbnailurl: json["thumbnailurl"],
//         videoUrl: json["videoUrl"],
//         categoryName: json["categoryName"],
//     );
//
//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "title": title,
//         "bodyText": bodyText,
//         "thumbnailurl": thumbnailurl,
//         "videoUrl": videoUrl,
//         "categoryName": categoryName,
//     };
// }
//
// class Post {
//     Post({
//         this.categoryId,
//         this.categoryName,
//         this.feeds,
//     });
//
//     String categoryId;
//     String categoryName;
//     List<Feed> feeds;
//
//     factory Post.fromJson(Map<String, dynamic> json) => Post(
//         categoryId: json["CategoryId"],
//         categoryName: json["CategoryName"],
//         feeds: List<Feed>.from(json["Feeds"].map((x) => Feed.fromJson(x))),
//     );
//
//     Map<String, dynamic> toJson() => {
//         "CategoryId": categoryId,
//         "CategoryName": categoryName,
//         "Feeds": List<dynamic>.from(feeds.map((x) => x.toJson())),
//     };
// }
//
// class Feed {
//     Feed({
//         this.id,
//         this.postPhoto,
//         this.caption,
//         this.createdAt,
//         this.textFeed,
//     });
//
//     String id;
//     List<PostPhoto> postPhoto;
//     String caption;
//     DateTime createdAt;
//     bool textFeed;
//
//     factory Feed.fromJson(Map<String, dynamic> json) => Feed(
//         id: json["_id"],
//         postPhoto: List<PostPhoto>.from(json["postPhoto"].map((x) => PostPhoto.fromJson(x))),
//         caption: json["caption"] == null ? null : json["caption"],
//         createdAt: DateTime.parse(json["createdAt"]),
//         textFeed: json["textFeed"],
//     );
//
//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "postPhoto": List<dynamic>.from(postPhoto.map((x) => x.toJson())),
//         "caption": caption == null ? null : caption,
//         "createdAt": createdAt.toIso8601String(),
//         "textFeed": textFeed,
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
//         fieldname: json["fieldname"],
//         originalname: json["originalname"],
//         encoding: json["encoding"],
//         mimetype: json["mimetype"],
//         size: json["size"],
//         bucket: json["bucket"],
//         key: json["key"],
//         acl: json["acl"],
//         contentType: json["contentType"],
//         contentDisposition: json["contentDisposition"],
//         storageClass: json["storageClass"],
//         serverSideEncryption: json["serverSideEncryption"],
//         metadata: json["metadata"],
//         location: json["location"],
//         etag: json["etag"],
//         thumbnailUrl: json["thumbnailUrl"] == null ? null : json["thumbnailUrl"],
//     );
//
//     Map<String, dynamic> toJson() => {
//         "fieldname": fieldname,
//         "originalname": originalname,
//         "encoding": encoding,
//         "mimetype": mimetype,
//         "size": size,
//         "bucket": bucket,
//         "key": key,
//         "acl": acl,
//         "contentType": contentType,
//         "contentDisposition": contentDisposition,
//         "storageClass": storageClass,
//         "serverSideEncryption": serverSideEncryption,
//         "metadata": metadata,
//         "location": location,
//         "etag": etag,
//         "thumbnailUrl": thumbnailUrl == null ? null : thumbnailUrl,
//     };
// }

//new one

// To parse this JSON data, do
//
//     final disovery = disoveryFromJson(jsonString);

// import 'dart:convert';
//
// Disovery disoveryFromJson(String str) => Disovery.fromJson(json.decode(str));
//
// String disoveryToJson(Disovery data) => json.encode(data.toJson());
//
// class Disovery {
//     Disovery({
//         this.message,
//         this.data,
//     });
//
//     String message;
//     Data data;
//
//     factory Disovery.fromJson(Map<String, dynamic> json) => Disovery(
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
//         this.content,
//         this.categoryList,
//         this.posts,
//     });
//
//     List<Content> content;
//     List<CategoryList> categoryList;
//     List<Post> posts;
//
//     factory Data.fromJson(Map<String, dynamic> json) => Data(
//         content: List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
//         categoryList: List<CategoryList>.from(json["categoryList"].map((x) => CategoryList.fromJson(x))),
//         posts: List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
//     );
//
//     Map<String, dynamic> toJson() => {
//         "content": List<dynamic>.from(content.map((x) => x.toJson())),
//         "categoryList": List<dynamic>.from(categoryList.map((x) => x.toJson())),
//         "posts": List<dynamic>.from(posts.map((x) => x.toJson())),
//     };
// }
//
// class CategoryList {
//     CategoryList({
//         this.id,
//         this.categoryName,
//     });
//
//     String id;
//     String categoryName;
//
//     factory CategoryList.fromJson(Map<String, dynamic> json) => CategoryList(
//         id: json["_id"],
//         categoryName: json["categoryName"],
//     );
//
//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "categoryName": categoryName,
//     };
// }
//
// class Content {
//     Content({
//         this.id,
//         this.title,
//         this.bodyText,
//         this.thumbnailurl,
//         this.videoUrl,
//         this.categoryName,
//     });
//
//     String id;
//     String title;
//     String bodyText;
//     String thumbnailurl;
//     String videoUrl;
//     String categoryName;
//
//     factory Content.fromJson(Map<String, dynamic> json) => Content(
//         id: json["_id"],
//         title: json["title"],
//         bodyText: json["bodyText"],
//         thumbnailurl: json["thumbnailurl"],
//         videoUrl: json["videoUrl"],
//         categoryName: json["categoryName"],
//     );
//
//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "title": title,
//         "bodyText": bodyText,
//         "thumbnailurl": thumbnailurl,
//         "videoUrl": videoUrl,
//         "categoryName": categoryName,
//     };
// }
//
// class Post {
//     Post({
//         this.categoryId,
//         this.categoryName,
//         this.feeds,
//     });
//
//     String categoryId;
//     String categoryName;
//     List<Feed> feeds;
//
//     factory Post.fromJson(Map<String, dynamic> json) => Post(
//         categoryId: json["CategoryId"],
//         categoryName: json["CategoryName"],
//         feeds: List<Feed>.from(json["Feeds"].map((x) => Feed.fromJson(x))),
//     );
//
//     Map<String, dynamic> toJson() => {
//         "CategoryId": categoryId,
//         "CategoryName": categoryName,
//         "Feeds": List<dynamic>.from(feeds.map((x) => x.toJson())),
//     };
// }
//
// class Feed {
//     Feed({
//         this.id,
//         this.postPhoto,
//         this.like,
//         this.repost,
//         this.privacyState,
//         this.privacyAllowance,
//         this.commentCount,
//         this.textFeed,
//         this.isDeleted,
//         this.caption,
//         this.category,
//         this.subCategory,
//         this.profileId,
//         this.createdAt,
//     });
//
//     String id;
//     List<PostPhoto> postPhoto;
//     List<String> like;
//     List<String> repost;
//     bool privacyState;
//     List<dynamic> privacyAllowance;
//     int commentCount;
//     bool textFeed;
//     bool isDeleted;
//     String caption;
//     String category;
//     String subCategory;
//     String profileId;
//     DateTime createdAt;
//
//     factory Feed.fromJson(Map<String, dynamic> json) => Feed(
//         id: json["_id"],
//         postPhoto: List<PostPhoto>.from(json["postPhoto"].map((x) => PostPhoto.fromJson(x))),
//         like: List<String>.from(json["like"].map((x) => x)),
//         repost: List<String>.from(json["repost"].map((x) => x)),
//         privacyState: json["privacyState"],
//         privacyAllowance: List<dynamic>.from(json["privacyAllowance"].map((x) => x)),
//         commentCount: json["commentCount"],
//         textFeed: json["textFeed"],
//         isDeleted: json["isDeleted"],
//         caption: json["caption"],
//         category: json["category"],
//         subCategory: json["subCategory"],
//         profileId: json["profileId"],
//         createdAt: DateTime.parse(json["createdAt"]),
//     );
//
//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "postPhoto": List<dynamic>.from(postPhoto.map((x) => x.toJson())),
//         "like": List<dynamic>.from(like.map((x) => x)),
//         "repost": List<dynamic>.from(repost.map((x) => x)),
//         "privacyState": privacyState,
//         "privacyAllowance": List<dynamic>.from(privacyAllowance.map((x) => x)),
//         "commentCount": commentCount,
//         "textFeed": textFeed,
//         "isDeleted": isDeleted,
//         "caption": caption,
//         "category": category,
//         "subCategory": subCategory,
//         "profileId": profileId,
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
//
//
//



import 'dart:convert';

Disovery disoveryFromJson(String str) => Disovery.fromJson(json.decode(str));

String disoveryToJson(Disovery data) => json.encode(data.toJson());

class Disovery {
    Disovery({
        this.message,
        this.data,
    });

    String message;
    Data data;

    factory Disovery.fromJson(Map<String, dynamic> json) => Disovery(
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
        this.content,
        this.categoryList,
        this.posts,
    });

    List<Content> content;
    List<CategoryList> categoryList;
    List<Post> posts;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        content: List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
        categoryList: List<CategoryList>.from(json["categoryList"].map((x) => CategoryList.fromJson(x))),
        posts: List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "content": List<dynamic>.from(content.map((x) => x.toJson())),
        "categoryList": List<dynamic>.from(categoryList.map((x) => x.toJson())),
        "posts": List<dynamic>.from(posts.map((x) => x.toJson())),
    };
}

class CategoryList {
    CategoryList({
        this.id,
        this.categoryName,
    });

    String id;
    String categoryName;

    factory CategoryList.fromJson(Map<String, dynamic> json) => CategoryList(
        id: json["_id"],
        categoryName: json["categoryName"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "categoryName": categoryName,
    };
}

class Content {
    Content({
        this.id,
        this.title,
        this.bodyText,
        this.thumbnailurl,
        this.videoUrl,
        this.categoryName,
    });

    String id;
    String title;
    String bodyText;
    String thumbnailurl;
    String videoUrl;
    String categoryName;

    factory Content.fromJson(Map<String, dynamic> json) => Content(
        id: json["_id"],
        title: json["title"],
        bodyText: json["bodyText"],
        thumbnailurl: json["thumbnailurl"],
        videoUrl: json["videoUrl"],
        categoryName: json["categoryName"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "bodyText": bodyText,
        "thumbnailurl": thumbnailurl,
        "videoUrl": videoUrl,
        "categoryName": categoryName,
    };
}

class Post {
    Post({
        this.categoryId,
        this.categoryName,
        this.feeds,
    });

    String categoryId;
    String categoryName;
    List<Feed> feeds;

    factory Post.fromJson(Map<String, dynamic> json) => Post(
        categoryId: json["CategoryId"],
        categoryName: json["CategoryName"],
        feeds: List<Feed>.from(json["Feeds"].map((x) => Feed.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "CategoryId": categoryId,
        "CategoryName": categoryName,
        "Feeds": List<dynamic>.from(feeds.map((x) => x.toJson())),
    };
}

class Feed {
    Feed({
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
    List<String> repost;
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

    factory Feed.fromJson(Map<String, dynamic> json) => Feed(
        id: json["_id"],
        postPhoto: List<PostPhoto>.from(json["postPhoto"].map((x) => PostPhoto.fromJson(x))),
        like: List<String>.from(json["like"].map((x) => x)),
        repost: List<String>.from(json["repost"].map((x) => x)),
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
        this.versionId,
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
    dynamic versionId;
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
        versionId: json["versionId"],
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
        "versionId": versionId,
        "thumbnailUrl": thumbnailUrl == null ? null : thumbnailUrl,
    };
}
