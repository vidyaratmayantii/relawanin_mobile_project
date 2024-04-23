import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  final IconData prefixIcon;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.prefixIcon,
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(0, 137, 123, 0.5)),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF00897B), width: 2.0),
          ),
          prefixIcon: Icon(
            prefixIcon,
            color: Color.fromRGBO(0, 137, 123, 0.2),
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: Color.fromRGBO(0, 137, 123, 0.2)),
        ),
      ),
    );
  }
}



