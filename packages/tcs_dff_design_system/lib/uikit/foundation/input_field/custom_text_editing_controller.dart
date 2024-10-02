import 'package:flutter/material.dart';

class CustomTextEditingController extends TextEditingController {
  CustomTextEditingController({
    this.maskedValue = true,
    required this.maskingLength,
    required this.isAadhar,
  });
  late bool maskedValue;
  int maskingLength;
  final bool isAadhar;

  @override
  TextSpan buildTextSpan({
    required final BuildContext context,
    final TextStyle? style,
    required final bool withComposing,
  }) {
    var displayValue = value.text.toString();
    if (maskedValue) {
      if (isAadhar) {
        if (displayValue.length <= maskingLength) {
          displayValue = displayValue.replaceAll(RegExp('[0-9]'), 'X');
        } else {
          final maskedValue = displayValue
              .substring(0, maskingLength + 1)
              .replaceAll(RegExp('[0-9]'), 'X');
          displayValue = '$maskedValue${displayValue.substring(
            maskingLength + 1,
            displayValue.length,
          )}';
        }
      } else {
        if (displayValue.length <= maskingLength) {
          displayValue = displayValue.replaceAll(RegExp('[A-Za-z0-9]'), 'X');
        } else {
          final maskedValue = displayValue
              .substring(0, maskingLength + 1)
              .replaceAll(RegExp('[A-Za-z0-9]'), 'X');
          displayValue = '$maskedValue${displayValue.substring(
                maskingLength + 1,
                displayValue.length,
              ).toUpperCase()}';
        }
      }
    }

    return TextSpan(
      style: style,
      text: displayValue,
    );
  }
}
