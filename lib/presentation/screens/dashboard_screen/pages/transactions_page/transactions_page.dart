import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
          child: BlocBuilder<TransactionsCubit, TransactionsState>(
            builder: (context, state) {
              if (state is TransactionsLoadingCompleted) {
                if (state.transactions.isEmpty) {
                  return const DeafultEmptyWidget(message: 'No Transactions');
                }
                return Column(
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
                            Text(
                              state.totalAmount.toString(),
                              style: const TextStyle(
                                fontSize: 28.0,
                                fontWeight: FontWeight.bold,
                              ),
                            )
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
                      child: ListView.builder(
                        itemCount: state.transactions.length,
                        itemBuilder: (context, index) => DefaultShadedContainer(
                          child: ListTile(
                            leading: const Icon(FontAwesomeIcons.rupeeSign),
                            title: Text(
                              state.transactions[index].recipient,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              state.transactions[index].date.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                            trailing: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Theme.of(context).primaryColor,
                              ),
                              child: Text(
                                state.transactions[index].amount.toString(),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
