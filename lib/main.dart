// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'package:cari_kegiatan_page/cariberita.dart';
// import 'package:cari_kegiatan_page/carikegiatan.dart';
import 'package:relawanin_mobile_project/pageSearch.dart';
import 'package:flutter/material.dart';

import 'package:relawanin_mobile_project/DetailKegiatan/DetailKegiatan.dart';
import 'package:relawanin_mobile_project/notification_page.dart';
import 'package:relawanin_mobile_project/Authenticator/login.dart';
// import 'package:relawanin_mobile_project/cari_kegiatan_page.dart';
import 'PageLogin/loginPage.dart';
import 'dashboard_page.dart';
import 'cari_kegiatan_page.dart';
import 'form.dart';
import 'detailBerita_page.dart';
import 'profile_page.dart';
import 'form_komunitas.dart';




void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Relawanin',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/dashboard': (context) => const DashboardPage(),
        '/detailKegiatan': (context) => DetailKegiatan(),
        '/pageSearch': (context) => pageSearch(),
        '/kegiatan': (context) => const form(),
        '/profile': (context) => const ProfilePage(),
        '/berita': (context) => const DetailBeritaPage(),
        '/cariKegiatan': (context) => const carikegiatan(),
        '/notification_page': (context) => NotificationPage(),
        '/form_komunitas': (context) => formKomunitas(),

        
      },

    );
  }
}
