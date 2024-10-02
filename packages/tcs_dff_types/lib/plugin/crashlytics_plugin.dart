import 'package:flutter/material.dart';

import 'plugin_types.dart';

abstract interface class CrashlyticsPlugin implements Plugin {
  Future<void> recordError({
    required final dynamic error,
    required final StackTrace stackTrace,
    required final String reason,
    required final bool fatal,
  });

  Future<void> recordFlutterError({
    required final FlutterErrorDetails errorDetails,
    required final bool fatal,
  });

  Future<void> setCustomKey({
    required final String key,
    required final Object value,
  });

  void logMessage({
    required final String message,
  });

  Future<void> setUserIdentifier({
    required final String id,
  });
}
