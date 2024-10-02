import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:tcs_dff_shared_library/uncaught_error/uncaught_error.dart';
import 'package:tcs_dff_types/tcs_dff_types.dart';

class FirebaseCrashlyticsPlugin
    implements CrashlyticsPlugin, UncaughtErrorCallback {
  late FirebaseCrashlytics instance;
  late UncaughtError uncaughtErrorInstance;
  late FirebaseOptions currentFirebaseOptions;
  late String? name;
  late bool fatalError = false;

  FirebaseCrashlyticsPlugin({
    required this.currentFirebaseOptions,
    this.name,
  });

  @override
  Future<void> init() async {
    await Firebase.initializeApp(
      name: name,
      options: currentFirebaseOptions,
    );
    instance = FirebaseCrashlytics.instance;
    uncaughtErrorInstance = UncaughtError();
    uncaughtErrorInstance.registerListener(this);
  }

  @override
  Future<void> release() async {
    uncaughtErrorInstance.unregisterListener(this);
  }

  @override
  Future<void> recordError({
    required final dynamic error,
    required final StackTrace? stackTrace,
    required final String reason,
    required final bool fatal,
  }) async {
    unawaited(
      instance.recordError(
        error,
        stackTrace,
        reason: reason,
        fatal: fatal,
      ),
    );
  }

  @override
  Future<void> recordFlutterError({
    required final FlutterErrorDetails errorDetails,
    required final bool fatal,
  }) async {
    unawaited(
      instance.recordFlutterError(
        errorDetails,
        fatal: fatal,
      ),
    );
  }

  @override
  Future<void> setCustomKey({
    required final String key,
    required final Object value,
  }) async {
    unawaited(
      instance.setCustomKey(
        key,
        value,
      ),
    );
  }

  @override
  void logMessage({
    required final String message,
  }) {
    instance.log(message);
  }

  @override
  Future<void> setUserIdentifier({
    required final String id,
  }) async {
    unawaited(
      instance.setUserIdentifier(id),
    );
  }

  @override
  void flutterErrorCallback(final FlutterErrorDetails errorDetails) {
    recordFlutterError(
      errorDetails: errorDetails,
      fatal: fatalError,
    );
  }

  @override
  void platformErrorCallback(
    final Object exception,
    final StackTrace stackTrace,
  ) {
    if (exception is! NetworkException) {
      instance.recordError(
        fatal: fatalError,
        exception,
        stackTrace,
        reason: StackTrace.current,
      );
    }
  }
}
