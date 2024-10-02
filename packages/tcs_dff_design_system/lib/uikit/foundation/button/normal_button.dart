import 'package:flutter/material.dart';

import '../../../tcs_dff_design_system.dart';
import '../../../theme/theme.dart';
import '../../../utils/sizer/app_sizer.dart';

class NormalButton extends StatelessWidget {
  final String caption;
  final ButtonVariants buttonType;
  final bool isEnabled;
  final VoidCallback onPressed;
  final String? leftIcon;
  final String? rightIcon;
  final String? package;
  final Color? overleyColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? captionColor;
  final double? fontSize;

  const NormalButton({
    super.key,
    required this.caption,
    required this.buttonType,
    this.isEnabled = true,
    required this.onPressed,
    this.leftIcon,
    this.rightIcon,
    this.package,
    this.backgroundColor,
    this.borderColor,
    this.overleyColor,
    this.captionColor,
    this.fontSize,
  });

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final color = context.theme.appColor;
    final textStyle = context.theme.appTextStyles;
    return Container(
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStatePropertyAll(size.size0.dp),
          fixedSize: MaterialStatePropertyAll(
            buttonType.size(),
          ),
          overlayColor: MaterialStatePropertyAll(
            overleyColor ?? color.clrPrimaryPurple10,
          ),
          backgroundColor: MaterialStatePropertyAll(
            isEnabled
                ? (backgroundColor ?? color.clrPrimaryPurple)
                : (backgroundColor ?? color.greyOffWhite90),
          ),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  context.theme.appSize.size40.dp,
                ),
              ),
              side: BorderSide(
                color: isEnabled
                    ? (borderColor ?? color.clrPrimaryPurple)
                    : (borderColor ?? color.greyLighterGrey70),
              ),
            ),
          ),
        ),
        onPressed: isEnabled ? onPressed : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (leftIcon == null)
              const SizedBox.shrink()
            else
              Padding(
                padding: EdgeInsets.only(
                  right: size.size4.dp,
                ),
                child: ImageWidget(
                  imageType: ImageType.assetImage,
                  path: leftIcon!,
                  package: package,
                ),
              ),
            Flexible(
              child: Text(
                caption,
                style: textStyle.h316pxsemiBold.copyWith(
                  fontSize: fontSize ?? size.size16.dp,
                  color: isEnabled
                      ? (captionColor ?? color.greyWhiteUi100)
                      : (captionColor ?? color.greyLighterGrey70),
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            if (rightIcon == null)
              const SizedBox.shrink()
            else
              Padding(
                padding: EdgeInsets.only(left: size.size4.dp),
                child: ImageWidget(
                  imageType: ImageType.assetImage,
                  path: rightIcon!,
                  package: package,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
