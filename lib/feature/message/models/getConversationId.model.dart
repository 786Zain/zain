// To parse this JSON data, do
//
//     final getConversationId = getConversationIdFromJson(jsonString);

import 'dart:convert';

GetConversationId getConversationIdFromJson(String str) => GetConversationId.fromJson(json.decode(str));

String getConversationIdToJson(GetConversationId data) => json.encode(data.toJson());

class GetConversationId {
  GetConversationId({
    this.message,
    this.id,
  });

  String message;
  String id;

  factory GetConversationId.fromJson(Map<String, dynamic> json) => GetConversationId(
    message: json["message"] == null ? null : json["message"],
    id: json["_id"] == null ? null : json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "_id": id == null ? null : id,
  };
}
