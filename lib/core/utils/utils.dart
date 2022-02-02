import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Utils {
  const Utils._();
  static final supabase = Supabase.instance.client;

  static void enableFullScreen() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  static void disableFullScreen() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  static void showLoadingDialog(BuildContext context) {
    showDialog(
      barrierColor: Colors.white54,
      context: context,
      builder: (_) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  static void showErrorSnackBar(
      {required BuildContext context, String? message}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message ?? ''),
        backgroundColor: Theme.of(context).primaryColor));
  }
}
