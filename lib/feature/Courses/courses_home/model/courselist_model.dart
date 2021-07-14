// To parse this JSON data, do
//
//     final getCourseList = getCourseListFromJson(jsonString);

import 'dart:convert';

GetCourseList getCourseListFromJson(String str) => GetCourseList.fromJson(json.decode(str));

String getCourseListToJson(GetCourseList data) => json.encode(data.toJson());

class GetCourseList {
  GetCourseList({
    this.courseList,
    this.message,
  });

  List<CourseList> courseList;
  String message;

  factory GetCourseList.fromJson(Map<String, dynamic> json) => GetCourseList(
    courseList: List<CourseList>.from(json["courseList"].map((x) => CourseList.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "courseList": List<dynamic>.from(courseList.map((x) => x.toJson())),
    "message": message,
  };
}

class CourseList {
  CourseList({
    this.id,
    this.courseName,
    this.createdAt,
    this.v,
    this.courseCover,
  });

  String id;
  String courseName;
  DateTime createdAt;
  int v;
  String courseCover;

  factory CourseList.fromJson(Map<String, dynamic> json) => CourseList(
    id: json["_id"],
    courseName: json["courseName"],
    createdAt: DateTime.parse(json["createdAt"]),
    v: json["__v"],
    courseCover: json["courseCover"] == null ? null : json["courseCover"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "courseName": courseName,
    "createdAt": createdAt.toIso8601String(),
    "__v": v,
    "courseCover": courseCover == null ? null : courseCover,
  };
}
