import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import '../../../data/transactions/transaction.dart';

part 'transactions_state.dart';

class TransactionsCubit extends Cubit<TransactionsState> {
  TransactionsCubit() : super(TransactonsLoading());

  void loadTransactions() async {
    emit(TransactonsLoading());

    final box = await Hive.openBox('transactions');
    final rawTransactions = box.values.toList();
    List<Transaction> transactions = [];
    for (final transaction in rawTransactions) {
      transactions.add(transaction);
    }
    emit(TransactionsLoadingCompleted(transactions: transactions));
  }

  void addTransaction({
    required String recipient,
    required DateTime date,
    required double amount,
  }) async {
    emit(TransactonsLoading());
    const uuid = Uuid();
    final id = uuid.v1();
    final transaction =
        Transaction(id: id, recipient: recipient, date: date, amount: amount);
    final box = await Hive.openBox('transactions');
    await box.put(id, transaction);
    emit(TransactionsAdded());
    loadTransactions();
  }

  void removeTransaction({required String id}) async {
    emit(TransactonsLoading());
    final box = await Hive.openBox('transactions');
    await box.delete(id);
    loadTransactions();
  }
}
