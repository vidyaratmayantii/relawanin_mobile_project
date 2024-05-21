import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:relawanin_mobile_project/dashboard_komunitas.dart';
import 'package:relawanin_mobile_project/dashboard_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:relawanin_mobile_project/Controller/authControllerUser.dart';
import 'package:logger/logger.dart';

class LoginScreen extends StatefulWidget {
  final AuthController? login;
  const LoginScreen({super.key, this.login});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isVisible = false;
  bool isLoginTrue = false;

  late final AuthController _login;
  final Logger _logger = Logger();

  @override
  void initState() {
    super.initState();
    _login = widget.login ??
        AuthController(); // Or provide your default RegisterService constructor
  }

  Future<void> signIn() async {
    if (formkey.currentState!.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text.trim(),
          password: password.text.trim(),
        );

        // Akses data pengguna yang sudah masuk
        User? user = userCredential.user;
        if (user != null) {
          String uid = user.uid;

          // Dapatkan data tambahan dari Firestore menggunakan UID pengguna
          DocumentSnapshot userData = await FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .get();

          if (userData.exists) {
            if (userData.data() is Map<String, dynamic>) {
              Map<String, dynamic> userDataMap = userData.data() as Map<String, dynamic>;

              String role = userDataMap['role'];
              if (role == 'komunitas') {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardKomunitas()));
              } else if (role == 'relawan') {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardPage()));
              } else {
              
                print('Role tidak dikenal: $role');
              }
            } else {
              print('Data pengguna tidak sesuai dengan format yang diharapkan');
            }
          } else {
            print('Dokumen pengguna tidak ditemukan');
          }
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          isLoginTrue = true;
        });
        print(e.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100.0),
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/Ilustrasi_2-removebg-preview.png',
                        height: 200,
                        width: 300,
                      ),
                      Center(
                        child: Text(
                          'Welcome Back',
                          style: TextStyle(
                            color: Color(0xFF00897B),
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          'Sign In to continue',
                          style: TextStyle(
                            color: Color.fromRGBO(0, 137, 123, 0.5),
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      // Email
                      Container(
                        margin: const EdgeInsets.all(11),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Color.fromRGBO(0, 137, 123, 0.5),
                            width: 2.0,
                          ),
                          color: Colors.white,
                        ),
                        child: TextFormField(
                          controller: emailController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Email is required!!!";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.person,
                              color: Color.fromRGBO(0, 137, 123, 10),
                            ),
                            border: InputBorder.none,
                            hintText: 'Email',
                          ),
                        ),
                      ),
                      // Password
                      Container(
                        margin: const EdgeInsets.all(11),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Color.fromRGBO(0, 137, 123, 0.5),
                            width: 2.0,
                          ),
                          color: Colors.white,
                        ),
                        child: TextFormField(
                          controller: passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Password is required!!!";
                            }
                            return null;
                          },
                          obscureText: !isVisible,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.lock,
                              color: Color.fromRGBO(0, 137, 123, 10),
                            ),
                            border: InputBorder.none,
                            hintText: 'Password',
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isVisible = !isVisible;
                                });
                              },
                              icon: Icon(
                                isVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              color: Color.fromRGBO(0, 137, 123, 10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Button Sign in
                      Container(
                        height: 55,
                        width: MediaQuery.of(context).size.width * .9,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(0, 137, 123, 10),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextButton(
                          onPressed: signIn,
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Button Sign up
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have any account?"),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/register');
                            },
                            child: const Text(
                              "SIGN UP",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(0, 137, 123, 10)),
                            ),
                          ),
                        ],
                      ),
                      isLoginTrue
                          ? const Text(
                              "Email or password incorrect",
                              style: TextStyle(color: Colors.red),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
