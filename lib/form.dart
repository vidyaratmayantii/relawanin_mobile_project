import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:relawanin_mobile_project/Komunitas/tableRelawan.dart';
import 'package:relawanin_mobile_project/dashboard_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Image.asset('assets/logo.png'),
          backgroundColor: const Color(0xFF00897B),
          centerTitle: true,
        ),
        body: FormPage(),
      ),
    );
  }
}

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> uploadPdf(String fileName, File file) async {
    final ref = FirebaseStorage.instance.ref().child("pdf/$fileName.pdf");
    final uploadTask = ref.putFile(file);
    await uploadTask.whenComplete(() {});
    final downloadLink = await ref.getDownloadURL();
    return downloadLink;
  }

  void selectPdf() async {
    final pick = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (pick != null) {
      String fileName = pick.files[0].name;
      File file = File(pick.files[0].path!);

      final downloadLink = await uploadPdf(fileName, file);

      await _firebaseFirestore.collection('pdf').add({
        "nama": fileName,
        "url": downloadLink,
      });

      print("File uploaded successfully: $downloadLink");
    }
  }

  @override
  Widget build(BuildContext context) {
    final namaController = TextEditingController();
    final emailController = TextEditingController();
    final noTlpController = TextEditingController();
    final umurController = TextEditingController();
    final pekerjaanController = TextEditingController();
    final alasanController = TextEditingController();
    final pengalamanController = TextEditingController();

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: namaController,
                decoration: InputDecoration(
                    hintText: 'Nama', hintStyle: TextStyle(fontSize: 16)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama wajib diisi';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                    hintText: 'Email', hintStyle: TextStyle(fontSize: 16)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email wajib diisi';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: noTlpController,
                decoration: InputDecoration(
                    hintText: 'Nomor Telepon', hintStyle: TextStyle(fontSize: 16)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nomor Telepon wajib diisi';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: umurController,
                decoration: InputDecoration(
                    hintText: 'Umur', hintStyle: TextStyle(fontSize: 16)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Umur wajib diisi';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: pekerjaanController,
                decoration: InputDecoration(
                    hintText: 'Pekerjaan', hintStyle: TextStyle(fontSize: 16)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Pekerjaan wajib diisi';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: alasanController,
                decoration: InputDecoration(
                    labelText: 'Mengapa Anda Tertarik dengan Aktivitas Ini?',
                    hintStyle: TextStyle(fontSize: 16),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Alasan wajib diisi';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: pengalamanController,
                decoration: InputDecoration(
                    labelText: 'Apa Pengalamanmu?',
                    hintStyle: TextStyle(fontSize: 16),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Pengalaman wajib diisi';
                  }
                  return null;
                },
              ),
              SizedBox(height: 40),
              Builder(
                builder: (BuildContext context) {
                  return ElevatedButton(
                    onPressed: () async {
                      User? user = _auth.currentUser;

                      if (user != null) {
                        if (_formKey.currentState?.validate() ?? false) {
                          CollectionReference collectionRef =
                              _firebaseFirestore.collection('form');
                          collectionRef.add({
                            'userId': user.uid,
                            'nama': namaController.text,
                            'email': emailController.text,
                            'noTlp': noTlpController.text,
                            'umur': umurController.text,
                            'pekerjaan': pekerjaanController.text,
                            'alasan': alasanController.text,
                            'pengalaman': pengalamanController.text,
                          }).then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Data berhasil terkirim'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SuksesScreen(),
                              ),
                            );
                          });
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('User tidak terautentikasi'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
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
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SuksesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/logo.png'),
        backgroundColor: const Color(0xFF00897B),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.check_circle_outline,
              size: 100,
              color: Colors.green,
            ),
            SizedBox(height: 20),
            Text(
              'Formulir Terkirim!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Terima kasih telah mendaftar kegiatan! \nProses pendaftaranmu akan diproses oleh pihak komunitas, dan tunggu email penerimaan dari komunitas',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DashboardPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(0, 137, 123, 1),
                minimumSize: Size(30, 50),
              ),
              child: Text(
                'Kembali',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
