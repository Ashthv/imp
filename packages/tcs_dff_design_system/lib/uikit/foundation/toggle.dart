import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../../utils/sizer/app_sizer.dart';

class Toggle extends StatefulWidget {
  final Function(bool)? onTap;
  final bool isDisable;
  final bool defaultState;

  const Toggle({
    super.key,
    this.onTap,
    this.isDisable = false,
    this.defaultState = false,
  });
  @override
  State<Toggle> createState() => _ToggleButton();
}

class _ToggleButton extends State<Toggle> {
  bool isToggled = false;

  @override
  void initState() {
    isToggled = widget.defaultState;
    super.initState();
  }

  void toggleButton() {
    setState(() {
      isToggled = !isToggled;
    });
    widget.onTap!(isToggled);
  }

  void istoggledisabled() {
    setState(() {});
  }

  @override
  Widget build(final BuildContext context) => GestureDetector(
        onTap: widget.isDisable ? null : toggleButton,
        child: Container(
          width: context.theme.appSize.size56.dp,
          height: context.theme.appSize.size32.dp,
          decoration: BoxDecoration(
            border: isToggled
                ? Border.all(color: context.theme.appColor.clrPrimaryPurple)
                : Border.all(color: context.theme.appColor.greyLightGrey60),
            borderRadius:
                BorderRadius.circular(context.theme.appSize.size15.dp),
            color: isToggled
                ? context.theme.appColor.clrPrimaryPurple120
                : context.theme.appColor.greyWhiteUi100,
          ),
          child: Align(
            alignment: isToggled ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              width: context.theme.appSize.size24.dp,
              height: context.theme.appSize.size24.dp,
              margin: EdgeInsets.all(context.theme.appSize.size2.dp),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isToggled
                    ? context.theme.appColor.clrPrimaryPurple10
                    : context.theme.appColor.greyLightGrey60,
              ),
            ),
          ),
        ),
      );
}
