import 'plugin_types.dart';

abstract interface class AnalyticsPlugin implements Plugin {
  void logEvent({
    required final String eventName,
    required final Map<String, dynamic> parameters,
  });

  // To do List for web setDefaultEventParameters doesn't work.
  void setDefaultEventParameters({
    required final Map<String, dynamic> parameters,
  });

  void setUserId({
    required final String id,
  });

  void setUserProperty({
    required final String name,
    required final String value,
  });
}
