import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:relawanin_mobile_project/Authenticator/login.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final fullname = TextEditingController();
  final email = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final noTelp = TextEditingController();
  String? gender;
  String? provinsi;
  DateTime? selectedDate;
  final pekerjaan = TextEditingController();
  final institusi = TextEditingController();

  final formkey = GlobalKey<FormState>();

  bool isVisible = false;

  // Fungsi untuk mendaftarkan pengguna
  Future<void> registerUser() async {
    if (formkey.currentState!.validate()) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text,
          password: password.text,
        );

        User? user = userCredential.user;

        if (user != null) {
          // Generate UUID for user id
          String userId = Uuid().v4();

          // Simpan data pengguna ke Firestore
          await FirebaseFirestore.instance.collection('users').doc(userId).set({
            'id': userId,
            'fullname': fullname.text ?? '',
            'email': email.text ?? '',
            'username': username.text ?? '',
            'password': password.text ?? '',
            'noTelphone': noTelp.text ?? '',
            'gender': gender ?? '',
            'tgl_lahir': selectedDate != null
                ? DateFormat('yyyy-MM-dd').format(selectedDate!)
                : '',
            'pekerjaan': pekerjaan.text ?? '',
            'institusi': institusi.text ?? '',
            'provinsi': provinsi ?? '',
          });

          // Navigasi ke halaman login atau halaman lainnya
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        }
      } on FirebaseAuthException catch (e) {
        print('Failed with error code: ${e.code}');
        print(e.message);
        // Tampilkan pesan error ke pengguna
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'Registration failed')),
        );
      }
    }
  }

  // Fungsi untuk mengisi daftar opsi dropdown
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
      'Papua' 'Papua Tengah',
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

  // Fungsi untuk menampilkan dialog pemilih tanggal
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/Ilustrasi_2-removebg-preview.png',
                    height: 200,
                    width: 300,
                  ),
                  Center(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Color(0xFF00897B),
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Register new account',
                      style: TextStyle(
                        color: Color.fromRGBO(0, 137, 123, 0.5),
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
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
                          return "name is required!!!";
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

                  // email
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
                          return "email is required!!!";
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
                          return "username is required!!!";
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

                  // Password
                  Container(
                    margin: const EdgeInsets.all(11),
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
                      controller: password,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "password is required!!!";
                        }
                        return null;
                      },
                      obscureText: isVisible,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.lock,
                          color: Color.fromRGBO(0, 137, 123, 10),
                        ),
                        border: InputBorder.none,
                        hintText: 'Password',
                        suffixIcon: IconButton(
                          onPressed: () {
                            // Tempat buat visible atau hide password
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                          icon: Icon(isVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                          color: Color.fromRGBO(0, 137, 123, 10),
                        ),
                      ),
                    ),
                  ),

                  // Confirm Password
                  Container(
                    margin: const EdgeInsets.all(11),
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
                      controller: confirmPassword,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "password is required!!!";
                        } else if (password.text != confirmPassword.text) {
                          return "password don't match";
                        }
                        return null;
                      },
                      obscureText: isVisible,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.lock,
                          color: Color.fromRGBO(0, 137, 123, 10),
                        ),
                        border: InputBorder.none,
                        hintText: 'Confirm Password',
                        suffixIcon: IconButton(
                          onPressed: () {
                            // Tempat buat visible atau hide password
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                          icon: Icon(isVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                          color: Color.fromRGBO(0, 137, 123, 10),
                        ),
                      ),
                    ),
                  ),

                  // No telphone
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
                          return "no telphone is required!!!";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: Color.fromRGBO(0, 137, 123, 10),
                        ),
                        border: InputBorder.none,
                        hintText: 'No telphone',
                      ),
                    ),
                  ),

                  // gender
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
                      value: gender,
                      onChanged: (newValue) {
                        setState(() {
                          gender = newValue;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select your gender';
                        }
                        return null;
                      },
                      items: <String>['Male', 'Female']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: Color.fromRGBO(0, 137, 123, 10),
                        ),
                        border: InputBorder.none,
                        hintText: 'Select Gender',
                      ),
                    ),
                  ),

                  // tanggal lahir
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
                    child: InkWell(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: InputDecorator(
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.calendar_today,
                            color: Color.fromRGBO(0, 137, 123, 10),
                          ),
                          border: InputBorder.none,
                          hintText: 'Tanggal Lahir',
                        ),
                        child: Text(
                          selectedDate != null
                              ? DateFormat('yyyy-MM-dd').format(selectedDate!)
                              : 'Pilih Tanggal',
                        ),
                      ),
                    ),
                  ),

                  // pekerjaan
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
                          return "Job is required!!!";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: Color.fromRGBO(0, 137, 123, 10),
                        ),
                        border: InputBorder.none,
                        hintText: 'Job',
                      ),
                    ),
                  ),

                  // institusi
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
                          return "institusi is required!!!";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: Color.fromRGBO(0, 137, 123, 10),
                        ),
                        border: InputBorder.none,
                        hintText: 'Institusi',
                      ),
                    ),
                  ),

                  // provinsi
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
                      value: provinsi,
                      onChanged: (newValue) {
                        setState(() {
                          provinsi = newValue;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Select Provinsi';
                        }
                        return null;
                      },
                      items:
                          dropdownItems(), // Memanggil fungsi dropdownItems untuk mengisi daftar opsi dropdown
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: Color.fromRGBO(0, 137, 123, 10),
                        ),
                        border: InputBorder.none,
                        hintText: 'Select Provinsi',
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Button Sign up
                  Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width * .9,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(0, 137, 123, 10),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextButton(
                      onPressed: registerUser,
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 10),

                  // button sign in
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                          );
                        },
                        child: const Text(
                          "SIGN IN",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(0, 137, 123, 10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
