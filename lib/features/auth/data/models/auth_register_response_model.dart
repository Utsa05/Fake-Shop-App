// To parse this JSON data, do
//
//     final authRegisterResposneModel = authRegisterResposneModelFromJson(jsonString);

import 'dart:convert';

import 'package:cart_product_ca_app/features/auth/domain/entities/auth_register_param.dart';

AuthRegisterResposneModel authRegisterResposneModelFromJson(String str) =>
    AuthRegisterResposneModel.fromJson(json.decode(str));

String authRegisterResposneModelToJson(AuthRegisterResposneModel data) =>
    json.encode(data.toJson());

class AuthRegisterResposneModel extends AuthRegisterParam {
  AuthRegisterResposneModel({
    required super.id,
    required super.username,
    required super.email,
    required super.password,
  });

  factory AuthRegisterResposneModel.fromJson(Map<String, dynamic> json) =>
      AuthRegisterResposneModel(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "password": password,
      };
}
