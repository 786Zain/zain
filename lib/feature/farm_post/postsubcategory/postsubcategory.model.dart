// To parse this JSON data, do
//
//     final subPostCategory = subPostCategoryFromJson(jsonString);

import 'dart:convert';

SubPostCategory subPostCategoryFromJson(String str) => SubPostCategory.fromJson(json.decode(str));

String subPostCategoryToJson(SubPostCategory data) => json.encode(data.toJson());

class SubPostCategory {
  SubPostCategory({
    this.message,
    this.data,
  });

  String message;
  List<Datum> data;

  factory SubPostCategory.fromJson(Map<String, dynamic> json) => SubPostCategory(
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
    this.postCount,
    this.id,
    this.subCategoryName,
  });

  int postCount;
  String id;
  String subCategoryName;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    postCount: json["postCount"],
    id: json["_id"],
    subCategoryName: json["subCategoryName"],
  );

  Map<String, dynamic> toJson() => {
    "postCount": postCount,
    "_id": id,
    "subCategoryName": subCategoryName,
  };
}
