// To parse this JSON data, do
//
//     final saveSearch = saveSearchFromJson(jsonString);

import 'dart:convert';

SaveSearch saveSearchFromJson(String str) => SaveSearch.fromJson(json.decode(str));

String saveSearchToJson(SaveSearch data) => json.encode(data.toJson());

class SaveSearch {
  SaveSearch({
    this.message,
  });

  String message;

  factory SaveSearch.fromJson(Map<String, dynamic> json) => SaveSearch(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}
