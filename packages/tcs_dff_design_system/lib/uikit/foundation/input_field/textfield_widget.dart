import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tcs_dff_shared_library/validators/field_validator_types.dart';
import 'package:tcs_dff_shared_library/validators/validators.dart';

import '../../../theme/theme.dart';
import '../../../theme/theme_export.dart';
import '../../../utils/sizer/app_sizer.dart';
import 'inline_message.dart';

class TextFieldWidget extends StatefulWidget {
  TextFieldWidget({
    required this.label,
    this.focused = false,
    this.focusNode,
    required this.controller,
    this.enabled = true,
    this.inputType = TextInputType.text,
    this.maskText = false,
    this.onChanged,
    this.validators = const [],
    this.isValid,
    this.inputFormatters = const [],
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.suffixWidget,
    this.prefixWidget,
    this.maxLength,
    this.maxLines = 1,
    this.helperWidget,
    this.ecoFriendlyWidget,
    this.hintText,
    this.textFieldtypeText,
    this.textColor = AppColors.greyBlackUi10,
    this.focusColor = AppColors.clrPrimaryPurple10,
    this.errorFocusColor = AppColors.greyLightestGrey80,
    this.normalFocusColor = AppColors.greyMediumGrey40,
    this.cursorColor = AppColors.clrPrimaryPurple10,
    this.labelHeight = 0.8,
    this.fieldKey,
  });

  final TextEditingController controller;
  final String label;
  final bool focused;
  final FocusNode? focusNode;
  final bool enabled;
  final TextInputType inputType;
  final bool maskText;
  final Function(String)? onChanged;
  final List<TextInputFormatter> inputFormatters;
  final List<FieldValidator<String?>> validators;
  final void Function(bool)? isValid;
  final AutovalidateMode autovalidateMode;
  final Widget? suffixWidget;
  final Widget? prefixWidget;
  final int? maxLength;
  final int maxLines;
  final Widget? helperWidget;
  final Widget? ecoFriendlyWidget;
  final String? hintText;
  final String? textFieldtypeText;
  final Color? textColor;
  final Color? focusColor;
  final Color? errorFocusColor;
  final Color? normalFocusColor;
  final Color? cursorColor;
  final double labelHeight;
  final Key? fieldKey;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late FocusNode _focusNode;
  late bool _keepSuffixAlwaysVisible;

  @override
  void initState() {
    super.initState();
    _keepSuffixAlwaysVisible = true;
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          _keepSuffixAlwaysVisible = false;
        });
      } else {
        if (widget.controller.text.isEmpty) {
          setState(() {
            _keepSuffixAlwaysVisible = true;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final color = context.theme.appColor;
    final textStyle = context.theme.appTextStyles;

    return IgnorePointer(
      ignoring: !widget.enabled,
      child: FormField<String?>(
        key: widget.fieldKey,
        initialValue: '',
        validator: MultiValidator(widget.validators),
        autovalidateMode: widget.autovalidateMode,
        builder: (final formFieldState) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              enableSuggestions: false,
              autocorrect: false,
              cursorColor: widget.cursorColor,
              focusNode: _focusNode,
              onTap: _requestFocus,
              style: textStyle.labelSmall14Medium.copyWith(
                fontSize: size.size18.sp,
                color: widget.textColor,
                fontWeight: FontWeight.w400,
              ),
              onChanged: (final text) {
                formFieldState.didChange(text);

                if (widget.isValid != null) {
                  widget.isValid!(formFieldState.isValid);
                }

                if (widget.onChanged != null) {
                  widget.onChanged!(text);
                }
              },
              maxLength: widget.maxLength,
              maxLines: widget.maxLines,
              obscureText: widget.maskText,
              obscuringCharacter: '*',
              keyboardType: widget.inputType,
              autofocus: widget.focused,
              controller: widget.controller,
              inputFormatters: widget.inputFormatters,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: textStyle.labelSmall14Medium.copyWith(
                  fontSize: size.size18.sp,
                  color: widget.textColor,
                  fontWeight: FontWeight.w400,
                ),
                contentPadding: EdgeInsets.all(size.size10.dp),
                counterText: '',
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: formFieldState.errorText != null
                        ? color.statRedDefault
                        : widget.focusColor!,
                    width: _focusNode.hasFocus
                        ? (size.size1 + size.sizePoint5).dp
                        : size.size1.dp,
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: formFieldState.errorText != null
                        ? color.statRedDefault
                        : widget.errorFocusColor!,
                    width: _focusNode.hasFocus
                        ? (size.size1 + size.sizePoint5).dp
                        : size.size1.dp,
                  ),
                ),
                prefix: widget.prefixWidget,
                suffix: !_keepSuffixAlwaysVisible ? widget.suffixWidget : null,
                suffixIcon: _keepSuffixAlwaysVisible
                    ? Padding(
                        padding: EdgeInsets.all(size.size8.dp),
                        child: widget.suffixWidget,
                      )
                    : null,
                label: RichText(
                  text: TextSpan(
                    text: widget.label,
                    style: textStyle.labelSmall14Medium.copyWith(
                      color: _focusNode.hasFocus
                          ? widget.focusColor
                          : widget.normalFocusColor,
                      fontSize: size.size18.sp,
                      fontWeight: FontWeight.w400,
                      height: _focusNode.hasFocus
                          ? widget.labelHeight.dp
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
      ),
    );
  }

  void _requestFocus() {
    setState(() {
      FocusScope.of(context).requestFocus();
    });
  }
}
