import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/error_discriptors.dart';
import '../../../core/utils/utils.dart';
import '../../../data/discover_payattu/models/payattu.dart';

part 'discover_payattu_state.dart';

class DiscoverPayattuCubit extends Cubit<DiscoverPayattuState> {
  DiscoverPayattuCubit() : super(DiscoverPayattuLoading());

  Future<void> loadPayattu() async {
    // show loading
    emit(DiscoverPayattuLoading());
    // fetch data from backend
    final response = await Utils.supabase.from('payatts').select().execute();
    // show error if error is not null
    if (response.error != null) {
      emit(DiscoverPayattuError(
          message: ErrorDescriptors.getNetworkErrorOrOriginalFromPostgrestError(
              response.error)));
      return;
    }
    // convert data to payatt model
    final data = response.data;
    late List<Payattu> payatts = [];
    data.forEach((e) {
      payatts.add(Payattu(
        id: e['id'],
        host: e['host'],
        time: TimeOfDay(
            hour: Utils.getHoursFromTimeString(e['time']),
            minute: Utils.getMinutesFromTimeString(e['time'])),
        hostPhoneNumber: e['host_phone_number'],
        location: e['location'],
        date: DateTime.parse(e['date']),
        createdBy: e['created_by'],
        coverImageUrl: e['cover_image_url'],
      ));
    });
    // loading success
    emit(DiscoverPayattuLoaded(payattList: payatts));
  }

  void searchPayattu({required String hostName}) async {
    // show loading
    emit(DiscoverPayattuLoading());
    // load data from backend
    final response = await Utils.supabase
        .from('payatts')
        .select()
        .ilike('host', '%$hostName%')
        .execute();
    // show error if error is not null
    if (response.error != null) {
      emit(DiscoverPayattuError(
          message: ErrorDescriptors.getNetworkErrorOrOriginalFromPostgrestError(
              response.error)));
      return;
    }
    final data = response.data;
    late List<Payattu> payatts = [];
    data.forEach((e) {
      payatts.add(Payattu(
        id: e['id'],
        host: e['host'],
        time: TimeOfDay(
            hour: Utils.getHoursFromTimeString(e['time']),
            minute: Utils.getMinutesFromTimeString(e['time'])),
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
