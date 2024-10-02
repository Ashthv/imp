import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tcs_dff_shared_library/validators/field_validator_types.dart';
import 'package:tcs_dff_shared_library/validators/validators.dart';

import '../../../theme/theme.dart';
import '../../../utils/image_type.dart';
import '../../../utils/sizer/app_sizer.dart';
import '../../container/image/image_widget.dart';
import '../icon_widget.dart';
import 'custom_text_editing_controller.dart';
import 'inline_message.dart';
import 'text_number_formatter.dart';
import 'uppercase_text_inputformatter.dart';

enum FieldType { aadhaarNo, aadhaarVid, panNo }

class AadhaarPanTextField extends StatefulWidget {
  AadhaarPanTextField({
    required this.label,
    this.verified = false,
    required this.inputType,
    required this.fieldType,
    this.isValid,
    this.validators = const [],
    required this.textEditingController,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.textFieldtypeText,
    this.onChanged,
    this.fieldKey,
  });

  final String label;
  final bool verified;
  final FieldType fieldType;
  final TextInputType inputType;
  final void Function(bool)? isValid;
  final List<FieldValidator<String?>> validators;
  final CustomTextEditingController textEditingController;
  final AutovalidateMode autovalidateMode;
  final String? textFieldtypeText;
  final Function(String)? onChanged;
  final Key? fieldKey;

  @override
  State<AadhaarPanTextField> createState() => _AadhaarPanTextFieldState();
}

class _AadhaarPanTextFieldState extends State<AadhaarPanTextField> {
  bool maskText = true;
  late FocusNode _focusNode;
  @override
  void initState() {
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setMaskText() {
    setState(() {
      maskText = !maskText;
      widget.textEditingController.maskedValue = maskText;
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
            textAlignVertical: TextAlignVertical.center,
            style: textStyle.labelSmall18Medium.copyWith(
              fontSize: size.size18.sp,
              color: color.greyBlackUi10,
            ),
            inputFormatters: widget.fieldType == FieldType.panNo
                ? [
                    FilteringTextInputFormatter.allow(
                      RegExp('[A-Za-z0-9]'),
                    ),
                    LengthLimitingTextInputFormatter(
                      getInputLength(widget.fieldType),
                    ),
                    UpperCaseTextInputFormatter(),
                  ]
                : [
                    FilteringTextInputFormatter.allow(RegExp('[0-9X]')),
                    LengthLimitingTextInputFormatter(
                      getInputLength(widget.fieldType),
                    ),
                    TextNumberFormatter(),
                  ],
            textCapitalization: TextCapitalization.characters,
            controller: widget.textEditingController,
            keyboardType: widget.inputType,
            textInputAction: TextInputAction.done,
            enabled: !widget.verified,
            focusNode: _focusNode,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(size.size10.dp),
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
              suffix: Container(
                child: !widget.verified
                    ? IconWidget(
                        iconName: maskText
                            ? 'packages/tcs_dff_design_system/assets/images/visibility_off.png'
                            : 'packages/tcs_dff_design_system/assets/images/visibility.png',
                        iconSize: IconSize.small,
                        iconColor: color.clrPrimaryPurple10,
                        onPressed: setMaskText,
                      )
                    : CircleAvatar(
                        radius: size.size12.dp,
                        child: ImageWidget(
                          imageType: ImageType.assetImage,
                          path:
                              'packages/tcs_dff_design_system/assets/images/tick_filled.svg',
                          fit: BoxFit.contain,
                        ),
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
                        ? (size.size1.dp - 0.1)
                        : widget.textEditingController.text.isNotEmpty
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
            onChanged: (final text) {
              formFieldState.didChange(text);

              if (widget.isValid != null) {
                widget.isValid!(formFieldState.isValid);
              }

              if (widget.onChanged != null) {
                widget.onChanged!(text);
              }
            },
          ),
          InlineMessage(
            errorText: formFieldState.errorText,
          ),
        ],
      ),
    );
  }

  int getInputLength(final FieldType fieldType) {
    //12 for aadhar and 16 for vid and 10 for pancard
    switch (fieldType) {
      case FieldType.aadhaarNo:
        return 12;
      case FieldType.aadhaarVid:
        return 16;
      case FieldType.panNo:
        return 10;
    }
  }
}
