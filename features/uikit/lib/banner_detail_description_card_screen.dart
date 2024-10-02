import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/uikit/container/card/card_config.dart';
import 'package:tcs_dff_design_system/uikit/container/product_description_details_widget.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';
import 'package:tcs_dff_shared_library/localization/app_localizations.dart';

class BannerDetailDescriptionScreen extends StatelessWidget {
  const BannerDetailDescriptionScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    final locale = context.locale;
    final size = Theme.of(context).appSize;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(size.size8.dp),
        child: Column(
          children: [
            ProductDescriptionDetailsWidget(
              cardModel: CardConfig(
                backgroundColor: context.theme.appColor.clrPrimaryPurple,
                height: size.size200.dp,
                width: size.size200.dp,
                elevation: size.size5.dp,
                margin: EdgeInsets.all(size.size10.dp),
                shapeBorder: RoundedRectangleBorder(
                  side: BorderSide(
                    color: context.theme.appColor.greyLightestGrey80,
                    width: size.size2.dp,
                  ),
                  borderRadius: BorderRadius.circular(
                    size.size20.dp,
                  ),
                ),
              ),
              productTitleText: locale.txt(key: 'detailProductDescription'),
              imagePath: 'images/category_ic_bill_payments.svg',
              imagePackage: 'uikit',
            ),
          ],
        ),
      ),
    );
  }
}
