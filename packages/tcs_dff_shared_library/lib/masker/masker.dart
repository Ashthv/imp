import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:tcs_dff_types/exceptions.dart';

class Masker {
  static String doMask({
    required final String originalText,
    required final MaskTypes maskType,
    final String customPattern = '',
    final String maskedSymbol = 'X',
    final String unmaskedSymbol = '#',
  }) {
    // removing all the whitespace from text
    final filteredText = originalText.replaceAll(' ', '');
    final filteredMaskPatternBuffer = StringBuffer();
    var maskPattern = '';

    // setting the masking pattern
    if (maskType != MaskTypes.custom) {
      maskPattern = maskType.getMaskPatter();
    } else {
      if (customPattern.isNotEmpty) {
        maskPattern = customPattern;
      } else {
        throw FormatterException(
          error: Error(
            title: 'No custom patter found',
            description:
                '''Parameter "customPattern" is mandatory with using Custom MaskType''',
          ),
        );
      }
    }

    // geting only maskedSymbol and unmaskedSymbol chars
    maskPattern.split('').forEach((final char) {
      if (char == maskedSymbol || char == unmaskedSymbol) {
        filteredMaskPatternBuffer.write(char);
      }
    });

    final filteredMaskPattern = filteredMaskPatternBuffer.toString();

    // checking the length of maskpatter and text is same
    if (filteredMaskPattern.length != filteredText.length) {
      throw FormatterException(
        error: Error(
          title: 'Length Mismatch',
          description:
              '''Length of orignal text ($filteredText) is ${filteredText.length}. 
              length of maskpattern ($filteredMaskPattern) is  ${filteredMaskPattern.length}.
              Maskpattern length is only addition of maskedSymbol: $maskedSymbol and unmaskedSymbol: $unmaskedSymbol''',
        ),
      );
    }

    // fetching the unmasked char's indexes
    final unmaskCharIndexes = <int>[];
    var index = filteredMaskPattern.indexOf(unmaskedSymbol);

    while (index >= 0) {
      unmaskCharIndexes.add(index);
      index = filteredMaskPattern.indexOf(unmaskedSymbol, index + 1);
    }

    // seting a single String of all unmasked chars
    final unmaskedCharBuffer = StringBuffer();
    for (final index in unmaskCharIndexes) {
      unmaskedCharBuffer.write(filteredText[index]);
    }
    final unmaskedChar = unmaskedCharBuffer.toString();

    final maskFormatter = MaskTextInputFormatter(
      mask: maskPattern,
      filter: {
        unmaskedSymbol: RegExp(
          r'[0-9a-zA-Z₹@./]', // reg for unmasked chars
        ),
      },
      initialText: unmaskedChar,
      type: MaskAutoCompletionType.eager,
    );

    return maskFormatter.getMaskedText();
  }
}

enum MaskTypes {
  creditCard,
  aadhar,
  mobileNumber,
  vid,
  custom;

  String getMaskPatter() {
    switch (this) {
      case MaskTypes.creditCard:
        return 'XXXX XXXX XXXX ####';
      case MaskTypes.aadhar:
        return 'XXXX XXXX ####';
      case MaskTypes.mobileNumber:
        return '+## XXXXXXX###';
      case MaskTypes.vid:
        return 'XXXX XXXX XXXX ####';
      default:
        return '';
    }
  }
}
