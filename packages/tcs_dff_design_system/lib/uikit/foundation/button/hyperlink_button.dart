import 'package:flutter/material.dart';
import '../../../theme/theme.dart';
import '../../../utils/sizer/app_sizer.dart';

class HyperlinkButton extends StatefulWidget {
  final String caption;
  final bool isEnabled;
  final VoidCallback onPressed;
  final double? labelFontSize;
  final Color? linkColor;
  final Color? onPressedLinkColor;
  const HyperlinkButton({
    super.key,
    required this.caption,
    this.isEnabled = true,
    required this.onPressed,
    this.labelFontSize,
    this.linkColor,
    this.onPressedLinkColor,
  });

  @override
  State<HyperlinkButton> createState() => _HyperlinkButtonState();
}

class _HyperlinkButtonState extends State<HyperlinkButton> {
  bool _isClicked = false;

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final color = context.theme.appColor;
    final textStyle = context.theme.appTextStyles;
    return GestureDetector(
      onTap: widget.isEnabled ? widget.onPressed : null,
      onTapDown: (final _) {
        setState(() {
          _isClicked = true;
        });
      },
      onTapUp: (final _) {
        setState(() {
          _isClicked = false;
        });
      },
      child: Text(
        widget.caption,
        style: textStyle.h316pxsemiBold.copyWith(
          fontSize: widget.labelFontSize ?? size.size16.sp,
          fontWeight: FontWeight.w600,
          shadows: [
            Shadow(
              color: !widget.isEnabled
                  ? color.greyLightestGrey80
                  : _isClicked
                      ? widget.onPressedLinkColor ?? color.clrPrimaryPurple10
                      : widget.linkColor ?? color.clrPrimaryPurple,
              offset: const Offset(0, -2),
            ),
          ],
          color: Colors.transparent,
          decoration: TextDecoration.underline,
          decorationColor: !widget.isEnabled
              ? color.greyLightestGrey80
              : _isClicked
                  ? widget.onPressedLinkColor ?? color.clrPrimaryPurple10
                  : widget.linkColor ?? color.clrPrimaryPurple,
          decorationThickness: 2,
        ),
      ),
    );
  }
}
