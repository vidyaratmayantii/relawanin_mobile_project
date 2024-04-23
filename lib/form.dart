import 'package:flutter/material.dart';
import 'package:relawanin_mobile_project/dashboard_page.dart';

class form extends StatelessWidget {
  const form({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData(
      //   primaryColor: Color.fromRGBO(0, 137, 123, 100),
      // ),
      home: Scaffold(
        appBar: AppBar(
          title: Image.asset('assets/logo.png'),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          backgroundColor: Color.fromRGBO(0, 137, 123, 100),
          centerTitle: true,
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

