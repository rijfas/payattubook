import 'package:supabase_flutter/supabase_flutter.dart';

class ErrorDescriptors {
  const ErrorDescriptors._();

  static String getNetworkErrorOrOriginal(PostgrestError? error) {
    if (error!.code == 'SocketException') {
      return 'Network Error!';
    }
    return error.message;
  }
}
