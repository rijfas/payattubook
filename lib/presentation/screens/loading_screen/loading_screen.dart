import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/utils/utils.dart';
import 'package:rive/rive.dart';

import '../../../core/constants/assets.dart';
import '../../../core/states/auth_state.dart';
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
    super.initState();
    Utils.enableFullScreen().then((value) => recoverSupabaseSession());
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationCompleted) {
          Utils.disableFullScreen().then((value) => Navigator.of(context)
              .pushNamedAndRemoveUntil(
                  AppRouter.dashboardScreen, (_) => false));
        } else if (state is AuthenticationPending) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(AppRouter.signInScreen, (_) => false);
        }
      },
      child: Scaffold(
        body: BlocBuilder<AuthenticationCubit, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    Assets.defaultErrorImage,
                    width: size.width * 0.4,
                  ),
                  SizedBox(height: size.height * 0.025),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('An error occured'),
                      const SizedBox(width: 4.0),
                      InkWell(
                        child: const Text(
                          'Sign in?',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onTap: () =>
                            context.read<AuthenticationCubit>().signOut(),
                      )
                    ],
                  )
                ],
              );
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.3,
                  child: const RiveAnimation.asset(
                    Assets.loadingAnimation,
                    artboard: 'wallet',
                  ),
                ),
                SizedBox(height: size.height * 0.025),
                const CircularProgressIndicator(),
              ],
            );
          },
        ),
      ),
    );
  }
}
