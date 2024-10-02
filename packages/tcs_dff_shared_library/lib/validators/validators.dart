import 'package:intl/intl.dart';

import './field_validator_types.dart';

/// Below [MultiValidator] is to accept and iterate all
/// the [validators] received from TextFieldComponent
class MultiValidator extends FieldValidator<String?> {
  final List<FieldValidator<String?>> validators;
  static String _errorText = '';

  MultiValidator(this.validators) : super(_errorText);

  @override
  bool isValid(final String? value) {
    for (final validator in validators) {
      if (validator.call(value?.replaceAll(' ', '')) != null) {
        _errorText = validator.errorText;
        return false;
      }
    }
    return true;
  }

  @override
  String? call(final String? value) => isValid(value) ? null : _errorText;
}

/// Field Validators
class RequiredValidator extends TextFieldValidator {
  RequiredValidator({required final String errorText}) : super(errorText);

  @override
  bool get ignoreEmptyValues => false;

  @override
  bool isValid(final String value) => value.isNotEmpty;
}

class MinLengthValidator extends TextFieldValidator {
  final int min;

  MinLengthValidator(this.min, {required final String errorText})
      : super(errorText);

  @override
  bool get ignoreEmptyValues => false;

  @override
  bool isValid(final String value) => value.length >= min;
}

class MaxLengthValidator extends TextFieldValidator {
  final int max;

  MaxLengthValidator(this.max, {required final String errorText})
      : super(errorText);

  @override
  bool isValid(final String value) => value.length <= max;
}

class LengthRangeValidator extends TextFieldValidator {
  final int min;
  final int max;

  @override
  bool get ignoreEmptyValues => false;

  LengthRangeValidator({
    required this.min,
    required this.max,
    required final String errorText,
  }) : super(errorText);

  @override
  bool isValid(final String? value) =>
      value!.length >= min && value.length <= max;
}

class RangeValidator extends TextFieldValidator {
  final num min;
  final num max;

  RangeValidator({
    required this.min,
    required this.max,
    required final String errorText,
  }) : super(errorText);

  @override
  bool get ignoreEmptyValues => true;

  @override
  bool isValid(final String? value) {
    try {
      final numericValue = num.parse(value!.replaceAll(RegExp(r'[^0-9.]'), ''));
      return numericValue >= min && numericValue <= max;
    } catch (_) {
      return false;
    }
  }
}

class DateValidator extends TextFieldValidator {
  final String format;

  DateValidator({this.format = 'dd/MM/yyyy', required final String errorText})
      : assert(format.isNotEmpty, "format can't be empty"),
        super(errorText);

  @override
  bool get ignoreEmptyValues => false;

  @override
  bool isValid(final String value) {
    try {
      final DateTime? dateTime = DateFormat(format).parseStrict(value);
      return dateTime != null;
    } catch (_) {
      return false;
    }
  }
}

class MatchValueValidator extends TextFieldValidator {
  final String matchValue;

  MatchValueValidator(this.matchValue, {required final String errorText})
      : super(errorText);

  @override
  bool get ignoreEmptyValues => true;

  @override
  bool isValid(final String value) => value == matchValue;
}

class MatchLengthValidator extends TextFieldValidator {
  final int matchLength;

  MatchLengthValidator(this.matchLength, {required final String errorText})
      : super(errorText);

  @override
  bool get ignoreEmptyValues => false;

  @override
  bool isValid(final String value) => value.length == matchLength;
}

class MpinValidator extends TextFieldValidator {
  MpinValidator({required final String errorText}) : super(errorText);

  @override
  bool get ignoreEmptyValues => false;

  @override
  bool isValid(final String value) => isValidMPIN(value);

