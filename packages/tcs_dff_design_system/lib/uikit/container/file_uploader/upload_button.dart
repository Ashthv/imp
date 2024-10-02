import 'package:flutter/material.dart';

import '../../../tcs_dff_design_system.dart';
import '../../../theme/theme.dart';
import '../../../utils/sizer/app_sizer.dart';
import 'dash_rectangular_painter.dart';

class UploadButton extends StatefulWidget {
  final IconData icon;
  final String name;
  final bool? isContentHorizontal;

  const UploadButton({
    super.key,
    required this.icon,
    required this.name,
    this.isContentHorizontal = false,
  });

  @override
  State<UploadButton> createState() => _UploadButtonState();
}

class _UploadButtonState extends State<UploadButton> {
  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final color = context.theme.appColor;
    return CustomPaint(
      painter: DashRectangularPainter(
        color: color.clrPrimaryBlue20,
        gap: size.size6.toInt(),
        strokeWidth: size.size3,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: size.size25.dp,
          vertical: size.size17.dp,
        ),
        decoration: BoxDecoration(
          color: color.clrPrimaryBlue110,
          borderRadius: BorderRadius.all(
            Radius.elliptical(
              size.size1.dp,
              size.size1.dp,
            ),
          ),
        ),
        child: widget.isContentHorizontal!
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    widget.icon,
                    size: size.size24.dp,
                    color: color.clrPrimaryBlue,
                  ),
                  SizedBox(
                    width: size.size6.dp,
                  ),
                  TextWidget(
                    text: widget.name,
                    style: context.theme.appTextStyles.bodyCopy3Medium14SemiBold
                        .copyWith(color: color.clrPrimaryBlue),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    widget.icon,
                    size: size.size24.dp,
                    color: color.clrPrimaryBlue,
                  ),
                  SizedBox(
                    width: size.size8.dp,
                  ),
                  TextWidget(
                    text: widget.name,
                    style: context.theme.appTextStyles.bodyCopy3Medium14SemiBold
                        .copyWith(color: color.clrPrimaryBlue),
                  ),
                ],
              ),
      ),
    );
  }
}
