import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../logic/transactions/cubit/transactions_cubit.dart';
import '../../components/default_empty_widget.dart';
import '../../components/default_shaded_container.dart';
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
                    itemBuilder: (context, index) => DefaultShadedContainer(
                      child: ListTile(
                        leading: const Icon(FontAwesomeIcons.rupeeSign),
                        title: Text(
                          state.transactions[index].recipient,
                          style: const TextStyle(fontWeight: FontWeight.bold),
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
          context.read<TransactionsCubit>().addTransaction(
              recipient: 'Rijfas', date: DateTime.now(), amount: 12300);
        },
      ),
    );
  }
}
