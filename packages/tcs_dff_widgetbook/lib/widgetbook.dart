// widgetbook.dart

import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// Import the generated directories variable
import 'widgetbook.directories.g.dart';

void main() {
  runApp(
    AppSizer(
      builder: (final context, final orientation, final type) =>
          const WidgetbookApp(),
    ),
  );
}

@widgetbook.App()
class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(final BuildContext context) => Widgetbook.material(
        // Use the generated directories variable
        directories: directories,
        addons: [
          themeAddon,
          DeviceFrameAddon(
            devices: [
              Devices.ios.iPhone13,
            ],
          ),
        ],
        integrations: [],
      );
}

final themeAddon = ThemeAddon<ThemeData>(
  themes: [
    WidgetbookTheme(
      name: 'Default',
      data: AppTheme.appTheme,
    ),
  ],
  initialTheme: WidgetbookTheme(
    name: 'Default',
    data: AppTheme.appTheme,
  ),
  themeBuilder:
      (final BuildContext context, final ThemeData theme, final Widget child) =>
          Theme(
    data: theme,
    child: child,
  ),
);
