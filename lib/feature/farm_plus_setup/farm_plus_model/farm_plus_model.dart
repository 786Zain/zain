// // // To parse this JSON data, do
// // //
// // //     final categoyName = categoyNameFromJson(jsonString);
// //
// // import 'dart:convert';
// //
// // CategoyName categoyNameFromJson(String str) => CategoyName.fromJson(json.decode(str));
// //
// // String categoyNameToJson(CategoyName data) => json.encode(data.toJson());
// //
// // class CategoyName {
// //   CategoyName({
// //     this.data,
// //     this.message,
// //   });
// //
// //   List<Datum> data;
// //   String message;
// //
// //   factory CategoyName.fromJson(Map<String, dynamic> json) => CategoyName(
// //     data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
// //     message: json["message"],
// //   );
// //
// //   Map<String, dynamic> toJson() => {
// //     "data": List<dynamic>.from(data.map((x) => x.toJson())),
// //     "message": message,
// //   };
// // }
// //
// // class Datum {
// //   Datum({
// //     this.id,
// //     this.categoryName,
// //     this.v,
// //   });
// //
// //   String id;
// //   String categoryName;
// //   int v;
// //
// //   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
// //     id: json["_id"],
// //     categoryName: json["categoryName"],
// //     v: json["__v"],
// //   );
// //
// //   Map<String, dynamic> toJson() => {
// //     "_id": id,
// //     "categoryName": categoryName,
// //     "__v": v,
// //   };
// // }
// // To parse this JSON data, do
// //
// //     final farmPlusHome = farmPlusHomeFromJson(jsonString);
//
// import 'dart:convert';
//
// FarmPlusHome farmPlusHomeFromJson(String str) => FarmPlusHome.fromJson(json.decode(str));
//
// String farmPlusHomeToJson(FarmPlusHome data) => json.encode(data.toJson());
//
// class FarmPlusHome {
//   FarmPlusHome({
//     this.message,
//     this.data,
//   });
//
//   String message;
//   Data data;
//
//   factory FarmPlusHome.fromJson(Map<String, dynamic> json) => FarmPlusHome(
//     message: json["message"],
//     data: Data.fromJson(json["data"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "message": message,
//     "data": data.toJson(),
//   };
// }
//
// class Data {
//   Data({
//     this.categoryList,
//     this.posts,
//   });
//
//   List<CategoryList> categoryList;
//   List<Post> posts;
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     categoryList: List<CategoryList>.from(json["categoryList"].map((x) => CategoryList.fromJson(x))),
//     posts: List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "categoryList": List<dynamic>.from(categoryList.map((x) => x.toJson())),
//     "posts": List<dynamic>.from(posts.map((x) => x.toJson())),
//   };
// }
//
// class CategoryList {
//   CategoryList({
//     this.id,
//     this.categoryName,
//     this.v,
//   });
//
//   String id;
//   String categoryName;
//   int v;
//
//   factory CategoryList.fromJson(Map<String, dynamic> json) => CategoryList(
//     id: json["_id"],
//     categoryName: json["categoryName"],
//     v: json["__v"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "categoryName": categoryName,
//     "__v": v,
//   };
// }
//
// class Post {
//   Post({
//     this.categoryId,
//     this.categoryName,
//     this.categoryContent,
//   });
//
//   String categoryId;
//   String categoryName;
//   List<CategoryContent> categoryContent;
//
//   factory Post.fromJson(Map<String, dynamic> json) => Post(
//     categoryId: json["CategoryId"],
//     categoryName: json["CategoryName"],
//     categoryContent: List<CategoryContent>.from(json["CategoryContent"].map((x) => CategoryContent.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "CategoryId": categoryId,
//     "CategoryName": categoryName,
//     "CategoryContent": List<dynamic>.from(categoryContent.map((x) => x.toJson())),
//   };
// }
//
// class CategoryContent {
//   CategoryContent({
//     this.id,
//     this.category,
//     this.subCategory,
//     this.title,
//     this.bodyText,
//     this.videoId,
//     this.thumbnailId,
//     this.featurePost,
//     this.userId,
//     this.createdAt,
//     this.v,
//     this.videoUrl,
//     this.thumbnailUrl,
//   });
//
//   String id;
//   String category;
//   SubCategory subCategory;
//   String title;
//   String bodyText;
//   VideoId videoId;
//   ThumbnailId thumbnailId;
//   bool featurePost;
//   UserId userId;
//   DateTime createdAt;
//   int v;
//   List<VideoUrl> videoUrl;
//   List<ThumbnailUrl> thumbnailUrl;
//
//   factory CategoryContent.fromJson(Map<String, dynamic> json) => CategoryContent(
//     id: json["_id"],
//     category: json["category"],
//     subCategory: subCategoryValues.map[json["subCategory"]],
//     title: json["title"],
//     bodyText: json["bodyText"],
//     videoId: json["videoId"] == null ? null : videoIdValues.map[json["videoId"]],
//     thumbnailId: json["thumbnailId"] == null ? null : thumbnailIdValues.map[json["thumbnailId"]],
//     featurePost: json["featurePost"],
//     userId: userIdValues.map[json["userId"]],
//     createdAt: DateTime.parse(json["createdAt"]),
//     v: json["__v"],
//     videoUrl: List<VideoUrl>.from(json["videoUrl"].map((x) => VideoUrl.fromJson(x))),
//     thumbnailUrl: List<ThumbnailUrl>.from(json["thumbnailUrl"].map((x) => ThumbnailUrl.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "category": category,
//     "subCategory": subCategoryValues.reverse[subCategory],
//     "title": title,
//     "bodyText": bodyText,
//     "videoId": videoId == null ? null : videoIdValues.reverse[videoId],
//     "thumbnailId": thumbnailId == null ? null : thumbnailIdValues.reverse[thumbnailId],
//     "featurePost": featurePost,
//     "userId": userIdValues.reverse[userId],
//     "createdAt": createdAt.toIso8601String(),
//     "__v": v,
//     "videoUrl": List<dynamic>.from(videoUrl.map((x) => x.toJson())),
//     "thumbnailUrl": List<dynamic>.from(thumbnailUrl.map((x) => x.toJson())),
//   };
// }
//
// enum SubCategory { EMPTY, HITTING, PITCHING }
//
// final subCategoryValues = EnumValues({
//   "": SubCategory.EMPTY,
//   "hitting": SubCategory.HITTING,
//   "pitching": SubCategory.PITCHING
// });
//
// enum ThumbnailId { THE_60829_E4_E8045_D12_CA46_AC70_E, THE_607_FCA524_D7_F636_B37078266, THE_607_FB3253_A759624_DE15_C0_DE }
//
// final thumbnailIdValues = EnumValues({
//   "607fb3253a759624de15c0de": ThumbnailId.THE_607_FB3253_A759624_DE15_C0_DE,
//   "607fca524d7f636b37078266": ThumbnailId.THE_607_FCA524_D7_F636_B37078266,
//   "60829e4e8045d12ca46ac70e": ThumbnailId.THE_60829_E4_E8045_D12_CA46_AC70_E
// });
//
// class ThumbnailUrl {
//   ThumbnailUrl({
//     this.url,
//   });
//
//   String url;
//
//   factory ThumbnailUrl.fromJson(Map<String, dynamic> json) => ThumbnailUrl(
//     url: json["url"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "url": url,
//   };
// }
//
// enum UserId { THE_5_FE16_B7089_A5549_B18_D7_ED88 }
//
// final userIdValues = EnumValues({
//   "5fe16b7089a5549b18d7ed88": UserId.THE_5_FE16_B7089_A5549_B18_D7_ED88
// });
//
// enum VideoId { THE_60829_E4_E8045_D12_CA46_AC70_F, THE_607_FCA524_D7_F636_B37078267, THE_607_FB3253_A759624_DE15_C0_DF }
//
// final videoIdValues = EnumValues({
//   "607fb3253a759624de15c0df": VideoId.THE_607_FB3253_A759624_DE15_C0_DF,
//   "607fca524d7f636b37078267": VideoId.THE_607_FCA524_D7_F636_B37078267,
//   "60829e4e8045d12ca46ac70f": VideoId.THE_60829_E4_E8045_D12_CA46_AC70_F
// });
//
// class VideoUrl {
//   VideoUrl({
//     this.videoLink,
//   });
//
//   String videoLink;
//
//   factory VideoUrl.fromJson(Map<String, dynamic> json) => VideoUrl(
//     videoLink: json["videoLink"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "videoLink": videoLink,
//   };
// }
//
// class EnumValues<T> {
//   Map<String, T> map;
//   Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     if (reverseMap == null) {
//       reverseMap = map.map((k, v) => new MapEntry(v, k));
//     }
//     return reverseMap;
//   }
// }





