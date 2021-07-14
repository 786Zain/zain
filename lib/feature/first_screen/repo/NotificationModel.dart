// To parse this JSON data, do
//
//     final notificatinModel = notificatinModelFromJson(jsonString);

import 'dart:convert';

NotificatinModel notificatinModelFromJson(String str) => NotificatinModel.fromJson(json.decode(str));

String notificatinModelToJson(NotificatinModel data) => json.encode(data.toJson());

class NotificatinModel {
  NotificatinModel({
    this.message,
    this.data,
    this.isNotSeenCount,
    this.notificationAlert,
  });

  String message;
  List<Datum> data;
  int isNotSeenCount;
  bool notificationAlert;

  factory NotificatinModel.fromJson(Map<String, dynamic> json) => NotificatinModel(
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    isNotSeenCount: json["isNotSeenCount"],
    notificationAlert: json["notificationAlert"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "isNotSeenCount": isNotSeenCount,
    "notificationAlert": notificationAlert,
  };
}

class Datum {
  Datum({
    this.id,
    this.isSeen,
    this.userId,
    this.guestId,
    this.activityType,
    this.referenceId,
    this.text,
    this.name,
    this.userName,
    this.createdAt,
    this.profilePic,
  });

  String id;
  bool isSeen;
  String userId;
  String guestId;
  String activityType;
  String referenceId;
  String text;
  String name;
  String userName;
  DateTime createdAt;
  String profilePic;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    isSeen: json["isSeen"],
    userId: json["userId"],
    guestId: json["guestId"],
    activityType: json["activityType"],
    referenceId: json["referenceId"],
    text: json["text"],
    name: json["name"],
    userName: json["userName"],
    createdAt: DateTime.parse(json["createdAt"]),
    profilePic: json["profilePic"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "isSeen": isSeen,
    "userId": userId,
    "guestId": guestId,
    "activityType": activityType,
    "referenceId": referenceId,
    "text": text,
    "name": name,
    "userName": userName,
    "createdAt": createdAt.toIso8601String(),
    "profilePic": profilePic,
  };
}
