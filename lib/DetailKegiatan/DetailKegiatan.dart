import 'package:flutter/material.dart';
import 'ButtonGabung.dart';
import 'ButtonHubungi.dart';
import 'MyCard.dart';


class DetailKegiatan extends StatelessWidget {
  DetailKegiatan({Key? key}) : super(key: key);

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
            centerTitle: true,
            title: Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Image.asset('lib/Images/logo.png'),
            ),
          ),
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Image.asset(
              'lib/Images/DetailGambar.png',
              width: double.infinity,
              height: screenHeight * 0.5,
              fit: BoxFit.fill,
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Karawang Peduli',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    'Karawang Peduli',
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
                    'Teens Go Green Indonesia membuka pendaftaran Volunteers bagi kamu yang ingin terlibat menjadi bagian dari Teens Go Green Indonesia. Volunteers yang terdaftar nantinya akan dilibatkan dalam program Teens Go Green Indonesia diantaranya #DigitalCampaigner dan Kelas Belajar Lingkungan atau menjadi bagian dari Volunteers Teens Go Green Indonesia untuk terlibat di banyak project lingkungan setelah pandemi berakhir.',
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
                    'Volunteers diharapkan menjadi Green Leaders atau pembawa virus cinta lingkungan untuk menyebarkan semangat positif menjaga lingkungan ke sekitarnya.',
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
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '1. Pemuda dan pemudi aktif usia 17-24 tahun\n',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: '2. Berkewarganegaraan Indonesia\n',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: '3. Sehat Jasmani dan rohani\n',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: '4. Berdomisili di Bandung lebih diutamakan\n',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text:
                              '5. Memiliki minat dan kepedulian terhadap isu lingkungan di Indonesia dan skala global\n',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text:
                              '6. Memiliki social media dan aktif menggunakan social media untuk gerakan perubahan yang positif\n',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, color: Colors.green),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text('14 September - 30 September 2020'),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.map, color: Colors.green),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text('Karawang'),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.dangerous_outlined, color: Colors.red),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          'Batas registrasi 30 September 2020',
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
                  SizedBox(width: 200), // Tambahkan jarak horizontal sebesar 10
                  Text('80'),
                ],
              ),
            ),
            const SizedBox(height: 10),
            
            Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Galeri',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          MyCard(
                              imagePath:
                                  'lib/Images/Dokter8.jpg'), 
                          MyCard(
                              imagePath:
                                  'lib/Images/Dokter8.jpg'),
                          MyCard(
                              imagePath:
                                  'lib/Images/Dokter8.jpg'), 
                        ],
                      ),
                    ),
                  ],
                )),
            Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ulasan',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Icon(Icons.person, color: Colors.grey, size: 80),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Marsya (18 tahun)',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'Kegiatan yang sangat bermanfaat dan bagus untuk diikuti!',
                                textAlign: TextAlign.justify,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 100,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ButtonGabung(
                      onTap: gabung,
                    ),
                    const SizedBox(height: 10),
                    ButtonHubungi(
                      onTap: hubungi,
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
