import 'package:flutter/material.dart';
import 'package:tcs_dff_shared_library/masker/masker.dart';

import '../../../tcs_dff_design_system.dart';
import '../../../theme/theme.dart';
import '../../../utils/sizer/app_sizer.dart';

class AccountCardWidget extends StatelessWidget {
  const AccountCardWidget({
    super.key,
    this.accountNumber,
    this.accountType,
    this.balance,
    this.lableText,
    this.onIconTap,
    this.onCardTap,
    this.bankLogo,
    this.isSelected = false,
    this.isDropdownArrow = false,
  });

  final String? accountNumber;
  final String? accountType;
  final String? balance;
  final String? lableText;
  final void Function()? onIconTap;
  final void Function()? onCardTap;
  final ImageWidget? bankLogo;
  final bool? isSelected;
  final bool? isDropdownArrow;

  Widget getImageIcon() {
    if (isDropdownArrow == true) {
      return ImageWidget(
        imageType: ImageType.assetImage,
        path: 'assets/images/keyboard_arrow_down.svg',
        package: 'tcs_dff_design_system',
      );
    } else if (isDropdownArrow == false && isSelected == true) {
      return ImageWidget(
        imageType: ImageType.assetImage,
        path: 'assets/images/check_circle.svg',
        package: 'tcs_dff_design_system',
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  @override
  Widget build(final BuildContext context) {
    final textStyle = context.theme.appTextStyles;
    final size = context.theme.appSize;
    final color = context.theme.appColor;

    return InkWell(
      onTap: onCardTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size.size12.dp),
          border: Border.all(
            color: isSelected ?? false
                ? color.clrPrimaryPurple
                : color.greyLightestGrey80,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (bankLogo != null)
                  Padding(
                    padding: EdgeInsets.only(
                      top: size.size10.dp,
                      left: size.size10.dp,
                      bottom: size.size10.dp,
                    ),
                    child: bankLogo,
                  ),
                Padding(
                  padding: EdgeInsets.all(size.size10.dp),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Masker.doMask(
                          originalText: accountNumber ?? '',
                          maskType: MaskTypes.creditCard,
                        ),
                        style: textStyle.bodyCopy2Medium16SemiBold
                            .copyWith(color: color.greyBlackUi10),
                      ),
                      Text(
                        accountType ?? '',
                        style: textStyle.detailsSmall12Regular
                            .copyWith(color: color.greyDarkGrey30),
                      ),
                      Row(
                        children: [
                          Text(
                            lableText ?? '',
                            style: textStyle.detailsSmall12Regular
                                .copyWith(color: color.greyDarkGrey30),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: size.size2.dp),
                            child: Text(
                              balance ?? '',
                              style: textStyle.detailsSmall12Regular
                                  .copyWith(color: color.greyDarkGrey30),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(size.size15.dp),
              child: getImageIcon(),
            ),
          ],
        ),
      ),
    );
  }
}
