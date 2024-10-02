import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/uikit/container/card/banner_card.dart';
import 'package:tcs_dff_design_system/uikit/container/card/card_config.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';
import 'package:tcs_dff_shared_library/localization/app_localizations.dart';

class BannerCardViewScreen extends StatelessWidget {
  const BannerCardViewScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    final locale = context.locale;
    final size = Theme.of(context).appSize;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(size.size8.dp),
        child: Column(
          children: [
            BannerCardWidget(
              cardModel: CardConfig(
                backgroundColor: context.theme.appColor.clrPrimaryPurple,
                elevation: size.size5.dp,
                margin: EdgeInsets.all(size.size30.dp),
                shapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    size.size16.dp,
                  ),
                ),
              ),
              bannerText: locale.txt(key: 'paplLoanSuccessMessage'),
              buttonText: locale.txt(key: 'applyNow'),
              highlightedTexts: [
                locale.txt(key: 'paplStatus'),
                locale.txt(key: 'paplAmount'),
              ],
              broderColorText: locale.txt(key: 'paplBorderText'),
              imagePath: [
                'images/loan_visible.svg',
                'images/keyboard_arrow_right.svg',
              ],
              imagePackage: 'uikit',
              callback: () {},
            ),
          ],
        ),
      ),
    );
  }
}
