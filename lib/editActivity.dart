import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class EditActivityForm extends StatefulWidget {
  final DocumentSnapshot activity;

  const EditActivityForm({Key? key, required this.activity}) : super(key: key);

  @override
  _EditActivityFormState createState() => _EditActivityFormState();
}

class _EditActivityFormState extends State<EditActivityForm> {
  final _formKey = GlobalKey<FormState>();
  final _controllerNamaKegiatan = TextEditingController();
  final _controllerDeskripsiKegiatan = TextEditingController();
  final _controllerAktivitasKegiatan = TextEditingController();
  final _controllerKetentuanKegiatan = TextEditingController();
  final _controllerTanggalKegiatan = TextEditingController();
  final _controllerBatasRegistrasi = TextEditingController();
  final _controllerLokasi = TextEditingController();
  final _controllerEstimasiPoint = TextEditingController();
  File? _image;
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    // Isi nilai controller dengan data dari aktivitas yang akan diupdate
    _controllerNamaKegiatan.text = widget.activity['namaKegiatan'];
    _controllerDeskripsiKegiatan.text = widget.activity['deskripsiKegiatan'];
    _controllerAktivitasKegiatan.text = widget.activity['aktivitasKegiatan'];
    _controllerKetentuanKegiatan.text = widget.activity['ketentuanKegiatan'];
    _controllerTanggalKegiatan.text = widget.activity['tanggalKegiatan'];
    _controllerBatasRegistrasi.text = widget.activity['batasRegistrasi'];
    _controllerLokasi.text = widget.activity['lokasi'];
    _controllerEstimasiPoint.text = widget.activity['estimasiPoint'].toString();
    _imageUrl = widget.activity['imageUrl'];
  }

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      }
    });
  }

  Future<String?> _uploadImage(File imageFile) async {
    try {
      String fileName = '${DateTime.now().millisecondsSinceEpoch}.png';
      Reference storageReference = FirebaseStorage.instance.ref().child('activity_images/$fileName');
      UploadTask uploadTask = storageReference.putFile(imageFile);
      await uploadTask;
      return await storageReference.getDownloadURL();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload image: $e')),
      );
      return null;
    }
  }

  void _updateActivity() async {
    try {
      String? imageUrl = _imageUrl;
      if (_image != null) {
        // Jika ada gambar baru, upload gambar baru
        imageUrl = await _uploadImage(_image!);
      }

      await FirebaseFirestore.instance.collection('activities').doc(widget.activity.id).update({
        'namaKegiatan': _controllerNamaKegiatan.text,
        'deskripsiKegiatan': _controllerDeskripsiKegiatan.text,
        'aktivitasKegiatan': _controllerAktivitasKegiatan.text,
        'ketentuanKegiatan': _controllerKetentuanKegiatan.text,
        'tanggalKegiatan': _controllerTanggalKegiatan.text,
        'batasRegistrasi': _controllerBatasRegistrasi.text,
        'lokasi': _controllerLokasi.text,
        'estimasiPoint': int.tryParse(_controllerEstimasiPoint.text) ?? 0,
        'imageUrl': imageUrl,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Activity updated successfully')),
      );

      Navigator.pop(context);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update activity: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Activity'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Tambahkan form fields untuk mengedit aktivitas
              TextFormField(
                controller: _controllerNamaKegiatan,
                decoration: InputDecoration(labelText: 'Nama Kegiatan'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the activity name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _controllerDeskripsiKegiatan,
                decoration: InputDecoration(labelText: 'Deskripsi Kegiatan'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the activity description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _controllerAktivitasKegiatan,
                decoration: InputDecoration(labelText: 'Aktivitas Kegiatan'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the activity details';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _controllerKetentuanKegiatan,
                decoration: InputDecoration(labelText: 'Ketentuan Kegiatan'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the activity requirements';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _controllerTanggalKegiatan,
                decoration: InputDecoration(labelText: 'Tanggal Kegiatan'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the activity date';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _controllerBatasRegistrasi,
                decoration: InputDecoration(labelText: 'Batas Registrasi'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the registration deadline';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _controllerLokasi,
                decoration: InputDecoration(labelText: 'Lokasi'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the location';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _controllerEstimasiPoint,
                decoration: InputDecoration(labelText: 'Estimasi Point'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the estimated points';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              _image != null
                  ? Image.file(_image!)
                  : _imageUrl != null
                      ? Image.network(_imageUrl!)
                      : Container(),
              TextButton.icon(
                icon: Icon(Icons.photo_camera),
                label: Text('Change Image'),
                onPressed: _getImage,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _updateActivity();
                  }
                },
                child: Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
