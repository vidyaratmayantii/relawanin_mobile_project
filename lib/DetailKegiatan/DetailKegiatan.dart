import 'package:flutter/material.dart';

import 'ButtonGabung.dart';
import 'ButtonHubungi.dart';
import 'MyCard.dart';

class DetailKegiatan extends StatelessWidget {
  static const String logoImage = 'assets/logo.png';
  final Map<String, dynamic> activityData;

  DetailKegiatan({Key? key, required this.activityData}) : super(key: key);

  void gabung() {}
  void hubungi() {}

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: AppBar(
            backgroundColor: Color(0xFF00897B),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            centerTitle: true,
            title: Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Image.asset(logoImage),
            ),
          ),
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            // Use a default image if activityData['imageUrl'] is null
            Image.network(
              activityData['imageUrl'] ?? 'https://via.placeholder.com/150',
              width: double.infinity,
              height: screenHeight * 0.4,
              fit: BoxFit.fill,
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    activityData['namaKegiatan'] ?? 'No Name',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    activityData['lokasi'] ?? 'No Location',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF00897B),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'Deskripsi',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    activityData['deskripsiKegiatan'] ?? 'No Description',
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'Aktivitas',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    activityData['aktivitasKegiatan'] ?? 'No Activity',
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'Ketentuan',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    activityData['ketentuanKegiatan'] ?? 'No Activity',
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, color: Colors.green),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text('Tanggal Kegiatan: ${activityData['tanggalKegiatan'] ?? 'No Date'}'),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.map, color: Colors.green),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text('Lokasi: ${activityData['lokasi'] ?? 'No Location'}'),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.dangerous_outlined, color: Colors.red),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          'Batas registrasi: ${activityData['batasRegistrasi'] ?? 'No Registration Limit'}',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: screenHeight * 0.1,
              color: const Color.fromARGB(255, 191, 191, 191),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Text('Estimated Poin'),
                  ),
                  SizedBox(width: 150),
                  Text(activityData['estimasiPoint']?.toString() ?? 'No Points'),
                ],
              ),
            ),
            const SizedBox(height: 10),
            
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  ButtonGabung(
                    onTap: gabung,
                  ),
                  const SizedBox(height: 10),
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
