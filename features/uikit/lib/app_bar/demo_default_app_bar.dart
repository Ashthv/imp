import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/uikit/container/app_bar/default_app_bar.dart';

class DemoDefaultAppBar extends DefaultAppBar {
  DemoDefaultAppBar({super.title = ''});

  @override
  Widget build(final BuildContext context) => const DefaultAppBar(
        title: 'Title',
        subTitle: 'Subtitle',
      );
}
