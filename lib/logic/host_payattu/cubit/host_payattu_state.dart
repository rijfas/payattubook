part of 'host_payattu_cubit.dart';

abstract class HostPayattuState {}

class HostPayattuLoading extends HostPayattuState {}

class HostPayattuLoaded extends HostPayattuState {
  List<Transaction> transactions;
  HostPayattuLoaded({required this.transactions});
}

class HostPayattuError extends HostPayattuState {}
