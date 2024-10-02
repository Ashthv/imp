import 'package:flutter/material.dart';
import 'package:tcs_dff_types/platform.dart';

class DemoAnalytics extends StatefulWidget {
  const DemoAnalytics({super.key});

  @override
  State<DemoAnalytics> createState() => _DemoAnalyticsState();
}

class _DemoAnalyticsState extends State<DemoAnalytics> {
  void _testEvent() {
    dff.analytics.logEvent(
      eventName: 'test_event',
      parameters: {
        'string': 'string',
        'int': 42,
        'long': 12345678910,
        'double': 42.0,
        'bool': true.toString(),
      },
    );
  }

  void _testSetUserId() {
    dff.analytics.setUserId(
      id: 'test-user',
    );
  }

  void _testSetUserProperty() {
    dff.analytics.setUserProperty(
      name: 'regular',
      value: 'indeed',
    );
  }

  void _testSetDefaultParameters() {
    dff.analytics.setDefaultEventParameters(
      parameters: {
        'hello': 'world',
        'default': 'parameters',
      },
    );
  }

  void _testAllEventTypes() {
    dff.analytics.logEvent(
      eventName: 'logAddToCart',
      parameters: {
        'currency': 'USD',
        'value': 123,
      },
    );
    dff.analytics.logEvent(
      eventName: 'logSearch',
      parameters: {
        'searchTerm': 'hotel',
        'numberOfNights': 2,
        'numberOfRooms': 1,
        'numberOfPassengers': 3,
        'origin': 'test origin',
        'destination': 'test destination',
        'startDate': '2015-09-14',
        'endDate': '2015-09-16',
        'travelClass': 'test travel class',
      },
    );
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MaterialButton(
                onPressed: _testEvent,
                child: const Text(
                  'Log event',
                ),
              ),
              MaterialButton(
                onPressed: _testSetUserId,
                child: const Icon(Icons.verified_user_rounded),
              ),
              MaterialButton(
                onPressed: _testSetUserProperty,
                child: const Icon(Icons.three_k_plus),
              ),
              MaterialButton(
                onPressed: _testSetDefaultParameters,
                child: const Icon(Icons.fire_extinguisher),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _testAllEventTypes,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      );
}
