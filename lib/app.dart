import 'package:flutter/material.dart';

import 'core/themes/app_theme.dart';
import 'presentation/router/app_router.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: AppRouter.signInScreen,
      theme: AppTheme.lightTheme,
    );
  }
}
