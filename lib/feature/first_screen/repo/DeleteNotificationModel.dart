// To parse this JSON data, do
//
//     final clearNotification = clearNotificationFromJson(jsonString);

import 'dart:convert';

ClearNotification clearNotificationFromJson(String str) => ClearNotification.fromJson(json.decode(str));

String clearNotificationToJson(ClearNotification data) => json.encode(data.toJson());

class ClearNotification {
  ClearNotification({
    this.message,
    this.deletedRecords,
  });

  String message;
  int deletedRecords;

  factory ClearNotification.fromJson(Map<String, dynamic> json) => ClearNotification(
    message: json["message"],
    deletedRecords: json["Deleted Records"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "Deleted Records": deletedRecords,
  };
}
