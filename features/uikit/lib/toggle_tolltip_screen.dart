import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/tcs_dff_design_system.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';

class Toggletooltip extends StatelessWidget {
  const Toggletooltip({super.key});

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    return Column(
      children: [
        SizedBox(
          height: size.size50.dp,
        ),
        Center(
          child: Toggle(
            onTap: (final p0) {},
          ),
        ),
        SizedBox(
          height: size.size100.dp,
        ),
      ],
    );
  }
}
