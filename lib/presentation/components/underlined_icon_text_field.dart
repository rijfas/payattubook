import 'package:flutter/material.dart';

class UnderlinedIconTextField extends StatelessWidget {
  const UnderlinedIconTextField({
    Key? key,
    required this.icon,
    required this.controller,
    this.labelText,
    this.obscureText = false,
    this.validator,
    this.hintText,
  }) : super(key: key);
  final String? labelText;
  final String? hintText;
  final IconData icon;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        icon: Icon(
          icon,
        ),
        hintText: hintText,
        label: labelText == null ? null : Text(labelText!),
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
