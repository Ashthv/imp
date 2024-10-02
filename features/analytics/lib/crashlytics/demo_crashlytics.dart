import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tcs_dff_types/platform.dart';

Future<void> main() async {
  runApp(const DemoCrashlytics());
}

class DemoCrashlytics extends StatefulWidget {
  const DemoCrashlytics({super.key});

  @override
  State<DemoCrashlytics> createState() => _DemoCrashlyticsState();
}

class _DemoCrashlyticsState extends State<DemoCrashlytics> {
  @override
  Widget build(final BuildContext context) => Center(
        child: Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                dff.crashlytics.setCustomKey(
                  key: 'example',
                  value: 'flutter',
                );
              },
              child: const Text('Key'),
            ),
            ElevatedButton(
              onPressed: () {
                dff.crashlytics.logMessage(message: 'This is a log example');
              },
              child: const Text('Log'),
            ),
            ElevatedButton(
              onPressed: () {
                throw StateError('Uncaught error thrown by app');
              },
              child: const Text('Throw Error check FlutterError'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  throw Error();
                } catch (e, s) {
                  unawaited(
                    dff.crashlytics.recordError(
                      reason: 'as an example of fatal error',
                      fatal: true,
                      error: e,
                      stackTrace: s,
                    ),
                  );
                }
              },
              child: const Text('Record Fatal Error'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  throw Error();
                } catch (e, s) {
                  unawaited(
                    dff.crashlytics.recordError(
                      reason: 'as an example of non-fatal error',
                      error: e,
                      fatal: false,
                      stackTrace: s,
                    ),
                  );
                }
              },
              child: const Text('Record Non-Fatal Error'),
            ),
            ElevatedButton(
              child: const Text('Platform Dispatcher Test!'),
              onPressed: () async {
                const channel = MethodChannel('crashy-custom-channel');
                unawaited(channel.invokeMethod('test'));
              },
            ),
          ],
        ),
      );
}
