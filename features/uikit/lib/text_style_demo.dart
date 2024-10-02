import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/uikit/foundation/text_widget.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';

// application default text style overview

class StyleDemo extends StatelessWidget {
  const StyleDemo({super.key});

  @override
  Widget build(final BuildContext context) => Column(
        children: [
          TextWidget(
            text: 'Scale Category',
            style: context.theme.appTextStyles.bodyCopy2Small16Regular
                .copyWith(fontSize: context.theme.appSize.size24.sp),
          ),
          TextWidget(
            text: 'captionStyle',
            style: context.theme.appTextStyles.detailsSmall12Regular
                .copyWith(fontWeight: FontWeight.w500),
          ),
          TextWidget(
            text: 'body2Style',
            style: context.theme.appTextStyles.buttonSmall14SemiBold
                .copyWith(fontWeight: FontWeight.w500),
          ),
          TextWidget(
            text: 'mediumHeader6Style',
            style: context.theme.appTextStyles.labelSmall18Medium
                .copyWith(fontSize: context.theme.appSize.size20.sp),
          ),
          TextWidget(
            text: 'regularHeader3Style',
            style: context.theme.appTextStyles.h636pxRegular
                .copyWith(fontSize: context.theme.appSize.size48.sp),
          ),
          TextWidget(
            text: 'regularHeader4Style',
            style: context.theme.appTextStyles.h636pxRegular
                .copyWith(fontSize: context.theme.appSize.size34.sp),
          ),
          TextWidget(
            text: 'regularHeader4Style',
            style: context.theme.appTextStyles.h636pxRegular
                .copyWith(fontSize: context.theme.appSize.size34.sp),
          ),
          TextWidget(
            text: 'regularHeader6Style',
            style: context.theme.appTextStyles.h636pxRegular
                .copyWith(fontSize: context.theme.appSize.size24.sp),
          ),
          TextWidget(
            text: 'subtitle1Style',
            style: context.theme.appTextStyles.labelSmall16Medium,
          ),
          TextWidget(
            text: 'subtitle2Style',
            style: context.theme.appTextStyles.labelSmall14Medium,
          ),
        ],
      );
}
