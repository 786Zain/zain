// To parse this JSON data, do
//
//     final moduleSearch = moduleSearchFromJson(jsonString);

import 'dart:convert';

ModuleSearch moduleSearchFromJson(String str) => ModuleSearch.fromJson(json.decode(str));

String moduleSearchToJson(ModuleSearch data) => json.encode(data.toJson());

class ModuleSearch {
  ModuleSearch({
    this.message,
    this.Contents,
    this.paginationCount,
  });

  String message;
  List<ContentModule> Contents;
  int paginationCount;

  factory ModuleSearch.fromJson(Map<String, dynamic> json) => ModuleSearch(
    message: json["message"],
    Contents: List<ContentModule>.from(json["Contents"].map((x) => ContentModule.fromJson(x))),
    paginationCount: json["PaginationCount"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "Contents": List<dynamic>.from(Contents.map((x) => x.toJson())),
    "PaginationCount": paginationCount,
  };
}

class ContentModule {
  ContentModule({
    this.id,
    this.moduleName,
    this.moduleCover,
    this.type,
    this.createdAt,
  });

  String id;
  String moduleName;
  String moduleCover;
  String type;
  DateTime createdAt;

  factory ContentModule.fromJson(Map<String, dynamic> json) => ContentModule(
    id: json["_id"],
    moduleName: json["moduleName"],
    moduleCover: json["moduleCover"],
    type: json["type"],
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "moduleName": moduleName,
    "moduleCover": moduleCover,
    "type": type,
    "createdAt": createdAt.toIso8601String(),
  };
}
