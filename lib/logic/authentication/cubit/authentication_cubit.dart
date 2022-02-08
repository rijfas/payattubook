import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import 'package:hive/hive.dart';

import '../../../core/utils/error_discriptors.dart';
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

  void reSignIn() {
    emit(AuthenticationPending());
  }

  Future<void> signOut() async {
    emit(AuthenticationLoading());
    final response = await Utils.supabase.auth.signOut();
    if (response.error != null) {
      emit(AuthenticationError(
          message: ErrorDescriptors.getNetworkErrorOrOriginalFromGotrueError(
              response.error)));
      return;
    }
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

  void updateName({required String name}) async {
    emit(AuthenticationLoading());
    final response = await Utils.supabase
        .from('profiles')
        .update({'full_name': name})
        .eq('user', Utils.supabase.auth.currentUser!.id)
        .execute();

    if (response.error != null) {
      emit(AuthenticationError(
          message: ErrorDescriptors.getNetworkErrorOrOriginalFromPostgrestError(
              response.error)));
      return;
    }

    final user = User(
        profileUrl: response.data[0]['profile_url'] ?? '',
        fullName: response.data[0]['full_name'],
        phoneNumber: response.data[0]['phone_number'],
        address: response.data[0]['address']);
    final box = await Hive.openBox('profile');
    box.put('user', user);
    emit(AuthenticationCompleted(user: user));
  }

  void updateAddress({required String address}) async {
    emit(AuthenticationLoading());
    final response = await Utils.supabase
        .from('profiles')
        .update({'address': address})
        .eq('user', Utils.supabase.auth.currentUser!.id)
        .execute();

    if (response.error != null) {
      emit(AuthenticationError(
          message: ErrorDescriptors.getNetworkErrorOrOriginalFromPostgrestError(
              response.error)));
      return;
    }

    final user = User(
      profileUrl: response.data[0]['profile_url'] ?? '',
      fullName: response.data[0]['full_name'],
      phoneNumber: response.data[0]['phone_number'],
      address: response.data[0]['address'],
    );
    final box = await Hive.openBox('profile');
    box.put('user', user);
    emit(AuthenticationCompleted(user: user));
  }

  void updateProfile(
      {required User currentProfile,
      required Uint8List image,
      required String fileName}) async {
    emit(ProfileChangeLoading());
    final profileFileName = 'profile.' + fileName.split('.').last;
    final response = await Utils.supabase.storage.from('profiles').uploadBinary(
        '${Utils.supabase.auth.currentUser?.id}/$profileFileName', image,
        fileOptions: const supabase.FileOptions(upsert: true));
    if (response.error != null) {
      emit(AuthenticationError(message: response.error?.message));
      emit(AuthenticationCompleted(user: currentProfile));
      return;
    }
    final imageUrl = Utils.supabase.storage
        .from('profiles')
        .getPublicUrl('${Utils.supabase.auth.currentUser?.id}/$profileFileName')
        .data;
    final profile = await Utils.supabase
        .from('profiles')
        .update({'profile_url': imageUrl})
        .eq('user', Utils.supabase.auth.currentUser!.id)
        .execute();

    if (profile.error != null) {
      emit(AuthenticationError(
          message: ErrorDescriptors.getNetworkErrorOrOriginalFromPostgrestError(
              profile.error)));
      emit(AuthenticationCompleted(user: currentProfile));
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

  void deleteProfile({required User currentProfile}) async {
    final fileName = currentProfile.profileUrl.split('/profiles/').last;
    emit(ProfileChangeLoading());
    final response =
        await Utils.supabase.storage.from('profiles').remove([fileName]);
    if (response.error != null) {
      emit(AuthenticationError(message: response.error?.message));
      return;
    }
    emit(
        AuthenticationCompleted(user: currentProfile.copyWith(profileUrl: '')));
  }
}
