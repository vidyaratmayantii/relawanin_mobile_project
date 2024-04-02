import 'package:flutter/material.dart';
import 'package:relawanin_mobile_project/dashboard_page.dart';
// import 'package:relawanin_mobile_project/editProfile_page.dart';
import 'package:relawanin_mobile_project/profile_page.dart';


class Riwayat extends StatelessWidget {
  const Riwayat({super.key});

  static const String profilePic = 'assets/profile_picture.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0), // Atur tinggi AppBar
        child: AppBar(
          backgroundColor: const Color(0xFF00897B),
          flexibleSpace: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                DashboardPage.logoImage,
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
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Riwayat',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  height: 600,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Card(
                        child: SizedBox(
                          height: 200,
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
    );
  }
}
