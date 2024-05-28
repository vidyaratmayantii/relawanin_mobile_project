import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:relawanin_mobile_project/DetailKegiatan/DetailKegiatan.dart';
import 'package:relawanin_mobile_project/Komunitas/notificationKomunitas_page.dart';
import 'package:relawanin_mobile_project/Komunitas/pageSearchKomunitas.dart';
import 'package:relawanin_mobile_project/Komunitas/profileKomunitas_page.dart';
import 'package:relawanin_mobile_project/detailBerita_page.dart';
import 'package:relawanin_mobile_project/Komunitas/editProfileKomunitas_page.dart';
import 'package:relawanin_mobile_project/historyActivities.dart';
import 'package:relawanin_mobile_project/notification_page.dart';
import 'package:relawanin_mobile_project/pageSearch.dart';
import '../profile_page.dart';
import '../formAktivitas.dart';

class DashboardKomunitas extends StatelessWidget {
  const DashboardKomunitas({super.key});

  static const String backgroundImage = 'assets/background_image.png';
  static const String logoImage = 'assets/logo.png';
  @override
  Widget build(BuildContext context) {
    Color buttonColor = const Color(0xFF00897B);
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: const AssetImage(backgroundImage),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.6), BlendMode.darken),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Pilih Kategori yang kamu inginkan',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ActivityForm()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        minimumSize: const Size(100, 50),
                      ),
                      child: const Text(
                        'Tambah Kegiatan',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyActivitiesList()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        minimumSize: const Size(100, 50),
                      ),
                      child: const Text(
                        'Kegiatan Saya',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Kegiatan Saya',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('activities')
                    .where('userId',
                        isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    if (snapshot.data!.docs.isEmpty) {
                      return Center(
                        child: Text('Belum ada kegiatan'),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: SizedBox(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var activity = snapshot.data!.docs[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailKegiatan(
                                        activityData: activity.data()
                                            as Map<String, dynamic>),
                                  ),
                                );
                              },
                              child: Card(
                                child: SizedBox(
                                  width: 150,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Mengambil gambar dari Firebase Storage jika imageUrl tidak kosong
                                      if (activity['imageUrl'] != null)
                                        Image.network(
                                          activity[
                                              'imageUrl'], // URL gambar dari Firestore
                                          width: 150,
                                          height: 125,
                                          fit: BoxFit.cover,
                                        ),
                                      // Menampilkan judul di sini
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, left: 8.0, right: 8.0),
                                        child: Text(
                                          activity[
                                              'namaKegiatan'], // Menggunakan data dari Firestore
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      // Menampilkan nama lokasi
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          'Lokasi: ${activity['lokasi']}',
                                          style: TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                      // Menampilkan tanggal kegiatan
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          'Tanggal: ${activity['tanggalKegiatan']}',
                                          style: TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Berita',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('berita').snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // Menampilkan indikator loading
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    // Menampilkan daftar kartu berdasarkan data yang diterima
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: SizedBox(
                        height: 240,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var doc = snapshot.data!.docs[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailBeritaPage(
                                      berita: doc,
                                      docId: doc.id,
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                child: SizedBox(
                                  width: 150,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Mengambil gambar dari Firebase Storage jika imageUrl tidak kosong
                                      if (doc['img'] != null)
                                        Image.network(
                                          doc['img'], // URL gambar dari Firestore
                                          width: 150,
                                          height: 125,
                                          fit: BoxFit.cover,
                                        ),
                                      // Menampilkan judul di sini
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, left: 8.0, right: 8.0),
                                        child: Text(
                                          doc['judul'], // Menggunakan data dari Firestore
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      // Menampilkan nama lokasi
                                      // Menampilkan tanggal kegiatan
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          'Oleh: ${doc['sumber']}',
                                          style: TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: 0,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Color(0xFF00897B),
          onTap: (int index) {
            if (index == 3) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePageKomunitas()),
              );
            } else if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const pageSearchKomunitas()),
              );
            } else if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NotificationPageKomunitas()),
              );
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
