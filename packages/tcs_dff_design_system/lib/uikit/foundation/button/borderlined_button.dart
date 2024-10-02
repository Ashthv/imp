import 'package:flutter/material.dart';

import '../../../tcs_dff_design_system.dart';
import '../../../theme/theme.dart';
import '../../../utils/sizer/app_sizer.dart';

class BorderlinedButton extends StatefulWidget {
  final String caption;
  final ButtonVariants buttonType;
  final bool isEnabled;
  final VoidCallback onPressed;
  final double elevation;
  final String? leftIcon;
  final String? rightIcon;
  final String? package;
  const BorderlinedButton({
    super.key,
    required this.caption,
    this.isEnabled = true,
    required this.onPressed,
    required this.buttonType,
    this.elevation = 0,
    this.leftIcon,
    this.rightIcon,
    this.package,
  });

  @override
  State<BorderlinedButton> createState() => _BorderlinedButtonState();
}

class _BorderlinedButtonState extends State<BorderlinedButton> {
  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final color = context.theme.appColor;
    final textStyle = context.theme.appTextStyles;
    return Container(
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStatePropertyAll(widget.elevation),
          fixedSize: MaterialStatePropertyAll(
            widget.buttonType.size(),
          ),
          backgroundColor: MaterialStatePropertyAll(
            widget.isEnabled ? color.greyWhiteUi100 : color.greyOffWhite90,
          ),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  size.size40.dp,
                ),
              ),
              side: BorderSide(
                color: widget.isEnabled
                    ? color.clrPrimaryPurple
                    : color.greyLighterGrey70,
              ),
            ),
          ),
          overlayColor: widget.isEnabled
              ? MaterialStatePropertyAll(
                  color.clrPrimaryPurple120,
                )
              : null,
        ),
        onPressed: widget.isEnabled ? widget.onPressed : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.leftIcon == null)
              const SizedBox.shrink()
            else
              Padding(
                padding: EdgeInsets.only(
                  right: size.size4.dp,
                ),
                child: ImageWidget(
                  imageType: ImageType.assetImage,
                  path: widget.leftIcon!,
                  package: widget.package,
                ),
              ),
            Text(
              widget.caption,
              style: textStyle.h316pxsemiBold.copyWith(
                color: widget.isEnabled
                    ? color.clrPrimaryPurple
                    : color.greyLighterGrey70,
                fontWeight: FontWeight.w600,
                fontSize: size.size16.dp,
              ),
              textAlign: TextAlign.center,
            ),
            if (widget.rightIcon == null)
              const SizedBox.shrink()
            else
              Padding(
                padding: EdgeInsets.only(
                  left: size.size4.dp,
                ),
                child: ImageWidget(
                  imageType: ImageType.assetImage,
                  path: widget.rightIcon!,
                  package: widget.package,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
