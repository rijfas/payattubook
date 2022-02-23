import 'package:bloc/bloc.dart';
import 'package:payattubook/core/utils/utils.dart';
import 'package:payattubook/data/authentication/models/user.dart';

part 'scan_qr_state.dart';

class ScanQrCubit extends Cubit<ScanQrState> {
  ScanQrCubit() : super(ScanQrInitial());

  // void scanQr({required String code}) async {
  //   emit(ScanQrLoading());
  //   final response = await Utils.supabase
  //       .from('profiles')
  //       .select()
  //       .eq('user', code)
  //       .execute();
  //   if (response.error != null) {
  //     emit(ScanQrError(message: response.error!.message));
  //   }
  //   final user = User(
  //       profileUrl: response.data[0]['profile_url'] ?? '',
  //       fullName: response.data[0]['full_name'],
  //       phoneNumber: response.data[0]['phone_number'],
  //       address: response.data[0]['address']);
  //   emit(ScanQrCompleted(user: user));
  // }

  // void addTransaction(
  //     {required User user,
  //     required String recipient,
  //     required double amount}) async {
  //   emit(ScanQrLoading());
  //   final response =
  //       await Utils.supabase.from('transactions').upsert({
  //         'sender':
  //       }).execute();
  // }
}
