import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../core/constants/assets.dart';

class RoundedProfile extends StatelessWidget {
  const RoundedProfile({Key? key, required this.url, this.radius})
      : super(key: key);
  final String url;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      foregroundImage: (url != '') ? CachedNetworkImageProvider(url) : null,
      backgroundImage: const AssetImage(Assets.defaultProfile),
    );
  }
}
