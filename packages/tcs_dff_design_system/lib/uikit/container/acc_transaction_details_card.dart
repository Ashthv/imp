import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../../utils/image_type.dart';
import '../../utils/sizer/app_sizer.dart';
import '../foundation/text_widget.dart';
import 'image/image_widget.dart';

class AccountTransactionDetailsWidget extends StatelessWidget {
  const AccountTransactionDetailsWidget({
    super.key,
    required this.fileimagePath,
    required this.imagePackage,
    required this.transactionStatusImagePath,
    required this.transactionType,
    required this.transactionAmount,
    required this.accNumber,
    required this.dateAndTime,
    required this.transactionStatus,
  });

  final String fileimagePath,
      transactionStatusImagePath,
      imagePackage,
      transactionType,
      transactionAmount,
      accNumber,
      dateAndTime,
      transactionStatus;

  @override
  Widget build(final BuildContext context) {
    final textStyle = context.theme.appTextStyles;
    final textColor = context.theme.appColor;
    final size = context.theme.appSize;

    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: size.size21.dp, vertical: size.size12.dp,),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                text: transactionType,
                style: textStyle.labelSmall14Medium
                    .copyWith(color: textColor.greyBlackUi10),
              ),
              Row(
                children: [
                  TextWidget(
                    text: transactionAmount,
                    style: textStyle.bodyCopy2Link16SemiBold
                        .copyWith(color: textColor.clrPrimaryPurple20),
                  ),
                  ImageWidget(
                    imageType: ImageType.assetImage,
                    path: fileimagePath,
                    package: imagePackage,
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                text: accNumber,
                style: textStyle.h414pxRegular.copyWith(
                  color: textColor.greyMediumGrey40,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: dateAndTime,
                    style: textStyle.h414pxRegular.copyWith(
                      color: textColor.greyMediumGrey40,
                    ),
                  ),
                  Row(
                    children: [
                      TextWidget(
                        text: transactionStatus,
                        style: textStyle.h414pxRegular.copyWith(
                          color: textColor.greyMediumGrey40,
                        ),
                      ),
                      ImageWidget(
                        imageType: ImageType.assetImage,
                        path: transactionStatusImagePath,
                        package: imagePackage,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
