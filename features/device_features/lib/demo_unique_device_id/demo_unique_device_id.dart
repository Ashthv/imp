import 'package:flutter/material.dart';
import 'package:tcs_dff_device_feature/unique_device_id/unique_device_id.dart';

class DemoUniqueDeviceId extends StatefulWidget {
  const DemoUniqueDeviceId({super.key});

  @override
  State<DemoUniqueDeviceId> createState() => _DemoUniqueDeviceIdState();
}

class _DemoUniqueDeviceIdState extends State<DemoUniqueDeviceId> {
  final uniqueDevice = UniqueDeviceId();
  String uuid = 'uuid details';
  String androidUuid = 'Android id details';
  String firebaseId = 'Firebase id details';
  String allDeviceInfo = 'All device details';

  @override
  Widget build(final BuildContext context) => SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final deviceId = await uniqueDevice.getUniqueDeviceId();
                  setState(() {
                    uuid = 'Unique Device Id : $deviceId';
                  });
                },
                child: const Text('Get Unique Device Id'),
              ),
            ),
            Text(
              uuid,
              style: const TextStyle(fontSize: 15),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final androidIdResult = await uniqueDevice.getAndroidUUIDId();
                  setState(() {
                    androidUuid = 'Android uuid : $androidIdResult';
                  });
                },
                child: const Text('Get Android Uuid'),
              ),
            ),
            Text(
              androidUuid,
              style: const TextStyle(fontSize: 15),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final firebaseIdResult = await uniqueDevice.getFid();
                  setState(() {
                    firebaseId = 'Firebase id : $firebaseIdResult';
                  });
                },
                child: const Text('Get Firebase Id'),
              ),
            ),
            Text(
              firebaseId,
              style: const TextStyle(fontSize: 15),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final deviceInfo = await uniqueDevice.getUniqueIds();
                  setState(() {
                    allDeviceInfo =
                        'All device info : $deviceInfo';
                  });
                },
                child: const Text('Get Unique Ids'),
              ),
            ),
            Text(
              allDeviceInfo,
              style: const TextStyle(fontSize: 15),
            ),
          ],
        ),
      );
}
