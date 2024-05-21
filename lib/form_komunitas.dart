import 'package:flutter/material.dart';
import 'package:relawanin_mobile_project/dashboard_page.dart';

class formKomunitas extends StatelessWidget {
  const formKomunitas({Key? key}) : super(key: key);
  static const String logoImage = 'assets/logo.png';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      // theme: ThemeData(
      //   primaryColor: Color.fromRGBO(0, 137, 123, 100),
      // ),
      home: Scaffold(
        appBar:  PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: AppBar(
            backgroundColor: const Color(0xFF00897B),
            automaticallyImplyLeading: false,
            flexibleSpace: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  logoImage,
                  height: 150,
                ),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'Nama Komunitas', hintStyle: TextStyle(fontSize: 16)),
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'Email Komunitas', hintStyle: TextStyle(fontSize: 16)),
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'Nomor Telepon',
                    hintStyle: TextStyle(fontSize: 16)),
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'Bidang Komunitas', hintStyle: TextStyle(fontSize: 16)),
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'Lokasi Komunitas', hintStyle: TextStyle(fontSize: 16)),
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'Deskripsi Komunitas', hintStyle: TextStyle(fontSize: 16)),
              ),
              
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(0, 137, 123, 1),
                  minimumSize: Size(30, 50), 
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Kirim Formulir',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
