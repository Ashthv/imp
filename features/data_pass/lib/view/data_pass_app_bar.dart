import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/uikit/container/app_bar/default_app_bar.dart';
import 'package:tcs_dff_route/route_navigator.dart';

import '../data_pass_main.dart';

class DataPassAppBar extends DefaultAppBar {
  const DataPassAppBar(
    this.dataPassRoute,
    this.backHandler, {
    super.key,
    super.title = '',
  });

  final DataPassRoute dataPassRoute;
  final bool Function(String routePath, BuildContext context) backHandler;

  @override
  Widget build(final BuildContext context) => DefaultAppBar(
        title: 'Data Pass',
        subTitle: _getSubTitle(dataPassRoute),
        onBackButtonTap: () =>
            backHandler(RouteNavigator.getCurrentRoutePath(context), context),
      );

  String? _getSubTitle(final DataPassRoute dataPassRoute) =>
      switch (dataPassRoute) {
        DataPassRoute.store => 'Store',
        DataPassRoute.route => 'Route',
        _ => null,
      };
}
