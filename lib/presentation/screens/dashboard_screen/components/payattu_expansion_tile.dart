import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/assets.dart';
import '../../../../data/payattu/models/payattu.dart';
import '../../../components/default_shaded_container.dart';
import 'custom_expansion_tile.dart';

class PayattuExpansionTile extends StatelessWidget {
  const PayattuExpansionTile({Key? key, required Payattu payattu})
      : _payattu = payattu,
        super(key: key);
  final Payattu _payattu;

  @override
  Widget build(BuildContext context) {
    return DefaultShadedContainer(
      margin: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      child: CustomExpansionTile(
        leading: CircleAvatar(
          foregroundImage: (_payattu.coverImageUrl != '')
              ? CachedNetworkImageProvider(_payattu.coverImageUrl)
              : null,
          backgroundImage: const AssetImage(Assets.defaultProfile),
        ),
        title: Text(_payattu.host),
        children: [
          ListTile(
            selected: true,
            leading: const Icon(Icons.date_range_outlined),
            title: Text(_payattu.date.toString()),
            subtitle: const Text('Date'),
          ),
          ListTile(
            selected: true,
            leading: const Icon(Icons.access_time_filled_outlined),
            title: Text(_payattu.time),
            subtitle: const Text('Time'),
          ),
          ListTile(
            selected: true,
            leading: const Icon(Icons.location_on),
            title: Text(_payattu.location),
            subtitle: const Text('Location'),
          )
        ],
      ),
    );
  }
}
