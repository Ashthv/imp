import 'package:tcs_dff_device_feature/device_info/device_info.dart';
import 'package:tcs_dff_device_feature/location/user_location.dart';
import 'package:tcs_dff_device_feature/sms_feature/sim_detail.dart';
import 'package:tcs_dff_device_feature/sms_feature/sms_feature.dart';
import 'package:tcs_dff_device_feature/unique_device_id/unique_device_id.dart';
import 'package:tcs_dff_shared_library/logger/logger.dart';
import 'package:tcs_dff_types/base_request.dart';
import 'package:tcs_dff_types/exceptions.dart';
import 'package:tcs_dff_types/plugin/device_info_plugin.dart';
import 'package:uuid/uuid.dart';

class CacheManager {
  final UserLocationProvider locationProvider;
  final UniqueDeviceIdProvider uniqueDeviceIdProvider;
  final DeviceInformationPlugin deviceInfoProvider;
  final SimSlotInfoProvider simSlotInfoProvider;

  CacheManager({
    required this.locationProvider,
    required this.uniqueDeviceIdProvider,
    required this.deviceInfoProvider,
    required this.simSlotInfoProvider,
  });

  factory CacheManager.defaultInit() => CacheManager(
        locationProvider: UserLocation(),
        uniqueDeviceIdProvider: UniqueDeviceId(),
        deviceInfoProvider: DeviceInfo(),
        simSlotInfoProvider: SMSFeature(),
      );

  Future<RequestHeader> getRequestHeaders() async {
    List<SIMDetail>? simSlotDetails;
    final locationDetails = await locationProvider.getUserLocation();
    final deviceDetails = await uniqueDeviceIdProvider.getUniqueDeviceId();
    final getOsDetails = await deviceInfoProvider.getOsVersion();
    try {
      simSlotDetails = await simSlotInfoProvider.getSIMInformation();
    } on DevicePermissionException catch (e) {
      ConsoleLogger().log(e.toString());
    }

    return RequestHeader(
      locationInfo: LocationInfo(
        latitude: locationDetails!.latitude,
        longitude: locationDetails.longitude,
        country: locationDetails.country,
        city: locationDetails.city,
        state: locationDetails.state,
        areaCode: locationDetails.areaCode,
      ),
      deviceInfo: DeviceDetails(
        deviceId: deviceDetails!,
        os: getOsDetails!.os,
        osVersion: getOsDetails.version,
        simSlot: simSlotDetails != null && simSlotDetails.isNotEmpty
            ? simSlotDetails[0].simSlotIndex
            : '',
      ),
      envMetaInfo: EnvMetaInfo(),
      reqNo: getRequestNumber(),
    );
  }

  String getRequestNumber() => const Uuid().v1();
}
