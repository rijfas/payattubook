import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../../../../components/transaction_tile.dart';

import '../../../../../core/constants/default_widgets.dart';
import '../../../../../core/themes/app_theme.dart';
import '../../../../../logic/transactions/cubit/transactions_cubit.dart';
import '../../../../components/default_empty_widget.dart';
import '../../../../components/default_shaded_container.dart';
import '../../../../router/app_router.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    context.read<TransactionsCubit>().loadTransactions();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: DefaultWidgets.padding,
        child: SizedBox(
            height: size.height - kToolbarHeight,
            child: Column(
              children: [
                DefaultShadedContainer(
                  child: Padding(
                    padding: DefaultWidgets.padding,
                    child: Column(
                      children: [
                        const Text(
                          'Total Spent',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        const Divider(),
                        BlocBuilder<TransactionsCubit, TransactionsState>(
                          builder: (context, state) {
                            if (state is TransactionsLoadingCompleted) {
                              return Text(
                                '₹ ${state.totalAmount}',
                                style: const TextStyle(
                                  fontSize: 28.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }

                            return const Text(
                              '₹ 0.0',
                              style: TextStyle(
                                fontSize: 28.0,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                DefaultWidgets.verticalSizedBox,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Latest Transactions',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      InkWell(
                        onTap: () => Navigator.of(context)
                            .pushNamed(AppRouter.transactionsScreen),
                        child: const Text(
                          'View All',
                          style: TextStyle(
                            color: AppTheme.lightSecondaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const Divider(),
                Expanded(
                  child: BlocBuilder<TransactionsCubit, TransactionsState>(
                    builder: (context, state) {
                      if (state is TransactionsLoadingCompleted) {
                        if (state.transactions.isEmpty) {
                          return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                SizedBox(width: double.infinity),
                                DeafultEmptyWidget(message: 'No Transactions')
                              ]);
                        }
                        return ListView.builder(
                          itemCount: state.transactions.length,
                          itemBuilder: (context, index) => TransactionTile(
                              transaction: state.transactions[index]),
                        );
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
