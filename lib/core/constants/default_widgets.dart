import 'package:flutter/material.dart';

class DefaultWidgets {
  const DefaultWidgets._();
  static const padding = EdgeInsets.all(8.0);
  static const verticalSizedBox = SizedBox(height: 8.0);
  static const horizontalSizedBox = SizedBox(width: 4.0);
  static Widget verticalSpacing(
      {required BuildContext context, double height = 0.025}) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(height: size.height * height);
  }

  static Widget horizontalSpacing(
      {required BuildContext context, double width = 0.025}) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(height: size.width * width);
  }
}
