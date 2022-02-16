import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payattubook/logic/host_payattu/cubit/host_payattu_cubit.dart';
import 'package:payattubook/logic/transactions/cubit/transactions_cubit.dart';

import 'core/themes/app_theme.dart';
import 'logic/authentication/cubit/authentication_cubit.dart';
import 'logic/create_payattu/cubit/create_payattu_cubit.dart';
import 'logic/discover_payattu/cubit/discover_payattu_cubit.dart';
import 'logic/manage_payattu/cubit/manage_payattu_cubit.dart';
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
        BlocProvider<CreatePayattuCubit>(
          create: (_) => CreatePayattuCubit(),
        ),
        BlocProvider<DiscoverPayattuCubit>(
          create: (_) => DiscoverPayattuCubit(),
        ),
        BlocProvider<ManagePayattuCubit>(
          create: (_) => ManagePayattuCubit(),
        ),
        BlocProvider<TransactionsCubit>(
          create: (_) => TransactionsCubit(),
        ),
        BlocProvider<HostPayattuCubit>(
          create: (_) => HostPayattuCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: AppRouter.splashScreen,
        theme: AppTheme.lightTheme,
      ),
    );
  }
}
