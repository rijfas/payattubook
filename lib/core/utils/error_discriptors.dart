import 'package:supabase_flutter/supabase_flutter.dart';

class ErrorDescriptors {
  const ErrorDescriptors._();

  static String getNetworkErrorOrOriginalFromPostgrestError(
      PostgrestError? error) {
    if (error!.code == 'SocketException') {
      return 'Network Error!';
    }
    return error.message;
  }

  static String getNetworkErrorOrOriginalFromGotrueError(GotrueError? error) {
    if (error!.message.startsWith('SocketException:')) {
      return 'Network Error!';
    }
    return error.message;
  }
}
