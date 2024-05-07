import 'package:flutter/material.dart';
import 'package:relawanin_mobile_project/Authenticator/login.dart';
import 'package:relawanin_mobile_project/JsonModels/relawan.dart';
import 'package:relawanin_mobile_project/SQLite/sqlite.dart';

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

  final formkey = GlobalKey<FormState>();

  bool isVisible = false;

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
                          Icons.person,
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
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            // Memanggil fungsi signUp untuk menambahkan pengguna baru
                            final db = DatabaseHelper();
                            db
                                .signUp(Relawan(
                                    username: username.text,
                                    usrPass: password.text))
                                .then((result) {
                              if (result == -1) {
                                // Jika gagal menambahkan pengguna karena username sudah ada
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('Username already exists'),
                                    content: Text(
                                        'Please choose a different username.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                // Jika berhasil menambahkan pengguna, kembali ke halaman login
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()),
                                );
                              }
                            });
                          }
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w700),
                        )),
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
                                  builder: (context) => const LoginScreen()));
                        },
                        child: const Text(
                          "SIGN IN",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(0, 137, 123, 10)),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
