// To parse this JSON data, do
//
//     final farmSubCategoryList = farmSubCategoryListFromJson(jsonString);

import 'dart:convert';

FarmSubCategoryList farmSubCategoryListFromJson(String str) => FarmSubCategoryList.fromJson(json.decode(str));

String farmSubCategoryListToJson(FarmSubCategoryList data) => json.encode(data.toJson());

class FarmSubCategoryList {
  FarmSubCategoryList({
    this.message,
    this.data,
  });

  String message;
  SubCategoryData data;

  factory FarmSubCategoryList.fromJson(Map<String, dynamic> json) => FarmSubCategoryList(
    message: json["message"],
    data: SubCategoryData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data.toJson(),
  };
}

class SubCategoryData {
  SubCategoryData({
    this.categoryList,
    this.post,
  });

  List<CategoryList> categoryList;
  List<Post> post;

  factory SubCategoryData.fromJson(Map<String, dynamic> json) => SubCategoryData(
    categoryList: List<CategoryList>.from(json["categoryList"].map((x) => CategoryList.fromJson(x))),
    post: List<Post>.from(json["post"].map((x) => Post.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "categoryList": List<dynamic>.from(categoryList.map((x) => x.toJson())),
    "post": List<dynamic>.from(post.map((x) => x.toJson())),
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
  String v;

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
    categoryContent: List<CategoryContent>.from(json["categoryContent"].map((x) => CategoryContent.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "categoryId": categoryId,
    "categoryName": categoryName,
    "categoryContent": List<dynamic>.from(categoryContent.map((x) => x.toJson())),
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

  factory CategoryContent.fromJson(Map<String, dynamic> json) => CategoryContent(
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
