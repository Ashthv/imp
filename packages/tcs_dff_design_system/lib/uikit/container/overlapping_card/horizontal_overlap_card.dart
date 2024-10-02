import 'package:flutter/material.dart';
import '../../../theme/theme.dart';
import '../../../utils/sizer/app_sizer.dart';
import 'card_content_model.dart';

class HorizontalOveralapCard extends StatelessWidget {
  const HorizontalOveralapCard({
    super.key,
    required this.cardData,
    this.margin = EdgeInsets.zero,
  });
  final CardModel cardData;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(final BuildContext context) {
    final color = context.theme.appColor;
    final size = context.theme.appSize;
    final textstyle = context.theme.appTextStyles;
    return InkWell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            margin: margin,
            decoration: BoxDecoration(
              color: color.clrPrimaryPurple30,
              boxShadow: [
                BoxShadow(
                  color: color.clrPrimaryPink100,
                  offset: Offset(size.size15.dp, size.size20.dp),
                ),
              ],
              borderRadius: BorderRadius.circular(size.size15.dp),
            ),
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size.size15.dp),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: size.size21.dp,
                  right: size.size14.dp,
                  bottom: size.size13.dp,
                  top: size.size12.dp,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: size.size2.dp),
                      child: Text(
                        cardData.title,
                        style: textstyle.bodyCopy2Large16Bold.copyWith(
                          color: color.greyWhiteUi100,
                          fontSize: size.size18.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Text(
                      cardData.description,
                      style: textstyle.bodyCopy3Small14Regular.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: size.size14.sp,
                        color: color.greyWhiteUi100,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
