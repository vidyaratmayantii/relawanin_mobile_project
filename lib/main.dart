import 'package:flutter/material.dart';
import 'package:relawanin_mobile_project/cari_kegiatan_page.dart';
import 'PageLogin/loginPage.dart';
import 'dashboard_page.dart';


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
      },
    );
  }
}
