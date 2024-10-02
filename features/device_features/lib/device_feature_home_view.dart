import 'package:flutter/material.dart';
import 'package:tcs_dff_route/route_navigator.dart';

class DeviceFeatureHomeView extends StatelessWidget {
  const DeviceFeatureHomeView({super.key});

  @override
  Widget build(final BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                RouteNavigator.push(context, '/deviceFeatures/location');
              },
              child: const Text('Location'),
            ),
            ElevatedButton(
              onPressed: () {
                RouteNavigator.push(context, '/deviceFeatures/biometrics');
              },
              child: const Text('Biometrics'),
            ),
            ElevatedButton(
              onPressed: () {
                RouteNavigator.push(context, '/deviceFeatures/camera');
              },
              child: const Text('Camera'),
            ),
            ElevatedButton(
              onPressed: () {
                RouteNavigator.push(context, '/deviceFeatures/filePicker');
              },
              child: const Text('File Picker'),
            ),
            ElevatedButton(
              onPressed: () {
                RouteNavigator.push(context, '/deviceFeatures/smsFeature');
              },
              child: const Text('SMS'),
            ),
            ElevatedButton(
              onPressed: () {
                RouteNavigator.push(context, '/deviceFeatures/notification');
              },
              child: const Text('Notification'),
            ),
            ElevatedButton(
              onPressed: () {
                RouteNavigator.push(context, '/deviceFeatures/deviceId');
              },
              child: const Text('Device Id'),
            ),
            ElevatedButton(
              onPressed: () {
                RouteNavigator.push(context, '/deviceFeatures/qrscanner');
              },
              child: const Text('Qr Scanner'),
            ),
            ElevatedButton(
              onPressed: () {
                RouteNavigator.push(context, '/deviceFeatures/deviceInfo');
              },
              child: const Text('Device Info'),
            ),
            ElevatedButton(
              onPressed: () {
                RouteNavigator.push(context, '/deviceFeatures/shareWidget');
              },
              child: const Text('Share Widget'),
            ),
            ElevatedButton(
              onPressed: () {
                RouteNavigator.push(context, '/deviceFeatures/readContact');
              },
              child: const Text('Read Contacts'),
            ),
          ],
        ),
      );
}
