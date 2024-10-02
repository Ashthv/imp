import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/uikit/foundation/tag_widget.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';
import 'package:tcs_dff_shared_library/localization/app_localizations.dart';

class TagScreen extends StatefulWidget {
  const TagScreen({super.key});

  @override
  State<TagScreen> createState() => _TagScreenState();
}

class _TagScreenState extends State<TagScreen> {
  bool leftIcon = false;
  @override
  Widget build(final BuildContext context) {
    final locale = context.locale;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: context.theme.appSize.size15.dp),
            TagWidget(
              text: locale.txt(key: 'tag'),
              textColor: context.theme.appColor.greyFullWhite120,
              backgroundColor: context.theme.appColor.clrPrimaryPink50,
              isSelected: true,
              // isLeftIcon: leftIcon,
              onPressed: (final bool isSelected) {},
            ),
            SizedBox(height: context.theme.appSize.size15.dp),
            TagWidget(
              text: locale.txt(key: 'tag'),
              //isLeftIcon: leftIcon,
            ),
            SizedBox(height: context.theme.appSize.size15.dp),
            TagWidget(
              text: locale.txt(key: 'tag'),
              // isLeftIcon: false,
            ),
            SizedBox(height: context.theme.appSize.size15.dp),
            TagWidget(
              text: locale.txt(key: 'tag'),
              //isLeftIcon: false,
              backgroundColor: context.theme.appColor.clrPrimaryPink100,
              textColor: context.theme.appColor.clrPrimaryPink10,
            ),
            SizedBox(height: context.theme.appSize.size15.dp),
          ],
        ),
      ),
    );
  }
}
