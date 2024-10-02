import 'package:flutter/material.dart';

import '../../tcs_dff_design_system.dart';
import '../../theme/theme.dart';
import '../../utils/credit_card_accordian_template_model.dart';
import '../../utils/sizer/app_sizer.dart';

class CreditCardAccordianWidget extends StatefulWidget {
  CreditCardAccordianWidget({
    super.key,
    required this.creditCardAccordianTemplateData,
  });
  final CreditCardAccordianTemplateData creditCardAccordianTemplateData;

  @override
  State<CreditCardAccordianWidget> createState() =>
      _CreditCardAccordianWidgetState();
}

class _CreditCardAccordianWidgetState extends State<CreditCardAccordianWidget> {
  bool isShowMore = false;
  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final color = context.theme.appColor;
    final textStyles = context.theme.appTextStyles;
    //final locale = context.locale;
    final expansionTileController = ExpansionTileController();
    return Padding(
      padding: EdgeInsets.all(size.size20.dp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: color.greyFullWhite120,
              borderRadius: BorderRadius.circular(size.size12.dp),
              border: Border.all(
                width: 0.5,
                color: color.greyLightestGrey80,
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: size.size5.dp,
                  color: color.greyLightestGrey80,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              children: [
                ExpansionTile(
                  controller: expansionTileController,
                  tilePadding: EdgeInsets.zero,
                  childrenPadding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 0.5,
                      color: color.greyLightestGrey80,
                    ),
                    borderRadius: BorderRadius.circular(size.size12.dp),
                  ),
                  collapsedShape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 0.5,
                      color: color.greyLightestGrey80,
                    ),
                    borderRadius: BorderRadius.circular(size.size12.dp),
                  ),
                  backgroundColor: color.greyFullWhite120,
                  collapsedBackgroundColor: color.greyFullWhite120,
                  title: Text(
                    widget.creditCardAccordianTemplateData.headingText,
                    style: textStyles.h316pxsemiBold,
                  ),
                  children: [
                    SizedBox(height: size.size15.dp),
                    Container(
                      padding: EdgeInsets.all(size.size20.dp),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.creditCardAccordianTemplateData
                                    .applicationNumberText,
                                style: textStyles.h414pxRegular.copyWith(
                                  color: color.greyDarkestGrey20,
                                ),
                              ),
                              Text(
                                widget.creditCardAccordianTemplateData
                                    .applicationNumber,
                                style: textStyles.bodyCopy2Medium16SemiBold,
                              ),
                              SizedBox(height: size.size12.dp),
                              Text(
                                widget.creditCardAccordianTemplateData
                                    .appliedOnDateText,
                                style: textStyles.h414pxRegular.copyWith(
                                  color: color.greyDarkestGrey20,
                                ),
                              ),
                              Text(
                                widget.creditCardAccordianTemplateData
                                    .appliedOnDate,
                                style: textStyles.bodyCopy2Medium16SemiBold,
                              ),
                              SizedBox(height: size.size12.dp),
                              Text(
                                widget
                                    .creditCardAccordianTemplateData.statusText,
                                style: textStyles.h414pxRegular.copyWith(
                                  color: color.greyDarkestGrey20,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: size.size12.dp),
                                padding: EdgeInsets.symmetric(
                                  vertical: size.size2.dp,
                                  horizontal: size.size8.dp,
                                ),
                                decoration: BoxDecoration(
                                  color: color.statLightAmber,
                                  borderRadius:
                                      BorderRadius.circular(size.size12.dp),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.info_outline,
                                      color: color.statAmberDark,
                                    ),
                                    SizedBox(width: size.size5.dp),
                                    TextWidget(
                                      text: widget
                                          .creditCardAccordianTemplateData
                                          .status,
                                      style: textStyles
                                          .bodyCopy2Medium16SemiBold
                                          .copyWith(
                                        fontSize: size.size12.dp,
                                        color: color.statAmberDark,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: size.size12.dp),
                              Text(
                                widget.creditCardAccordianTemplateData
                                    .remarksText,
                                style: textStyles.bodyCopy3Medium14SemiBold
                                    .copyWith(
                                  color: color.greyDarkestGrey20,
                                ),
                              ),
                              SizedBox(height: size.size12.dp),
                              Text(
                                widget.creditCardAccordianTemplateData.remarks,
                                style: textStyles.h414pxRegular.copyWith(
                                  color: color.greyDarkestGrey20,
                                ),
                                maxLines: isShowMore ? null : 2,
                              ),
                              GestureDetector(
                                onTap: () {
                                  toggleShowMore(
                                    !isShowMore,
                                  );
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      !isShowMore
                                          ? Icons.keyboard_arrow_down
                                          : Icons.keyboard_arrow_up,
                                      color: color.clrPrimaryPurple,
                                    ),
                                    TextWidget(
                                      text:
                                          // ignore: lines_longer_than_80_chars
                                          '${widget.creditCardAccordianTemplateData.showText} ${!isShowMore ? widget.creditCardAccordianTemplateData.moreText : widget.creditCardAccordianTemplateData.lessText}',
                                      style: textStyles.h414pxRegular.copyWith(
                                        color: color.clrPrimaryPurple,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: SizedBox(
                              width: size.size109.dp,
                              height: size.size70.dp,
                              child: widget
                                  .creditCardAccordianTemplateData.cardImage,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(size.size12.dp),
                    border: Border.all(
                      width: 0.5,
                      color: color.greyLightestGrey80,
                    ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: size.size16.dp,
                        offset: Offset(size.size4.dp, size.size4.dp),
                        color: color.greyLightestGrey80,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(size.size12.dp),
                    child: ExpansionTile(
                      tilePadding: EdgeInsets.symmetric(
                        horizontal: size.size24.dp,
                        vertical: size.size4.dp,
                      ),
                      onExpansionChanged: (final value) {
                        !value
                            ? expansionTileController.collapse()
                            : expansionTileController.expand();
                      },
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 0.5,
                          color: color.greyLightestGrey80,
                        ),
                        borderRadius: BorderRadius.circular(size.size12.dp),
                      ),
                      collapsedShape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 0.5,
                          color: color.greyLightestGrey80,
                        ),
                        borderRadius: BorderRadius.circular(size.size12.dp),
                      ),
                      title: Text(
                        //locale.txt(key: 'creditcardapplication'),
                        widget.creditCardAccordianTemplateData.headingText,
                        style: textStyles.h316pxsemiBold,
                      ),
                      backgroundColor: color.greyFullWhite120,
                      collapsedBackgroundColor: color.greyFullWhite120,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void toggleShowMore(final bool checkIsShowMore) {
    setState(() {
      isShowMore = checkIsShowMore;
    });
  }
}
