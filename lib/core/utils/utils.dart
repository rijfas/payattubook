import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Utils {
  const Utils._();

  static final supabase = Supabase.instance.client;

  static Future<void> enableFullScreen() async {
    return SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: []);
  }

  static Future<void> disableFullScreen() async {
    return SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
  }

  static void showLoadingDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      barrierColor: Colors.white54,
      context: context,
      builder: (_) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  static void showSnackBar({required BuildContext context, String? message}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message ?? ''),
        backgroundColor: Theme.of(context).primaryColor));
  }

  static bool isSameDate(DateTime first, DateTime second) {
    return first.day == second.day &&
        first.month == second.month &&
        first.year == second.year;
  }

  static int getHoursFromTimeString(String timeString) {
    return int.tryParse(timeString.split(':').first) ?? 0;
  }

  static int getMinutesFromTimeString(String timeString) {
    return int.tryParse(timeString.split(':')[1]) ?? 0;
  }
}
