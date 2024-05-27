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
  final String? umur; // Tambahkan bidang umur
  final String? hp;   // Tambahkan bidang hp

  Relawan({
    this.usrId,
    this.fullname,
    this.username,
    this.email,
    this.usrPass,
    this.umur,
    this.hp,
  });

  factory Relawan.fromMap(Map<String, dynamic> json) => Relawan(
        usrId: json["usrId"],
        fullname: json["fullname"],
        username: json["username"],
        email: json["email"],
        usrPass: json["usrPass"],
        umur: json["umur"], // Ambil nilai umur dari JSON
        hp: json["hp"],     // Ambil nilai hp dari JSON
      );

  Map<String, dynamic> toMap() => {
        "usrId": usrId,
        "fullname": fullname,
        "username": username,
        "email": email,
        "usrPass": usrPass,
        "umur": umur, // Tambahkan nilai umur ke dalam JSON
        "hp": hp,     // Tambahkan nilai hp ke dalam JSON
      };
}