// To parse this JSON data, do
//
//     final farmPlusHome = farmPlusHomeFromJson(jsonString);

// import 'dart:convert';
//
// FarmPlusHome farmPlusHomeFromJson(String str) => FarmPlusHome.fromJson(json.decode(str));
//
// String farmPlusHomeToJson(FarmPlusHome data) => json.encode(data.toJson());
//
// class FarmPlusHome {
//   FarmPlusHome({
//     this.message,
//     this.data,
//   });
//
//   String message;
//   Data data;
//
//   factory FarmPlusHome.fromJson(Map<String, dynamic> json) => FarmPlusHome(
//     message: json["message"],
//     data: Data.fromJson(json["data"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "message": message,
//     "data": data.toJson(),
//   };
// }
//
// class Data {
//   Data({
//     this.categoryList,
//     this.post,
//   });
//
//   List<CategoryList> categoryList;
//   List<Post> post;
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     categoryList: List<CategoryList>.from(json["categoryList"].map((x) => CategoryList.fromJson(x))),
//     post: List<Post>.from(json["post"].map((x) => Post.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "categoryList": List<dynamic>.from(categoryList.map((x) => x.toJson())),
//     "post": List<dynamic>.from(post.map((x) => x.toJson())),
//   };
// }
//
// class CategoryList {
//   CategoryList({
//     this.id,
//     this.categoryName,
//     this.v,
//   });
//
//   String id;
//   String categoryName;
//   int v;
//
//   factory CategoryList.fromJson(Map<String, dynamic> json) => CategoryList(
//     id: json["_id"],
//     categoryName: json["categoryName"],
//     v: json["__v"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "categoryName": categoryName,
//     "__v": v,
//   };
// }
//
// class Post {
//   Post({
//     this.categoryId,
//     this.categoryName,
//     this.categoryContent,
//   });
//
//   String categoryId;
//   String categoryName;
//   List<CategoryContent> categoryContent;
//
//   factory Post.fromJson(Map<String, dynamic> json) => Post(
//     categoryId: json["categoryId"],
//     categoryName: json["categoryName"],
//     categoryContent: List<CategoryContent>.from(json["categoryContent"].map((x) => CategoryContent.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "categoryId": categoryId,
//     "categoryName": categoryName,
//     "categoryContent": List<dynamic>.from(categoryContent.map((x) => x.toJson())),
//   };
// }
//
// class CategoryContent {
//   CategoryContent({
//     this.id,
//     this.category,
//     this.subCategory,
//     this.title,
//     this.bodyText,
//     this.videoId,
//     this.thumbnailId,
//     this.videoUrl,
//     this.thumbnailUrl,
//   });
//
//   String id;
//   String category;
//   String subCategory;
//   String title;
//   String bodyText;
//   String videoId;
//   String thumbnailId;
//   String videoUrl;
//   String thumbnailUrl;
//
//   factory CategoryContent.fromJson(Map<String, dynamic> json) => CategoryContent(
//     id: json["_id"],
//     category: json["category"],
//     subCategory: json["subCategory"],
//     title: json["title"],
//     bodyText: json["bodyText"],
//     videoId: json["videoId"],
//     thumbnailId: json["thumbnailId"],
//     videoUrl: json["videoUrl"],
//     thumbnailUrl: json["thumbnailUrl"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "category": category,
//     "subCategory": subCategory,
//     "title": title,
//     "bodyText": bodyText,
//     "videoId": videoId,
//     "thumbnailId": thumbnailId,
//     "videoUrl": videoUrl,
//     "thumbnailUrl": thumbnailUrl,
//   };
// }
//



