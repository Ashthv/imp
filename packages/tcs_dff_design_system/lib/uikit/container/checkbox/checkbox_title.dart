import 'package:flutter/material.dart';
import '../../../theme/theme.dart';
import '../../../utils/sizer/app_sizer.dart';
import '../../foundation/checkbox_widget.dart';

class CheckboxTitle extends StatefulWidget {
  final bool isChecked;
  final bool disabled;
  final bool isMixed;
  final bool withBackgroundCard;
  final Widget? textWidget;
  final bool isMultilineTitle;
  final Function(bool)? onChanged;
  final Function()? onInfoPressed;

  const CheckboxTitle({
    super.key,
    this.isChecked = false,
    this.disabled = false,
    this.isMixed = false,
    this.withBackgroundCard = false,
    this.isMultilineTitle = false,
    this.textWidget,
    this.onChanged,
    this.onInfoPressed,
  });

  @override
  State<CheckboxTitle> createState() => _CheckboxTitleState();
}

class _CheckboxTitleState extends State<CheckboxTitle> {
  late bool _isHighlighted;
  late Function()? _onInfoPressed;

  @override
  void initState() {
    super.initState();
    _onInfoPressed = widget.onInfoPressed;
    _isHighlighted = widget.withBackgroundCard;
  }

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final color = context.theme.appColor;
    return Container(
      color: _isHighlighted ? color.clrPrimaryBlue110 : null,
      padding: _isHighlighted
          ? EdgeInsets.symmetric(
              vertical: size.size10.dp,
              horizontal: size.size21.dp,
            )
          : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: widget.isMultilineTitle
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center,
              children: [
                CheckboxWidget(
                  onChanged: widget.onChanged,
                  isMixed: widget.isMixed,
                  isChecked: widget.isChecked,
                  disabled: widget.disabled,
                ),
                SizedBox(
                  width: size.size8.dp,
                ),
                if (widget.textWidget != null)
                  Visibility(
                    visible: widget.textWidget != null,
                    child: Flexible(
                      child: widget.textWidget!,
                    ),
                  ),
              ],
            ),
          ),
          Visibility(
            visible: _onInfoPressed != null,
            child: GestureDetector(
              onTap: _onInfoPressed,
              child: Icon(
                Icons.info_outlined,
                color: color.clrPrimaryPurple,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
