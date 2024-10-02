import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/uikit/container/branch_location_widget.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';
import 'package:tcs_dff_shared_library/localization/app_localizations.dart';

class BranchLocationWidgetScreen extends StatelessWidget {
  const BranchLocationWidgetScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final locale = context.locale;
    return Column(
      children: [
        BranchLocationWidget(
          imagePath: 'images/location_on.svg',
          package: 'uikit',
          title: locale.txt(key: 'branchLocationTitle'),
          subTitle: locale.txt(key: 'branchLocationSubTitle'),
          isSelected: true,
        ),
        SizedBox(
          height: size.size20.dp,
        ),
        BranchLocationWidget(
          title: locale.txt(key: 'branchLocationTitle'),
          subTitle: locale.txt(key: 'branchLocationSubTitle'),
        ),
      ],
    );
  }
}
