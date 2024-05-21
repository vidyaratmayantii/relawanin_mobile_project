import 'package:flutter/material.dart';
import 'package:relawanin_mobile_project/dashboard_page.dart';

class form extends StatelessWidget {
  const form({Key? key}) : super(key: key);
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
                    hintText: 'Nama', hintStyle: TextStyle(fontSize: 16)),
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'Email', hintStyle: TextStyle(fontSize: 16)),
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
                    hintText: 'Umur', hintStyle: TextStyle(fontSize: 16)),
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'Pekerjaan', hintStyle: TextStyle(fontSize: 16)),
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Mengapa Anda Tertarik dengan Aktivitas Ini?',
                    hintStyle: TextStyle(fontSize: 16),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(05.0))),
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Apa Pengalamanmu?',
                    hintStyle: TextStyle(fontSize: 16),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(05.0))),
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
              SizedBox(height: 10), 
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(0, 137, 123, 1),
                    ),
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center, 
                      children: [
                        Icon(
                          Icons.add_circle,
                          color: Colors.white,
                        ),
                        SizedBox(width: 8), 
                        Text(
                          'Upload CV',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
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
