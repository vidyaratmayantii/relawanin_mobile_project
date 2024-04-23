// To parse this JSON data, do
//
//     final relawan = relawanFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Relawan relawanFromMap(String str) => Relawan.fromMap(json.decode(str));

String relawanToMap(Relawan data) => json.encode(data.toMap());

class Relawan {
    final int? usrId;
    final String? fullname;
    final String? username;
    final String? email;
    final String? usrPass;

    Relawan({
        this.usrId,
        this.fullname,
        this.username,
        this.email,
        this.usrPass,
    });

    factory Relawan.fromMap(Map<String, dynamic> json) => Relawan(
        usrId: json["usrId"],
        fullname: json["fullname"],
        username: json["username"],
        email: json["email"],
        usrPass: json["usrPass"],
    );

    Map<String, dynamic> toMap() => {
        "usrId": usrId,
        "fullname": fullname,
        "username": username,
        "email": email,
        "usrPass": usrPass,
    };
}
