// To parse this JSON data, do
//
//     final conversationList = conversationListFromJson(jsonString);

import 'dart:convert';

ConversationList conversationListFromJson(String str) =>
    ConversationList.fromJson(json.decode(str));

String conversationListToJson(ConversationList data) =>
    json.encode(data.toJson());

class ConversationList {
  ConversationList({
    this.message,
    this.data,
    this.count,
  });

  String message;
  List<Datum> data;
  int count;

  factory ConversationList.fromJson(Map<String, dynamic> json) =>
      ConversationList(
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        count: json["count"] == null ? null : json["count"],
      );

  Map<String, dynamic> toJson() => {
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
        "count": count == null ? null : count,
      };
}

class Datum {
  Datum({
    this.id,
    this.userDetails,
    this.lastMessage,
    this.isSeen,
    this.createdAt,
  });

  String id;
  UserDetails userDetails;
  String lastMessage;
  bool isSeen;
  DateTime createdAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"] == null ? null : json["_id"],
        userDetails: json["userDetails"] == null
            ? null
            : UserDetails.fromJson(json["userDetails"]),
        lastMessage: json["lastMessage"] == null ? null : json["lastMessage"],
        isSeen: json["isSeen"] == null ? null : json["isSeen"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "userDetails": userDetails == null ? null : userDetails.toJson(),
        "lastMessage": lastMessage == null ? null : lastMessage,
        "isSeen": isSeen == null ? null : isSeen,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
      };
}

class UserDetails {
  UserDetails({
    this.id,
    this.userName,
    this.userPic,
  });

  String id;
  String userName;
  String userPic;

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        id: json["_id"] == null ? null : json["_id"],
        userName: json["userName"] == null ? null : json["userName"],
        userPic: json["userPic"] == null ? null : json["userPic"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "userName": userName == null ? null : userName,
        "userPic": userPic == null ? null : userPic,
      };
}
