part of 'discover_payattu_cubit.dart';

abstract class DiscoverPayattuState {}

class DiscoverPayattuLoading extends DiscoverPayattuState {}

class DiscoverPayattuLoaded extends DiscoverPayattuState {
  DiscoverPayattuLoaded({required this.payattList});
  final List<Payattu> payattList;
}

class DiscoverPayattuError extends DiscoverPayattuState {
  DiscoverPayattuError({required this.message});
  final String message;
}
