import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:payattubook/core/utils/error_discriptors.dart';

import '../../../core/utils/utils.dart';
import '../../../data/authentication/models/user.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationPending());

  /// signs up the user with given details
  /// uploads the profileImage if present with the given filename
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
      emit(AuthenticationError(
          message: ErrorDescriptors.getNetworkErrorOrOriginalFromGotrueError(
              response.error)));
      return;
    }

    if (response.data == null) {
      emit(AuthenticationError(message: 'Unknown Error'));
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
      emit(AuthenticationError(
          message: ErrorDescriptors.getNetworkErrorOrOriginalFromPostgrestError(
              profile.error)));
      return;
    }

    if (profile.data == null) {
      emit(AuthenticationError(message: 'Unknown Error'));
      return;
    }

    final user = User(
        profileUrl: imageUrl ?? '',
        fullName: fullName,
        phoneNumber: phoneNumber,
        address: address);

    final box = await Hive.openBox('profile');
    box.put('user', user);
    emit(AuthenticationCompleted(user: user));
  }

  void signIn({required String phoneNumber, required String password}) async {
    emit(AuthenticationLoading());
    // login
    final response = await Utils.supabase.auth
        .signIn(phone: phoneNumber, password: password);

    if (response.error != null) {
      emit(AuthenticationError(
          message: ErrorDescriptors.getNetworkErrorOrOriginalFromGotrueError(
              response.error)));
      return;
    }

    if (response.data == null) {
      emit(AuthenticationError(message: 'Unknown Error'));
      return;
    }

    // create profile in profile table
    final profile = await Utils.supabase
        .from('profiles')
        .select()
        .eq('user', response.user?.id)
        .execute();

    if (profile.error != null) {
      emit(AuthenticationError(
          message: ErrorDescriptors.getNetworkErrorOrOriginalFromPostgrestError(
              profile.error)));
      return;
    }

    if (profile.data == null) {
      emit(AuthenticationError(message: 'Unknown Error'));
      return;
    }

    final user = User(
        profileUrl: profile.data[0]['profile_url'] ?? '',
        fullName: profile.data[0]['full_name'],
        phoneNumber: profile.data[0]['phone_number'],
        address: profile.data[0]['address']);
    final box = await Hive.openBox('profile');
    box.put('user', user);
    emit(AuthenticationCompleted(user: user));
  }

  void signOut() {
    emit(AuthenticationPending());
  }

  void signInWithSession() async {
    emit(AuthenticationLoading());
    final box = await Hive.openBox('profile');
    final user = await box.get('user');
    if (user == null) {
      emit(AuthenticationError(
          message: 'Session expired, please login to continue'));
    } else {
      emit(AuthenticationCompleted(user: user));
    }
  }
}
