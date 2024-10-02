import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../../theme/theme.dart';
import '../../utils/sizer/app_sizer.dart';
import '../foundation/input_field/amount_textfield.dart';
import '../foundation/input_field/currency_formatter.dart';
import '../foundation/range_slider_widget.dart';
import '../foundation/text_widget.dart';

class HeaderWithTextInputWithSlider extends StatefulWidget {
  final String titleText;
  final TextEditingController controller;
  final int sliderDivision;
  final int minValue;
  final int maxValue;
  final String? prefix;
  final String? suffix;
  final String? inputFormatType;
  final int? inputLength;
  final void Function(String) onChange;

  const HeaderWithTextInputWithSlider({
    super.key,
    required this.titleText,
    required this.controller,
    required this.minValue,
    required this.maxValue,
    required this.sliderDivision,
    this.prefix,
    this.suffix,
    this.inputFormatType,
    this.inputLength,
    required this.onChange,
  });

  @override
  State<HeaderWithTextInputWithSlider> createState() =>
      _HeaderWithTextInputWithSliderState();
}

class _HeaderWithTextInputWithSliderState
    extends State<HeaderWithTextInputWithSlider> {
  late int sliderValue;
  TextEditingController amountInputFieldController = TextEditingController();

  @override
  void initState() {
    sliderValue = 0;
    super.initState();
    amountInputFieldController = widget.controller;
    amountInputFieldController.text = (widget.controller.text.length) > 5
        ? NumberFormat('#,##,##,###').format(int.parse(widget.controller.text))
        : amountInputFieldController.text;
  }

  @override
  Widget build(final BuildContext context) {
    final textStyle = context.theme.appTextStyles;
    final color = context.theme.appColor;
    final size = context.theme.appSize;

    return Wrap(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: size.size21.dp),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size.size8.dp),
          ),
          child: Card(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(size.size8.dp),
                      topRight: Radius.circular(size.size8.dp),
                    ),
                    color: color.clrPrimaryPurple110,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: size.size16.dp,
                      right: size.size16.dp,
                      bottom: size.size10.dp,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: size.size30.dp),
                          child: TextWidget(
                            text: widget.titleText,
                            style: textStyle.bodyCopy3Small14Regular.copyWith(
                              color: color.greyBlackUi10,
                              fontWeight: FontWeight.w500,
                              fontSize: size.size14.dp,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                        Flexible(
                          child: IntrinsicWidth(
                            child: AmountTextField(
                              maxLength: (widget.inputLength != null)
                                  ? widget.inputLength
                                  : widget.maxValue.toString().length,
                              label: '',
                              controller: amountInputFieldController,
                              inputFormatters:
                                  widget.inputFormatType == 'double'
                                      ? [
                                          FilteringTextInputFormatter.allow(
                                            RegExp(r'^(\d+)?\.?\d{0,2}'),
                                          ),
                                          CurrencyInputFormatter(),
                                        ]
                                      : [
                                          FilteringTextInputFormatter.allow(
                                            RegExp(r'[0-9]'),
                                          ),
                                          CurrencyInputFormatter(),
                                        ],
                              prefixWidget: widget.prefix != null
                                  ? TextWidget(
                                      text: widget.prefix!,
                                      style: textStyle.bodyCopy3Small14Regular
                                          .copyWith(
                                        color: color.clrPrimaryPurple,
                                        fontWeight: FontWeight.w700,
                                        fontSize: size.size18.dp,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    )
                                  : const TextWidget(text: ''),
                              sufixWidget: (widget.suffix != null)
                                  ? TextWidget(
                                      text: widget.suffix!,
                                      style: textStyle.bodyCopy3Small14Regular
                                          .copyWith(
                                        color: color.clrPrimaryPurple,
                                        fontWeight: FontWeight.w700,
                                        fontSize: size.size18.dp,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    )
                                  : const TextWidget(text: ''),
                              textFieldStyle:
                                  textStyle.labelSmall14Medium.copyWith(
                                fontSize: size.size18.sp,
                                color: color.clrPrimaryPurple,
                                fontWeight: FontWeight.w700,
                              ),
                              onChanged: (final text) {
                                if (text.isNotEmpty) {
                                  final inputValue =
                                      double.parse(text.replaceAll(',', ''))
                                          .round();
                                  sliderValue = inputValue <= widget.maxValue
                                      ? inputValue
                                      : widget.maxValue;
                                  widget.onChange(text);
                                } else {
                                  sliderValue = widget.minValue;
                                }
                                setState(() {});
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.size16.dp,
                    vertical: size.size8.dp,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(
                        text: (widget.prefix != null)
                            ? '${widget.prefix} ${widget.minValue}'
                            : (widget.suffix!.contains('%'))
                                ? widget.minValue.toString()
                                : '${widget.minValue} ${widget.suffix}',
                        style: textStyle.bodyCopy3Small14Regular.copyWith(
                          color: color.greyDarkGrey30,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                      TextWidget(
                        text: (widget.prefix != null)
                            ? '${widget.prefix} ${widget.maxValue}'
                            : (widget.suffix!.contains('%'))
                                ? widget.maxValue.toString()
                                : '${widget.maxValue} ${widget.suffix}',
                        style: textStyle.bodyCopy3Small14Regular.copyWith(
                          color: color.greyDarkGrey30,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: size.size10.dp,
                    right: size.size10.dp,
                    bottom: size.size10.dp,
                  ),
                  child: RangeSliderWidget(
                    minValue: widget.minValue.toDouble(),
                    maxValue: widget.maxValue.toDouble(),
                    division: widget.sliderDivision,
                    initialSliderValue:
                        (amountInputFieldController.text.isNotEmpty)
                            ? amountInputFieldController.text.contains('.')
                                ? double.parse(amountInputFieldController.text)
                                : int.tryParse(
                                    amountInputFieldController.text
                                        .replaceAll(',', ''),
                                  )!
                                    .roundToDouble()
                            : sliderValue.roundToDouble(),
                    selectedSliderValue: (final value) {
                      setState(() {
                        widget.onChange(value.toString());
                        sliderValue = value;
                        amountInputFieldController.text =
                            NumberFormat('#,##,##,###').format(value);
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    amountInputFieldController.dispose();
    super.dispose();
  }
}
