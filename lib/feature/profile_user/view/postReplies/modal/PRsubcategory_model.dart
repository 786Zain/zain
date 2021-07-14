// To parse this JSON data, do
//
//     final profileCategoriesDetails = profileCategoriesDetailsFromJson(jsonString);

import 'dart:convert';

PostReplyCategoriesDetails postReplyCategoriesDetailsFromJson(String str) => PostReplyCategoriesDetails.fromJson(json.decode(str));

String PostReplyCategoriesDetailsToJson(PostReplyCategoriesDetails data) => json.encode(data.toJson());

class PostReplyCategoriesDetails {
  PostReplyCategoriesDetails({
    this.message,
    this.data,
  });

  String message;
  List<postreplyCategory> data;

  factory PostReplyCategoriesDetails.fromJson(Map<String, dynamic> json) => PostReplyCategoriesDetails(
    message: json["message"],
    data: List<postreplyCategory>.from(json["data"].map((x) => postreplyCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class postreplyCategory {
  postreplyCategory({
    this.isMainCategory,
    this.id,
    this.categoryName,
  });

  bool isMainCategory;
  String id;
  String categoryName;

  factory postreplyCategory.fromJson(Map<String, dynamic> json) => postreplyCategory(
    isMainCategory: json["isMainCategory"],
    id: json["_id"],
    categoryName: json["categoryName"],
  );

  Map<String, dynamic> toJson() => {
    "isMainCategory": isMainCategory,
    "_id": id,
    "categoryName": categoryName,
  };
}
