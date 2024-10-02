import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/uikit/container/app_bar/default_app_bar.dart';

import '../demo_di_main.dart';

class DiAppBar extends DefaultAppBar {
  const DiAppBar(
    this.diRoute, {
    super.key,
    super.title = '',
  });

  final DiRoute diRoute;

  @override
  Widget build(final BuildContext context) => DefaultAppBar(
        title: 'Dependency Injection',
        subTitle: _getSubTitle(diRoute),
      );

  String? _getSubTitle(final DiRoute diRoute) => switch (diRoute) {
        DiRoute.factory => 'Factory',
        DiRoute.singleton => 'Singleton',
        _ => null,
      };
}
