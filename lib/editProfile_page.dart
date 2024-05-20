import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class EditProfilPage extends StatefulWidget {
  final String userId;

  const EditProfilPage({required this.userId, Key? key}) : super(key: key);

  @override
  _EditProfilPageState createState() => _EditProfilPageState();
}

class _EditProfilPageState extends State<EditProfilPage> {
  final fullname = TextEditingController();
  final email = TextEditingController();
  final username = TextEditingController();
  final noTelp = TextEditingController();
  String? gender;
  String? provinsi;
  DateTime? _selectDate;
  final pekerjaan = TextEditingController();
  final institusi = TextEditingController();
  final formkey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() {
    print('Fetching data for user ID: ${widget.userId}');
    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userId)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        print('User document found: ${snapshot.data()}');
        setState(() {
          fullname.text = snapshot['fullname'] ?? '';
          email.text = snapshot['email'] ?? '';
          username.text = snapshot['username'] ?? '';
          noTelp.text = snapshot['noTelphone'] ?? '';
          gender = snapshot['gender'];
          pekerjaan.text = snapshot['pekerjaan'] ?? '';
          institusi.text = snapshot['institusi'] ?? '';
          provinsi = snapshot['provinsi'];
          if (snapshot['tgl_lahir'] != null) {
            _selectDate = DateTime.parse(snapshot['tgl_lahir']);
          }
        });
      } else {
        print('User document not found');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User document not found')),
        );
      }
    }).catchError((error) {
      print('Error fetching data: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch user data')),
      );
    });
  }

  Future<void> saveChanges() async {
    if (formkey.currentState!.validate()) {
      try {
        final docRef =
            FirebaseFirestore.instance.collection('users').doc(widget.userId);
        final snapshot = await docRef.get();

        if (snapshot.exists) {
          await docRef.update({
            'fullname': fullname.text,
            'email': email.text,
            'username': username.text,
            'noTelphone': noTelp.text,
            'gender': gender,
            'tgl_lahir': _selectDate != null
                ? DateFormat('yyyy-MM-dd').format(_selectDate!)
                : null,
            'pekerjaan': pekerjaan.text,
            'institusi': institusi.text,
            'provinsi': provinsi,
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Changes saved successfully')),
          );
        } else {
          print('User document not found during save');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('User document not found')),
          );
        }
      } catch (e) {
        print('Error saving changes: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save changes: $e')),
        );
      }
    }
  }

  List<DropdownMenuItem<String>> dropdownItems() {
    return [
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
    ].map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectDate) {
      setState(() {
        _selectDate = picked;
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
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/profile_picture.png'),
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
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    "My Account",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),

                // Fullname
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
                    controller: fullname,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Name is required!";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.person,
                        color: Color.fromRGBO(0, 137, 123, 10),
                      ),
                      border: InputBorder.none,
                      hintText: 'Name',
                    ),
                  ),
                ),

                // Email
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
                    controller: email,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Email is required!";
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
                    controller: username,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Username is required!";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.person_outline,
                        color: Color.fromRGBO(0, 137, 123, 10),
                      ),
                      border: InputBorder.none,
                      hintText: 'Username',
                    ),
                  ),
                ),

                // Nomor Telp
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
                    controller: noTelp,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Phone number is required!";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.phone,
                        color: Color.fromRGBO(0, 137, 123, 10),
                      ),
                      border: InputBorder.none,
                      hintText: 'Phone Number',
                    ),
                  ),
                ),

                // Gender
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
                  child: DropdownButtonFormField<String>(
                    value: gender,
                    items: ['Male', 'Female']
                        .map<DropdownMenuItem<String>>((String value) {
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
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.transgender,
                        color: Color.fromRGBO(0, 137, 123, 10),
                      ),
                      border: InputBorder.none,
                      hintText: 'Gender',
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
                  child: InkWell(
                    onTap: () => selectDate(context),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.calendar_today,
                          color: Color.fromRGBO(0, 137, 123, 10),
                        ),
                        border: InputBorder.none,
                        hintText: 'Birth Date',
                      ),
                      child: Text(
                        _selectDate == null
                            ? 'Select date'
                            : DateFormat('yyyy-MM-dd').format(_selectDate!),
                        style: TextStyle(
                          color:
                              _selectDate == null ? Colors.grey : Colors.black,
                        ),
                      ),
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
                    controller: pekerjaan,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Occupation is required!";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.work,
                        color: Color.fromRGBO(0, 137, 123, 10),
                      ),
                      border: InputBorder.none,
                      hintText: 'Occupation',
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
                    controller: institusi,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Institution is required!";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.school,
                        color: Color.fromRGBO(0, 137, 123, 10),
                      ),
                      border: InputBorder.none,
                      hintText: 'Institution',
                    ),
                  ),
                ),

                // Provinsi
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
                  child: DropdownButtonFormField<String>(
                    value: provinsi,
                    items: dropdownItems(),
                    onChanged: (String? newValue) {
                      setState(() {
                        provinsi = newValue;
                      });
                    },
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.location_city,
                        color: Color.fromRGBO(0, 137, 123, 10),
                      ),
                      border: InputBorder.none,
                      hintText: 'Province',
                    ),
                  ),
                ),

                // Tombol Simpan
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: ElevatedButton(
                    onPressed: saveChanges,
                    style: ElevatedButton.styleFrom(
                      // primary: const Color(0xFF00897B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        'Save Changes',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
