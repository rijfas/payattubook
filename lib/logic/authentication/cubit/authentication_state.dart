part of 'authentication_cubit.dart';

abstract class AuthenticationState {}

class AuthenticationPending extends AuthenticationState {}

class AuthenticationCompleted extends AuthenticationState {
  AuthenticationCompleted({required this.user});
  final User user;
}

class AuthenticationError extends AuthenticationState {
  AuthenticationError({required this.message});
  final String? message;
}

class AuthenticationLoading extends AuthenticationState {}

class ProfileChangeLoading extends AuthenticationState {}
