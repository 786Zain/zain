// To parse this JSON data, do
//
//     final profileCategoriesDetails = profileCategoriesDetailsFromJson(jsonString);

import 'dart:convert';

ProfileCategoriesDetails profileCategoriesDetailsFromJson(String str) => ProfileCategoriesDetails.fromJson(json.decode(str));

String profileCategoriesDetailsToJson(ProfileCategoriesDetails data) => json.encode(data.toJson());

class ProfileCategoriesDetails {
  ProfileCategoriesDetails({
    this.message,
    this.data,
  });

  String message;
  List<Datum> data;

  factory ProfileCategoriesDetails.fromJson(Map<String, dynamic> json) => ProfileCategoriesDetails(
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
    this.id,
    this.categoryName,
  });

  bool isMainCategory;
  String id;
  String categoryName;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
