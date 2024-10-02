import 'package:flutter/services.dart';

class UpperCaseTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    final TextEditingValue oldValue,
    final TextEditingValue newValue,
  ) =>
      newValue.copyWith(
        text: newValue.text.toUpperCase(),
        selection: TextSelection.collapsed(
          offset: newValue.selection.baseOffset,
        ),
      );
}
