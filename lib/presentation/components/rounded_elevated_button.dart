import 'package:flutter/material.dart';

class RoundedElevatedButton extends StatelessWidget {
  const RoundedElevatedButton({
    Key? key,
    required this.child,
    this.shrinkWrap = false,
    this.onPressed,
    this.color,
    this.borderRadius,
  }) : super(key: key);
  final void Function()? onPressed;
  final Widget child;
  final Color? color;
  final BorderRadiusGeometry? borderRadius;
  final bool shrinkWrap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: shrinkWrap ? null : double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color,
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
