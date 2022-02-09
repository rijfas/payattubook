import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Slide extends StatelessWidget {
  const Slide(
      {Key? key,
      required this.slide,
      required this.title,
      required this.subTitle})
      : super(key: key);
  final String slide;
  final String title;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          slide,
          width: size.width * 0.4,
        ),
        SizedBox(height: size.height * 0.03),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
        ),
        Text(
          subTitle,
          style: TextStyle(color: Theme.of(context).disabledColor),
        )
      ],
    );
  }
}
