import 'package:flutter/material.dart';
import 'package:relawanin_mobile_project/DetailKegiatan/DetailKegiatan.dart';
// import 'package:relawanin_mobile_project/cari_kegiatan_page.dart';
import 'PageLogin/loginPage.dart';
import 'dashboard_page.dart';
import 'cari_kegiatan_page.dart';
import 'form.dart';
import 'detailBerita_page.dart';
import 'profile_page.dart';



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
        '/': (context) => loginPage(),
        '/dashboard': (context) => const DashboardPage(),
        '/detailKegiatan': (context) => DetailKegiatan(),
        '/kegiatan': (context) => const form(),
        '/profile': (context) => const ProfilePage(),
        '/berita': (context) => const DetailBeritaPage(),
        '/cariKegiatan': (context) => const carikegiatan(),
        
      },
    );
  }
}
