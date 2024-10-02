import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import '../../../utils/image_type.dart';
import '../../../utils/sizer/app_sizer.dart';
import '../image/image_widget.dart';

class BankCard extends StatefulWidget {
  final String cardType;
  final String cardName;
  final String cardNumber;
  final String cardHolderName;
  final String accountNo;
  final String backgroundImagePath;
  final String cardTypeImagePath;
  final String? package;
  final bool? isFaded;
  BankCard({
    super.key,
    required this.cardType,
    required this.cardName,
    required this.cardNumber,
    required this.cardHolderName,
    required this.accountNo,
    required this.backgroundImagePath,
    required this.cardTypeImagePath,
    this.isFaded,
    this.package,
  });

  @override
  State<BankCard> createState() => _BankCardState();
}

class _BankCardState extends State<BankCard> {
  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final textStyle = context.theme.appTextStyles;
    final color = context.theme.appColor;

    return Container(
      padding: EdgeInsets.only(
        left: size.size24.dp,
        top: size.size16.dp,
        bottom: size.size15.dp,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          size.size8.dp,
        ),
        image: DecorationImage(
          opacity: widget.isFaded ?? false ? 0.5 : 1,
          fit: BoxFit.fill,
          image: AssetImage(
            widget.backgroundImagePath,
            package: widget.package,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.cardType,
            style: textStyle.labelSmall14Medium.copyWith(
              fontWeight: FontWeight.w700,
              color: color.greyFullWhite120,
              fontSize: size.size14.dp,
            ),
          ),
          Text(
            widget.cardName,
            style: textStyle.labelSmall14Medium.copyWith(
              fontWeight: FontWeight.w700,
              color: color.greyFullWhite120,
              fontSize: size.size14.dp,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: size.size22.dp,
              bottom: size.size25.dp,
            ),
            child: Text(
              widget.cardNumber,
              style: textStyle.h520pxMedium.copyWith(
                fontSize: size.size20.dp,
                fontWeight: FontWeight.w700,
                color: color.greyFullWhite120,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.cardHolderName,
                    style: textStyle.h520pxMedium.copyWith(
                      fontSize: size.size20.dp,
                      fontWeight: FontWeight.w700,
                      color: color.greyFullWhite120,
                    ),
                  ),
                  Text(
                    widget.accountNo,
                    style: textStyle.labelSmall14Medium.copyWith(
                      fontSize: size.size14.dp,
                      fontWeight: FontWeight.w400,
                      color: color.greyFullWhite120,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: size.size17.dp,
                ),
                child: ImageWidget(
                  imageType: ImageType.assetImage,
                  path: widget.cardTypeImagePath,
                  package: widget.package,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BankCardModel {
  String cardType;
  String cardName;
  String cardNumber;
  String cardHolderName;
  String accountNo;
  String backgroundImagePath;
  String cardTypeImagePath;
  String? package;
  bool? isFaded;

  BankCardModel({
    required this.cardType,
    required this.cardName,
    required this.cardNumber,
    required this.cardHolderName,
    required this.accountNo,
    required this.backgroundImagePath,
    required this.cardTypeImagePath,
    this.package,
    this.isFaded,
  });
}
