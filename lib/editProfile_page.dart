import 'package:flutter/material.dart';
import 'package:relawanin_mobile_project/profile_page.dart';
import 'package:relawanin_mobile_project/SQLite/sqlite.dart'; // Import kelas DatabaseHelper
import 'package:relawanin_mobile_project/JsonModels/relawan.dart'; // Import kelas Relawan

class EditProfilPage extends StatefulWidget {
  const EditProfilPage({Key? key}) : super(key: key);

  @override
  _EditProfilPageState createState() => _EditProfilPageState();
}

class _EditProfilPageState extends State<EditProfilPage> {
  final DatabaseHelper db =
      DatabaseHelper(); // Buat instance dari DatabaseHelper

  // Controllers untuk nilai textfield
  TextEditingController fullnameController = TextEditingController();
  TextEditingController umurController = TextEditingController();
  TextEditingController hpController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getDataFromDatabase(); // Panggil metode untuk mengambil data pengguna saat halaman dimuat
  }

  void getDataFromDatabase() async {
    // Mengambil data pengguna dari database
    Relawan? currentUser = await db.getUserData();
    if (currentUser != null) {
      // Set nilai controller sesuai dengan data pengguna yang diperoleh
      setState(() {
        fullnameController.text = currentUser.fullname ?? '';
        umurController.text = currentUser.umur ?? '';
        hpController.text = currentUser.hp ?? '';
        emailController.text = currentUser.email ?? '';
      });
    }
  }

  void saveChangesToDatabase() async {
    // Ambil nilai terbaru dari textfield
    String fullname = fullnameController.text;
    String umur = umurController.text;
    String hp = hpController.text;
    String email = emailController.text;

    // Buat objek Relawan baru dengan data terbaru
    Relawan penggunaBaru = Relawan(
      fullname: fullname,
      umur: umur,
      hp: hp,
      email: email,
    );

    // Simpan perubahan ke database
    await db.updateUserData(penggunaBaru);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: AppBar(
            backgroundColor: const Color(0xFF00897B),
            flexibleSpace: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Edit Profil',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(ProfilePage.profilePic),
                  ),
                ),
                width: 100,
                height: 100,
              ),
              SizedBox(height: 16),
              Text(
                'Ubah Foto',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF00897B),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 24),
              TextFormField(
                controller: fullnameController,
                decoration: InputDecoration(
                  hintText: 'Nama',
                  hintStyle: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: umurController,
                decoration: InputDecoration(
                  hintText: 'Umur',
                  hintStyle: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: hpController,
                decoration: InputDecoration(
                  hintText: 'Nomor HP',
                  hintStyle: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  saveChangesToDatabase(); // Panggil metode untuk menyimpan perubahan ke database
                  Navigator.pop(
                      context); // Kembali ke halaman profil setelah menyimpan
                },
                child: const Text(
                  'Simpan',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF00897B),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
