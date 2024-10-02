import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/uikit/foundation/button/normal_button.dart';
import 'package:tcs_dff_design_system/utils/button_utils.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';
import 'package:tcs_dff_device_feature/device_info/device_info.dart';

class DemoDeviceInfo extends StatefulWidget {
  DemoDeviceInfo({super.key});

  @override
  State<DemoDeviceInfo> createState() => _DemoDeviceInfoState();
}

class _DemoDeviceInfoState extends State<DemoDeviceInfo> {
  final deviceInfo = DeviceInfo();

  String? os;
  String? version;
  String? sdkVersion;
  String? model;

  @override
  Widget build(final BuildContext context) {
    final textStyles = context.theme.appTextStyles;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            NormalButton(
              caption: 'Get Device Info',
              buttonType: ButtonVariants.normal,
              onPressed: () async {
                final res = await deviceInfo.getOsVersion();

                setState(() {
                  os = res?.os;
                  version = res?.version;
                  sdkVersion = res?.sdkVersion;
                  model = res?.model;
                });
              },
            ),
            SizedBox(height: 20.sp),
            Text(
              'Os is: $os',
              style: textStyles.bodyCopy1Small18Regular,
            ),
            Text(
              'Version is: $version',
              style: textStyles.bodyCopy1Small18Regular,
            ),
            Text(
              'SdkVersion is: $sdkVersion',
              style: textStyles.bodyCopy1Small18Regular,
            ),
            Text(
              'Model is : $model',
              style: textStyles.bodyCopy1Small18Regular,
            ),
          ],
        ),
      ),
    );
  }
}
