import 'package:bloc/bloc.dart';

import '../../../core/utils/utils.dart';
import '../../../data/transactions/transaction.dart';

part 'host_payattu_state.dart';

class HostPayattuCubit extends Cubit<HostPayattuState> {
  HostPayattuCubit() : super(HostPayattuLoading());

  void loadHostTransactions({required int payattuId}) async {
    emit(HostPayattuLoading());
    final response = await Utils.supabase
        .from('transaction')
        .select()
        .eq('payattu', payattuId)
        .execute();
    if (response.error != null) {
      emit(HostPayattuError());
      return;
    }
    final data = response.data;
    List<Transaction> transactions = [];
    data.forEach((e) {
      transactions.add(Transaction(
          id: e['id'].toString(),
          recipient: e['sender_name'],
          amount: e['amount'].toDouble(),
          date: DateTime.parse(e['created_at'])));
    });
    emit(HostPayattuLoaded(transactions: transactions));
  }

  void addHostTransaction(
      List<Transaction> old, Map<String, dynamic> newRecord) async {
    emit(HostPayattuLoaded(
        transactions: [...old, Transaction.fromMap(newRecord)]));
  }
}
