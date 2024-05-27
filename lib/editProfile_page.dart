// views/edit_profile_page.dart

import 'package:flutter/material.dart';
import 'package:relawanin_mobile_project/Controller/controllerUser.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:relawanin_mobile_project/SQLite/sqlite.dart';
import 'package:relawanin_mobile_project/profile_page.dart';
import 'package:intl/intl.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final UserController _userController = UserController();
  Map<String, dynamic>? userData;
  File? _profilePic;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController notelpController = TextEditingController();
  final TextEditingController pekerjaanController = TextEditingController();
  final TextEditingController institusiController = TextEditingController();
  final _dateController = TextEditingController();
  String? gender;
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
    _getUserDataFromDatabase();
    _loadProfilePic();
  }

  void _getUserDataFromDatabase() async {
    Map<String, dynamic>? data = await _userController.getUser();
    if (data != null) {
      setState(() {
        userData = data;
        usernameController.text = userData?['username'] ?? '';
        nameController.text = userData?['fullname'] ?? '';
        passwordController.text = userData?['password'] ?? '';
        notelpController.text = userData?['noTelp'] ?? '';
        pekerjaanController.text = userData?['pekerjaan'] ?? '';
        institusiController.text = userData?['institusi'] ?? '';
        _dateController.text = userData?['tglLahir'] ?? '';
        gender = userData?['gender'];
        provinsi = userData?['provinsi'];
      });
    }
  }

  // Function to save profile
  void saveProfile() async {
    Map<String, dynamic> userData = {
      'name': nameController.text,
      'username': usernameController.text,
      'password': passwordController.text,
      'noTelp': notelpController.text,
      'gender': gender!,
      'tglLahir': _dateController.text,
      'pekerjaan': pekerjaanController.text,
      'institusi': institusiController.text,
      'provinsi': provinsi!,
    };
    await _userController.updateData(userData);
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

              // Nama
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
                  controller: nameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Nama is required!!!";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.email,
                      color: Color.fromRGBO(0, 137, 123, 10),
                    ),
                    border: InputBorder.none,
                    hintText: 'Nama',
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

              // gender dropdown
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
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.person,
                      color: Color.fromRGBO(0, 137, 123, 10),
                    ),
                    border: InputBorder.none,
                  ),
                  hint: Text('Select Gender'),
                  value: gender,
                  items: ['Male', 'Female', 'Other'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      gender = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Gender is required!";
                    }
                    return null;
                  },
                ),
              ),

              // Tanggal Lahir input field
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
                      return "Tanggal Lahir is required!!!";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.calendar_today,
                      color: Color.fromRGBO(0, 137, 123, 10),
                    ),
                    border: InputBorder.none,
                    hintText: 'Tanggal Lahir (yyyy/mm/dd)',
                  ),
                ),
              ),

              // No pekerjaan
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
                  controller: pekerjaanController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "job is required!!!";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.email,
                      color: Color.fromRGBO(0, 137, 123, 10),
                    ),
                    border: InputBorder.none,
                    hintText: 'pekerjaan',
                  ),
                ),
              ),

              // No institusi
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
                  controller: institusiController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "institusi is required!!!";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.email,
                      color: Color.fromRGBO(0, 137, 123, 10),
                    ),
                    border: InputBorder.none,
                    hintText: 'Institusi',
                  ),
                ),
              ),

              // provinsi dropdown field
              // gender dropdown
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
                      return "Gender is required!";
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
      ),
    );
  }
}