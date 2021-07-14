// To parse this JSON data, do
//
//     final followsList = followsListFromJson(jsonString);

import 'dart:convert';

FollowsList followsListFromJson(String str) => FollowsList.fromJson(json.decode(str));

String followsListToJson(FollowsList data) => json.encode(data.toJson());

class FollowsList {
  FollowsList({
    this.message,
    this.data,
  });

  String message;
  List<Follows> data;

  factory FollowsList.fromJson(Map<String, dynamic> json) => FollowsList(
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<Follows>.from(json["data"].map((x) => Follows.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Follows {
  Follows({
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

  factory Follows.fromJson(Map<String, dynamic> json) => Follows(
    id: json["_id"] == null ? null : json["_id"],
    isFollowing: json["isFollowing"] == null ? null : json["isFollowing"],
    profilePic: json["profilePic"] == null ? null : json["profilePic"],
    userName: json["userName"] == null ? null : json["userName"],
    name: json["name"] == null ? null : json["name"],
    bio: json["bio"] == null ? null : json["bio"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "isFollowing": isFollowing == null ? null : isFollowing,
    "profilePic": profilePic == null ? null : profilePic,
    "userName": userName == null ? null : userName,
    "name": name == null ? null : name,
    "bio": bio == null ? null : bio,
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
  };
}


