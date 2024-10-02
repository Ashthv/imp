import 'package:tcs_dff_design_system/uikit/container/app_bar/default_app_bar.dart';
import 'package:tcs_dff_types/config.dart';

import 'cipher_screen.dart';

FeatureConfig featureConfig = FeatureConfig(
  name: 'cipher',
  content: (final _, final __) => const CipherScreen(),
  appBar: (final model) => const DefaultAppBar(
    title: 'Cipher',
  ),
);
