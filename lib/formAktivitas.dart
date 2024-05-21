import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Get the current user's UID
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        _showErrorSnackBar('User not logged in');
        return;
      }
      String uid = user.uid;

      Map<String, dynamic> newActivity = {
        'namaKegiatan': _controllerNamaKegiatan.text,
        'deskripsiKegiatan': _controllerDeskripsiKegiatan.text,
        'aktivitasKegiatan': _controllerAktivitasKegiatan.text,
        'ketentuanKegiatan': _controllerKetentuanKegiatan.text,
        'tanggalKegiatan': _controllerTanggalKegiatan.text,
        'batasRegistrasi': _controllerBatasRegistrasi.text,
        'lokasi': _controllerLokasi.text,
        'estimasiPoint': int.tryParse(_controllerEstimasiPoint.text) ?? 0,
      };

      // Use the UID as the document ID
      await FirebaseFirestore.instance
          .collection('activities')
          .doc(uid)
          .set(newActivity);

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
      // Clear the form fields
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

