import '../specification/specification.dart';

class ViewGeneratorTmpl {
  static String generateViewStateLessClass(final ViewSpec viewSpec) => '''
import 'package:flutter/material.dart';

import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_shared_library/localization/app_localizations.dart';

class ${viewSpec.className}Page extends StatelessWidget {

  const ${viewSpec.className}Page({super.key});

    @override
    Widget build(final BuildContext context) {
      final size = context.theme.appSize;
      final color = context.theme.appColor;
      final style = context.theme.appTextStyles;
      final locale = context.locale;

      // return any widget
  }
}
''';

  static String generateViewStatefullClass(final ViewSpec viewSpec) => '''
import 'package:flutter/material.dart';

import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_shared_library/localization/app_localizations.dart';

class ${viewSpec.className}Page extends StatefulWidget {
  const ${viewSpec.className}Page({super.key});

  @override
  State<${viewSpec.className}Page> createState() =>
      _${viewSpec.className}PageState();
  
}

class _${viewSpec.className}PageState extends State<${viewSpec.className}Page> {
  @override
  void initState() {
    super.initState();
  }

  @override
    Widget build(final BuildContext context) {
      final size = context.theme.appSize;
      final color = context.theme.appColor;
      final style = context.theme.appTextStyles;
      final locale = context.locale;

      // return any widget
  }

''';
}
