import 'package:flutter/material.dart';
import 'package:payattubook/core/utils/utils.dart';
import 'package:payattubook/presentation/router/app_router.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    Utils.enableFullScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Utils.disableFullScreen();
          Navigator.of(context)
              .pushNamedAndRemoveUntil(AppRouter.signInScreen, (_) => false);
        },
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
