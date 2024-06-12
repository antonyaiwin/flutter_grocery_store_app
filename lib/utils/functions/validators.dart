import 'package:email_validator/email_validator.dart';

String? nameValidator(String? value) {
  if ((value?.length ?? 0) > 3) {
    return null;
  } else {
    return 'Enter valid name!';
  }
}

String? emailValidator(String? value) {
  if (EmailValidator.validate(value ?? '')) {
    return null;
  } else {
    return 'Enter valid email address!';
  }
}

String? passwordValidator(String? value) {
  if (value == null || value.length < 8) {
    return 'Enter a valid password with minimum 8 characters!';
  } else if (value.length > 15) {
    return 'Enter a valid password with maximum 15 characters!';
  } else {
    return null;
  }
}

String? passwordConfirmValidator(
  String? value1,
  String? value2,
) {
  if (value1 != value2) {
    return 'Passwords does not match!';
  } else {
    return null;
  }
}
