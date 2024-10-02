import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tcs_dff_shared_library/validators/field_validator_types.dart';
import 'package:tcs_dff_shared_library/validators/validators.dart';

import '../../../theme/theme.dart';
import '../../../utils/image_type.dart';
import '../../../utils/sizer/app_sizer.dart';
import '../../container/image/image_widget.dart';
import 'inline_message.dart';

class AccountNumberTextField extends StatefulWidget {
  AccountNumberTextField({
    required this.label,
    required this.controller,
    this.maskText = false,
    this.onChanged,
    this.validators = const [],
    this.isValid,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.maxLength,
    this.infoText,
    this.inputType = TextInputType.number,
    this.textFieldtypeText,
    this.verified = false,
    this.fieldKey,
  });

  final TextEditingController controller;
  final String label;
  final bool maskText;
  final Function(String)? onChanged;
  final List<FieldValidator<String?>> validators;
  final void Function(bool)? isValid;
  final AutovalidateMode autovalidateMode;
  final int? maxLength;
  final String? textFieldtypeText;
  final String? infoText;
  final TextInputType inputType;
  final bool verified;
  final Key? fieldKey;

  @override
  State<AccountNumberTextField> createState() => _AccountNumberTextFieldState();
}

class _AccountNumberTextFieldState extends State<AccountNumberTextField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
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
            },
            style: textStyle.labelSmall14Medium.copyWith(
              fontSize: size.size18.sp,
              color: color.greyBlackUi10,
              fontWeight: FontWeight.w500,
              letterSpacing: 4.0,
            ),
            maxLength: widget.maxLength,
            obscureText: widget.maskText,
            keyboardType: widget.inputType,
            controller: widget.controller,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[A-Za-z0-9]')),
            ],
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
              suffix: widget.verified
                  ? CircleAvatar(
                      radius: size.size12.dp,
                      child: ImageWidget(
                        imageType: ImageType.assetImage,
                        path:
                            'packages/tcs_dff_design_system/assets/images/tick_filled.svg',
                        fit: BoxFit.contain,
                      ),
                    )
                  : null,
            ),
          ),
          InlineMessage(
            errorText: formFieldState.errorText,
          ),
        ],
      ),
    );
  }
}
