import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tcs_dff_types/exceptions.dart';
import '../permission/device_permission_manager.dart';
import '../permission/permission_types.dart';
import '../utils/string_constants.dart';
import 'contacts_utils.dart';
 
class DeviceContact {
  late DevicePermissionManager devicePermissionManager;
  DeviceContact() {
    devicePermissionManager = DevicePermissionManager();
  }
 
  Future<List<UserContact>> getContacts() async {
    final status = await devicePermissionManager.checkAndRequestPermission(
      DevicePermission.contacts,
    );
 
    if (status.isGranted) {
      return await FlutterContacts.getContacts(
        withAccounts: true,
        withPhoto: true,
        withProperties: true,
        withThumbnail: true,
      );
    } else {
      throw DevicePermissionException(
        error:
            Error(title: permissionDenyMessage, description: status.toString()),
      );
    }
  }
}
 