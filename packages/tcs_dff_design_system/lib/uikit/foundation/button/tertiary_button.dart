import 'package:flutter/material.dart';

import '../../../tcs_dff_design_system.dart';
import '../../../theme/theme.dart';
import '../../../utils/sizer/app_sizer.dart';

class TertiaryButton extends StatefulWidget {
  final String caption;
  final bool isEnabled;
  final VoidCallback onPressed;
  final String? package;
  final String? leadingImagePath;
  final String? trailingImagePath;
  final Color? buttonColor;
  final Color? disablebuttonColor;
  final double? textFontSize;

  const TertiaryButton({
    super.key,
    required this.caption,
    this.isEnabled = true,
    required this.onPressed,
    this.package,
    this.leadingImagePath,
    this.trailingImagePath,
    this.buttonColor,
    this.disablebuttonColor,
    this.textFontSize,
  });

  @override
  State<TertiaryButton> createState() => _TertiaryButtonState();
}

class _TertiaryButtonState extends State<TertiaryButton> {
  bool _isHovered = false;
  @override
  Widget build(final BuildContext context) => GestureDetector(
        onTap: widget.isEnabled ? widget.onPressed : null,
        onTapUp: (final _) {
          setState(() {
            _isHovered = false;
          });
        },
        onTapDown: (final _) {
          setState(() {
            _isHovered = true;
          });
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.leadingImagePath != null)
              ImageWidget(
                imageType: ImageType.assetImage,
                path: widget.leadingImagePath!,
                package: widget.package,
              ),
            if (widget.leadingImagePath != null)
              SizedBox(
                width: context.theme.appSize.size4.dp,
              ),
            Text(
              widget.caption,
              style: context.theme.appTextStyles.h316pxsemiBold.copyWith(
                fontSize:
                    widget.textFontSize ?? context.theme.appSize.size16.sp,
                fontWeight: FontWeight.w600,
                color: !widget.isEnabled
                    ? widget.disablebuttonColor ??
                        context.theme.appColor.greyLighterGrey70
                    : _isHovered
                        ? context.theme.appColor.clrPrimaryPurple10
                        : widget.buttonColor ??
                            context.theme.appColor.clrPrimaryPurple,
              ),
            ),
            if (widget.trailingImagePath != null)
              SizedBox(
                width: context.theme.appSize.size4.dp,
              ),
            if (widget.trailingImagePath != null)
              ImageWidget(
                imageType: ImageType.assetImage,
                path: widget.trailingImagePath!,
                package: widget.package,
              ),
          ],
        ),
      );
}
