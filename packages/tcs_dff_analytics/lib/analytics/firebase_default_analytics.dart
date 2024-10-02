import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tcs_dff_types/plugin/analytics_plugin.dart';
import 'analytics_config.dart';

class FirebaseAnalyticsPlugin implements AnalyticsPlugin {
  late FirebaseAnalytics instance;
  late FirebaseOptions currentFirebaseOptions;
  late String? name;

  FirebaseAnalyticsPlugin({
    required this.currentFirebaseOptions,
    this.name,
  });

  @override
  Future<void> init() async {
    await Firebase.initializeApp(
      name: name,
      options: currentFirebaseOptions,
    );
    instance = FirebaseAnalytics.instance;
  }

  @override
  Future<void> release() async {}

  @override
  void logEvent({
    required final String eventName,
    required final Map<String, dynamic> parameters,
  }) {
    unawaited(
      instance.logEvent(
        name: eventName,
        parameters: parameters,
      ),
    );
  }

  @override
  void setDefaultEventParameters({
    required final Map<String, dynamic> parameters,
  }) {
    parameters.addAll(defaultParameters);
    unawaited(
      instance.setDefaultEventParameters(
        parameters,
      ),
    );
  }

  @override
  void setUserId({
    required final String id,
  }) {
    unawaited(
      instance.setUserId(id: id),
    );
  }

  @override
  void setUserProperty({
    required final String name,
    required final String value,
  }) {
    unawaited(
      instance.setUserProperty(
        name: name,
        value: value,
      ),
    );
  }
}

typedef PluginFirebaseOptions = FirebaseOptions;
