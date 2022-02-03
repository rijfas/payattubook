part of 'create_payattu_cubit.dart';

abstract class CreatePayattuState {}

class CreatePayattuLoading extends CreatePayattuState {}

class CreatePayattuCompleted extends CreatePayattuState {}

class CreatePayattuError extends CreatePayattuState {
  final String message;
  CreatePayattuError({required this.message});
}
