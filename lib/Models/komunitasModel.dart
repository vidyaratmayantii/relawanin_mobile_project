import 'package:cloud_firestore/cloud_firestore.dart';

class Komunitasmodel {
  final String? id;
  final String? email;
  final String? username;
  final String? password;
  final String? noTelp;
  final DateTime? tglTerbentuk;
  final String? provinsi;
  final String? bidang;

  Komunitasmodel(
      {this.id,
      this.email,
      this.username,
      this.password,
      this.noTelp,
      this.tglTerbentuk,
      this.provinsi,
      this.bidang});

  factory Komunitasmodel.fromMap(Map<String, dynamic> komunitasData) {
    return Komunitasmodel(
      email: komunitasData['Email'],
      bidang: komunitasData['bidang'],
      username: komunitasData['username'],
      password: komunitasData['password'],
      noTelp: komunitasData['noTelp'],
      tglTerbentuk: komunitasData['tglTerbentuk'] != null
          ? DateTime.parse(komunitasData['tglTerbentuk'])
          : null,
      provinsi: komunitasData['provinsi'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'bidang': bidang,
      'password': password,
      'noTelp': noTelp,
      'tglTerbentuk':
          tglTerbentuk != null ? tglTerbentuk!.toIso8601String() : null,
      'provinsi': provinsi,
    };
  }
}
