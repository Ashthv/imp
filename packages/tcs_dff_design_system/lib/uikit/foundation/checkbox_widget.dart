import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../../utils/sizer/app_sizer.dart';

class CheckboxWidget extends StatefulWidget {
  final bool isChecked;
  final bool disabled;
  final bool isMixed;
  final Function(bool)? onChanged;

  CheckboxWidget({
    super.key,
    this.isChecked = false,
    this.disabled = false,
    this.isMixed = false,
    this.onChanged,
  });

  @override
  State<CheckboxWidget> createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {
  late bool _isMixed;
  bool checkEnable = false;

  @override
  void initState() {
    super.initState();
    _isMixed = widget.isMixed;
    checkEnable = widget.isChecked;
    setState(() {});
  }

  @override
  void didUpdateWidget(covariant final CheckboxWidget oldWidget) {
    _isMixed = widget.isMixed;
    checkEnable = widget.isChecked;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final color = context.theme.appColor;
    return InkWell(
      onTap: widget.disabled || widget.isMixed
          ? null
          : () {
              setState(() {
                checkEnable = !checkEnable;
                widget.onChanged?.call(checkEnable);
              });
            },
      child: Container(
        width: size.size20.dp,
        height: size.size20.dp,
        decoration: BoxDecoration(
          color: widget.disabled ? color.greyOffWhite90 : color.transparent,
          border: Border.all(
            width: checkEnable ? size.size2.dp : size.size1.dp,
            color: widget.disabled
                ? color.greyLighterGrey70
                : checkEnable || _isMixed
                    ? color.clrPrimaryPurple
                    : color.greyGrey50,
          ),
          borderRadius: BorderRadius.circular(
            size.size4.dp,
          ),
        ),
        child: checkEnable
            ? Icon(
                Icons.check,
                size: size.size14.dp,
                color: widget.disabled
                    ? color.greyLighterGrey70
                    : color.clrPrimaryPurple,
              )
            : _isMixed
                ? Icon(
                    Icons.horizontal_rule,
                    size: size.size14.dp,
                    color: widget.disabled
                        ? color.greyLighterGrey70
                        : color.clrPrimaryPurple,
                  )
                : null,
      ),
    );
  }
}
