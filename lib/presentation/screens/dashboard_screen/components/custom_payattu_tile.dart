import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/assets.dart';
import '../../../../data/payattu/models/payattu.dart';

class CustomPayattuTile extends StatelessWidget {
  const CustomPayattuTile({
    Key? key,
    required Payattu payattu,
    required void Function() onTap,
  })  : _payattu = payattu,
        _onTap = onTap,
        super(key: key);

  final void Function() _onTap;
  final Payattu _payattu;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: _onTap,
      leading: CircleAvatar(
        foregroundImage: (_payattu.coverImageUrl != '')
            ? CachedNetworkImageProvider(_payattu.coverImageUrl)
            : null,
        backgroundImage: const AssetImage(Assets.defaultProfile),
      ),
      title: Text(
        _payattu.host,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        _payattu.date.toString(),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      trailing: const Icon(Icons.add),
    );
  }
}
