import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/uikit/container/filter_field.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';
import 'package:tcs_dff_shared_library/localization/app_localizations.dart';

class FilterFieldScreen extends StatefulWidget {
  const FilterFieldScreen({super.key});

  @override
  State<FilterFieldScreen> createState() => _FilterFieldScreenState();
}

class _FilterFieldScreenState extends State<FilterFieldScreen> {
  bool v = false;
  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final locale = context.locale;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            FilterField(
              onChanged: (final val) {},
              title: locale.txt(key: 'mobilePrepaid'),
            ),
            SizedBox(
              height: size.size10.dp,
            ),
            FilterField(
              bankLogoPath: 'images/location_on.svg',
              package: 'uikit',
              onChanged: (final val) {},
              title: locale.txt(key: 'mobilePrepaid'),
            ),
          ],
        ),
      ),
    );
  }
}
