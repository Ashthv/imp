import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tcs_dff_shared_library/validators/field_validator_types.dart';
import 'package:tcs_dff_shared_library/validators/validators.dart';

import '../../../theme/theme.dart';
import '../../../utils/sizer/app_sizer.dart';
import 'inline_message.dart';

class AmountTextField extends StatefulWidget {
  const AmountTextField({
    required this.label,
    required this.controller,
    this.onChanged,
    this.inputFormatters = const [],
    this.validators = const [],
    this.isValid,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.focusNode,
    this.prefixWidget,
    this.sufixWidget,
    this.maxLength,
    this.helperWidget,
    this.ecoFriendlyWidget,
    this.textFieldtypeText,
    this.textFieldStyle,
    this.fieldKey,
  });

  final TextEditingController controller;
  final FocusNode? focusNode;
  final String label;
  final Function(String)? onChanged;
  final List<TextInputFormatter> inputFormatters;
  final List<FieldValidator<String?>> validators;
  final void Function(bool)? isValid;
  final AutovalidateMode autovalidateMode;
  final Widget? prefixWidget;
  final Widget? sufixWidget;
  final int? maxLength;
  final Widget? helperWidget;
  final Widget? ecoFriendlyWidget;
  final String? textFieldtypeText;
  final TextStyle? textFieldStyle;
  final Key? fieldKey;

  @override
  State<AmountTextField> createState() => _AmountTextFieldState();
}

class _AmountTextFieldState extends State<AmountTextField> {
  late FocusNode _focusNode;
  late int? _maxLength;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _maxLength = widget.maxLength;
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _requestFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final color = context.theme.appColor;
    final textStyle = context.theme.appTextStyles;

    return FormField<String?>(
      key: widget.fieldKey,
      initialValue: '',
      validator: MultiValidator(widget.validators),
      autovalidateMode: widget.autovalidateMode,
      builder: (final formFieldState) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            style: (widget.textFieldStyle != null)
                ? widget.textFieldStyle
                : textStyle.labelSmall14Medium.copyWith(
                    fontSize: size.size18.sp,
                    color: color.greyBlackUi10,
                    fontWeight: FontWeight.w500,
                  ),
            focusNode: _focusNode,
            onTap: _requestFocus,
            onChanged: (final text) {
              formFieldState.didChange(text);

              if (widget.isValid != null) {
                widget.isValid!(formFieldState.isValid);
              }

              if (widget.onChanged != null) {
                widget.onChanged!(text);
              }

              // value using regEx
              setState(() {
                // if (text.contains('.')) {
                //   _maxLength = text.indexOf('.') + 3;
                // } else {
                if (text.contains(',') && widget.maxLength != null) {
                  final splittedText = widget.controller.text.split(',');
                  _maxLength = widget.maxLength! + splittedText.length - 1;
                } else {
                  _maxLength = widget.maxLength;
                }
                // }
              });
            },
            maxLength: _maxLength,
            keyboardType: TextInputType.number,
            controller: widget.controller,
            inputFormatters: widget.inputFormatters,
            obscuringCharacter: 'X',
            decoration: InputDecoration(
              counterText: '',
              contentPadding: EdgeInsets.all(size.size10.dp),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: formFieldState.errorText != null
                      ? color.statRedDefault
                      : color.clrPrimaryPurple10,
                  width: _focusNode.hasFocus
                      ? (size.size1 + size.sizePoint5).dp
                      : size.size1.dp,
                ),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: formFieldState.errorText != null
                      ? color.statRedDefault
                      : color.greyLightestGrey80,
                  width: _focusNode.hasFocus
                      ? (size.size1 + size.sizePoint5).dp
                      : size.size1.dp,
                ),
              ),
              prefix: widget.prefixWidget,
              suffix: widget.sufixWidget,
              label: RichText(
                text: TextSpan(
                  text: widget.label,
                  style: textStyle.labelSmall14Medium.copyWith(
                    color: _focusNode.hasFocus
                        ? color.clrPrimaryPurple10
                        : color.greyMediumGrey40,
                    fontSize: size.size18.sp,
                    fontWeight: FontWeight.w400,
                    height: _focusNode.hasFocus
                        ? (size.size1.dp - 0.2)
                        : widget.controller.text.isNotEmpty
                            ? size.size1.dp
                            : size.size3.dp,
                  ),
                  children: widget.textFieldtypeText != null
                      ? [
                          TextSpan(
                            text: ' (${widget.textFieldtypeText})',
                          ),
                        ]
                      : null,
                ),
              ),
            ),
          ),
          InlineMessage(
            errorText: formFieldState.errorText,
            ecoFriendlyWidget: widget.ecoFriendlyWidget,
            helperWidget: widget.helperWidget,
          ),
        ],
      ),
    );
  }
}
