import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String? fullname;
  final String? email;
  final String? username;
  final String? password;
  final String? noTelp;
  final String? gender;
  final DateTime? tglLahir;
  final String? pekerjaan;
  final String? institusi;
  final String? provinsi;

  UserModel({
    this.id,
    this.fullname,
    this.email,
    this.username,
    this.password,
    this.noTelp,
    this.gender,
    this.tglLahir,
    this.pekerjaan,
    this.institusi,
    this.provinsi,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      fullname: data['fullname'],
      email: data['Email'],
      username: data['username'],
      password: data['password'],
      noTelp: data['noTelp'],
      gender: data['Gender'],
      tglLahir: data['Tanggal Lahir'] != null
          ? DateTime.parse(data['Tanggal Lahir'])
          : null,
      pekerjaan: data['pekerjaan'],
      institusi: data['institusi'],
      provinsi: data['provinsi'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullname': fullname,
      'email': email,
      'username': username,
      'password': password,
      'noTelphone': noTelp,
      'gender': gender,
      'tgl_lahir': tglLahir != null ? tglLahir!.toIso8601String() : null,
      'pekerjaan': pekerjaan,
      'institusi': institusi,
      'provinsi': provinsi,
    };
  }
}
