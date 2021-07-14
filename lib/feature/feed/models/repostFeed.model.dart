// To parse this JSON data, do
//
//     final repostFeedModel = repostFeedModelFromJson(jsonString);

import 'dart:convert';

RepostFeedModel repostFeedModelFromJson(String str) => RepostFeedModel.fromJson(json.decode(str));

String repostFeedModelToJson(RepostFeedModel data) => json.encode(data.toJson());

class RepostFeedModel {
  RepostFeedModel({
    this.message,
  });

  String message;

  factory RepostFeedModel.fromJson(Map<String, dynamic> json) => RepostFeedModel(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}
