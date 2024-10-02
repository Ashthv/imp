import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/tcs_dff_design_system.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/uikit/foundation/divider_line/divider_line.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';

class DividerLineScreen extends StatefulWidget {
  const DividerLineScreen({super.key});

  @override
  State<DividerLineScreen> createState() => _DividerLineScreenState();
}

class _DividerLineScreenState extends State<DividerLineScreen> {
  @override
  Widget build(final BuildContext context) {
    final color = context.theme.appColor;
    final size = context.theme.appSize;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(size.size10.dp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DividerLine(
              dividerType: DividerType.solidDivider,
              height: size.size1.dp,
            ),
            SizedBox(
              height: size.size10.dp,
            ),
            DividerLine(
              dividerType: DividerType.dashDivider,
              height: size.size1.dp,
              width: size.size4.dp,
            ),
            SizedBox(
              height: size.size10.dp,
            ),
            DividerLine(
              dividerType: DividerType.textDivider,
              height: size.size1.dp,
              color: color.clrPrimaryBlue,
              text: 'Text',
            ),
          ],
        ),
      ),
    );
  }
}
