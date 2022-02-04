import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';

import '../../../data/manage_payattu/models/user_payattu.dart';
import '../../../data/payattu/models/payattu.dart';

part 'manage_payattu_state.dart';

class ManagePayattuCubit extends Cubit<ManagePayattuState> {
  ManagePayattuCubit() : super(ManagePayattuLoading());

  void loadPayattu() async {
    emit(ManagePayattuLoading());
    final box = await Hive.openBox('payatts');
    final payattuRawList = box.get('payatts') as List;
    List<UserPayattu> payattulist = [];
    for (var e in payattuRawList) {
      payattulist.add(e);
    }
    emit(ManagePayattuLoaded(payattuList: payattulist));
  }

  void addPayattu({
    required List<UserPayattu> currentPayatts,
    required Payattu payattu,
    required double amount,
  }) async {
    emit(ManagePayattuLoading());

    final newPayatts = [
      ...currentPayatts,
      UserPayattu(payattu: payattu, amount: amount)
    ];
    final box = await Hive.openBox('payatts');
    box.put('payatts', newPayatts);
    emit(ManagePayattuLoaded(payattuList: newPayatts));
  }
}
