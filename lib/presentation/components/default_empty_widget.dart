import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/constants/assets.dart';
import '../../core/constants/default_widgets.dart';

class DeafultEmptyWidget extends StatelessWidget {
  const DeafultEmptyWidget({Key? key, required this.message}) : super(key: key);
  final String message;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DefaultWidgets.verticalSizedBox,
        SvgPicture.asset(
          Assets.defaulEmptyImage,
          width: size.width * 0.3,
        ),
        DefaultWidgets.verticalSizedBox,
        Text(message),
      ],
    );
  }
}
