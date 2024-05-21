import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    if (email.isEmpty || password.isEmpty) {
      _logger.e("Email or password is empty");
      return;
    }

    try {
      final user = await _login.signInWithEmailAndPassword(email, password);
      if (user != null) {
        // Ambil data pengguna dari Firestore
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          _logger.i("Login successful");

          // Navigasi ke dashboard atau layar lain yang diinginkan
          Navigator.pushReplacementNamed(context, '/dashboard');
        } else {
          _logger.w("User data not found in Firestore");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('User data not found. Please contact support.'),
            ),
          );
        }
      } else {
        _logger.w("Login failed");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login failed. Please try again.'),
          ),
        );
      }
    } catch (e) {
      _logger.e("Error during sign in: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error during sign in: $e'),
        ),
      );
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