//3rd model

// To parse this JSON data, do
//
//     final farmPlusHome = farmPlusHomeFromJson(jsonString);

// import 'dart:convert';
//
// FarmPlusHome farmPlusHomeFromJson(String str) => FarmPlusHome.fromJson(json.decode(str));
//
// String farmPlusHomeToJson(FarmPlusHome data) => json.encode(data.toJson());
//
// class FarmPlusHome {
//   FarmPlusHome({
//     this.message,
//     this.data,
//   });
//
//   String message;
//   Data data;
//
//   factory FarmPlusHome.fromJson(Map<String, dynamic> json) => FarmPlusHome(
//     message: json["message"],
//     data: Data.fromJson(json["data"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "message": message,
//     "data": data.toJson(),
//   };
// }
//
// class Data {
//   Data({
//     this.content,
//     this.categoryList,
//     this.post,
//   });
//
//   List<Content> content;
//   List<CategoryList> categoryList;
//   List<Post> post;
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     content: List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
//     categoryList: List<CategoryList>.from(json["categoryList"].map((x) => CategoryList.fromJson(x))),
//     post: List<Post>.from(json["post"].map((x) => Post.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "content": List<dynamic>.from(content.map((x) => x.toJson())),
//     "categoryList": List<dynamic>.from(categoryList.map((x) => x.toJson())),
//     "post": List<dynamic>.from(post.map((x) => x.toJson())),
//   };
// }
//
// class CategoryList {
//   CategoryList({
//     this.id,
//     this.categoryName,
//     this.v,
//   });
//
//   Id id;
//   String categoryName;
//   int v;
//
//   factory CategoryList.fromJson(Map<String, dynamic> json) => CategoryList(
//     id: idValues.map[json["_id"]],
//     categoryName: json["categoryName"],
//     v: json["__v"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "_id": idValues.reverse[id],
//     "categoryName": categoryName,
//     "__v": v,
//   };
// }
//
// enum Id { THE_60533_FB60837_B55_CA29_A093_B, THE_6051_D9_FC946897328_F21291_A, THE_60533_FB60837_B55_CA29_A093_C, THE_60533_FB60837_B55_CA29_A093_D, THE_60533_FB60837_B55_CA29_A093_E }
//
// final idValues = EnumValues({
//   "6051d9fc946897328f21291a": Id.THE_6051_D9_FC946897328_F21291_A,
//   "60533fb60837b55ca29a093b": Id.THE_60533_FB60837_B55_CA29_A093_B,
//   "60533fb60837b55ca29a093c": Id.THE_60533_FB60837_B55_CA29_A093_C,
//   "60533fb60837b55ca29a093d": Id.THE_60533_FB60837_B55_CA29_A093_D,
//   "60533fb60837b55ca29a093e": Id.THE_60533_FB60837_B55_CA29_A093_E
// });
//
// class Content {
//   Content({
//     this.id,
//     this.title,
//     this.bodyText,
//     this.thumbnailurl,
//   });
//
//   String id;
//   String title;
//   String bodyText;
//   String thumbnailurl;
//
//   factory Content.fromJson(Map<String, dynamic> json) => Content(
//     id: json["_id"],
//     title: json["title"],
//     bodyText: json["bodyText"],
//     thumbnailurl: json["thumbnailurl"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "title": title,
//     "bodyText": bodyText,
//     "thumbnailurl": thumbnailurl,
//   };
// }
//
// class Post {
//   Post({
//     this.categoryId,
//     this.categoryName,
//     this.categoryContent,
//   });
//
//   Id categoryId;
//   String categoryName;
//   List<CategoryContent> categoryContent;
//
//   factory Post.fromJson(Map<String, dynamic> json) => Post(
//     categoryId: idValues.map[json["categoryId"]],
//     categoryName: json["categoryName"],
//     categoryContent: List<CategoryContent>.from(json["categoryContent"].map((x) => CategoryContent.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "categoryId": idValues.reverse[categoryId],
//     "categoryName": categoryName,
//     "categoryContent": List<dynamic>.from(categoryContent.map((x) => x.toJson())),
//   };
// }
//
// class CategoryContent {
//   CategoryContent({
//     this.id,
//     this.category,
//     this.subCategory,
//     this.title,
//     this.bodyText,
//     this.videoId,
//     this.thumbnailId,
//     this.videoUrl,
//     this.thumbnailUrl,
//   });
//
//   String id;
//   Id category;
//   SubCategory subCategory;
//   String title;
//   String bodyText;
//   String videoId;
//   String thumbnailId;
//   String videoUrl;
//   String thumbnailUrl;
//
//   factory CategoryContent.fromJson(Map<String, dynamic> json) => CategoryContent(
//     id: json["_id"],
//     category: idValues.map[json["category"]],
//     subCategory: subCategoryValues.map[json["subCategory"]],
//     title: json["title"],
//     bodyText: json["bodyText"],
//     videoId: json["videoId"],
//     thumbnailId: json["thumbnailId"],
//     videoUrl: json["videoUrl"],
//     thumbnailUrl: json["thumbnailUrl"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "category": idValues.reverse[category],
//     "subCategory": subCategoryValues.reverse[subCategory],
//     "title": title,
//     "bodyText": bodyText,
//     "videoId": videoId,
//     "thumbnailId": thumbnailId,
//     "videoUrl": videoUrl,
//     "thumbnailUrl": thumbnailUrl,
//   };
// }
//
// enum SubCategory { S_P, PITCHING, HITTING, EMPTY }
//
// final subCategoryValues = EnumValues({
//   "": SubCategory.EMPTY,
//   "hitting": SubCategory.HITTING,
//   "pitching": SubCategory.PITCHING,
//   "S+P": SubCategory.S_P
// });
//
// class EnumValues<T> {
//   Map<String, T> map;
//   Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     if (reverseMap == null) {
//       reverseMap = map.map((k, v) => new MapEntry(v, k));
//     }
//     return reverseMap;
//   }
// }

