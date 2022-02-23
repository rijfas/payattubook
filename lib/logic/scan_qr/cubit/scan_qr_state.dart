part of 'scan_qr_cubit.dart';

abstract class ScanQrState {}

class ScanQrInitial extends ScanQrState {}

class ScanQrLoading extends ScanQrState {}

class ScanQrCompleted extends ScanQrState {
  final String code;
  ScanQrCompleted({required this.code});
}

class ScanQrError extends ScanQrState {
  final String message;
  ScanQrError({required this.message});
}

// class TransactionAdded extends ScanQrState {
//   // final Payattu payattu;
//   final double amount;
//   TransactionAdded({required this.payattu, required this.amount});
// }
