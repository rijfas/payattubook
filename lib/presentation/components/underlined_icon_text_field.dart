import 'package:flutter/material.dart';

class UnderlinedIconTextField extends StatelessWidget {
  const UnderlinedIconTextField({
    Key? key,
    required this.hintText,
    required this.icon,
    required this.controller,
    this.obscureText = false,
  }) : super(key: key);
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        icon: Icon(
          icon,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFF5F5F5),
          ),
        ),
      ),
    );
  }
}
