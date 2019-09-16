import 'dart:convert';

import 'package:mini_curso_flutter/shared/model/user_model.dart';

MessageModel messageModelFromJson(String str) =>
    MessageModel.fromJson(json.decode(str));

String messageModelToJson(MessageModel data) => json.encode(data.toJson());

class MessageModel {
  int id;
  String message;
  UserModel user;

  MessageModel({this.id, this.message, this.user});

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
      id: json["id"],
      message: json["message"],
      user: UserModel.fromJson(json["user"]));

  static List<MessageModel> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => MessageModel.fromJson(item)).toList();
  }

  Map<String, dynamic> toJson() =>
      {"id": id, "message": message, "user": user.toJson()};
}
