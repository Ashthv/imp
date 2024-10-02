import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tcs_dff_device_feature/location/location_details.dart';
import 'package:tcs_dff_device_feature/sms_feature/sim_detail.dart';
import 'package:tcs_dff_network/cache_manager.dart';
import 'package:tcs_dff_test/dff_mocks.dart';
import 'package:tcs_dff_types/plugin/device_info_plugin.dart';

void main() {
  group('CacheManager', () {
    late CacheManager cacheManager;
    late MockUserLocationProvider mockLocationProvider;
    late MockUniqueDeviceIdProvider mockDeviceIdProvider;
    late MockDeviceInfoProvider mockDeviceInfoProvider;
    late MockSimSlotInfoProvider mockSimSlotInfoProvider;

    setUp(() {
      mockLocationProvider = MockUserLocationProvider();
      mockDeviceIdProvider = MockUniqueDeviceIdProvider();
      mockDeviceInfoProvider = MockDeviceInfoProvider();
      mockSimSlotInfoProvider = MockSimSlotInfoProvider();

      cacheManager = CacheManager(
        locationProvider: mockLocationProvider,
        uniqueDeviceIdProvider: mockDeviceIdProvider,
        deviceInfoProvider: mockDeviceInfoProvider,
        simSlotInfoProvider: mockSimSlotInfoProvider,
      );
    });

    test('getRequestHeaders should return correct RequestHeader', () async {
      final locationData = LocationDetails(
        latitude: 1.2,
        longitude: 2.1,
        country: 'in',
        city: 'mum',
        state: 'Mah',
        areaCode: '123',
      );
      const deviceId = 'abc123';
      final osInfo = DeviceBasicInfo(
        os: 'Android',
        version: '10.0',
        sdkVersion: '',
        manufacturer: '',
        model: '',
      );
      final simSlotData = [SIMDetail(simSlotIndex: '1', subscriptionID: '')];

      when(() => mockLocationProvider.getUserLocation())
          .thenAnswer((final _) async => locationData);
      when(() => mockDeviceIdProvider.getUniqueDeviceId())
          .thenAnswer((final _) async => deviceId);
      when(() => mockDeviceInfoProvider.getOsVersion())
          .thenAnswer((final _) async => osInfo);
      when(() => mockSimSlotInfoProvider.getSIMInformation())
          .thenAnswer((final _) async => simSlotData);

      final requestHeader = await cacheManager.getRequestHeaders();

      expect(requestHeader.locationInfo, isNotNull);
      expect(requestHeader.deviceInfo, isNotNull);
      expect(requestHeader.locationInfo!.latitude, locationData.latitude);
      expect(requestHeader.locationInfo!.longitude, locationData.longitude);
      expect(requestHeader.deviceInfo!.deviceId, deviceId);
      expect(requestHeader.deviceInfo!.os, osInfo.os);
      expect(requestHeader.deviceInfo!.osVersion, osInfo.version);
      expect(requestHeader.deviceInfo!.simSlot, simSlotData[0].simSlotIndex);
    });
  });
}
