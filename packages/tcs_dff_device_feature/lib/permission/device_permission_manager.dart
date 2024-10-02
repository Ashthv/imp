import 'package:permission_handler/permission_handler.dart';

import 'permission_types.dart';

class DevicePermissionManager {
  Future<PermissionStatus> checkAndRequestPermission(
    final DevicePermission permission,
  ) async {
    final status = await checkForPermissionStatus(permission);
    if (status == PermissionStatus.denied) {
      return await requestForPermission(permission);
    } else {
      return status;
    }
  }

  Future<PermissionStatus> checkForPermissionStatus(
    final DevicePermission requestedPermission,
  ) async =>
      await requestedPermission.status;

  Future<PermissionStatus> requestForPermission(
    final DevicePermission requestedPermission,
  ) async =>
      await requestedPermission.request();

  Future<bool> checkServiceStatus(final DevicePermission permission) async {
    try {
      final permisionService = permission as PermissionWithService;
      return await permisionService.serviceStatus.isEnabled;
    } catch (_) {
      return false;
    }
  }
}
