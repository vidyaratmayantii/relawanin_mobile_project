import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:relawanin_mobile_project/Authenticator/signUp.dart';
import 'package:relawanin_mobile_project/pageSearch.dart';
import 'package:relawanin_mobile_project/DetailKegiatan/DetailKegiatan.dart';
import 'package:relawanin_mobile_project/notification_page.dart';
import 'package:relawanin_mobile_project/Authenticator/login.dart';
import 'package:relawanin_mobile_project/AuthenticatorKomunitas/signUpKomunitas.dart';
import 'dashboard_page.dart';
import 'dashboard_komunitas.dart';
import 'cari_kegiatan_page.dart';
import 'form.dart';
import 'detailBerita_page.dart';
import 'profile_page.dart';
import 'form_komunitas.dart';

Future<void> main() async {
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
        '/dashboard': (context) => const DashboardPage(),
        '/dashboardKomunitas': (context) => DashboardKomunitas(),
        '/detailKegiatan': (context) => DetailKegiatan(
      activityData: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>,
  ),
        '/pageSearch': (context) => pageSearch(),
        '/kegiatan': (context) => const form(),
        '/profile': (context) => const ProfilePage(),
        '/berita': (context) => const DetailBeritaPage(),
        '/cariKegiatan': (context) => const carikegiatan(),
        '/notification_page': (context) => NotificationPage(),
        '/form_komunitas': (context) => formKomunitas(),
        '/register': (context) =>Register(),
        '/registration_komunitas': (context) => RegistrationForm(),
      },
    );
  }
}
