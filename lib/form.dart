import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

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

  Widget build(BuildContext context) {
    final namaController = TextEditingController();
    final emailController = TextEditingController();
    final noTlpController = TextEditingController();
    final umurController = TextEditingController();
    final pekerjaanController = TextEditingController();
    final alasanController = TextEditingController();
    final pengalamanController = TextEditingController();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Image.asset('assets/logoRelawanin.png'),
          backgroundColor: Color.fromRGBO(0, 137, 123, 100),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          physics:BouncingScrollPhysics() ,
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
                        hintText: 'Nomor Telepon',
                        hintStyle: TextStyle(fontSize: 16)),
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
                        hintText: 'Pekerjaan',
                        hintStyle: TextStyle(fontSize: 16)),
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
                  SizedBox(height: 10), //jaraknya dengan yang atas
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start, // kiri button
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          selectPdf();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(0, 137, 123, 1),
                        ),
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.center, //tulisan ditengah
                          children: [
                            Icon(
                              Icons.add_circle,
                              color: Colors.white,
                            ),
                            SizedBox(width: 8), // jarak antara icon dan teks
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
                      CollectionReference collectionRef =
                          FirebaseFirestore.instance.collection('form');
                      collectionRef.add({
                        'nama': namaController.text,
                        'email': emailController.text,
                        'noTlp': noTlpController.text,
                        'umur': umurController.text,
                        'pekerjaan': pekerjaanController.text,
                        'alasan': alasanController.text,
                        'pengalaman': pengalamanController.text,
                      });
                      if (_formKey.currentState?.validate() ?? false) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Formulir terkirim')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(0, 137, 123, 1),
                      minimumSize: Size(30, 50), // Mengatur lebar tombol
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
          )
        ),
      ),
    );
  }
}



