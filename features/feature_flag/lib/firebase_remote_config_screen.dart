import 'package:flutter/widgets.dart';
import 'package:tcs_dff_design_system/tcs_dff_design_system.dart';
import 'package:tcs_dff_types/platform.dart';

class FirebaseRemoteConfigScreen extends StatefulWidget {
  @override
  State<FirebaseRemoteConfigScreen> createState() =>
      _FirebaseRemoteConfigScreenState();
}

class _FirebaseRemoteConfigScreenState
    extends State<FirebaseRemoteConfigScreen> {
  @override
  Widget build(final BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TitleSubtitleTextWidget(
            title: 'App Version',
            subtitle: dff.featureFlag.getString('app_version'),
          ),
          const SizedBox(
            height: 16,
          ),
          TitleSubtitleTextWidget(
            title: 'Is App Update Required',
            subtitle: '${dff.featureFlag.getBool('is_update_required')}',
          ),
        ],
      );
}
