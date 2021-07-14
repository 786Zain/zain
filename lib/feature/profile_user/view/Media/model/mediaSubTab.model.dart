// To parse this JSON data, do
//
//     final profileCategoriesDetails = profileCategoriesDetailsFromJson(jsonString);

import 'dart:convert';

MediaCategoriesDetails mediaCategoriesDetailsFromJson(String str) => MediaCategoriesDetails.fromJson(json.decode(str));

String mediaCategoriesDetailsToJson(MediaCategoriesDetails data) => json.encode(data.toJson());

class MediaCategoriesDetails {
  MediaCategoriesDetails({
    this.message,
    this.data,
  });

  String message;
  List<mediaCategory> data;

  factory MediaCategoriesDetails.fromJson(Map<String, dynamic> json) => MediaCategoriesDetails(
    message: json["message"],
    data: List<mediaCategory>.from(json["data"].map((x) => mediaCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class mediaCategory {
  mediaCategory({
    this.isMainCategory,
    this.id,
    this.categoryName,
  });

  bool isMainCategory;
  String id;
  String categoryName;

  factory mediaCategory.fromJson(Map<String, dynamic> json) => mediaCategory(
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
