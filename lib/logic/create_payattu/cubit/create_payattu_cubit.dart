import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:payattubook/core/utils/utils.dart';

part 'create_payattu_state.dart';

class CreatePayattuCubit extends Cubit<CreatePayattuState> {
  CreatePayattuCubit() : super(CreatePayattuLoading());

  void createPayattu({
    required String host,
    required String hostPhoneNumber,
    String? coverImageUrl,
    required DateTime date,
    required TimeOfDay time,
    required String location,
    Uint8List? coverImage,
    String? coverImageFileName,
  }) async {
    final String createdBy = Utils.supabase.auth.currentUser!.id;
    emit(CreatePayattuLoading());
    if (coverImage != null && coverImageFileName != null) {
      final image = await Utils.supabase.storage.from('profiles').uploadBinary(
          '${Utils.supabase.auth.currentUser!.id}/$coverImageFileName',
          coverImage);
      if (image.error != null) {
        emit(CreatePayattuError(message: image.error!.message));
        return;
      }
      coverImageUrl = Utils.supabase.storage
          .from('profiles')
          .getPublicUrl(
              '${Utils.supabase.auth.currentUser!.id}/$coverImageFileName')
          .data;
    }

    final response = await Utils.supabase.from('payatts').insert({
      'created_by': createdBy,
      'host': host,
      'host_phone_number': hostPhoneNumber,
      'cover_image_url': coverImageUrl,
      'date': date.toIso8601String(),
      'time': '${time.hour}:${time.minute}',
      'location': location,
    }).execute();

    if (response.error != null) {
      emit(CreatePayattuError(message: response.error!.message));
      return;
    }

    emit(CreatePayattuCompleted());
  }

  void deletePayattu({required int payattId}) async {
    emit(CreatePayattuLoading());
    final response = await Utils.supabase
        .from('payatts')
        .delete()
        .match({'id': payattId}).execute();

    if (response.error != null) {
      emit(CreatePayattuError(message: response.error!.message));
      return;
    }

    emit(CreatePayattuCompleted());
  }
}
