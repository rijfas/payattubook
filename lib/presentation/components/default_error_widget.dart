import 'package:flutter/material.dart';
import '../../core/constants/default_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/constants/assets.dart';

class DefaultErrorWidget extends StatelessWidget {
  const DefaultErrorWidget({Key? key, required this.message, this.onRetry})
      : super(key: key);
  final String message;
  final void Function()? onRetry;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DefaultWidgets.verticalSizedBox,
        SvgPicture.asset(
          Assets.defaultErrorImage,
          width: size.width * 0.3,
        ),
        DefaultWidgets.verticalSizedBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message),
            DefaultWidgets.horizontalSizedBox,
            InkWell(
              onTap: onRetry,
              child: const Text(
                'Retry?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ],
    );
  }
}
