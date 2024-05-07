import 'package:flutter/material.dart';

class ButtonHubungi extends StatefulWidget {
  final Function()? onTap;

  const ButtonHubungi({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<ButtonHubungi> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => isHovered = true),
      onTapUp: (_) => setState(() => isHovered = false),
      onTapCancel: () => setState(() => isHovered = false),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 0),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isHovered
              ? Color.fromRGBO(0, 137, 123, 10)
              : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Color.fromRGBO(0, 137, 123, 10.0), // Warna border
            width: 2.0, // Lebar border
          ),
        ),
        child: Center(
          child: Text(
            "Hubungi Organisasi",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
