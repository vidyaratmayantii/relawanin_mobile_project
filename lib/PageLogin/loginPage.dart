import 'package:flutter/material.dart';
import 'package:relawanin_mobile_project/PageLogin/ButtonSignin.dart';
import 'package:relawanin_mobile_project/PageLogin/ButtonSignup.dart';
import 'package:relawanin_mobile_project/PageLogin/textField.dart';

class loginPage extends StatelessWidget {
  loginPage({Key? key}) : super(key: key);

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn() {}
  void signUserUp() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: ListView(
            scrollDirection: Axis.vertical, // Scroll direction added here
            children: [
              const SizedBox(height: 30),
              //logo
              Image.asset(
                'assets/Ilustrasi_2-removebg-preview.png',
                height: 200,
                width: 300,
              ),

              //quote
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

              const SizedBox(height: 30),

              //Username field
              MyTextField(
                controller: usernameController,
                hintText: 'Email',
                obscureText: false,
                prefixIcon: Icons.mail,
              ),

              const SizedBox(height: 30),

              //password field
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: false,
                prefixIcon: Icons.lock,
              ),

              const SizedBox(height: 10),

              //forgot password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password',
                      style: TextStyle(
                        color: Color.fromRGBO(0, 137, 123, 10),
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              //sign button
              MyButtonSignIn(
                onTap: signUserIn,
              ),

              const SizedBox(height: 10),

              // continue with
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.7,
                        color: Color.fromRGBO(0, 137, 123, 10),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(0, 137, 123, 10),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.7,
                        color: Color.fromRGBO(0, 137, 123, 10),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              //Sign up
              MyButtonSignUp(
                onTap: signUserUp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
