import 'package:flutter/material.dart';
<<<<<<< Updated upstream
import 'profile_page.dart'; // Import file profil_page.dart
=======
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:relawanin_mobile_project/DetailKegiatan/detailKegiatan.dart';
import 'package:relawanin_mobile_project/detailBerita_page.dart';
import 'package:relawanin_mobile_project/notification_page.dart';
import 'package:relawanin_mobile_project/pageSearch.dart';
import 'package:relawanin_mobile_project/profile_page.dart';
import 'package:relawanin_mobile_project/cari_kegiatan_page.dart';
>>>>>>> Stashed changes

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key});

  static const String backgroundImage = 'assets/background_image.png';
  static const String logoImage = 'assets/logo.png';

  @override
  Widget build(BuildContext context) {
    Color buttonColor = const Color(0xFF00897B);
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0), // Atur tinggi AppBar
          child: AppBar(
            backgroundColor: const Color(0xFF00897B),
            flexibleSpace: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  logoImage,
                  height: 150, // Ubah tinggi logo sesuai kebutuhan
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
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Claim poin dengan \n menjadi aktivis!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Lanjutkan'),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Dapatkan penawaran terbaik \n dengan menukarkan poin',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ],
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
                        // Navigasi ke halaman lain
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        minimumSize: const Size(100, 50),
                      ),
                      child: const Text(
                        'Kegiatan',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        minimumSize: const Size(100, 50),
                      ),
                      child: const Text(
                        'Webinar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        minimumSize: const Size(100, 50),
                      ),
                      child: const Text(
                        'Project',
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
                  'Rekomendasi untuk mu',
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
                child: SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
<<<<<<< Updated upstream
                      return Card(
                        child: SizedBox(
                          width: 150,
                          child: Center(
                            child: Text('Card ${index + 1}'),
=======
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailKegiatan()),
                          );
                        },
                        child: Card(
                          child: SizedBox(
                            width: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/DetailGambar.png'),
                                Text(
                                  'Card ${index + 1}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
>>>>>>> Stashed changes
                          ),
                        ),
                      );
                    },
                  ),
                ),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  height: 200,
<<<<<<< Updated upstream
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
=======
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('berita').snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Center(child: Text('No news available'));
                      }

                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var berita = snapshot.data!.docs[index];
                          var imageData = berita['img'];
                          ImageProvider imageProvider;
                          imageProvider = NetworkImage(imageData);

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailBeritaPage(
                                    berita: berita,
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              child: SizedBox(
                                width: 150,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image(image: imageProvider),
                                    Text(
                                      berita['judul'],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
>>>>>>> Stashed changes
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: 0,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.green,
          onTap: (int index) {
            // Tambahkan kondisi untuk navigasi ke halaman profil
            if (index == 3) {
              // Indeks 3 adalah indeks untuk tombol "Profile"
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
<<<<<<< Updated upstream
=======
              );
            } else if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => pageSearch()),
              );
            } else if (index == 2 ) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationPage()),
>>>>>>> Stashed changes
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

                                         
