import 'package:flutter/material.dart';
import '../../../theme/theme.dart';
import '../../../utils/enums.dart';
import '../../../utils/sizer/app_sizer.dart';
import '../../foundation/text_widget.dart';

class FileUploadProgressBarWidget extends StatefulWidget {
  const FileUploadProgressBarWidget({
    super.key,
    this.activeBytes,
    required this.durationLeft,
    required this.onCancelPressed,
    required this.uploadType,
    required this.progreesValue,
    required this.title,
  });

  final String? activeBytes;
  final String durationLeft;
  final double progreesValue;
  final String title;
  final UploadType uploadType;

  final Function() onCancelPressed;

  @override
  State<FileUploadProgressBarWidget> createState() =>
      _FileUploadProgressBarWidgetState();
}

class _FileUploadProgressBarWidgetState
    extends State<FileUploadProgressBarWidget> {
  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final color = context.theme.appColor;

    return Container(
      padding: EdgeInsets.all(size.size16.dp),
      decoration: BoxDecoration(
        color: color.clrPrimaryBlue110,
        borderRadius: BorderRadius.all(
          Radius.elliptical(
            size.size6.dp,
            size.size6.dp,
          ),
        ),
      ),
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    size: size.size24.dp,
                    getUploadType(widget.uploadType),
                    color: color.clrPrimaryBlue,
                  ),
                  SizedBox(
                    width: size.size12.dp,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: widget.title,
                          style: context
                              .theme.appTextStyles.bodyCopy3Small14Regular,
                        ),
                        SizedBox(
                          height: size.size2.dp,
                        ),
                        Row(
                          children: [
                            TextWidget(
                              text: widget.activeBytes!,
                              style: context
                                  .theme.appTextStyles.detailsSmall12Regular
                                  .copyWith(color: color.greyDarkGrey30),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                top: size.size1.dp,
                                left: size.size10.dp,
                                right: size.size10.dp,
                              ),
                              width: size.size5.dp,
                              height: size.size5.dp,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: color.greyLightGrey60,
                              ),
                            ),
                            TextWidget(
                              text: widget.durationLeft,
                              style: context
                                  .theme.appTextStyles.detailsSmall12Regular
                                  .copyWith(color: color.greyDarkGrey30),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: widget.onCancelPressed,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: size.size15.dp),
                      child: Icon(
                        size: size.size24.dp,
                        Icons.close,
                        color: color.clrPrimaryBlue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: size.size8.dp,
          ),
          LinearProgressIndicator(
            minHeight: size.size6.dp,
            backgroundColor: color.greyWhiteUi100,
            color: color.clrPrimaryBlue,
            value: widget.progreesValue,
            borderRadius: BorderRadius.circular(size.size4),
          ),
        ],
      ),
    );
  }
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
