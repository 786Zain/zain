// To parse this JSON data, do
//
//     final profileCategoriesDetails = profileCategoriesDetailsFromJson(jsonString);

import 'dart:convert';

LikeCategoriesDetails likeCategoriesDetailsFromJson(String str) => LikeCategoriesDetails.fromJson(json.decode(str));

String likeCategoriesDetailsToJson(LikeCategoriesDetails data) => json.encode(data.toJson());

class LikeCategoriesDetails {
  LikeCategoriesDetails({
    this.message,
    this.data,
  });

  String message;
  List<likeCategory> data;

  factory LikeCategoriesDetails.fromJson(Map<String, dynamic> json) => LikeCategoriesDetails(
    message: json["message"],
    data: List<likeCategory>.from(json["data"].map((x) => likeCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class likeCategory {
  likeCategory({
    this.isMainCategory,
    this.id,
    this.categoryName,
  });

  bool isMainCategory;
  String id;
  String categoryName;

  factory likeCategory.fromJson(Map<String, dynamic> json) => likeCategory(
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
