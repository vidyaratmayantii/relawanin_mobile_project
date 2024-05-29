import 'package:firebase_storage/firebase_storage.dart';
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
  String? _profilePicUrl;
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
  }

  void _getUserDataFromDatabase() async {
    Map<String, dynamic>? data = await _userController.getUser();
    if (data != null) {
      setState(() {
        userData = data;
        usernameController.text = userData?['username'] ?? '';
        nameController.text = userData?['name'] ?? '';
        emailController.text = userData?['email'] ?? '';
        notelpController.text = userData?['noTelp'] ?? '';
        pekerjaanController.text = userData?['pekerjaan'] ?? '';
        institusiController.text = userData?['institusi'] ?? '';
        _dateController.text = userData?['tglLahir'] ?? '';
        gender = userData?['gender'];
        provinsi = userData?['provinsi'];
        _profilePicUrl = userData?['profilePic'];
      });
    }
  }

  // Function to save profile
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profilePic = File(pickedFile.path);
      });
    }
  }

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _profilePic = File(pickedFile.path);
      });
    }
  }

  Future<String?> _uploadImageToFirebase(File imageFile) async {
    try {
      String uid = (await _userController.getLogInUser())?.uid ?? '';
      if (uid.isNotEmpty) {
        Reference ref =
            FirebaseStorage.instance.ref().child('profilePics/$uid.jpg');
        UploadTask uploadTask = ref.putFile(imageFile);
        TaskSnapshot taskSnapshot = await uploadTask;
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();
        return downloadUrl;
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
    return null;
  }

  void saveProfile() async {
    String? uid = (await _userController.getLogInUser())?.uid;
    String? imageUrl;
    if (uid != null && _profilePic != null) {
      imageUrl = await _uploadImageToFirebase(_profilePic!);
    }

    Map<String, dynamic> userData = {
      'email': emailController.text,
      'name': nameController.text,
      'username': usernameController.text,
      'password': passwordController.text,
      'noTelp': notelpController.text,
      'gender': gender!,
      'tglLahir': _dateController.text,
      'pekerjaan': pekerjaanController.text,
      'institusi': institusiController.text,
      'provinsi': provinsi!,
      if (imageUrl != null)
        'profilePic': imageUrl, // Menyimpan URL foto profil jika ada
    };
    await _userController.updateData(userData);
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
                            image: _profilePic != null
                                ? FileImage(_profilePic!)
                                : (_profilePicUrl != null
                                        ? NetworkImage(_profilePicUrl!)
                                        : AssetImage(
                                            'assets/default_profile_pic.png'))
                                    as ImageProvider<Object>,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: _pickImage,
                    icon: Icon(Icons.photo_library, color: Colors.white),
                    label: Text(
                      'Galeri',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF00897B),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton.icon(
                    onPressed: _takePicture,
                    icon: Icon(Icons.camera_alt, color: Colors.white),
                    label: Text(
                      'Kamera',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF00897B),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 5.0),
                child: Text(
                  'Informasi Akun',
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
                      return "Username diperlukan!";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.person,
                      color: Color.fromRGBO(0, 137, 123, 10),
                    ),
                    border: InputBorder.none,
                    hintText: 'Username',
                  ),
                ),
              ),

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
                  controller: emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Email diperlukan!";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.email,
                      color: Color.fromRGBO(0, 137, 123, 10),
                    ),
                    border: InputBorder.none,
                    hintText: 'Email',
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
                      return "Nama diperlukan!";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.person,
                      color: Color.fromRGBO(0, 137, 123, 10),
                    ),
                    border: InputBorder.none,
                    hintText: 'Nama Lengkap',
                  ),
                ),
              ),

              // Email

              // No Telepon
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
                      return "No. Telepon diperlukan!";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.phone,
                      color: Color.fromRGBO(0, 137, 123, 10),
                    ),
                    border: InputBorder.none,
                    hintText: 'No. Telepon',
                  ),
                ),
              ),

              // Pekerjaan
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
                      return "Pekerjaan diperlukan!";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.work,
                      color: Color.fromRGBO(0, 137, 123, 10),
                    ),
                    border: InputBorder.none,
                    hintText: 'Pekerjaan',
                  ),
                ),
              ),

              // Institusi
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
                      return "Institusi diperlukan!";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.business,
                      color: Color.fromRGBO(0, 137, 123, 10),
                    ),
                    border: InputBorder.none,
                    hintText: 'Institusi',
                  ),
                ),
              ),

              // Tanggal Lahir
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
                  controller: _dateController,
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    _selectDate(context);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Tanggal Lahir diperlukan!";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.calendar_today,
                      color: Color.fromRGBO(0, 137, 123, 10),
                    ),
                    border: InputBorder.none,
                    hintText: 'Tanggal Lahir',
                  ),
                ),
              ),

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
                  hint: Text('Pilih provinsi'),
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

              SizedBox(height: 24),
              // Tombol Simpan
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
