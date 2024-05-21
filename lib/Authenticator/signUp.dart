import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:relawanin_mobile_project/Authenticator/login.dart';
import 'package:intl/intl.dart';
import 'package:relawanin_mobile_project/Controller/authControllerUser.dart';
import 'package:uuid/uuid.dart';
import 'package:logger/logger.dart';

class Register extends StatefulWidget {
  final AuthController? register;
  const Register({super.key, this.register});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isVisible = false;

  final Logger _logger = Logger();
  late final AuthController _register;

  @override
  void initState() {
    super.initState();
    _register = widget.register ?? AuthController();
  }

  Future<void> register() async {
    final email = emailController.text.trim();
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    // Pastikan gender, selectedDate, dan provinsi sudah dipilih sebelum digunakan
    if (email.isEmpty || password.isEmpty || username.isEmpty) {
      _logger.e("One or more required fields are empty");
      return;
    }

    // Call the registerUser method and await for the result
    // Pastikan variabel gender, selectedDate, dan provinsi tidak null sebelum mengirimkannya ke metode registerUser
    final user = await _register.registerUser(
        email, password, username, confirmPassword);

    // Check if the user is not null (registration successful)
    if (user != null) {
      _logger.i("Register successful");

      // Navigate to the HomeScreen using a MaterialPageRoute
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    } else {
      _logger.w("Register failed");

      // Show an error message or handle the registration failure
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registration failed. Please try again.'),
        ),
      );
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
              // key: controller_user.formKey,
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
                      controller: emailController,
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
                      controller: usernameController,
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
                      controller: passwordController,
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
                      controller: confirmPasswordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "password is required!!!";
                        } else if (passwordController !=
                            confirmPasswordController.text) {
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
                      onPressed: () async {
                        await register();
                      },
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