// To parse this JSON data, do
//
//     final farmPlusHome = farmPlusHomeFromJson(jsonString);

import 'dart:convert';

FarmPlusHome farmPlusHomeFromJson(String str) =>
    FarmPlusHome.fromJson(json.decode(str));

String farmPlusHomeToJson(FarmPlusHome data) => json.encode(data.toJson());

class FarmPlusHome {
  FarmPlusHome({
    this.message,
    this.data,
  });

  String message;
  Data data;

  factory FarmPlusHome.fromJson(Map<String, dynamic> json) => FarmPlusHome(
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
    this.post,
  });

  List<Content> content;
  List<CategoryList> categoryList;
  List<Post> post;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    content:
    List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
    categoryList: List<CategoryList>.from(
        json["categoryList"].map((x) => CategoryList.fromJson(x))),
    post: List<Post>.from(json["post"].map((x) => Post.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "content": List<dynamic>.from(content.map((x) => x.toJson())),
    "categoryList": List<dynamic>.from(categoryList.map((x) => x.toJson())),
    "post": List<dynamic>.from(post.map((x) => x.toJson())),
  };
}

class Content {
  Content(
      {this.id,
        this.title,
        this.bodyText,
        this.thumbnailurl,
        this.videoUrl,
        this.categoryName});

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

class CategoryList {
  CategoryList({
    this.id,
    this.categoryName,
    this.v,
  });

