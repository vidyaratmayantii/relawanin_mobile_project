import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final String imagePath;

  const MyCard({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: EdgeInsets.all(8.0),
      child: Container(
        width: 200,
        height: 200,
        child: Image.asset( // Menggunakan Image.asset untuk menampilkan gambar dari assets
          imagePath,
          fit: BoxFit.cover, // Menyesuaikan gambar ke dalam ukuran kotak
        ),
      ),
    );
  }
}