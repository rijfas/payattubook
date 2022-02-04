import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payattubook/presentation/components/rounded_elevated_button.dart';

import '../../../core/utils/auth_state.dart';
import '../../../core/utils/utils.dart';
import '../../../logic/authentication/cubit/authentication_cubit.dart';
import '../../router/app_router.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends AuthState<LoadingScreen> {
  @override
  void initState() {
    recoverSupabaseSession();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationCompleted) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(AppRouter.dashboardScreen, (_) => false);
        } else if (state is AuthenticationPending) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(AppRouter.signInScreen, (_) => false);
        }
      },
      child: Scaffold(
        body: BlocBuilder<AuthenticationCubit, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              children: [
                RoundedElevatedButton(
                  child: Text('Re Login'),
                  onPressed: () {
                    context.read<AuthenticationCubit>().signOut();
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
