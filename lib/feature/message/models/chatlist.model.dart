// To parse this JSON data, do
//
//     final chatList = chatListFromJson(jsonString);

import 'dart:convert';

ChatList chatListFromJson(String str) => ChatList.fromJson(json.decode(str));

String chatListToJson(ChatList data) => json.encode(data.toJson());

class ChatList {
  ChatList({
    this.message,
    this.data,
    this.count,
    this.isNotificationDisabled,
  });

  String message;
  List<Chat> data;
  int count;
  bool isNotificationDisabled;

  factory ChatList.fromJson(Map<String, dynamic> json) => ChatList(
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<Chat>.from(json["data"].map((x) => Chat.fromJson(x))),
    count: json["count"] == null ? null : json["count"],
    isNotificationDisabled: json["isNotificationDisabled"] == null ? null : json["isNotificationDisabled"],
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    "count": count == null ? null : count,
    "isNotificationDisabled": isNotificationDisabled == null ? null : isNotificationDisabled,
  };
}

class Chat {
  Chat({
    this.id,
    this.conversationId,
    this.messageBody,
    this.messageMedia,
    this.createdAt,
    this.iaMsender,
  });

  String id;
  String conversationId;
  String messageBody;
  String messageMedia;
  DateTime createdAt;
  bool iaMsender;

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
    id: json["_id"] == null ? null : json["_id"],
    conversationId: json["conversationId"] == null ? null : json["conversationId"],
    messageBody: json["messageBody"] == null ? null : json["messageBody"],
    messageMedia: json["messageMedia"] == null ? null : json["messageMedia"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    iaMsender: json["IAMsender"] == null ? null : json["IAMsender"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "conversationId": conversationId == null ? null : conversationId,
    "messageBody": messageBody == null ? null : messageBody,
    "messageMedia": messageMedia == null ? null : messageMedia,
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    "IAMsender": iaMsender == null ? null : iaMsender,
  };
}
