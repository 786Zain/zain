// To parse this JSON data, do
//
//     final discSearch = discSearchFromJson(jsonString);

import 'dart:convert';

DiscSearch discSearchFromJson(String str) => DiscSearch.fromJson(json.decode(str));

String discSearchToJson(DiscSearch data) => json.encode(data.toJson());

class DiscSearch {
  DiscSearch({
    this.message,
    this.data,
  });

  String message;
  List<Datum> data;

  factory DiscSearch.fromJson(Map<String, dynamic> json) => DiscSearch(
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
    this.isFollowing,
    this.profilePic,
    this.userName,
    this.name,
    this.bio,
    this.createdAt,
  });

  String id;
  bool isFollowing;
  String profilePic;
  String userName;
  String name;
  String bio;
  DateTime createdAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    isFollowing: json["isFollowing"],
    profilePic: json["profilePic"],
    userName: json["userName"],
    name: json["name"],
    bio: json["bio"],
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "isFollowing": isFollowing,
    "profilePic": profilePic,
    "userName": userName,
    "name": name,
    "bio": bio,
    "createdAt": createdAt.toIso8601String(),
  };
}
