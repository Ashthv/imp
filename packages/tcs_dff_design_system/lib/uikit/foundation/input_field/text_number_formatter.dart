import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    final TextEditingValue oldValue,
    final TextEditingValue newValue,
  ) {
    final inputText = newValue.text;

    if (newValue.selection.baseOffset == 0 && newValue.text.length == 1) {
      return newValue;
    }

    final bufferString = StringBuffer();
    var spaceCount = 0;
    for (var i = 0; i < inputText.length; i++) {
      final nonZeroIndexValue = i + 1;
      if (nonZeroIndexValue % 4 == 0 && nonZeroIndexValue != inputText.length) {
        bufferString.write('${inputText[i]} ');
        if (i < newValue.selection.baseOffset) {
          spaceCount++;
        }
      } else {
        bufferString.write(inputText[i]);
      }
    }

    final string = bufferString.toString();

    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(
        offset: string.characters
                    .characterAt(
                      newValue.selection.baseOffset + spaceCount - 1,
                    )
                    .toString() ==
                ' '
            ? newValue.selection.baseOffset + spaceCount - 1
            : newValue.selection.baseOffset + spaceCount,
      ),
    );
  }
}
