import 'package:flutter/material.dart';

import '../../../tcs_dff_design_system.dart';
import '../../../theme/theme.dart';
import '../../../theme/theme_extensions/color_extension.dart';
import '../../../theme/theme_extensions/size_extension.dart';
import '../../../theme/theme_extensions/text_style_extension.dart';
import '../../../utils/credit_card_type.dart';
import '../../../utils/sizer/app_sizer.dart';

class CreditCard extends StatefulWidget {
  final String cardName;
  final String cardNumber;
  final Color backgroundColor;
  final String bgImagePath;
  final String? bgImagePackage;
  final String outStandingText;
  final String outstandingDate;
  final String outStandingAmount;
  final String? buttonTextActivate;
  final String? buttonTextReissue;
  final String? cardBlockedText;
  final String? reIssuanceText;
  final CreditCardStatus creditCardStatus;
  final bool isReissuranceApplied;
  final VoidCallback? onPressedActivate;
  final VoidCallback? onPressedReissue;
  final String? cardBlockedStatusImagePath;
  final String? cardBlockedStatusImagePackage;
  final String? reinsuranceStatusImagePath;
  final String? reinsuranceStatusImagePackage;
  final bool isDisabled;
  CreditCard({
    super.key,
    required this.cardName,
    required this.cardNumber,
    required this.backgroundColor,
    required this.bgImagePath,
    this.bgImagePackage,
    required this.outStandingText,
    required this.outstandingDate,
    required this.outStandingAmount,
    this.buttonTextActivate,
    this.buttonTextReissue,
    this.cardBlockedText,
    this.reIssuanceText,
    required this.creditCardStatus,
    this.isReissuranceApplied = false,
    this.onPressedActivate,
    this.onPressedReissue,
    this.cardBlockedStatusImagePath,
    this.cardBlockedStatusImagePackage,
    this.reinsuranceStatusImagePath,
    this.reinsuranceStatusImagePackage,
    this.isDisabled = false,
  });

  @override
  State<CreditCard> createState() => _CreditCardState();
}

