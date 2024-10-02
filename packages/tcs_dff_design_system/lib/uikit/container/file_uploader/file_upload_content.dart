import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import '../../../utils/enums.dart';
import '../../../utils/sizer/app_sizer.dart';
import '../../foundation/text_widget.dart';
import 'dash_rectangular_painter.dart';

class FileUploadContent extends StatelessWidget {
  const FileUploadContent({
    super.key,
    required this.title,
    required this.subtitle,
    required this.uploadType,
  });

  final UploadType uploadType;

  final String title;
  final String subtitle;

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final color = context.theme.appColor;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomPaint(
          painter: DashRectangularPainter(
            color: color.clrPrimaryBlue20,
            gap: size.size6.toInt(),
            strokeWidth: size.size3,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: size.size8.dp,
              horizontal: size.size12.dp,
            ),
            decoration: BoxDecoration(
              color: color.clrPrimaryBlue110,
              borderRadius: BorderRadius.all(
                Radius.elliptical(
                  size.size6.dp,
                  size.size6.dp,
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  size: size.size24.dp,
                  getUploadType(uploadType),
                  color: color.clrPrimaryBlue,
                ),
                SizedBox(
                  width: size.size12.dp,
                ),
                Padding(
                  padding: EdgeInsets.all(size.size8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: title,
                        style:
                            context.theme.appTextStyles.bodyCopy3Small14Regular,
                      ),
                      TextWidget(
                        text: subtitle,
                        style: context.theme.appTextStyles.detailsSmall12Regular
                            .copyWith(color: color.greyDarkGrey30),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  IconData? getUploadType(final UploadType uploadType) {
    switch (uploadType) {
      case UploadType.document:
        return Icons.upload_file;

      case UploadType.selfieOrProfile:
        return Icons.file_upload_outlined;

      case UploadType.selfie:
        return Icons.camera_alt_outlined;

      default:
    }
    return null;
  }
}
