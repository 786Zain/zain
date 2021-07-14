// To parse this JSON data, do
//
//     final followModel = followModelFromJson(jsonString);

import 'dart:convert';

FollowModel followModelFromJson(String str) => FollowModel.fromJson(json.decode(str));

String followModelToJson(FollowModel data) => json.encode(data.toJson());

class FollowModel {
    FollowModel({
        this.message,
    });

    String message;

    factory FollowModel.fromJson(Map<String, dynamic> json) => FollowModel(
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
    };
}
