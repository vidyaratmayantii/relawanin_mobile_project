import 'package:flutter/material.dart';
import 'package:relawanin_mobile_project/form.dart';

class ButtonGabung extends StatefulWidget {
  final Function()? onTap;

  const ButtonGabung({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<ButtonGabung> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()),
        );
      },
      onTapDown: (_) => setState(() => isHovered = true),
      onTapUp: (_) => setState(() => isHovered = false),
      onTapCancel: () => setState(() => isHovered = false),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 0),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isHovered
              ? Colors.white
              : Color.fromRGBO(0, 137, 123, 10),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Color.fromRGBO(0, 137, 123, 0.10), // Warna border
            width: 2.0, // Lebar border
          ),
        ),
        child: Center(
          child: Text(
            "Bergabung",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