  bool isValidMPIN(final String mpin) {
    // Check for 6-digit number
    if (!RegExp(r'^\d{6}$').hasMatch(mpin)) {
      return false;
    }

    // Check for 3 consecutive same digits and 3 consecutive sequential digits
    var consecutiveSame = 0;
    var consecutiveSequential = 0;
    for (var i = 0; i < mpin.length - 1; i++) {
      if (mpin[i] == mpin[i + 1]) {
        consecutiveSame++;
        if (consecutiveSame >= 2) return false; // 3 consecutive same digits
      } else {
        consecutiveSame = 0;
      }

      if (int.parse(mpin[i + 1]) - int.parse(mpin[i]) == 1) {
        consecutiveSequential++;
        if (consecutiveSequential >= 2) {
          return false; // 3 consecutive sequential digits
        }
      } else {
        consecutiveSequential = 0;
      }
    }

    // Check for at least 3 unique digits
    final uniqueDigits = mpin.split('').toSet();
    if (uniqueDigits.length < 3) {
      return false;
    }

    return true;
  }
}

/// Pattern Validators
class PatternValidator extends TextFieldValidator {
  final Pattern pattern;
  final bool caseSensitive;

  PatternValidator(
    this.pattern, {
    required final String errorText,
    this.caseSensitive = false,
  }) : super(errorText);

  @override
  bool get ignoreEmptyValues => false;

  @override
  bool isValid(final String? value) =>
      hasMatch(pattern.toString(), value!, caseSensitive: caseSensitive);
}

class EmailValidator extends PatternValidator {
  EmailValidator({required final String errorText})
      : super(
          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
          errorText: errorText,
        );
}

// Should be 10 digits only
// Should start with 6, 7, 8, 9 only
// Not contains “.” or “,”
// All digits should not be same
class MobileValidator extends PatternValidator {
  MobileValidator({
    required final String errorText,
  }) : super(
          r'^(?!(\d)\1{9})[6789]\d{9}$',
          errorText: errorText,
        );
}

class PanValidator extends PatternValidator {
  PanValidator({
    required final String errorText,
  }) : super(
          r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$',
          errorText: errorText,
          caseSensitive: true,
        );
}

class AadhaarValidator extends PatternValidator {
  AadhaarValidator({
    required final String errorText,
  }) : super(
          r'^(?!(\d)\1{11})[2-9]{1}[0-9]{3}[0-9]{4}[0-9]{4}$',
          errorText: errorText,
        );
}

class AadhaarVIDValidator extends PatternValidator {
  AadhaarVIDValidator({
    required final String errorText,
  }) : super(
          r'^(?!(\d)\1{15})[0-9]{16}$',
          errorText: errorText,
        );
}

class AccountValidator extends PatternValidator {
  AccountValidator({
    required final String errorText,
  }) : super(
          r'^[0-9a-zA-Z]{9,18}$',
          errorText: errorText,
        );
}

/// 16 or 15 digit card number validator
class CardValidator extends PatternValidator {
  CardValidator({
    required final String errorText,
  }) : super(
          r'^[0-9]{15,16}$',
          errorText: errorText,
        );
}

class PinCodeValidator extends PatternValidator {
  PinCodeValidator({
    required final String errorText,
  }) : super(
          r'^[1-9]{1}[0-9]{2}[0-9]{3}$',
          errorText: errorText,
        );
}

// Use at least 1 capital letter (?=.*[A-Z])
// Use at least 1 small letter (?=.*[a-z])
// Use at least 1 special character (?=.*[!@#$%^&*()\-_=+{};:,<.>])
// Use at least 1 number (?=.*[0-9])
// Minimum length of 8 characters .{8,}
class PasswordValidator extends PatternValidator {
  PasswordValidator({
    required final String errorText,
  }) : super(
          r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[!@#$%^&*()\-_=+{};:,<.>])(?=.*[0-9]).{8,}$',
          errorText: errorText,
          caseSensitive: true,
        );
}

// Total 11 characters,
// first 4 characters should be alphabets,
// 5th character should be 0 and
// next 6 characters should be alphanumeric
class IfscCodeValidator extends PatternValidator {
  IfscCodeValidator({
    required final String errorText,
  }) : super(
          r'^[a-zA-Z]{4}[0]{1}\w{6}$',
          errorText: errorText,
        );
}

class NameValidator extends PatternValidator {
  NameValidator({
    required final String errorText,
  }) : super(
          r'^[a-zA-Z ]+$',
          errorText: errorText,
        );
}

class AddressValidator extends PatternValidator {
  AddressValidator({
    required final String errorText,
  }) : super(
          r'^[A-Za-z0-9,-/. ]+$',
          errorText: errorText,
        );
}
