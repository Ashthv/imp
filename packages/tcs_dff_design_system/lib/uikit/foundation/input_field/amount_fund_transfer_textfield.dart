import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tcs_dff_shared_library/validators/field_validator_types.dart';
import 'package:tcs_dff_shared_library/validators/validators.dart';

import '../../../theme/size.dart';
import '../../../theme/theme.dart';
import '../../../utils/sizer/app_sizer.dart';
import '../text_widget.dart';
import 'currency_formatter.dart';

class AmountFundTransferTextfield extends StatefulWidget {
  AmountFundTransferTextfield({
    super.key,
    required this.controller,
    this.onChanged,
    this.inputFormatters = const [],
    this.validators = const [],
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.prefixText,
    this.maxLength,
    this.infoText,
  });

  final TextEditingController controller;
  final Function(String)? onChanged;
  final List<TextInputFormatter> inputFormatters;
  final List<FieldValidator<String?>> validators;
  final AutovalidateMode autovalidateMode;
  final String? prefixText;
  final int? maxLength;
  final String? infoText;

  @override
  State<AmountFundTransferTextfield> createState() =>
      _AmountFundTransferTextfieldState();
}

class _AmountFundTransferTextfieldState
    extends State<AmountFundTransferTextfield> {
  late FocusNode _focusNode;
  late int? _maxLength;
  late List<String> splittedText;

  @override
  void initState() {
    super.initState();
    _maxLength = widget.maxLength;
    _focusNode = FocusNode();
    splittedText = [''];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final size = context.theme.appSize;
    final color = context.theme.appColor;
    final textStyle = context.theme.appTextStyles;
    final textFieldTextStyle = textStyle.labelSmall14Medium.copyWith(
      fontSize: size.size42.sp,
      color: color.clrPrimaryPurple,
      fontWeight: FontWeight.w700,
      height: 1.2,
    );
    final prefixWidget = Text(
      '${widget.prefixText!.trim()} ',
      style: textFieldTextStyle,
    );

    void _requestFocus() {
      setState(() {
        FocusScope.of(context).requestFocus(_focusNode);
      });
    }

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(0),
          constraints: BoxConstraints(maxWidth: deviceWidth),
          width: AppSizes.size58.dp +
              ((widget.controller.text.isEmpty)
                  ? size.size0.dp
                  : ((widget.controller.text.length - 1) -
                              (splittedText.length - 1)) *
                          AppSizes.size24.dp +
                      (splittedText.length - 1) * AppSizes.size11.dp),
          child: TextFormField(
            style: textFieldTextStyle,
            autofocus: true,
            focusNode: _focusNode,
            onTap: _requestFocus,
            onChanged: (final text) {
              setState(() {
                if (widget.onChanged != null) {
                  widget.onChanged!(
                    text,
                  );
                }
                if (text.contains('.')) {
                  _maxLength = text.indexOf('.') + 3;
                } else {
                  if (text.contains(',')) {
                    splittedText = widget.controller.text.split(',');
                    _maxLength = widget.maxLength != null
                        ? widget.maxLength! + splittedText.length - 1
                        : widget.maxLength;
                  } else {
                    splittedText = [''];
                  }
                }
              });
            },
            maxLength: _maxLength,
            keyboardType: TextInputType.number,
            controller: widget.controller,
            validator: MultiValidator(widget.validators),
            autovalidateMode: widget.autovalidateMode,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
              CurrencyInputFormatter(),
            ],
            decoration: InputDecoration(
              hintText: '0',
              hintStyle: textFieldTextStyle,
              counterText: '',
              contentPadding: const EdgeInsets.all(0),
              border: InputBorder.none,
              prefixIcon: prefixWidget,
              prefixIconConstraints: const BoxConstraints.tightForFinite(),
              suffixIcon: Container(),
              suffixIconConstraints: BoxConstraints.tight(Size.zero),
            ),
          ),
        ),
        if (widget.infoText != null)
          SizedBox(
            height: size.size4.dp,
          ),
        if (widget.infoText != null)
          TextWidget(
            text: widget.infoText ?? '',
            style: textStyle.labelSmall14Medium.copyWith(
              fontSize: size.size14.sp,
              fontWeight: FontWeight.w400,
              color: color.greyDarkGrey30,
              height: 1,
            ),
          ),
      ],
    );
  }
}
