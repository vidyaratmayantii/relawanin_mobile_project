import 'package:flutter/material.dart';
import 'package:relawanin_mobile_project/Komunitas/dashboard_komunitas.dart';
import 'package:relawanin_mobile_project/Komunitas/notificationKomunitas_page.dart';
import 'package:relawanin_mobile_project/Komunitas/pageSearchKomunitas.dart';
import 'package:relawanin_mobile_project/Komunitas/profileKomunitas_page.dart';
import 'package:relawanin_mobile_project/dashboard_page.dart';
// import 'package:relawanin_mobile_project/editProfile_page.dart';
// import 'package:relawanin_mobile_project/profile_page.dart';

class TentangKamiKomunitas extends StatelessWidget {
  const TentangKamiKomunitas({super.key});

  static const String profilePic = 'assets/profile_picture.png';
  static const String backgroundImage = 'assets/BackImage_tentangkami.png';

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
            Container(
              height: 100,
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
                      'Tentang Kami',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Aplikasi Relawanin merupakan platform inovatif yang menghubungkan mahasiswa yang ingin berkontribusi dalam kegiatan pengurangan emisi gas pada lingkup mahasiswa dengan organisasi. Tujuan kami adalah memudahkan kolaborasi antara para relawan dan organisasi yang mengadakan, sehingga menciptakan dampak positif yang lebih bagi masyarakat.',
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Keuntungan',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    'Aplikasi Relawanin menyediakan akses mudah dan cepat kepada sukarelawan. Para pengguna dapat melihat aktivitas yang tersedia, melihat deskripsi, lokasi, dan persyaratan yang diperlukan, sehingga memudahkan mereka untuk menemukan proyek yang sesuai dengan minat dan keahlian mereka.',
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Aplikasi Relawanin memungkinkan para sukarelawan untuk terhubung dengan komunitas sukarelawan yang berbagi minat dan tujuan yang sama. Mereka dapat berkomunikasi, berbagi pengalaman, dan mendukung satu sama lain dalam perjalanan sukarelawan mereka. Komunitas ini juga memberikan kesempatan untuk belajar dari pengalaman sukarelawan lainnya dan mendapatkan wawasan yang berharga.',
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Nilai Kami',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Kami mengutamakan kepercayaan dalam setiap interaksi di platform kami. Kami melindungi informasi pribadi relawan dan organisasi dengan keamanan yang kuat serta mempromosikan transparansi dalam hubungan antara kedua belah pihak.',
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Kami percaya bahwa setiap aksi sukarela memiliki potensi untuk menciptakan dampak yang signifikan dalam masyarakat. Oleh karena itu, kami berkomitmen untuk mempromosikan proyek-proyek yang bermanfaat dan memberikan kesempatan bagi para relawan untuk berkontribusi dalam pengurangan emisi gas ini.',
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Kami mendorong partisipasi aktif dari semua pengguna kami. Kami menyediakan pengalaman yang menyenangkan dan bermakna bagi para relawan dan organisasi untuk terlibat dalam kegiatan sukarela.',
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ],
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
                MaterialPageRoute(builder: (context) => ProfilePageKomunitas()),
              );
            } else if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DashboardKomunitas()),
              );
            } else if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => pageSearchKomunitas()),
              );
            } else if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationPageKomunitas()),
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
