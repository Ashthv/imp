import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/tcs_dff_design_system.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';
import 'package:tcs_dff_shared_library/localization/app_localizations.dart';

class GridCarouselScreen extends StatelessWidget {
  const GridCarouselScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    final locale = context.locale;
    return WidgetCarousel(
      // autoScroll: false,
      widgetList: [
        BuildGridwidget(
          crossAxisCount: 2,
          itemCount: 4,
          productDescription: [
            locale.txt(key: 'detailProductDescription'),
            locale.txt(key: 'detailProductDescription1'),
            locale.txt(key: 'detailProductDescription2'),
            locale.txt(key: 'detailProductDescription3'),
          ],
          imagePath: [
            'images/category_ic_bill_payments.svg',
            'images/ic_mutual_funds.svg',
            'images/ic_view_more.svg',
            'images/ic_mobile_recharge.svg',
          ],
          productDetailHeader:
              locale.txt(key: 'ProductDetailDescriptionHeader'),
        ),
        BuildGridwidget(
          crossAxisCount: 2,
          itemCount: 3,
          productDescription: [
            locale.txt(key: 'detailProductDescription4'),
            locale.txt(key: 'detailProductDescription5'),
            locale.txt(key: 'detailProductDescription6'),
          ],
          imagePath: [
            'images/ic_view_more.svg',
            'images/ic_mobile_recharge.svg',
            'images/category_ic_bill_payments.svg',
          ],
          productDetailHeader:
              locale.txt(key: 'ProductDetailDescriptionHeader1'),
        ),
        BuildListwidget(
          productDescription: [
            locale.txt(key: 'detailProductDescription7'),
            locale.txt(key: 'detailProductDescription8'),
          ],
          imagePath: [
            'images/ic_view_more.svg',
            'images/ic_mobile_recharge.svg',
          ],
          productDetailHeader:
              locale.txt(key: 'ProductDetailDescriptionHeader2'),
        ),
      ],
      imageChangeDuration: 3,
    );
  }
}

class BuildGridwidget extends StatelessWidget {
  final int crossAxisCount;
  final int itemCount;
  final List<String> productDescription;
  final List<String> imagePath;
  final String productDetailHeader;

  BuildGridwidget({
    super.key,
    required this.crossAxisCount,
    required this.itemCount,
    required this.productDescription,
    required this.imagePath,
    required this.productDetailHeader,
  });

  @override
  Widget build(final BuildContext context) {
    final size = Theme.of(context).appSize;
    final textStyle = context.theme.appTextStyles;
    final color = context.theme.appColor;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: context.theme.appSize.size12.dp,
          ),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              productDetailHeader,
              style: textStyle.h124pxsemiBold.copyWith(
                fontSize: size.size22.dp,
                fontWeight: FontWeight.w600,
                color: color.clrPrimaryPurple,
              ),
            ),
          ),
        ),
        Expanded(
          child: GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            childAspectRatio: 1 / 0.8,
            crossAxisCount: crossAxisCount,
            children: List<Widget>.generate(
              itemCount,
              (final index) => GridTile(
                child: BuildProductDescriptionDetailsWidget(
                  productDescription: productDescription,
                  imagePath: imagePath,
                  indexValue: index,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BuildListwidget extends StatelessWidget {
  final List<String> productDescription;
  final List<String> imagePath;
  final String productDetailHeader;

  BuildListwidget({
    super.key,
    required this.productDescription,
    required this.imagePath,
    required this.productDetailHeader,
  });

  @override
  Widget build(final BuildContext context) {
    final size = Theme.of(context).appSize;
    final textStyle = context.theme.appTextStyles;
    final color = context.theme.appColor;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: context.theme.appSize.size12.dp,
          ),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              productDetailHeader,
              style: textStyle.h124pxsemiBold.copyWith(
                fontSize: size.size22.dp,
                fontWeight: FontWeight.w600,
                color: color.clrPrimaryPurple,
              ),
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 2,
          itemBuilder: (final context, final index) =>
              BuildProductDescriptionDetailsWidget(
            productDescription: productDescription,
            imagePath: imagePath,
            indexValue: index,
          ),
        ),
      ],
    );
  }
}

class BuildProductDescriptionDetailsWidget extends StatelessWidget {
  final List<String> productDescription;
  final List<String> imagePath;
  final int indexValue;

  BuildProductDescriptionDetailsWidget({
    super.key,
    required this.productDescription,
    required this.imagePath,
    required this.indexValue,
  });

  @override
  Widget build(final BuildContext context) {
    final size = Theme.of(context).appSize;

    return ProductDescriptionDetailsWidget(
      cardModel: CardConfig(
        backgroundColor: context.theme.appColor.clrPrimaryPurple,
        elevation: size.size5.dp,
        margin: EdgeInsets.all(size.size10.dp),
        shapeBorder: RoundedRectangleBorder(
          side: BorderSide(
            color: context.theme.appColor.greyLightestGrey80,
            width: size.size2.dp,
          ),
          borderRadius: BorderRadius.circular(
            size.size8.dp,
          ),
        ),
      ),
      productTitleText: productDescription[indexValue],
      imagePath: imagePath[indexValue],
      imagePackage: 'uikit',
    );
  }
}
