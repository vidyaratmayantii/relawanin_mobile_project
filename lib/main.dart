import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:relawanin_mobile_project/pageSearch.dart';
import 'package:relawanin_mobile_project/Authenticator/signUp.dart';
import 'package:relawanin_mobile_project/DetailKegiatan/DetailKegiatan.dart';
import 'package:relawanin_mobile_project/notification_page.dart';
import 'package:relawanin_mobile_project/Authenticator/login.dart';
import 'dashboard_page.dart';
import 'cari_kegiatan_page.dart';
import 'form.dart';
import 'detailBerita_page.dart';
import 'profile_page.dart';
import 'form_komunitas.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        '/register': (context) => Register(),
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
