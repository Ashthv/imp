import 'package:tcs_dff_design_system/uikit/container/app_bar/default_app_bar.dart';
import 'package:tcs_dff_route/route_content.dart';
import 'package:tcs_dff_types/config.dart';
import 'package:tcs_dff_types/platform.dart';

import 'view/create_profile_screen.dart';
import 'view/profile_list_screen.dart';
import 'view/shared_prefernce_screen.dart';
import 'viewmodel/profile_view_model.dart';

FeatureConfig featureConfig = FeatureConfig(
  name: 'storage',
  routes: _routes,
  content: (final _, final __) => const CreateProfileScreen(),
  appBar: (final routePath) => DefaultAppBar(
    title: 'Storage',
    subTitle: _getSubTitle(routePath),
  ),
);

final _routes = [
  RouteContent(
    routePath: 'profileList',
    content: (final _, final __) => const ProfileListScreen(),
  ),
  RouteContent(
    routePath: 'create_profile_screen',
    content: (final _, final __) => const CreateProfileScreen(),
  ),
  RouteContent(
    routePath: 'shared_prefernce_screen',
    content: (final _, final __) => const SharedPrefernceScreen(),
  ),
];

void setUpDiForDiStorage() {
  if (!dff.di
      .isRegistered<ProfileViewModel>(instanceName: 'profileNameViewModel')) {
    dff.di.registerSingleton<ProfileViewModel>(
      model: ProfileViewModel(),
      instanceName: 'profileNameViewModel',
    );
  }
}

String? _getSubTitle(final String routePath) => switch (routePath) {
      'profileList' => 'Profile List',
      _ => null,
    };
