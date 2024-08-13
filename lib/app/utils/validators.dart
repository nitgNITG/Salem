import 'package:email_validator_flutter/email_validator_flutter.dart';
import 'package:flutter/material.dart';

import 'helper_funcs.dart';

class Validators {
  late final BuildContext context;

  Validators(this.context);

  String? validateName(
    String? value,
  ) {
    if (value == null || value.isEmpty) {
      return getL10(context).pleaseFillThisFieldN;
    }
    const String arabicLetters = "أإببتثججحخدذرززسشصضطظعغفقكلمنهويةى";
    // Check if the name contains only letters and spaces.
    if (!RegExp(r'^[a-zA-Z أاإببتثججحخدذرززسشصضطظعغفقكلمنهويةى]+$')
        .hasMatch(value)) {
      return "Name should only contains characters";
    }

    return null;
  }

  String? validateLName(
      String? value,
      ) {
    if (value == null || value.isEmpty) {
      return getL10(context).pleaseFillThisFieldL;
    }
    const String arabicLetters = "أإببتثججحخدذرززسشصضطظعغفقكلمنهويةى";
    // Check if the name contains only letters and spaces.
    if (!RegExp(r'^[a-zA-Z أاإببتثججحخدذرززسشصضطظعغفقكلمنهويةى]+$')
        .hasMatch(value)) {
      return "Name should only contains characters";
    }

    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return getL10(context).pleaseFillThisFieldE;

    }
    else if(!EmailValidatorFlutter().validateEmail(value))
      return getL10(context).validE;
    // Check if the email address is in a valid format.
    final regex = RegExp(
        r'''^[a-zA-Z0-9.!#$%&\'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$''');
    if (!regex.hasMatch(value)) {
      return getL10(context).pleaseEnterYourEmailAddress;
    }

    // Check if the email address is registered with a real domain.
    // This is an optional check, but it can help to reduce spam.
    // To use this check, you will need to install the `email_validator` package from Pub.
    // Once you have installed the package, you can uncomment the following lines of code:

    // import 'package:email_validator/email_validator.dart';
    //
    // if (!EmailValidator.validate(value)) {
    //   return 'Please enter an email address that is registered with a real domain.';
    // }

    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return getL10(context).pleaseFillThisFieldP;
    }
    // Check if the phone number contains only numbers and parentheses.
    if (!RegExp(r'^[+0-9()]+$').hasMatch(value)) {
      return getL10(context).pleaseEnterYourPhoneNumber;
    }

    // Check if the phone number is at least 10 digits long.
    if (value.length < 11) {
      return getL10(context).pleaseEnterAPhoneNumberWithAtLeast10Digits;
    }

    return null;
  }

  String? validateIdNumber(String? value) {
    if (value == null || value.isEmpty) {
      return getL10(context).pleaseFillThisField;
    }
    // Check if the id number contains only numbers and parentheses.
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return getL10(context).pleaseEnterYourPhoneNumber;
    }

    // Check if the id number is at least 10 digits long.
    if (value.length != 14) {
      return getL10(context).pleaseEnterValidIdNumber;
    }

    return null;
  }

  String? notEmpty(String? value) =>
      (value == null || value.isEmpty) ? "" : null;
}
