// To parse this JSON data, do
//
//     final postCategory = postCategoryFromJson(jsonString);

import 'dart:convert';

PostCategory postCategoryFromJson(String str) => PostCategory.fromJson(json.decode(str));

String postCategoryToJson(PostCategory data) => json.encode(data.toJson());

class PostCategory {
  PostCategory({
    this.message,
    this.data,
  });

  String message;
  List<Datum> data;

  factory PostCategory.fromJson(Map<String, dynamic> json) => PostCategory(
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
    this.isMainCategory,
    this.postCount,
    this.id,
    this.categoryName,
  });

  bool isMainCategory;
  int postCount;
  String id;
  String categoryName;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    isMainCategory: json["isMainCategory"],
    postCount: json["postCount"],
    id: json["_id"],
    categoryName: json["categoryName"],
  );

  Map<String, dynamic> toJson() => {
    "isMainCategory": isMainCategory,
    "postCount": postCount,
    "_id": id,
    "categoryName": categoryName,
  };
}
