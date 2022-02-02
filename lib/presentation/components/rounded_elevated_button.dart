import 'package:flutter/material.dart';

class RoundedElevatedButton extends StatelessWidget {
  const RoundedElevatedButton({
    Key? key,
    required this.child,
    this.onPressed,
    this.color,
  }) : super(key: key);
  final void Function()? onPressed;
  final Widget child;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color,
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}