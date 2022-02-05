import 'package:flutter/material.dart';

class DefaultShadedContainer extends StatelessWidget {
  const DefaultShadedContainer({
    Key? key,
    required Widget child,
    double borderRadius = 10.0,
    EdgeInsets margin = const EdgeInsets.all(8.0),
  })  : _child = child,
        _borderRadius = borderRadius,
        _margin = margin,
        super(key: key);
  final Widget _child;
  final double _borderRadius;
  final EdgeInsets _margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: _margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_borderRadius),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 5),
            color: Colors.black12,
            blurRadius: 5,
          )
        ],
      ),
      child: _child,
    );
  }
}
