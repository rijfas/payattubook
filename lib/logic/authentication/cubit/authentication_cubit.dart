import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/utils.dart';
import '../../../data/authentication/models/user.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationPending());

  void signUp({
    required String fullName,
    required String phoneNumber,
    required String password,
    required String address,
    Uint8List? profileImage,
    String? profileFileName,
  }) async {
    String? imageUrl;
    emit(AuthenticationLoading());
    // create user account
    final response =
        await Utils.supabase.auth.signUpWithPhone(phoneNumber, password);

    if (response.error != null) {
      emit(AuthenticationError(message: response.error?.message));
      return;
    }

    if (response.data == null) {
      emit(AuthenticationError(message: 'empty response: $response'));
      return;
    }

    if (profileImage != null && profileFileName != null) {
      profileFileName = 'profile.' + profileFileName.split('.').last;
      final image = await Utils.supabase.storage.from('profiles').uploadBinary(
          '${response.data!.user?.id}/$profileFileName', profileImage);
      if (image.error != null) {
        emit(AuthenticationError(message: image.error?.message));
        return;
      }
      imageUrl = Utils.supabase.storage
          .from('profiles')
          .getPublicUrl('${response.data!.user?.id}/$profileFileName')
          .data;
    }

    // create profile in profile table
    final profile = await Utils.supabase.from('profiles').upsert({
      'user': response.data!.user?.id,
      'full_name': fullName,
      'phone_number': phoneNumber,
      'address': address,
      'profile_url': imageUrl,
    }).execute();

    if (profile.error != null) {
      emit(AuthenticationError(message: profile.error?.message));
      return;
    }

    if (profile.data == null) {
      emit(AuthenticationError(message: 'empty response: $response'));
      return;
    }

    final user =
        User(fullName: fullName, phoneNumber: phoneNumber, address: address);
    emit(AuthenticationCompleted(user: user));
  }

  void signIn({required String phoneNumber, required String password}) async {
    emit(AuthenticationLoading());
    // login
    final response = await Utils.supabase.auth
        .signIn(phone: phoneNumber, password: password);

    if (response.error != null) {
      emit(AuthenticationError(message: response.error?.message));
      return;
    }

    if (response.data == null) {
      emit(AuthenticationError(message: 'empty response: $response'));
      return;
    }

    // create profile in profile table
    final profile = await Utils.supabase
        .from('profiles')
        .select()
        .eq('user', response.user?.id)
        .execute();

    if (profile.error != null) {
      emit(AuthenticationError(message: profile.error?.message));
      return;
    }

    if (profile.data == null) {
      emit(AuthenticationError(message: 'empty response: $response'));
      return;
    }

    final user = User(
        profileUrl: profile.data[0]['profile_url'],
        fullName: profile.data[0]['full_name'],
        phoneNumber: profile.data[0]['phone_number'],
        address: profile.data[0]['address']);
    emit(AuthenticationCompleted(user: user));
  }
}