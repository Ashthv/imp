import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/tcs_dff_design_system.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';

class DemoIconSubSectionAppBar extends IconSubSectionAppBar {
  const DemoIconSubSectionAppBar({
    super.key,
    super.title = '',
    super.leadingIcon = const SizedBox.shrink(),
  });

  @override
  Widget build(final BuildContext context) => IconSubSectionAppBar(
        title: 'Page Header_18_semibold',
        backgroundColor: context.theme.appColor.goldLighter,
        subSections: [
          Text(
            'Sub Section Heading_4_14_regular',
            style: context.theme.appTextStyles.h414pxRegular.copyWith(
              fontSize: context.theme.appSize.size14.sp,
            ),
          ),
          Row(
            children: [
              Text(
                'Copy ',
                style: context.theme.appTextStyles.h414pxRegular.copyWith(
                  fontSize: context.theme.appSize.size14.sp,
                ),
              ),
              Icon(
                Icons.copy_outlined,
                color: context.theme.appColor.clrPrimaryPurple,
              ),
            ],
          ),
        ],
        leadingIcon: Container(
          padding: EdgeInsets.all(context.theme.appSize.size10.dp),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: context.theme.appColor.clrPrimaryBlue90,
            ),
          ),
          child: IconWidget(
            iconName: 'images/bill_payments.png',
            iconColor: context.theme.appColor.clrPrimaryPurple,
            package: 'uikit',
            iconSize: IconSize.large,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.ad_units_outlined,
              color: context.theme.appColor.clrPrimaryPurple,
            ),
          ),
        ],
      );
}