class _CreditCardState extends State<CreditCard> {
  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final textStyle = context.theme.appTextStyles;
    final color = context.theme.appColor;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            blurRadius: 7.0,
            color: color.greyFullBlack10.withOpacity(0.25),
            offset: const Offset(7, 7),
          ),
        ],
      ),
      child: Stack(
        children: [
          Container(
            height: getHeight(widget.creditCardStatus),
            width: size.size350.dp,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size.size10.dp),
            ),
            child: ImageWidget(
              imageType: ImageType.assetImage,
              path: widget.bgImagePath,
              package: widget.bgImagePackage,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              left: size.size18.dp,
              top: size.size16.dp,
              bottom: size.size16.dp,
              right: size.size18.dp,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                size.size8.dp,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                cardNameAndStatus(
                  widget.creditCardStatus,
                  widget.isReissuranceApplied,
                  size,
                  color,
                  textStyle,
                ),
                SizedBox(
                  height: size.size34.dp,
                ),
                Text(
                  widget.cardNumber,
                  style: textStyle.labelSmall14Medium.copyWith(
                    fontSize: size.size16.dp,
                    fontWeight: FontWeight.w400,
                    color: color.greyFullWhite120,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(size.size2.dp, size.size2.dp),
                        color: color.greyDarkGrey30,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.size29.dp,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      text: widget.outStandingText + widget.outstandingDate,
                      style: TextStyle(color: color.greyFullWhite120),
                      styledTextList: [widget.outstandingDate],
                      styledTextStyle: TextStyle(color: color.greyFullWhite120),
                    ),
                    Text(
                      widget.outStandingAmount,
                      style: textStyle.labelSmall14Medium.copyWith(
                        fontSize: size.size16.dp,
                        fontWeight: FontWeight.w700,
                        color: color.greyFullWhite120,
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: widget.creditCardStatus == CreditCardStatus.inactive,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStatePropertyAll(size.size0.dp),
                          backgroundColor: MaterialStatePropertyAll(
                            widget.backgroundColor,
                          ),
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  context.theme.appSize.size12.dp,
                                ),
                              ),
                              side: BorderSide(
                                color: context.theme.appColor.greyFullWhite120,
                              ),
                            ),
                          ),
                        ),
                        onPressed: widget.onPressedActivate,
                        child: Text(
                          widget.buttonTextActivate!,
                          style: TextStyle(
                            color: context.theme.appColor.greyWhiteUi100,
                            fontSize: context.theme.appSize.size12.dp,
                            fontWeight: FontWeight.w500,
                            height: size.size0.dp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (widget.isDisabled)
            Container(
              height: getHeight(widget.creditCardStatus),
              width: size.size350.dp,
              decoration: BoxDecoration(
                color: color.greyFullWhite120.withOpacity(0.5),
                borderRadius: BorderRadius.circular(size.size10.dp),
              ),
            ),
        ],
      ),
    );
  }

  Widget cardNameAndStatus(
    final CreditCardStatus status,
    final bool isReissuranceApplied,
    final AppSizeExtension size,
    final AppColorsExtension color,
    final AppTextStyleExtension textStyle,
  ) {
    if (widget.creditCardStatus == CreditCardStatus.blocked) {
      return Column(
        children: [
          Row(
            children: [
              ImageWidget(
                imageType: ImageType.assetImage,
                path: widget.cardBlockedStatusImagePath!,
                package: widget.cardBlockedStatusImagePackage!,
                fit: BoxFit.cover,
              ),
              SizedBox(
                width: size.size10.dp,
              ),
              Text(
                widget.cardBlockedText!,
                style: textStyle.bodyCopy2Medium16SemiBold.copyWith(
                  fontSize: size.size16.sp,
                  fontWeight: FontWeight.w600,
                  color: color.greyWhiteUi100,
                ),
              ),
              SizedBox(
                width: size.size60.dp,
              ),
              Visibility(
                visible: !widget.isReissuranceApplied,
                child: ElevatedButton(
                  style: ButtonStyle(
                    elevation: MaterialStatePropertyAll(size.size0.dp),
                    backgroundColor: MaterialStatePropertyAll(
                      widget.backgroundColor,
                    ),
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            context.theme.appSize.size5.dp,
                          ),
                        ),
                        side: BorderSide(
                          color: context.theme.appColor.greyFullWhite120,
                        ),
                      ),
                    ),
                  ),
                  onPressed: widget.onPressedReissue,
                  child: Text(
                    widget.buttonTextReissue!,
                    style: TextStyle(
                      color: context.theme.appColor.greyWhiteUi100,
                      fontSize: context.theme.appSize.size12.dp,
                      fontWeight: FontWeight.w500,
                      height: size.size0.dp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          if (widget.creditCardStatus == CreditCardStatus.blocked &&
              widget.isReissuranceApplied)
            Row(
              children: [
                Container(
                  height: size.size24.dp,
                  width: size.size24.dp,
                  child: ImageWidget(
                    imageType: ImageType.assetImage,
                    path: widget.reinsuranceStatusImagePath!,
                    package: widget.reinsuranceStatusImagePackage,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: size.size10.dp,
                ),
                Text(
                  widget.reIssuanceText!,
                  style: textStyle.bodyCopy2Medium16SemiBold.copyWith(
                    fontSize: size.size12.sp,
                    fontWeight: FontWeight.w400,
                    color: color.greyWhiteUi100,
                  ),
                ),
              ],
            ),
        ],
      );
    } else {
      return Text(
        widget.cardName,
        style: textStyle.labelSmall14Medium.copyWith(
          fontWeight: FontWeight.w700,
          color: color.greyFullWhite120,
          fontSize: size.size16.dp,
        ),
      );
    }
  }
}
