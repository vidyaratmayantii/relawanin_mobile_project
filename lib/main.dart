// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'package:cari_kegiatan_page/cariberita.dart';
// import 'package:cari_kegiatan_page/carikegiatan.dart';
import 'package:relawanin_mobile_project/pageSearch.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: pageSearch(),
      debugShowCheckedModeBanner: false,
    );
  }
}
