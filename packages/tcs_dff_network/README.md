
http_network wrapper library provides a convenient way to make HTTP requests from the app. 

## Features


## Getting started
1. Support for common HTTP methods: GET, POST, PUT, PATCH, DELETE, SEND etc.
2. Customizable request headers and query paramaters.


## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder.
Following are the useful methods

Make a http call for the GET request
```dart
Future<http.Response> get(
    final Uri url, {
    final Map<String, String>? headers,
  });
```

This sends an HTTP GET request and that returns a response or throw an error.
```url```- The URL to which the request will be sent.
```headers```- add if there are any custom headers need to be supplied with request.

Make a http call for the POST request
```dart
Future<http.Response> post(
    final Uri url, {
    final Map<String, String>? headers,
    final Object? body,
    final Encoding? encoding,
  })
```
This sends an HTTP POST request and that returns a response or throw an error.
```url```- The URL to which the request will be sent.
```headers```- add if there are any custom headers need to be supplied with request
```body``` - Is used to sets the body of the request. It can be a [String], a [List] or a [Map<String, String>].
If [body] is a String, it's encoded using [encoding] and used as the body of the request. The content-type of the request will default to "text/plain".
If [body] is a List, it's used as a list of bytes for the body of the request.
If [body] is a Map, it's encoded as form fields using [encoding]. The content-type of the request will be set to "application/x-www-form-urlencoded"; this cannot be overridden.
[encoding] defaults to [utf8].

Make a http call for the PUT request
```dart
Future<http.Response> put(
    final Uri url, {
    final Map<String, String>? headers,
    final Object? body,
    final Encoding? encoding,
  })
```
This sends an HTTP PUT request and that returns a response or throw an error.

Make a http call for the DELETE request
```dart
Future<http.Response> delete(
    final Uri url, {
    final Map<String, String>? headers,
    final Object? body,
    final Encoding? encoding,
  })
```
This sends an HTTP DELETE request and that returns a response or throw an error.

Make a http call for the PATCH request
```dart
Future<http.Response> patch(
    final Uri url, {
    final Map<String, String>? headers,
    final Object? body,
    final Encoding? encoding,
  })
```
This sends an HTTP PATCH request and that returns Response or throw an error.

Make a http call for the SEND request
```dart
 Future<http.StreamedResponse> send(final http.BaseRequest request)
```
This sends an HTTP PATCH request and that returns Response or throw an error.


## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.
