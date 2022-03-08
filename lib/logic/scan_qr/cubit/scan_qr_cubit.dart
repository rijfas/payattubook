import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/utils.dart';
import '../../../data/authentication/models/user.dart';
import '../../../data/discover_payattu/models/payattu.dart';

part 'scan_qr_state.dart';

class ScanQrCubit extends Cubit<ScanQrState> {
  ScanQrCubit() : super(ScanQrInitial());

  void scanQr({required String code}) async {
    // emit(ScanQrLoading());
    // final response = await Utils.supabase
    //     .from('profiles')
    //     .select()
    //     .eq('user', code)
    //     .execute();
    // if (response.error != null) {
    //   emit(ScanQrError(message: response.error!.message));
    // }
    // final user = User(
    //     profileUrl: response.data[0]['profile_url'] ?? '',
    //     fullName: response.data[0]['full_name'],
    //     phoneNumber: response.data[0]['phone_number'],
    //     address: response.data[0]['address']);
    // emit(ScanQrCompleted(user: user));

    emit(ScanQrLoading());
    final response = await Utils.supabase
        .from('payatts')
        .select()
        .eq('id', int.parse(code))
        .execute();

    if (response.error != null) {
      emit(ScanQrError(message: response.error!.message));
    }
    final payattu = Payattu(
      id: response.data[0]['id'],
      host: response.data[0]['host'],
      time: TimeOfDay(
          hour: Utils.getHoursFromTimeString(response.data[0]['time']),
          minute: Utils.getMinutesFromTimeString(response.data[0]['time'])),
      hostPhoneNumber: response.data[0]['host_phone_number'],
      location: response.data[0]['location'],
      date: DateTime.parse(response.data[0]['date']),
      createdBy: response.data[0]['created_by'],
      coverImageUrl: response.data[0]['cover_image_url'],
    );
    emit(ScanQrCompleted(payattu: payattu));
  }

  void addTransaction(
      {required Payattu payattu,
      required String sender,
      required String senderName,
      required double amount}) async {
    emit(ScanQrLoading());
    final response = await Utils.supabase.from('transaction').upsert({
      'payattu': payattu.id,
      'sender': sender,
      'sender_name': senderName,
      'amount': amount,
    }).execute();
    if (response.error != null) {
      emit(ScanQrError(message: response.error!.message));
    }
    emit(TransactionAdded(payattu: payattu, amount: amount));
  }
}
