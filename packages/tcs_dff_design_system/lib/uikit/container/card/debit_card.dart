import 'package:flutter/material.dart';
import 'package:tcs_dff_shared_library/masker/masker.dart';

import '../../../theme/theme.dart';
import '../../../utils/image_type.dart';
import '../../../utils/sizer/app_sizer.dart';
import '../../foundation/text_widget.dart';
import '../image/image_widget.dart';

enum BankCardDetails { cardNumber, expiryDate, cvv }

class DebitCard extends StatefulWidget {
  final String cardName;
  final String cardNumber;
  final String cardHolderName;
  final String expiryDate;
  final String cvv;
  final String backgroundImagePath;
  final String cardTypeImagePath;
  final String package;
  final String? cardTypeNote;
  final ImageType imageType;
  final String expiryTitle;
  final String cvvTitle;

  DebitCard({
    super.key,
    required this.cardName,
    required this.cardNumber,
    required this.cardHolderName,
    required this.expiryDate,
    required this.cvv,
    required this.backgroundImagePath,
    required this.cardTypeImagePath,
    required this.package,
    this.cardTypeNote,
    this.imageType = ImageType.networkImage,
    required this.expiryTitle,
    required this.cvvTitle,
  });

  @override
  State<DebitCard> createState() => _DebitCardState();
}

class _DebitCardState extends State<DebitCard> {
  bool maskCardNumber = false;
  bool maskExpiryDate = true;
  bool maskCVV = true;

  ImageProvider imageProvider = const NetworkImage('');

  void setMaskText(final BankCardDetails mask) {
    switch (mask) {
      case BankCardDetails.cardNumber:
        maskCardNumber = !maskCardNumber;
        maskExpiryDate = true;
        maskCVV = true;
        break;
      case BankCardDetails.expiryDate:
        maskCardNumber = true;
        maskExpiryDate = !maskExpiryDate;
        maskCVV = true;
        break;
      case BankCardDetails.cvv:
        maskCardNumber = true;
        maskExpiryDate = true;
        maskCVV = !maskCVV;
        break;
    }
    setState(() {});
  }

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final textStyle = context.theme.appTextStyles;
    final color = context.theme.appColor;

    if (widget.imageType == ImageType.assetImage) {
      imageProvider = AssetImage(
        widget.backgroundImagePath,
        package: widget.package,
      );
    }

    return Container(
      padding: EdgeInsets.only(
        top: size.size20.dp,
        left: size.size22.dp,
        right: size.size22.dp,
        bottom: size.size20.dp,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          size.size16.dp,
        ),
        image: DecorationImage(fit: BoxFit.fill, image: imageProvider),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ImageWidget(
                imageType: ImageType.assetImage,
                path: 'assets/images/card_chip.svg',
                package: 'tcs_dff_design_system',
              ),
              Container(
                margin:
                    EdgeInsets.only(top: size.size5.dp, right: size.size2.dp),
                child: ImageWidget(
                  imageType: widget.imageType,
                  path: widget.cardTypeImagePath,
                  package: widget.package,
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: size.size11.dp),
            child: Text(
              widget.cardHolderName.toUpperCase(),
              style: textStyle.bodyCopy1Small18Regular.copyWith(
                fontSize: size.size16.sp,
                fontWeight: FontWeight.w400,
                color: color.greyFullWhite120,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: size.size3.dp,
              bottom: size.size21.dp,
            ),
            child: Row(
              children: [
                Text(
                  maskCardNumber
                      ? Masker.doMask(
                          originalText: widget.cardNumber,
                          maskType: MaskTypes.custom,
                          customPattern: '**** **** **** ####',
                          maskedSymbol: '*',
                        )
                      : widget.cardNumber,
                  style: textStyle.h520pxMedium.copyWith(
                    fontSize: size.size19.sp,
                    fontWeight: FontWeight.w700,
                    color: color.greyFullWhite120,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: size.size9.dp),
                  child: InkWell(
                    onTap: () {
                      setMaskText(BankCardDetails.cardNumber);
                    },
                    child: maskCardNumber
                        ? ImageWidget(
                            imageType: ImageType.assetImage,
                            path: 'assets/images/visibility.svg',
                            color: color.greyFullWhite120,
                            package: 'tcs_dff_design_system',
                          )
                        : ImageWidget(
                            imageType: ImageType.assetImage,
                            path: 'assets/images/visibility_off_variation.svg',
                            package: 'tcs_dff_design_system',
                          ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              LabelValue(
                label: widget.expiryTitle,
                value: maskExpiryDate
                    ? Masker.doMask(
                        originalText: widget.expiryDate,
                        maskType: MaskTypes.custom,
                        customPattern: '**#**',
                        maskedSymbol: '*',
                      )
                    : widget.expiryDate,
                onTap: () {
                  setMaskText(BankCardDetails.expiryDate);
                },
                isMasked: maskExpiryDate,
                package: widget.package,
              ),
              Container(
                margin: EdgeInsets.only(left: size.size18.dp),
              ),
              LabelValue(
                label: widget.cvvTitle,
                value: maskCVV
                    ? Masker.doMask(
                        originalText: widget.cvv,
                        maskType: MaskTypes.custom,
                        customPattern: '***',
                        maskedSymbol: '*',
                      )
                    : widget.cvv,
                onTap: () {
                  setMaskText(BankCardDetails.cvv);
                },
                isMasked: maskCVV,
                package: widget.package,
              ),
            ],
          ),
          Container(
            alignment: Alignment.centerRight,
            child: TextWidget(
              text: widget.cardTypeNote ?? '',
              style: textStyle.labelSmall14Medium.copyWith(
                fontSize: size.size14.dp,
                fontWeight: FontWeight.w500,
                color: color.greyFullWhite120,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LabelValue extends StatelessWidget {
  final String label;
  final String value;
  final Function() onTap;
  final bool isMasked;
  final String package;
  LabelValue({
    super.key,
    required this.label,
    required this.value,
    required this.onTap,
    this.isMasked = true,
    required this.package,
  });

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final textStyle = context.theme.appTextStyles;
    final color = context.theme.appColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: size.size8.dp),
          child: Text(
            label,
            style: textStyle.labelSmall14Medium.copyWith(
              fontSize: size.size16.sp,
              fontWeight: FontWeight.w400,
              color: color.greyFullWhite120,
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              textAlign: TextAlign.center,
              value,
              style: textStyle.h520pxMedium.copyWith(
                fontSize: size.size20.sp,
                fontWeight: FontWeight.w400,
                color: color.greyFullWhite120,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: size.size12.dp,
              ),
              child: InkWell(
                onTap: onTap,
                child: isMasked
                    ? ImageWidget(
                        imageType: ImageType.assetImage,
                        path: 'assets/images/visibility.svg',
                        color: color.greyFullWhite120,
                        package: 'tcs_dff_design_system',
                      )
                    : ImageWidget(
                        imageType: ImageType.assetImage,
                        path: 'assets/images/visibility_off.svg',
                        color: color.greyFullWhite120,
                        package: 'tcs_dff_design_system',
                      ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
