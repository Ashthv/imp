import 'package:flutter/material.dart';

import '../../tcs_dff_design_system.dart';
import '../../theme/theme.dart';
import '../../theme/theme_extensions/color_extension.dart';
import '../../utils/sizer/app_sizer.dart';

class StatusTypesWidget extends StatelessWidget {
  final String text;
  final StatusTypes statusType;
  final Color? textcolor;
  final Color? bgColor;
  final String? imgPackage;
  final String? icon;

  const StatusTypesWidget({
    super.key,
    required this.text,
    required this.statusType,
    this.textcolor,
    this.icon,
    this.bgColor,
   this.imgPackage,
  });

  Color getTextColor(
    final StatusTypes? statusType,
    final AppColorsExtension color,
  ) {
    if (textcolor != null) {
      return textcolor!;
    } else {
      switch (statusType) {
        case StatusTypes.successful:
          return color.greenDark;
        case StatusTypes.pending:
          return color.statAmberDark;
        case StatusTypes.failed:
          return color.statRedDark;
        case StatusTypes.closed:
          return color.greyDarkGrey30;
        default:
          return color.statRedDefault;
      }
    }
  }

  Color getBgColor(
    final StatusTypes? statustype,
    final AppColorsExtension color,
  ) {
    if (bgColor != null) {
      return bgColor!;
    } else {
      switch (statustype) {
        case StatusTypes.successful:
          return color.statLightGreen;
        case StatusTypes.pending:
          return color.statLightAmber;
        case StatusTypes.failed:
          return color.statRedLightRed;
        case StatusTypes.closed:
          return color.greyOffWhite90;
        default:
          return color.statRedDefault;
      }
    }
  }

  String getIcon(
    final StatusTypes? statustype,
    final String? icon,
  ) {
    if (icon != null) {
      return icon;
    } else {
      switch (statustype) {
        case StatusTypes.successful:
          return 'assets/images/status_success_icn.svg';
        case StatusTypes.pending:
          return 'assets/images/pending_status_icn.svg';
        case StatusTypes.failed:
          return 'assets/images/error_status_icn.svg';
        case StatusTypes.closed:
          return 'assets/images/close_status_icn.svg';
        default:
          return 'assets/images/status_success_icn.svg';
      }
    }
  }

  @override
  Widget build(final BuildContext context) {
    final color = context.theme.appColor;
    final textStyle = context.theme.appTextStyles;
    final size = context.theme.appSize;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding:  EdgeInsets.symmetric(vertical: 2.dp, horizontal: 8.dp),
          decoration: BoxDecoration(
            borderRadius:  BorderRadius.all(Radius.circular(8.dp)),
            color: getBgColor(statusType, color),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageWidget(
                fit: BoxFit.fill,
                imageType: ImageType.assetImage,
                path: getIcon(statusType, icon),
                package: imgPackage??'tcs_dff_design_system',
              ),
              SizedBox(
                width: size.size2.dp,
              ),
              Column(
                children: [
                  Text(
                    text,
                    style: textStyle.detailsMedium12SemiBold.copyWith(
                      color: getTextColor(statusType, color),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

enum StatusTypes {
  successful,
  pending,
  closed,
  failed,
  success,
}
