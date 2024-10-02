import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';

class AppSizerScreen extends StatelessWidget {
  const AppSizerScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    final style = context.theme.appTextStyles;
    final size = context.theme.appSize;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          '${size.size25}',
          style: style.labelSmall14Medium.copyWith(
            fontSize: size.size25,
          ),
        ),
        Text(
          '${size.size25.dp} dp',
          style: style.labelSmall14Medium.copyWith(
            fontSize: size.size25.dp,
          ),
        ),
        Text(
          '${size.size25.sp} sp',
          style: style.labelSmall14Medium.copyWith(
            fontSize: size.size25.sp,
          ),
        ),
      ],
    );
  }
}
