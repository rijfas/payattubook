import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../logic/authentication/cubit/authentication_cubit.dart';

class AuthState<T extends StatefulWidget> extends SupabaseAuthState<T> {
  @override
  void onUnauthenticated() {
    if (mounted) {
      context.read<AuthenticationCubit>().signOut();
    }
  }

  @override
  void onAuthenticated(Session session) {
    if (mounted) {
      context.read<AuthenticationCubit>().signInWithSession();
    }
  }

  @override
  void onPasswordRecovery(Session session) {}

  @override
  void onErrorAuthenticating(String message) {
    context.read<AuthenticationCubit>().signOut();
  }
}
