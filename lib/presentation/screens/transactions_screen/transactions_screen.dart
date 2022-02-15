import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../logic/transactions/cubit/transactions_cubit.dart';
import '../../components/default_empty_widget.dart';
import '../../components/transaction_tile.dart';
import '../../router/app_router.dart';
import '../dashboard_screen/components/custom_search_bar.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
      ),
      body: Column(
        children: [
          CustomSearchBar(
            controller: _searchController,
            onSearch: () {},
            hintText: 'Search Transaction',
          ),
          BlocBuilder<TransactionsCubit, TransactionsState>(
            builder: (context, state) {
              if (state is TransactionsLoadingCompleted) {
                if (state.transactions.isEmpty) {
                  return const DeafultEmptyWidget(message: 'No Transactions');
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.transactions.length,
                    itemBuilder: (context, index) =>
                        TransactionTile(transaction: state.transactions[index]),
                  ),
                );
              }
              return const CircularProgressIndicator();
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(AppRouter.createTransactionScreen);
        },
      ),
    );
  }
}
