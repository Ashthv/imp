import 'package:flutter/material.dart';
import 'package:tcs_dff_shared_library/localization/app_localizations.dart';

import '../../tcs_dff_design_system.dart';
import '../../theme/theme.dart';
import '../../utils/sizer/app_sizer.dart';

class IncrementDecrementSwitch extends StatefulWidget {
  final Function(int) onCounterValueChanged;
  final int? minLimit;
  final int maxLimit;

  const IncrementDecrementSwitch({
    super.key,
    required this.maxLimit,
    required this.onCounterValueChanged,
    this.minLimit = 0,
  });

  @override
  State<IncrementDecrementSwitch> createState() =>
      _IncrementDecrementSwitchState();
}

class _IncrementDecrementSwitchState extends State<IncrementDecrementSwitch> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      if (_counter < widget.maxLimit) {
        _counter += 1;
        widget.onCounterValueChanged(_counter);
      }
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > widget.minLimit!) {
        _counter -= 1;
        widget.onCounterValueChanged(_counter);
      }
    });
  }

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final color = context.theme.appColor;
    final textStyle = context.theme.appTextStyles;
    final locale = context.locale;
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: size.size4.dp,
      ),
      decoration: BoxDecoration(
        color: color.clrPrimaryPurple110,
        borderRadius: BorderRadius.circular(
          size.size24.dp,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            splashColor: context.theme.appColor.transparent,
            highlightColor: context.theme.appColor.transparent,
            onTap: _decrementCounter,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: size.size20.dp,
              ),
              child: TextWidget(
                text: locale.txt(key: 'substractSymbol'),
                style: textStyle.bodyCopy2Small16Regular,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: size.size10.dp,
              horizontal: size.size22.dp,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                size.size8.dp,
              ),
              color: color.greyWhiteUi100,
            ),
            child: TextWidget(
              text: '$_counter',
              style: textStyle.h316pxsemiBold.copyWith(
                color: color.clrPrimaryPurple,
              ),
            ),
          ),
          InkWell(
            splashColor: context.theme.appColor.transparent,
            highlightColor: context.theme.appColor.transparent,
            onTap: _incrementCounter,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.size19.dp,
              ),
              child: TextWidget(
                text: locale.txt(key: 'addSymbol'),
                style: textStyle.bodyCopy2Small16Regular,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
