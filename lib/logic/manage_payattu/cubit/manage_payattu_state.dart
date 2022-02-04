part of 'manage_payattu_cubit.dart';

abstract class ManagePayattuState {}

class ManagePayattuLoading extends ManagePayattuState {}

class ManagePayattuLoaded extends ManagePayattuState {
  ManagePayattuLoaded({required this.payattuList});
  final List<UserPayattu> payattuList;
}

class ManagePayattuError extends ManagePayattuState {
  ManagePayattuError({required this.message});
  final String message;
}
