part of 'transactions_cubit.dart';

abstract class TransactionsState {}

class TransactonsLoading extends TransactionsState {}

class TransactionsLoadingCompleted extends TransactionsState {
  TransactionsLoadingCompleted({required this.transactions}) {
    double total = 0.0;
    for (final transaction in transactions) {
      total += transaction.amount;
    }
    totalAmount = total;
  }
  final List<Transaction> transactions;
  late final double totalAmount;
}

class TransactionsAdded extends TransactionsState {}
