import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../data/discover_payattu/models/payattu.dart';
import '../../../components/rounded_profile.dart';

class PayattuTile extends StatelessWidget {
  const PayattuTile({
    Key? key,
    required this.payattu,
    this.onTap,
    this.trailing,
  }) : super(key: key);

  final void Function()? onTap;
  final Widget? trailing;
  final Payattu payattu;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: true,
      onTap: onTap,
      leading: RoundedProfile(url: payattu.coverImageUrl),
      title: Text(
        payattu.host,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        DateFormat("EEE, dd/MM/y").format(payattu.date),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      trailing: trailing,
    );
  }
}
