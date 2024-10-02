import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/uikit/container/card/card_config.dart';
import 'package:tcs_dff_design_system/uikit/container/card/product_description_banner.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';
import 'package:tcs_dff_shared_library/localization/app_localizations.dart';

class ProductDescriptionBannerScreen extends StatelessWidget {
  const ProductDescriptionBannerScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    final locale = context.locale;
    final size = Theme.of(context).appSize;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(size.size4.dp),
        child: Column(
          children: [
            ProductDescriptionBannerWidget(
              cardModel: CardConfig(
                backgroundColor: context.theme.appColor.clrPrimaryPurple,
                height: size.size200.dp,
                width: size.size200.dp,
                elevation: size.size5.dp,
                margin: EdgeInsets.all(size.size30.dp),
                shapeBorder: RoundedRectangleBorder(
                  side: BorderSide(
                    color: context.theme.appColor.greyLightestGrey80,
                    width: size.size2.dp,
                  ),
                  borderRadius: BorderRadius.circular(
                    size.size10.dp,
                  ),
                ),
              ),
              bannerText: locale.txt(key: 'productDescription'),
              loanAmount: locale.txt(key: 'paplAmount'),
              imagePath: 'images/product_description_banner.svg',
              imagePackage: 'uikit',
              textAlign: Alignment.topLeft,
            ),
          ],
        ),
      ),
    );
  }
}
