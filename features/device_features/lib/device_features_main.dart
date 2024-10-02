import 'package:tcs_dff_design_system/uikit/container/app_bar/default_app_bar.dart';
import 'package:tcs_dff_route/route_content.dart';
import 'package:tcs_dff_types/config.dart';

import 'demo_biometrics/demo_biometrics.dart';
import 'demo_camera/demo_camera.dart';
import 'demo_device_info/demo_devce_info.dart';
import 'demo_file_picker/demo_file_picker.dart';
import 'demo_location/get_location.dart';
import 'demo_notification/demo_notification.dart';
import 'demo_qr_scanner/demo_qr_scanner.dart';
import 'demo_read_contact/demo_read_user_device_contacts.dart';
import 'demo_share_widget/demo_share_widget.dart';
import 'demo_sms_feature/demo_sms_feature.dart';
import 'demo_unique_device_id/demo_unique_device_id.dart';
import 'device_feature_home_view.dart';

FeatureConfig featureConfig = FeatureConfig(
  name: 'deviceFeatures',
  routes: _routes,
  content: (final _, final __) => const DeviceFeatureHomeView(),
  appBar: (final routePath) => DefaultAppBar(
    title: 'Device Features',
    subTitle: _getSubTitle(routePath),
  ),
);

final _routes = [
  RouteContent(
    routePath: 'biometrics',
    content: (final _, final __) => const DemoBiometrics(),
  ),
  RouteContent(
    routePath: 'camera',
    content: (final _, final __) => const DemoCamera(),
  ),
  RouteContent(
    routePath: 'filePicker',
    content: (final _, final __) => const DemoFilePicker(),
  ),
  RouteContent(
    routePath: 'smsFeature',
    content: (final _, final __) => const DemoSMSFeature(),
  ),
  RouteContent(
    routePath: 'notification',
    content: (final _, final __) => const DemoNotification(),
    routes: [
      RouteContent(
        routePath: 'path/:id',
        content: (final _, final state) =>
            DemoNotification(pathParam: state.pathParameters['id']),
      ),
      RouteContent(
        routePath: 'query',
        content: (final _, final state) =>
            DemoNotification(queryParam: state.uri.queryParameters['id']),
      ),
    ],
  ),
  RouteContent(
    routePath: 'deviceId',
    content: (final _, final __) => const DemoUniqueDeviceId(),
  ),
  RouteContent(
    routePath: 'location',
    content: (final _, final __) => const GetLocation(),
  ),
  RouteContent(
    routePath: 'qrscanner',
    content: (final _, final __) => const DemoQrScanner(),
  ),
  RouteContent(
    routePath: 'deviceInfo',
    content: (final _, final __) => DemoDeviceInfo(),
  ),
  RouteContent(
    routePath: 'shareWidget',
    content: (final _, final __) => const DemoShareWidget(),
  ),
  RouteContent(
    routePath: 'readContact',
    content: (final _, final __) => const DemoReadUserDeviceContacts(),
  ),
];

String? _getSubTitle(final String routePath) => switch (routePath) {
      'biometrics' => 'Biometrics',
      'camera' => 'Camera',
      'filePicker' => 'File Picker',
      'smsFeature' => 'SMS',
      'notification' => 'Notification',
      'deviceId' => 'Device Id',
      'location' => 'location',
      'qrscanner' => 'Qr Scanner',
      'deviceInfo' => 'Device Info',
      'shareWidget' => 'Share Widget',
      'path' => 'Notification (Path)',
      'query' => 'Notification (Query)',
      'readContact' => 'Read Contacts',
      _ => null,
    };
