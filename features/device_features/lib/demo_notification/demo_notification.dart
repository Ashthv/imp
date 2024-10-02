import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_shared_library/logger/logger.dart';
import 'package:tcs_dff_types/exceptions.dart';
import 'package:tcs_dff_types/platform.dart';

class DemoNotification extends StatefulWidget {
  const DemoNotification({super.key, this.pathParam, this.queryParam});

  final String? pathParam;
  final String? queryParam;

  @override
  State<DemoNotification> createState() => _DemoNotificationState();
}

class _DemoNotificationState extends State<DemoNotification> {
  @override
  Widget build(final BuildContext context) {
    final textStyle = Theme.of(context).appTextStyles;
    final size = Theme.of(context).appSize;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          icon: const Icon(Icons.notification_add_outlined),
          label: const Text('Request Permission'),
          onPressed: requestPermission,
        ),
        SizedBox(height: size.size50),
        FutureBuilder(
          future: dff.notification.getToken(),
          builder: (final context, final snapshot) {
            if (snapshot.hasData) {
              final token = snapshot.data;
              return Column(
                children: [
                  Text(
                    'Token:',
                    style: textStyle.labelSmall18Medium,
                  ),
                  if (token == null)
                    const Text('Status: Currently unregistered')
                  else
                    SelectableText(token),
                ],
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
        SizedBox(height: size.size50),
        Column(
          children: [
            if (widget.pathParam != null)
              Text(
                'Path Param = ${widget.pathParam}',
                style: textStyle.labelSmall18Medium,
              ),
            SizedBox(height: size.size5),
            if (widget.queryParam != null)
              Text(
                'Query Param = ${widget.queryParam}',
                style: textStyle.labelSmall18Medium,
              ),
          ],
        ),
        SizedBox(height: size.size50),
        FutureBuilder(
          future: dff.notification.getNotificationOpenOnTerminate(),
          builder: (final context, final snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final initial = snapshot.data;
              return initial == null
                  ? const Text(
                      'No notification on terminate state',
                    )
                  : Column(
                      children: [
                        Text(
                          'Notification on terminate state:',
                          style: textStyle.labelSmall18Medium,
                        ),
                        SizedBox(height: size.size10),
                        Text('${initial.toMap()}'),
                      ],
                    );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ],
    );
  }

  Future<void> requestPermission() async {
    try {
      await dff.notification.requestNotificationPermissions();
    } on DevicePermissionException catch (e) {
      ConsoleLogger().log('${e.error.title} -- ${e.error.description}');
    }
  }
}
