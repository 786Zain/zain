// // To parse this JSON data, do
// //
// //     final getCourseListlesson = getCourseListlessonFromJson(jsonString);
//
// import 'dart:convert';
//
// GetCourseListlesson getCourseListlessonFromJson(String str) => GetCourseListlesson.fromJson(json.decode(str));
//
// String getCourseListlessonToJson(GetCourseListlesson data) => json.encode(data.toJson());
//
// class GetCourseListlesson {
//   GetCourseListlesson({
//     this.courseList,
//     this.message,
//     this.list,
//     this.count,
//   });
//
//   List<CourseList> courseList;
//   String message;
//   List<ListElement> list;
//   int count;
//
//   factory GetCourseListlesson.fromJson(Map<String, dynamic> json) => GetCourseListlesson(
//     courseList: List<CourseList>.from(json["courseList"].map((x) => CourseList.fromJson(x))),
//     message: json["message"],
//     list: List<ListElement>.from(json["List"].map((x) => ListElement.fromJson(x))),
//     count: json["Count"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "courseList": List<dynamic>.from(courseList.map((x) => x.toJson())),
//     "message": message,
//     "List": List<dynamic>.from(list.map((x) => x.toJson())),
//     "Count": count,
//   };
// }
//
// class CourseList {
//   CourseList({
//     this.id,
//     this.courseName,
//     this.createdAt,
//     this.v,
//     this.courseCover,
//   });
//
//   String id;
//   String courseName;
//   DateTime createdAt;
//   int v;
//   String courseCover;
//
//   factory CourseList.fromJson(Map<String, dynamic> json) => CourseList(
//     id: json["_id"],
//     courseName: json["courseName"],
//     createdAt: DateTime.parse(json["createdAt"]),
//     v: json["__v"],
//     courseCover: json["courseCover"] == null ? null : json["courseCover"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "courseName": courseName,
//     "createdAt": createdAt.toIso8601String(),
//     "__v": v,
//     "courseCover": courseCover == null ? null : courseCover,
//   };
// }
//
// class ListElement {
//   ListElement({
//     this.id,
//     this.userId,
//     this.courseId,
//     this.module,
//     this.title,
//     this.bodyText,
//     this.videoId,
//     this.thumbnailId,
//     this.createdAt,
//     this.v,
//     this.courseName,
//     this.videoUrl,
//     this.thumbnailUrl,
//   });
//
//   String id;
//   String userId;
//   String courseId;
//   String module;
//   String title;
//   String bodyText;
//   String videoId;
//   String thumbnailId;
//   DateTime createdAt;
//   int v;
//   List<CourseName> courseName;
//   List<VideoUrl> videoUrl;
//   List<ThumbnailUrl> thumbnailUrl;
//
//   factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
//     id: json["_id"],
//     userId: json["userId"],
//     courseId: json["courseId"],
//     module: json["module"],
//     title: json["title"],
//     bodyText: json["bodyText"],
//     videoId: json["videoId"],
//     thumbnailId: json["thumbnailId"],
//     createdAt: DateTime.parse(json["createdAt"]),
//     v: json["__v"],
//     courseName: List<CourseName>.from(json["courseName"].map((x) => CourseName.fromJson(x))),
//     videoUrl: List<VideoUrl>.from(json["videoUrl"].map((x) => VideoUrl.fromJson(x))),
//     thumbnailUrl: List<ThumbnailUrl>.from(json["thumbnailUrl"].map((x) => ThumbnailUrl.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "userId": userId,
//     "courseId": courseId,
//     "module": module,
//     "title": title,
//     "bodyText": bodyText,
//     "videoId": videoId,
//     "thumbnailId": thumbnailId,
//     "createdAt": createdAt.toIso8601String(),
//     "__v": v,
//     "courseName": List<dynamic>.from(courseName.map((x) => x.toJson())),
//     "videoUrl": List<dynamic>.from(videoUrl.map((x) => x.toJson())),
//     "thumbnailUrl": List<dynamic>.from(thumbnailUrl.map((x) => x.toJson())),
//   };
// }
//
// class CourseName {
//   CourseName({
//     this.courseName,
//   });
//
//   String courseName;
//
//   factory CourseName.fromJson(Map<String, dynamic> json) => CourseName(
//     courseName: json["courseName"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "courseName": courseName,
//   };
// }
//
// class ThumbnailUrl {
//   ThumbnailUrl({
//     this.url,
//   });
//
//   String url;
//
//   factory ThumbnailUrl.fromJson(Map<String, dynamic> json) => ThumbnailUrl(
//     url: json["url"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "url": url,
//   };
// }
//
// class VideoUrl {
//   VideoUrl({
//     this.videoLink,
//   });
//
//   String videoLink;
//
//   factory VideoUrl.fromJson(Map<String, dynamic> json) => VideoUrl(
//     videoLink: json["videoLink"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "videoLink": videoLink,
//   };
// }


