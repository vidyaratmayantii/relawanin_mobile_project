import 'package:flutter/material.dart';
import 'package:relawanin_mobile_project/profile_page.dart';

class EditProfilPage extends StatelessWidget {
  const EditProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0), // Atur tinggi AppBar
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
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 24),
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'Nama', hintStyle: TextStyle(fontSize: 16)),
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'Umur', hintStyle: TextStyle(fontSize: 16)),
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'Nomor HP', hintStyle: TextStyle(fontSize: 16)),
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'Email', hintStyle: TextStyle(fontSize: 16)),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
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
