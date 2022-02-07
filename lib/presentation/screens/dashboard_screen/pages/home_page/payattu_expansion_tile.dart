import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:payattubook/presentation/components/rounded_elevated_button.dart';

import '../../../../../data/discover_payattu/models/payattu.dart';
import '../../../../components/default_shaded_container.dart';
import '../../../../components/rounded_profile.dart';
import '../../components/custom_expansion_tile.dart';

class PayattuExpansionTile extends StatelessWidget {
  const PayattuExpansionTile({Key? key, required this.payattu})
      : super(key: key);
  final Payattu payattu;

  @override
  Widget build(BuildContext context) {
    return DefaultShadedContainer(
      margin: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      child: CustomExpansionTile(
        leading: RoundedProfile(url: payattu.coverImageUrl),
        title: Text(payattu.host),
        children: [
          ListTile(
            selected: true,
            leading: const Icon(Icons.date_range_outlined),
            title: Text(DateFormat("EEEE, dd/MM/y").format(payattu.date)),
            subtitle: const Text('Date'),
          ),
          ListTile(
            selected: true,
            leading: const Icon(Icons.access_time_filled_outlined),
            title: Text(payattu.time.format(context)),
            subtitle: const Text('Time'),
          ),
          ListTile(
            selected: true,
            leading: const Icon(Icons.location_on),
            title: Text(payattu.location),
            subtitle: const Text('Location'),
          ),
          RoundedElevatedButton(
            child: const Text('Add to payattlist'),
            onPressed: () {},
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(10.0),
            ),
          )
        ],
      ),
    );
  }
}
