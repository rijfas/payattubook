part of 'payattu_cubit.dart';

abstract class PayattuState {}

class PayattuLoading extends PayattuState {}

class PayattuLoaded extends PayattuState {}

class PayattuError extends PayattuState {
  final String message;
  PayattuError({required this.message});
}

class PayattuCreated extends PayattuState {}
