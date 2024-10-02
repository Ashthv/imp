import 'package:flutter/material.dart';
import 'package:tcs_dff_shared_library/validators/field_validator_types.dart';

import '../../../theme/theme.dart';
import '../../../utils/sizer/app_sizer.dart';
import '../../container/choice_chip/chip_widget.dart';
import '../text_widget.dart';
import 'textfield_widget.dart';

class TextfieldSuffixSuggestion extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final List<String> suggestions;
  final bool focused;
  final FocusNode? focusNode;
  final List<FieldValidator<String?>> validators;
  final void Function(bool)? isValid;
  final AutovalidateMode autovalidateMode;
  final int maxLines;
  final int? maxLength;
  final String? hintText;
  final Function(String)? onChanged;
  final TextStyle? suffixStyle;
  const TextfieldSuffixSuggestion({
    super.key,
    required this.label,
    required this.controller,
    required this.suggestions,
    this.focused = false,
    this.focusNode,
    this.validators = const [],
    this.isValid,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.maxLines = 1,
    this.maxLength,
    this.hintText,
    this.onChanged,
    this.suffixStyle,
  });

  @override
  State<TextfieldSuffixSuggestion> createState() =>
      _TextfieldSuffixSuggestionState();
}

class _TextfieldSuffixSuggestionState extends State<TextfieldSuffixSuggestion> {
  Map<String, bool> suggestionMap = {};
  String suffixText = '';

  @override
  void initState() {
    super.initState();
    suggestionMap = {
      for (final String suggestion in widget.suggestions) suggestion: false,
    };
  }

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFieldWidget(
            label: widget.label,
            controller: widget.controller,
            suffixWidget: TextWidget(
              text: suffixText,
              style: widget.suffixStyle,
            ),
            focused: widget.focused,
            focusNode: widget.focusNode,
            validators: widget.validators,
            isValid: widget.isValid,
            autovalidateMode: widget.autovalidateMode,
            maxLines: widget.maxLines,
            hintText: widget.hintText,
            onChanged: (final txt) {
              if (widget.onChanged != null) {
                widget.onChanged!(txt + suffixText);
              }
            },
            maxLength: widget.maxLength,
          ),
          Wrap(
            children: widget.suggestions
                .map(
                  (final suggestion) => Padding(
                    padding: EdgeInsets.all(
                      size.size4.dp,
                    ),
                    child: ChipWidget(
                      label: suggestion,
                      isSelected: suggestionMap[suggestion] ?? false,
                      onSelected: (final value) {
                        suggestionMap.forEach(
                          (final key, final value) {
                            suggestionMap[key] = false;
                          },
                        );
                        suggestionMap[suggestion] = true;
                        suffixText = suggestion;
                        setState(() {});
                      },
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
