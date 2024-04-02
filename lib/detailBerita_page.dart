import 'package:flutter/material.dart';

class DetailBeritaPage extends StatelessWidget {
  const DetailBeritaPage({super.key});

  static const String logoImage = 'assets/logo.png';
  static const String backgroundImage = 'assets/images.jpeg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: const Color(0xFF00897B),
          flexibleSpace: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/logo.png', 
                height: 150,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 241,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images.jpeg'), 
                  fit: BoxFit.cover, 
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 250),
                  Text(
                    'DKI Jakarta & Jawa Barat Berpotensi Hujan dan Angin Kencang',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Kompas',
                    style: TextStyle(
                      color: Color(0xFF00897B),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'JAKARTA - KOMPAS Badan Meteorologi, Klimatologi, dan Geofisika memprakirakan DKI Jakarta dan sekitarnya akan mengalami hujan disertai petir dan angin kencang pada Minggu (5/1/2020). Untuk wilayah Jakarta Utara dan Jakarta Pusat, potensi itu akan berlangsung pada pagi hari. Jakarta Selatan serta Jakarta Timur pada sore hari.',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Kepala Bagian Hubungan Masyarakat Badan Meteorologi, Klimatologi, dan Geofisika (BMKG) Akhmad Taufan Maulana, saat dihubungi di Jakarta, menuturkan, pada Minggu pagi, daerah Jakarta Pusat, Jakarta Selatan, dan Jakarta Barat akan berawan dan hujan ringan. Sementara pada siang hari, hujan diprakirakan terjadi merata di seluruh wilayah DKI Jakarta, termasuk Kepulauan Seribu.',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Untuk malam hari, wilayah DKI hanya berawan. ”Sebagai peringatan dini, waspada potensi hujan disertai kilat ataupun petir dan angin kencang di wilayah Jakarta Utara dan Jakarta Pusat pada pagi hari, dan Jakarta Selatan, serta Jakarta Timur pada sore hari,” katanya.',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '\n Berita Lainnya',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 250),
                ],
              ),
            ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 50,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Card(
                        child: SizedBox(
                          width: 150,
                          child: Center(
                            child: Text('Card ${index + 1}'),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}