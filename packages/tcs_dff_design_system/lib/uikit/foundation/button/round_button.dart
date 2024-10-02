import 'package:flutter/material.dart';

import '../../../tcs_dff_design_system.dart';
import '../../../theme/theme.dart';
import '../../../utils/sizer/app_sizer.dart';

class RoundButton extends StatelessWidget {
  final bool isEnabled;
  final VoidCallback onPressed;
  final ButtonVariants buttonVariant;
  final String iconPath;
  final String package;
  final RoundedButtonType buttonType;
  final Color? buttonColor;

  const RoundButton({
    super.key,
    this.isEnabled = true,
    required this.onPressed,
    required this.buttonVariant,
    this.buttonType = RoundedButtonType.filled,
    required this.iconPath,
    required this.package,
    this.buttonColor,
  });

  @override
  Widget build(final BuildContext context) {
    final color = context.theme.appColor;
    final size = context.theme.appSize;

    return FloatingActionButton(
      heroTag: null,
      backgroundColor: isEnabled
          ? buttonType == RoundedButtonType.borderlined
              ? color.greyFullWhite120
              : color.clrPrimaryPurple
          : color.greyOffWhite90,
      shape: CircleBorder(
        side: BorderSide(
          color: isEnabled
              ? context.theme.appColor.clrPrimaryPurple
              : context.theme.appColor.greyLighterGrey70,
        ),
      ),
      elevation: size.size0.dp,
      onPressed: isEnabled ? onPressed : null,
      child: ImageWidget(
        imageType: ImageType.assetImage,
        path: iconPath,
        package: package,
        color: buttonColor,
      ),
    );
  }
}


