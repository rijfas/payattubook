import 'package:validators/validators.dart';

class Validators {
  const Validators._();
  static String? phoneNumberValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter phone number';
    }
    if (!isNumeric(value) || value.length != 10) {
      return 'Please enter valid phone number';
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    }
    if (value.length < 6) {
      return 'Password should have at least 6 letters';
    }
    return null;
  }

  static String? Function(String?)? defaultStringValidator(String name) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return 'Please enter $name';
      }
      return null;
    };
  }
}
