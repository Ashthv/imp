import 'package:flutter/material.dart';

import '../../../../tcs_dff_design_system.dart';
import '../../../../theme/theme.dart';
import '../../../../utils/sizer/app_sizer.dart';
import 'card_painter.dart';
import 'radio_button_title_color_change.dart';

class SimSlot extends StatelessWidget {
  final String title;
  final Function(bool value) onChanged;
  final bool isEnabled;
  final bool isError;
  final bool isSelected;
  final String imagePath;
  final String? package;

  SimSlot({
    required this.title,
    required this.onChanged,
    required this.isSelected,
    this.package,
    required this.imagePath,
    required this.isEnabled,
    required this.isError,
  });

  @override
  Widget build(final BuildContext context) {
    final color = context.theme.appColor;
    final size = context.theme.appSize;
    return InkWell(
      splashColor: context.theme.appColor.transparent,
      highlightColor: context.theme.appColor.transparent,
      enableFeedback: !isEnabled ? false : null,
      onTap: () {
        if (isEnabled) {
          onChanged(isSelected);
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          ImageWidget(
            imageType: ImageType.assetImage,
            path: imagePath,
            package: package,
          ),
          Container(
            padding: EdgeInsets.only(
              bottom: size.size16.dp,
              right: size.size10.dp,
              left: size.size6.dp,
            ),
            alignment: Alignment.center,
            child: CustomPaint(
              painter: CardPainter(
                color: isError
                    ? color.statRedDefault
                    : isEnabled
                        ? isSelected
                            ? color.clrPrimaryPurple
                            : color.greyLightestGrey80
                        : color.greyLightestGrey80,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(size.size12.sp),
                    child: RadioButtonTitleColorChange(
                      isError: isError,
                      isEnabled: isEnabled,
                      isSelected: isSelected,
                      onChanged: onChanged,
                      title: title,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
