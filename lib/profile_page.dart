import 'package:flutter/material.dart';
import 'package:relawanin_mobile_project/PageLogin/loginPage.dart';
import 'package:relawanin_mobile_project/cari_kegiatan_page.dart';
import 'package:relawanin_mobile_project/dashboard_page.dart';
import 'package:relawanin_mobile_project/editProfile_page.dart';
import 'package:relawanin_mobile_project/riwayat_page.dart';
import 'package:relawanin_mobile_project/tentangkami_page.dart';
import 'package:relawanin_mobile_project/notification_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static const String profilePic = 'assets/profile_picture.png';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: AppBar(
            backgroundColor: const Color(0xFF00897B),
            automaticallyImplyLeading: false, // Menyembunyikan tombol "back"

            flexibleSpace: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(profilePic),
                    ),
                  ),
                  width: 100,
                  height: 100,
                ),
                SizedBox(height: 16),
                Text(
                  'Fadel Alif',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  '18 tahun',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Color(0xFF00897B),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '50 Poin Terkumpul',
                        style: TextStyle(color: Colors.white),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'Tukarkan',
                          style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFF00897B),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Divider(),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Pengaturan'),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('Edit Profil'),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditProfilPage()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.history),
                  title: Text('Riwayat'),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Riwayat()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.dark_mode),
                  title: Text('Mode Gelap'),
                  trailing: Switch(
                    value: false,
                    onChanged: (value) {},
                  ),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text('Tentang Kami'),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TentangKami()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.group),
                  title: Text('Bergabung Menjadi Komunitas'),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {},
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => loginPage()),
                    );
                  },
                  child: const Text(
                    'Keluar',
                    style: TextStyle(color: Colors.red), // warna teks
                  ),
                )

                // ListTile(
                //   // Widget ListTile
                //   contentPadding: EdgeInsets.symmetric(
                //       horizontal: 16.0), // Menambahkan padding horizontal
                //   trailing: Center(
                //     child: ElevatedButton(
                //       onPressed: () {},
                //       child: Text(
                //         'Keluar',
                //         style: TextStyle(color: Colors.white),
                //       ),
                //       style: ElevatedButton.styleFrom(
                //         backgroundColor: Color(0xFF00897B),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: 3,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Color(0xFF00897B),
          onTap: (int index) {
            // Tambahkan kondisi untuk navigasi ke halaman profil
            if (index == 3) {
              // Indeks 3 adalah indeks untuk tombol "Profile"
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            } else if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DashboardPage()),
              );
            } else if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => carikegiatan()),
              );
            } else if (index == 2 ) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationPage()),
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
