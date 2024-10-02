import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import '../../../utils/image_type.dart';
import '../../../utils/profile_card_type.dart';
import '../../../utils/sizer/app_sizer.dart';
import '../../foundation/text_widget.dart';

import '../image/image_widget.dart';
import '../profile_card/profile_card.dart';

class ScheduledPayment extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? infoText;
  final String? upComingEventText;
  final Function() onTap;
  final String? amount;
  final String? date;
  final String? upComingEventIcon;
  final String? package;
  final String? profileImage;
  final double? width;
  final double? height;
  final Color? borderColor;
  final ProfileCardType profileCardType;
  final Color? backgroundColor;
  final VoidCallback? onSuffixIconTap;

  const ScheduledPayment({
    super.key,
    required this.title,
    required this.onTap,
    required this.profileCardType,
    this.subtitle,
    this.infoText,
    this.upComingEventText,
    this.amount,
    this.date,
    this.upComingEventIcon,
    this.package = '',
    this.profileImage,
    this.width,
    this.height,
    this.borderColor,
    this.backgroundColor,
    this.onSuffixIconTap,
  });
  String _formatAmount(String amount) =>
      amount = amount.replaceAll(RegExp(r'(?<=\d)(?=(\d\d)+\d$)'), ',');

  @override
  Widget build(final BuildContext context) {
    final color = context.theme.appColor;
    final size = context.theme.appSize;
    final textStyle = context.theme.appTextStyles;
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: color.greyOffWhite90,
            width: size.size1.dp,
          ),
          borderRadius: BorderRadius.circular(
            size.size8.dp,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: backgroundColor ?? color.greyWhiteUi100,
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  size.size21.dp,
                  size.size12.dp,
                  size.size21.dp,
                  size.size12.dp,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ProfileCard(
                      title: title,
                      subtitle: subtitle,
                      infoText: infoText,
                      imagePath: profileImage,
                      package: package,
                      width: width,
                      height: height,
                      borderColor: borderColor,
                      profileCardType: profileCardType,
                      imageType: ImageType.networkImage,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (amount != null)
                          Row(
                            children: [
                              TextWidget(
                                text: '₹ ${_formatAmount(amount!)}',
                                style: textStyle.bodyCopy2Medium16SemiBold
                                    .copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: color.clrPrimaryPurple,
                                ),
                              ),
                              if (onSuffixIconTap != null)
                                Container(
                                  width: size.size24.dp,
                                  height: size.size24.dp,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(top: size.size2.dp),
                                    child: InkWell(
                                      onTap: onSuffixIconTap,
                                      child: ImageWidget(
                                        imageType: ImageType.assetImage,
                                        path:
                                            'assets/images/arrow_right_purple.svg',
                                        package: 'tcs_dff_design_system',
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        if (date != null)
                          Padding(
                            padding: onSuffixIconTap != null
                                ? EdgeInsets.only(
                                    top: size.size2.dp,
                                    right: size.size15,
                                  )
                                : EdgeInsets.only(
                                    top: size.size2.dp,
                                  ),
                            child: TextWidget(
                              text: date!,
                              style: textStyle.detailsSmall12Regular.copyWith(
                                fontWeight: FontWeight.w400,
                                color: color.greyMediumGrey40,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (upComingEventText != null || upComingEventIcon != null)
              Container(
                color: color.clrPrimaryPurple120,
                padding: EdgeInsets.only(
                  top: size.size6.dp,
                  bottom: size.size6.dp,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (upComingEventIcon != null)
                      Padding(
                        padding: EdgeInsets.only(
                          right: size.size4.dp,
                        ),
                        child: ImageWidget(
                          imageType: ImageType.assetImage,
                          path: upComingEventIcon!,
                          package: package,
                        ),
                      ),
                    Flexible(
                      child: TextWidget(
                        text: upComingEventText!,
                        style: textStyle.bodyCopy3Small14Regular.copyWith(
                          fontWeight: FontWeight.w400,
                          color: color.greyBlackUi10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
