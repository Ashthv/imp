import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import '../../../utils/image_type.dart';
import '../../../utils/sizer/app_sizer.dart';
import '../../foundation/text_widget.dart';
import '../image/image_widget.dart';

class PhysicalDebitCard extends StatefulWidget {
  final String cardHolderName;
  final String backgroundImagePath;
  final String package;
  final String? cardTypeNote;
  final ImageType imageType;

  PhysicalDebitCard({
    super.key,
    required this.cardHolderName,
    required this.backgroundImagePath,
    required this.package,
    this.cardTypeNote,
    this.imageType = ImageType.assetImage,
  });

  @override
  State<PhysicalDebitCard> createState() => _DebitCardState();
}

class _DebitCardState extends State<PhysicalDebitCard> {
  ImageProvider imageProvider = const NetworkImage('');

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
          ImageWidget(
            imageType: ImageType.assetImage,
            path: 'assets/images/card_chip.svg',
            package: 'tcs_dff_design_system',
          ),
          Expanded(
            child: Container(
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
          ),
          Container(
            alignment: Alignment.bottomRight,
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
