// To parse this JSON data, do
//
//     final farmPlusCategory = farmPlusCategoryFromJson(jsonString);

import 'dart:convert';

FarmPlusCategory farmPlusCategoryFromJson(String str) => FarmPlusCategory.fromJson(json.decode(str));

String farmPlusCategoryToJson(FarmPlusCategory data) => json.encode(data.toJson());

class FarmPlusCategory {
  FarmPlusCategory({
    this.data,
    this.message,
  });

  List<Datum> data;
  String message;

  factory FarmPlusCategory.fromJson(Map<String, dynamic> json) => FarmPlusCategory(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
  };
}

class Datum {
  Datum({
    this.id,
    this.categoryName,
    this.v,
  });

  String id;
  String categoryName;
  int v;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
