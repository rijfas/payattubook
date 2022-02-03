import 'package:bloc/bloc.dart';
import 'package:payattubook/core/utils/utils.dart';

import '../../../data/payattu/models/payattu.dart';

part 'discover_payattu_state.dart';

class DiscoverPayattuCubit extends Cubit<DiscoverPayattuState> {
  DiscoverPayattuCubit() : super(DiscoverPayattuLoading());

  Future<void> loadPayattu() async {
    emit(DiscoverPayattuLoading());
    final response = await Utils.supabase.from('payatts').select().execute();
    if (response.error != null) {
      emit(DiscoverPayattuError(message: response.error!.message));
      return;
    }
    final data = response.data;
    late List<Payattu> payatts = [];
    data.forEach((e) {
      payatts.add(Payattu(
        host: e['host'],
        time: e['time'],
        hostPhoneNumber: e['host_phone_number'],
        location: e['location'],
        date: DateTime.parse(e['date']),
        createdBy: e['created_by'],
        coverImageUrl: e['cover_image_url'],
      ));
    });

    emit(DiscoverPayattuLoaded(payattList: payatts));
  }
}
