import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import '../../../utils/enums.dart';
import '../../../utils/sizer/app_sizer.dart';

import '../../foundation/text_widget.dart';
import 'dash_rectangular_painter.dart';

class UploadedFileWidget extends StatefulWidget {
  const UploadedFileWidget({
    super.key,
    required this.uploadType,
    required this.fileName,
    required this.onCancelPressed,
  });

  final String fileName;
  final UploadType uploadType;

  final Function() onCancelPressed;

  @override
  State<UploadedFileWidget> createState() => _UploadedState();
}

class _UploadedState extends State<UploadedFileWidget> {
  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final color = context.theme.appColor;
    return InkWell(
      child: Column(
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
                vertical: size.size12.dp,
                horizontal: size.size16.dp,
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
                  Expanded(
                    flex: 0,
                    child: Icon(
                      getUploadType(widget.uploadType),
                      size: size.size24.dp,
                      color: color.clrPrimaryBlue,
                    ),
                  ),
                  SizedBox(
                    width: size.size12.dp,
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: TextWidget(
                            maxLine: 2,
                            text: widget.fileName,
                            style: context
                                .theme.appTextStyles.bodyCopy3Link14SemiBold
                                .copyWith(
                              decorationThickness: 2,
                              decorationColor: color.greyBlackUi10,
                              color: color.greyDarkGrey30,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: widget.onCancelPressed,
                          child: Icon(
                            Icons.close,
                            size: size.size24.dp,
                            color: color.greyDarkGrey30,
                          ),
                        ),
                      ],
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
