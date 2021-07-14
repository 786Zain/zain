// To parse this JSON data, do
//
//     final courseSearch = courseSearchFromJson(jsonString);

import 'dart:convert';

CourseSearch courseSearchFromJson(String str) => CourseSearch.fromJson(json.decode(str));

String courseSearchToJson(CourseSearch data) => json.encode(data.toJson());

class CourseSearch {
  CourseSearch({
    this.message,
    this.data,
  });

  String message;
  List<Datum> data;

  factory CourseSearch.fromJson(Map<String, dynamic> json) => CourseSearch(
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
    this.id,
    this.courseName,
    this.courseCover,
    this.createdAt,
    this.v,
  });

  String id;
  String courseName;
  String courseCover;
  DateTime createdAt;
  int v;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    courseName: json["courseName"],
    courseCover: json["courseCover"],
    createdAt: DateTime.parse(json["createdAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "courseName": courseName,
    "courseCover": courseCover,
    "createdAt": createdAt.toIso8601String(),
    "__v": v,
  };
}
