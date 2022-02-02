import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/themes/app_theme.dart';
import 'logic/authentication/cubit/authentication_cubit.dart';
import 'presentation/router/app_router.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationCubit>(
          create: (_) => AuthenticationCubit(),
        ),
      ],
      child: MaterialApp(
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: AppRouter.signInScreen,
        theme: AppTheme.lightTheme,
      ),
    );
  }
}
