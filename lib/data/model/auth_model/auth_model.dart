// To parse this JSON data, do
//
//     final auth = authFromJson(jsonString);

import 'dart:convert';

Auth authFromJson(String str) => Auth.fromJson(json.decode(str));

String authToJson(Auth data) => json.encode(data.toJson());

class Auth {
    bool? status;
    String? message;
    String? username;
    String? email;
    String? token;

    Auth({
         this.status,
         this.message,
         this.username,
         this.email,
         this.token,
    });

    factory Auth.fromJson(Map<String, dynamic> json) => Auth(
        status: json["status"],
        message: json["message"],
        username: json["username"],
        email: json["email"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "username": username,
        "email": email,
        "token": token,
    };
}
