import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    final TextEditingValue oldValue,
    final TextEditingValue newValue,
  ) {
    final newText = newValue.text;
    if (newText.isEmpty) {
      return newValue;
    }
    var selectionIndex = newValue.selection.end;
    String newTextFormatted;
    if (newText.contains('.')) {
      final splittedText = newText.split('.');
      final formatedText = splittedText[0] != ''
          ? NumberFormat('#,##,##,###').format(double.tryParse(splittedText[0]))
          : '0';
      newTextFormatted = '$formatedText.${splittedText[1]}';
    } else {
      newTextFormatted = NumberFormat('#,##,##,###').format(
        double.tryParse(newText),
      );
    }
    if (newText == newTextFormatted) {
      return newValue;
    }
    selectionIndex += -(newText.length - newTextFormatted.length);
    return TextEditingValue(
      text: newTextFormatted,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
