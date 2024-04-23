import 'package:flutter/material.dart';
import 'SignUp.dart';
import 'package:relawanin_mobile_project/dashboard_page.dart';
import 'package:relawanin_mobile_project/JsonModels/relawan.dart';
import 'package:relawanin_mobile_project/SQLite/sqlite.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // text password buat visible dan hide
  final username = TextEditingController();
  final password = TextEditingController();

  // Buat Password hide
  bool isVisible = false;

  //buat cek sign salah 
  bool isLoginTrue = false;

  final db = DatabaseHelper();

  login() async{
    var response = await db
      .login(Relawan(username: username.text, usrPass: password.text));
    if(response == true){
      if(!mounted)return;
      Navigator.push(
        context, MaterialPageRoute(builder: (context) => DashboardPage()));
    }else{
      setState(() {
        isLoginTrue = true;
      });
    }
  }

  // Buat Validasi password
  final formkey = GlobalKey<FormState>();

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
                  key: formkey,
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
                      // username
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
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
          
                      SizedBox(height: 10),
          
                      // Button Sign in
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
                                login();
                              }
                            },
                            child: const Text(
                              'Sign In',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            )),
                      ),
          
                      SizedBox(height: 10),
          
                      // button sign up
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have any account?"),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Register()));
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
                      isLoginTrue? const Text(
                       "Username or password incorrect",
                       style: TextStyle(color: Colors.red), 
                      ): const SizedBox(),
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
