import 'package:bloc/bloc.dart';

import '../../../core/utils/utils.dart';
import '../../../data/transactions/transaction.dart';

part 'host_payattu_state.dart';

class HostPayattuCubit extends Cubit<HostPayattuState> {
  HostPayattuCubit() : super(HostPayattuLoading());

  void loadHostTransactions() async {
    emit(HostPayattuLoading());
    final response =
        await Utils.supabase.from('transaction').select().execute();
    if (response.error != null) {
      emit(HostPayattuError());
      return;
    }
    final data = response.data;
    List<Transaction> transactions = [];
    data.forEach((e) {
      transactions.add(Transaction.fromMap(e));
    });
    emit(HostPayattuLoaded(transactions: transactions));
  }

  void addHostTransaction(
      List<Transaction> old, Map<String, dynamic> newRecord) async {
    emit(HostPayattuLoaded(
        transactions: [...old, Transaction.fromMap(newRecord)]));
  }
}
