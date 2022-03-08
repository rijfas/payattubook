import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../../core/themes/app_theme.dart';

import '../../data/transactions/transaction.dart';
import '../../logic/transactions/cubit/transactions_cubit.dart';
import 'confirm_popup.dart';
import 'default_shaded_container.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({Key? key, required this.transaction})
      : super(key: key);
  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(transaction.id),
      confirmDismiss: (_) => showDialog<bool>(
          context: context,
          builder: (_) => ConfirmPopup(
              title: 'Delete transaction?',
              message:
                  'are you sure to delete the transaction of ${transaction.recipient}, ₹ ${transaction.amount}')),
      onDismissed: (_) {
        context.read<TransactionsCubit>().removeTransaction(id: transaction.id);
      },
      child: DefaultShadedContainer(
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: AppTheme.lightPrimaryColor,
            child: Text(
              transaction.recipient[0].toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          title: Text(
            transaction.recipient,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            DateFormat("EEE, dd/M/y").format(transaction.date),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          trailing: Container(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Theme.of(context).primaryColor,
            ),
            child: Text(
              '₹ ${transaction.amount}',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
