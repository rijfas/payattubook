import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payattubook/core/constants/default_widgets.dart';
import 'package:payattubook/core/themes/app_theme.dart';
import 'package:payattubook/core/utils/utils.dart';
import 'package:payattubook/data/transactions/transaction.dart';
import 'package:payattubook/logic/host_payattu/cubit/host_payattu_cubit.dart';
import 'package:payattubook/presentation/components/default_shaded_container.dart';
import 'package:payattubook/presentation/components/transaction_tile.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/host_payattu/cubit/host_payattu_cubit.dart';

class HostPayattuScreen extends StatefulWidget {
  const HostPayattuScreen({Key? key}) : super(key: key);

  @override
  State<HostPayattuScreen> createState() => _HostPayattuScreenState();
}

class _HostPayattuScreenState extends State<HostPayattuScreen> {
  List<Transaction> _transactions = [];
  late final RealtimeSubscription _realtimeSubscription;
  @override
  void initState() {
    context.read<HostPayattuCubit>().loadHostTransactions();
    _realtimeSubscription = Utils.supabase
        .from('transaction')
        .on(SupabaseEventTypes.insert, (payload) {
      context.read<HostPayattuCubit>().loadHostTransactions();
      // for (final transactionMap in payload) {
      //   _transactions.add(Transaction(
      //       id: transactionMap['id'],
      //       recipient: transactionMap['recipient'],
      //       date: transactionMap['date'],
      //       amount: transactionMap['amount']));
      // }
    }).subscribe();
    super.initState();
  }

  @override
  void dispose() {
    _realtimeSubscription.unsubscribe();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Host Payattu'),
        actions: [
          IconButton(
              onPressed: () => Utils.showSnackBar(
                  context: context, message: 'Scan QR to make payment'),
              icon: const Icon(Icons.help))
        ],
      ),
      body: Padding(
        padding: DefaultWidgets.padding,
        child: Column(children: [
          DefaultShadedContainer(
            child: CircleAvatar(
              radius: size.width * 0.25,
              backgroundColor: Colors.transparent,
              child: QrImage(
                padding: EdgeInsets.all(size.width * 0.05),
                data: Utils.supabase.auth.currentUser!.id,
                foregroundColor: AppTheme.lightPrimaryColor,
              ),
            ),
          ),
          DefaultWidgets.verticalSizedBox,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text(
                  'Latest Transactions',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                )
              ],
            ),
          ),
          const Divider(),
          Expanded(child: BlocBuilder<HostPayattuCubit, HostPayattuState>(
            builder: (context, state) {
              if (state is HostPayattuLoaded) {
                return ListView.builder(
                    itemCount: state.transactions.length,
                    itemBuilder: ((context, index) => TransactionTile(
                        transaction: state.transactions[index])));
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ))
        ]),
      ),
    );
  }
}
