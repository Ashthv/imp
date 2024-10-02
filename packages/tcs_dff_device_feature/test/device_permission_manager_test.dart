import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:permission_handler_platform_interface/permission_handler_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:tcs_dff_device_feature/permission/device_permission_manager.dart';
import 'package:tcs_dff_device_feature/permission/permission_types.dart';

class MockPermissionHandlerPlatform extends Mock
    with
        // ignore: prefer_mixin
        MockPlatformInterfaceMixin
    implements
        PermissionHandlerPlatform {
  @override
  Future<PermissionStatus> checkPermissionStatus(final Permission permission) =>
      Future.value(PermissionStatus.granted);

  @override
  Future<ServiceStatus> checkServiceStatus(final Permission permission) =>
      Future.value(ServiceStatus.enabled);

  @override
  Future<Map<Permission, PermissionStatus>> requestPermissions(
    final List<Permission> permissions,
  ) {
    final permissionsMap = <Permission, PermissionStatus>{
      Permission.unknown: PermissionStatus.granted,
      Permission.contacts: PermissionStatus.denied,
    };

    return Future.value(permissionsMap);
  }
}

class MockPermission extends Mock implements DevicePermission {}

class MockPermissionWithService extends Mock
    implements DevicePermission, PermissionWithService {}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  group('DevicePermissionManager', () {
    late DevicePermissionManager permissionManager;
    late MockPermission mockPermission;
    late MockPermissionWithService mockPermissionWithService;

    setUp(() {
      PermissionHandlerPlatform.instance = MockPermissionHandlerPlatform();

      mockPermission = MockPermission();
      permissionManager = DevicePermissionManager();
      mockPermissionWithService = MockPermissionWithService();
    });

    group('requestForPermission', () {
      test('requests the permission and returns the status', () async {
        // not the correct implementation of test.
        final status =
            await permissionManager.requestForPermission(mockPermission);

        expect(status, PermissionStatus.denied);
      });

      test('requests the permission service status with invalid type',
          () async {
        final status =
            await permissionManager.checkServiceStatus(mockPermission);

        expect(status, false);
      });

      test('requests the permission service status with invalid type',
          () async {
        final status = await permissionManager
            .checkServiceStatus(mockPermissionWithService);

        expect(status, true);
      });
    });
  });
}