// To parse this JSON data, do
//
//     final insideCorseList = insideCorseListFromJson(jsonString);

// To parse this JSON data, do
//
//     final insideCorseList = insideCorseListFromJson(jsonString);

import 'dart:convert';

InsideCorseList insideCorseListFromJson(String str) => InsideCorseList.fromJson(json.decode(str));

String insideCorseListToJson(InsideCorseList data) => json.encode(data.toJson());

class InsideCorseList {
  InsideCorseList({
    this.message,
    this.contents,
    this.paginationCount,
  });

  String message;
  List<Content> contents;
  int paginationCount;

  factory InsideCorseList.fromJson(Map<String, dynamic> json) => InsideCorseList(
    message: json["message"],
    contents: List<Content>.from(json["Contents"].map((x) => Content.fromJson(x))),
    paginationCount: json["PaginationCount"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "Contents": List<dynamic>.from(contents.map((x) => x.toJson())),
    "PaginationCount": paginationCount,
  };
}

class Content {
  Content({
    this.id,
    this.title,
    this.videoLink,
    this.thumbnailUrl,
    this.bodyText,
    this.type,
    this.userId,
    this.courseId,
    this.moduleId,
    this.moduleName,
    this.videoId,
    this.thumbnailId,
    this.createdAt,
    this.moduleCover,
  });

  String id;
  String title;
  String videoLink;
  String thumbnailUrl;
  String bodyText;
  String type;
  String userId;
  String courseId;
  String moduleId;
  String moduleName;
  String videoId;
  String thumbnailId;
  DateTime createdAt;
  String moduleCover;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    id: json["_id"],
    title: json["title"] == null ? null : json["title"],
    videoLink: json["videoLink"] == null ? null : json["videoLink"],
    thumbnailUrl: json["thumbnailUrl"] == null ? null : json["thumbnailUrl"],
    bodyText: json["bodyText"] == null ? null : json["bodyText"],
    type: json["type"],
    userId: json["userId"] == null ? null : json["userId"],
    courseId: json["courseId"],
    moduleId: json["moduleId"] == null ? null : json["moduleId"],
    moduleName: json["moduleName"],
    videoId: json["videoId"] == null ? null : json["videoId"],
    thumbnailId: json["thumbnailId"] == null ? null : json["thumbnailId"],
    createdAt: DateTime.parse(json["createdAt"]),
    moduleCover: json["moduleCover"] == null ? null : json["moduleCover"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title == null ? null : title,
    "videoLink": videoLink == null ? null : videoLink,
    "thumbnailUrl": thumbnailUrl == null ? null : thumbnailUrl,
    "bodyText": bodyText == null ? null : bodyText,
    "type": type,
    "userId": userId == null ? null : userId,
    "courseId": courseId,
    "moduleId": moduleId == null ? null : moduleId,
    "moduleName": moduleName,
    "videoId": videoId == null ? null : videoId,
    "thumbnailId": thumbnailId == null ? null : thumbnailId,
    "createdAt": createdAt.toIso8601String(),
    "moduleCover": moduleCover == null ? null : moduleCover,
  };
}

