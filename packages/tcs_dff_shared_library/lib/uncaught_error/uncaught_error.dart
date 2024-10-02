import 'package:flutter/foundation.dart';
import 'package:tcs_dff_types/tcs_dff_types.dart';

class UncaughtError {
  List<UncaughtErrorCallback> listeners = [];

  factory UncaughtError() => _uncaughtError;

  static final UncaughtError _uncaughtError = UncaughtError._internal();

  UncaughtError._internal() {
    // uncaught flutter framework UI rendering errors
    FlutterError.onError = (final FlutterErrorDetails errorDetails) {
      for (final listener in listeners) {
        listener.flutterErrorCallback(errorDetails);
      }
    };

    // uncaught asynchronous platform/plugin errors
    PlatformDispatcher.instance.onError = (final exception, final stacktrace) {
      for (final listener in listeners) {
        listener.platformErrorCallback(exception, stacktrace);
      }

      return true;
    };
  }

  void registerListener(final UncaughtErrorCallback listener) {
    listeners.add(listener);
  }

  void unregisterListener(final UncaughtErrorCallback listener) {
    listeners.remove(listener);
  }
}
