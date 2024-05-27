// views/edit_profile_page.dart

import 'package:flutter/material.dart';
import 'package:relawanin_mobile_project/Controller/controllerKomunitas.dart';
import 'package:relawanin_mobile_project/Controller/controllerUser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:relawanin_mobile_project/Komunitas/dashboard_komunitas.dart';
import 'package:relawanin_mobile_project/Komunitas/notificationKomunitas_page.dart';
import 'package:relawanin_mobile_project/Komunitas/pageSearchKomunitas.dart';
import 'package:relawanin_mobile_project/Komunitas/profileKomunitas_page.dart';
import 'dart:io';
import 'package:relawanin_mobile_project/SQLite/sqlite.dart';
import 'package:relawanin_mobile_project/profile_page.dart';
import 'package:intl/intl.dart';

class EditProfilePageKomunitas extends StatefulWidget {
  @override
  _EditProfilePageKomunitasState createState() =>
      _EditProfilePageKomunitasState();
}

class _EditProfilePageKomunitasState extends State<EditProfilePageKomunitas> {
  final komunitasController _komunitasController = komunitasController();
  Map<String, dynamic>? komunitasData;
  File? _profilePic;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController bidangController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController notelpController = TextEditingController();
  final _dateController = TextEditingController();
  String? provinsi;
  bool isVisible = false;

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('yyyy/MM/dd').format(picked);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getkomunitasDataFromDatabase();
    _loadProfilePic();
  }

  void _getkomunitasDataFromDatabase() async {
    Map<String, dynamic>? data = await _komunitasController.getUser();
    if (data != null) {
      setState(() {
        komunitasData = data;
        usernameController.text = komunitasData?['username'] ?? '';
        bidangController.text = komunitasData?['bidang'] ?? '';
        notelpController.text = komunitasData?['noTelp'] ?? '';
        _dateController.text = komunitasData?['tglTerbentuk'] ?? '';
        provinsi = komunitasData?['provinsi'];
      });
    }
  }

  // Function to save profile
  void saveProfile() async {
    Map<String, dynamic> komunitasData = {
      'bidang': bidangController.text,
      'username': usernameController.text,
      'noTelp': notelpController.text,
      'tglTerbentuk': _dateController.text,
      'provinsi': provinsi!,
    };
    await _komunitasController.updateData(komunitasData);
  }

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      await DatabaseHelper().saveProfilePic(pickedFile.path);

      setState(() {
        _profilePic = imageFile;
      });
    }
  }

  Future<void> _loadProfilePic() async {
    String? profilePicPath = await DatabaseHelper().getProfilePic();
    if (profilePicPath != null) {
      setState(() {
        _profilePic = File(profilePicPath);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: AppBar(
            backgroundColor: const Color(0xFF00897B),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipOval(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: _profilePic == null
                        ? DecorationImage(
                            image: AssetImage('assets/default_profile_pic.png'),
                            fit: BoxFit.cover,
                          )
                        : DecorationImage(
                            image: FileImage(_profilePic!),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _pickImage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF00897B),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: const Text(
                  'Ubah Foto',
                  style: TextStyle(
                    fontSize: 14, // Set a smaller font size
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 24),

              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 5.0),
                child: Text(
                  'Information Account',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),

              // Username
              Container(
                margin: EdgeInsets.all(11),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Color.fromRGBO(0, 137, 123, 0.5),
                      width: 2.0,
                    ),
                    color: Colors.white),
                child: TextFormField(
                  controller: usernameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "username is required!!!";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.email,
                      color: Color.fromRGBO(0, 137, 123, 10),
                    ),
                    border: InputBorder.none,
                    hintText: 'Username',
                  ),
                ),
              ),

              // Data diri
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 5.0),
                child: Text(
                  'Data Diri',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),

              // Bidang
              Container(
                margin: EdgeInsets.all(11),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Color.fromRGBO(0, 137, 123, 0.5),
                      width: 2.0,
                    ),
                    color: Colors.white),
                child: TextFormField(
                  controller: bidangController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Bidang is required!!!";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.email,
                      color: Color.fromRGBO(0, 137, 123, 10),
                    ),
                    border: InputBorder.none,
                    hintText: 'Bidang',
                  ),
                ),
              ),

              // No telp
              Container(
                margin: EdgeInsets.all(11),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Color.fromRGBO(0, 137, 123, 0.5),
                      width: 2.0,
                    ),
                    color: Colors.white),
                child: TextFormField(
                  controller: notelpController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "phone number is required!!!";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.email,
                      color: Color.fromRGBO(0, 137, 123, 10),
                    ),
                    border: InputBorder.none,
                    hintText: 'phone number',
                  ),
                ),
              ),

              // Tanggal Terbentuk input field
              Container(
                margin: EdgeInsets.all(11),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Color.fromRGBO(0, 137, 123, 0.5),
                    width: 2.0,
                  ),
                  color: Colors.white,
                ),
                child: TextFormField(
                  controller: _dateController,
                  readOnly: true, // Prevents manual input
                  onTap: () => _selectDate(context),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Tanggal Terbentuk is required!!!";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.calendar_today,
                      color: Color.fromRGBO(0, 137, 123, 10),
                    ),
                    border: InputBorder.none,
                    hintText: 'Tanggal Terbentuk (yyyy/mm/dd)',
                  ),
                ),
              ),

              // provinsi dropdown field
              Container(
                margin: EdgeInsets.all(11),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Color.fromRGBO(0, 137, 123, 0.5),
                    width: 2.0,
                  ),
                  color: Colors.white,
                ),
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.person,
                      color: Color.fromRGBO(0, 137, 123, 10),
                    ),
                    border: InputBorder.none,
                  ),
                  hint: Text('Select provinsi'),
                  value: provinsi,
                  items: [
                    'Nanggroe Aceh Darussalam',
                    'Sumatera Utara',
                    'Sumatera Selatan',
                    'Sumatera Barat',
                    'Bengkulu',
                    'Riau',
                    'Kepulauan Riau',
                    'Jambi',
                    'Lampung',
                    'Bangka Belitung',
                    'Kalimantan Barat',
                    'Kalimantan Timur',
                    'Kalimantan Selatan',
                    'Kalimantan Tengah',
                    'Kalimantan Utara',
                    'Banten',
                    'DKI Jakarta',
                    'Jawa Barat',
                    'Jawa Tengah',
                    'Daerah Istimewa Yogyakarta',
                    'Jawa Timur',
                    'Bali',
                    'Nusa Tenggara Timur',
                    'Nusa Tenggara Barat',
                    'Gorontalo',
                    'Sulawesi Barat',
                    'Sulawesi Tengah',
                    'Sulawesi Utara',
                    'Sulawesi Tenggara',
                    'Sulawesi Selatan',
                    'Maluku Utara',
                    'Maluku',
                    'Papua Barat',
                    'Papua',
                    'Papua Tengah',
                    'Papua Pegunungan',
                    'Papua Selatan',
                    'Papua Barat Daya'
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      provinsi = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Provinsi is required!";
                    }
                    return null;
                  },
                ),
              ),

              SizedBox(height: 16),

              ElevatedButton(
                onPressed: () {
                  saveProfile(); // Panggil metode untuk menyimpan perubahan ke database
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
      ),
    );
  }
}
