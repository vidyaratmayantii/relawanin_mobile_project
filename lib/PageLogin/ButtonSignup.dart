import 'package:flutter/material.dart';

class MyButtonSignUp extends StatefulWidget {
  final Function()? onTap;

  const MyButtonSignUp({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButtonSignUp> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => isHovered = true),
      onTapUp: (_) => setState(() => isHovered = false),
      onTapCancel: () => setState(() => isHovered = false),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 50),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isHovered
              ? Color.fromRGBO(0, 137, 123, 0.5)
              : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Color.fromRGBO(0, 137, 123, 0.5), // Warna border
            width: 2.0, // Lebar border
          ),
        ),
        child: Center(
          child: Text(
            "Sign up",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