  String id;
  String categoryName;
  int v;

  factory CategoryList.fromJson(Map<String, dynamic> json) => CategoryList(
    id: json["_id"],
    categoryName: json["categoryName"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "categoryName": categoryName,
    "__v": v,
  };
}

class Post {
  Post({
    this.categoryId,
    this.categoryName,
    this.categoryContent,
  });

  String categoryId;
  String categoryName;
  List<CategoryContent> categoryContent;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    categoryId: json["categoryId"],
    categoryName: json["categoryName"],
    categoryContent: List<CategoryContent>.from(
        json["categoryContent"].map((x) => CategoryContent.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "categoryId": categoryId,
    "categoryName": categoryName,
    "categoryContent":
    List<dynamic>.from(categoryContent.map((x) => x.toJson())),
  };
}

class CategoryContent {
  CategoryContent({
    this.id,
    this.category,
    this.subCategory,
    this.title,
    this.bodyText,
    this.videoId,
    this.thumbnailId,
    this.videoUrl,
    this.thumbnailUrl,
  });

  String id;
  String category;
  String subCategory;
  String title;
  String bodyText;
  String videoId;
  String thumbnailId;
  String videoUrl;
  String thumbnailUrl;

  factory CategoryContent.fromJson(Map<String, dynamic> json) =>
      CategoryContent(
        id: json["_id"],
        category: json["category"],
        subCategory: json["subCategory"],
        title: json["title"],
        bodyText: json["bodyText"],
        videoId: json["videoId"],
        thumbnailId: json["thumbnailId"],
        videoUrl: json["videoUrl"],
        thumbnailUrl: json["thumbnailUrl"],
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "category": category,
    "subCategory": subCategory,
    "title": title,
    "bodyText": bodyText,
    "videoId": videoId,
    "thumbnailId": thumbnailId,
    "videoUrl": videoUrl,
    "thumbnailUrl": thumbnailUrl,
  };
}
