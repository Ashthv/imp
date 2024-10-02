This package helps use to achieve Analytics that can provide insight on app usage and user engagement. You can read more about Google Analytics for Firebase [here](https://firebase.google.com/docs/analytics)!


## Getting started

Google Analytics for Firebase offers multiple ways to understand how users are engaging with your app. In this package we have made the methods which can be used to log in-app events and set user properties, set user id, set default parameters with the log events and various events which are provided by Firebase can be used within our custom log event.

To get started with the Firebase Analytics for Flutter please visit https://firebase.google.com/docs/analytics/overview/.


## Usages
Various Firebase functionalities that has been implemented in our package are:

## Log Event

Logs an app event. The event can have up to 25 parameters. Events with the same name must have the same parameters. Up to 500 event names are supported. Using predefined FirebaseAnalytics.Event and/or FirebaseAnalytics.Param is recommended for optimal reporting. (https://firebase.google.com/docs/reference/android/com/google/firebase/analytics/FirebaseAnalytics.html#logEvent)

eventName: predefined events available see Firebase: (https://firebase.google.com/docs/reference/android/com/google/firebase/analytics/FirebaseAnalytics.Event)

```dart
Future<void> logEvent({
    required final String eventName,
    required final Map<String, dynamic> parameters,
  });
```

## Set Deafault Parameters

You can log parameters across events using setDefaultEventParameters(). Default parameters are associated with all future events that are logged. As with custom parameters, register the default event parameters to ensure they appear in Analytics reports. If a parameter is specificed in the logEvent() or log- method, that value is used instead of the default.

```dart
Future<void> setDefaultEventParameters({
    required final Map<String, dynamic> parameters,
  });
```

## Set User Id

Google Analytics has a setUserID call, which allows you to store a user ID for the individual using your app. This feature must be used in accordance with Google's Privacy Policy. (https://firebase.google.com/docs/reference/android/com/google/firebase/analytics/FirebaseAnalytics.html#setUserId)


```dart
Future<void> setUserId({
    required final String id,
  });
```

## Set User Property

Sets a user property to a given value. Up to 25 user property names are supported. Once set, user property values persist throughout the app lifecycle and across sessions. (https://firebase.google.com/docs/reference/android/com/google/firebase/analytics/FirebaseAnalytics.html#setUserProperty)

```dart
Future<void> setUserProperty({
    required final String name,
    required final String value,
  });
```

## Additional information

