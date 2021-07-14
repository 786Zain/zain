// To parse this JSON data, do
//
//     final farmCategoryPost = farmCategoryPostFromJson(jsonString);

import 'dart:convert';

FarmCategoryPost farmCategoryPostFromJson(String str) => FarmCategoryPost.fromJson(json.decode(str));

String farmCategoryPostToJson(FarmCategoryPost data) => json.encode(data.toJson());

class FarmCategoryPost {
  FarmCategoryPost({
    this.message,
    this.data,
  });

  String message;
  CategoryData data;

  factory FarmCategoryPost.fromJson(Map<String, dynamic> json) => FarmCategoryPost(
    message: json["message"],
    data: CategoryData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data.toJson(),
  };
}

class CategoryData {
  CategoryData({
    this.post,
  });

  List<Post> post;

  factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
    post: List<Post>.from(json["post"].map((x) => Post.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "post": List<dynamic>.from(post.map((x) => x.toJson())),
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
