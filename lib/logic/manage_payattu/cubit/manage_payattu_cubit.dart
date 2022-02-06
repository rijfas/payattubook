import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';

import '../../../data/discover_payattu/models/payattu.dart';
import '../../../data/manage_payattu/models/user_payattu.dart';

part 'manage_payattu_state.dart';

class ManagePayattuCubit extends Cubit<ManagePayattuState> {
  ManagePayattuCubit() : super(ManagePayattuLoading());

  void loadPayattu() async {
    emit(ManagePayattuLoading());
    final box = await Hive.openBox('payatts');
    final rawPayattuList = box.values.toList();
    List<UserPayattu> payattulist = [];
    for (UserPayattu item in rawPayattuList) {
      payattulist.add(item);
    }
    emit(ManagePayattuLoaded(payattuList: payattulist));
  }

  void addPayattu({
    required Payattu payattu,
    required double amount,
  }) async {
    emit(ManagePayattuLoading());
    final box = await Hive.openBox('payatts');
    box.add(UserPayattu(payattu: payattu, amount: amount));
    loadPayattu();
  }

  void removePayattu({required int index}) async {
    emit(ManagePayattuLoading());
    final box = await Hive.openBox('payatts');
    box.deleteAt(index);
    loadPayattu();
  }
}
