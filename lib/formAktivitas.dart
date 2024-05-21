import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';


class ActivityForm extends StatefulWidget {
  @override
  _ActivityFormState createState() => _ActivityFormState();
}

class _ActivityFormState extends State<ActivityForm> {
  final _formKey = GlobalKey<FormState>();
  final _controllerNamaKegiatan = TextEditingController();
  final _controllerDeskripsiKegiatan = TextEditingController();
  final _controllerAktivitasKegiatan = TextEditingController();
  final _controllerKetentuanKegiatan = TextEditingController();
  final _controllerTanggalKegiatan = TextEditingController();
  final _controllerBatasRegistrasi = TextEditingController();
  final _controllerLokasi = TextEditingController();
  final _controllerEstimasiPoint = TextEditingController();

  DateTime? _selectedDateKegiatan;
  DateTime? _selectedDateRegistrasi;
  XFile? _image;
  String? _imageUrl;

  void _presentDatePickerKegiatan() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDateKegiatan = pickedDate;
        _controllerTanggalKegiatan.text =
            "${_selectedDateKegiatan!.day}/${_selectedDateKegiatan!.month}/${_selectedDateKegiatan!.year}";
      });
    });
  }

  void _presentDatePickerRegistrasi() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDateRegistrasi = pickedDate;
        _controllerBatasRegistrasi.text =
            "${_selectedDateRegistrasi!.day}/${_selectedDateRegistrasi!.month}/${_selectedDateRegistrasi!.year}";
      });
    });
  }

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  Future<String?> _uploadImage(File imageFile) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        _showErrorSnackBar('User not logged in');
        return null;
      }
      String fileName = '${DateTime.now().millisecondsSinceEpoch}.png';
      Reference storageReference = FirebaseStorage.instance.ref().child('activity_images/$fileName');
      UploadTask uploadTask = storageReference.putFile(File(imageFile.path));
      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      _showErrorSnackBar('Failed to upload image: $e');
      return null;
    }
  }




  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        _showErrorSnackBar('User not logged in');
        return;
      }
      String uid = user.uid;

      if (_image != null) {

        File imageFile = File(_image!.path);
        _imageUrl = await _uploadImage(imageFile);
      }


      Map<String, dynamic> newActivity = {
        'namaKegiatan': _controllerNamaKegiatan.text,
        'deskripsiKegiatan': _controllerDeskripsiKegiatan.text,
        'aktivitasKegiatan': _controllerAktivitasKegiatan.text,
        'ketentuanKegiatan': _controllerKetentuanKegiatan.text,
        'tanggalKegiatan': _controllerTanggalKegiatan.text,
        'batasRegistrasi': _controllerBatasRegistrasi.text,
        'lokasi': _controllerLokasi.text,
        'estimasiPoint': int.tryParse(_controllerEstimasiPoint.text) ?? 0,
        'userId': uid,
        'imageUrl': _imageUrl,
      };

      await FirebaseFirestore.instance.collection('activities').add(newActivity);

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Activity Registered Successfully')));

      _controllerNamaKegiatan.clear();
      _controllerDeskripsiKegiatan.clear();
      _controllerAktivitasKegiatan.clear();
      _controllerKetentuanKegiatan.clear();
      _controllerTanggalKegiatan.clear();
      _controllerBatasRegistrasi.clear();
      _controllerLokasi.clear();
      _controllerEstimasiPoint.clear();
      setState(() {
        _image = null;
        _imageUrl = null;
      });
      _formKey.currentState!.reset();
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Activity Registration')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _controllerNamaKegiatan,
                  decoration: InputDecoration(
                    labelText: 'Nama Kegiatan',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the activity name';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _controllerDeskripsiKegiatan,
                  decoration: InputDecoration(
                    labelText: 'Deskripsi Kegiatan',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the activity description';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _controllerAktivitasKegiatan,
                  decoration: InputDecoration(
                    labelText: 'Aktivitas Kegiatan',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the activity details';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _controllerKetentuanKegiatan,
                  decoration: InputDecoration(
                    labelText: 'Ketentuan Kegiatan',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the activity terms';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _controllerTanggalKegiatan,
                  decoration: InputDecoration(
                    labelText: 'Tanggal Kegiatan',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: _presentDatePickerKegiatan,
                    ),
                  ),
                  readOnly: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the activity date';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _controllerBatasRegistrasi,
                  decoration: InputDecoration(
                    labelText: 'Batas Registrasi',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: _presentDatePickerRegistrasi,
                    ),
                  ),
                  readOnly: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the registration deadline';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _controllerLokasi,
                  decoration: InputDecoration(
                    labelText: 'Lokasi',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the activity location';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _controllerEstimasiPoint,
                  decoration: InputDecoration(
                    labelText: 'Estimasi Point',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the estimated points';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: _getImage,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Unggah Gambar',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8), 
                    Container(
                      width: 350,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: _image != null
                          ? Image.file(File(_image!.path), fit: BoxFit.cover)
                          : Icon(Icons.add_photo_alternate, size: 40, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Register Activity'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

