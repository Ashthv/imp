import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exceptions.g.dart';

/// All exceptions Network exception, Server Error,
/// Authentication or Device native exception

@JsonSerializable()
class Error {
  final String title;
  final String description;
  final String? userMessage;
  final String? technicalMessage;
  final String? errorCode;

  Error({
    required this.title,
    required this.description,
    this.userMessage,
    this.technicalMessage,
    this.errorCode,
  });

  factory Error.fromJson(final Map<String, dynamic> json) =>
      _$ErrorFromJson(json);
}

enum ExceptionType {
  ioexception,
  timeout,
  socket,
  unknown,
  authorization,
  unknownStub,
}
// add the above type in all the exceptions

abstract class BaseException {
  Exception? exceptionDetails = Exception();
  ExceptionType? type = ExceptionType.unknown;

  BaseException({this.exceptionDetails, this.type});
}

class NetworkException extends BaseException implements Exception {
  Error error;
  NetworkException({super.exceptionDetails, super.type, required this.error});
}

/// for restricted access,
class AuthorizationException extends BaseException implements Exception {
  Error error;
  AuthorizationException({
    super.exceptionDetails,
    super.type,
    required this.error,
  });
}

///User authenticatoin related errors
class AuthenticationException extends BaseException implements Exception {
  Error error;
  AuthenticationException({
    super.exceptionDetails,
    super.type,
    required this.error,
  });
}

// Exception occures during native code executing
class NativeException extends BaseException implements Exception {
  Error error;
  NativeException({
    super.exceptionDetails,
    super.type,
    required this.error,
  });
}

// Exception occures during the device permission handling
class DevicePermissionException extends BaseException implements Exception {
  Error error;
  DevicePermissionException({
    super.exceptionDetails,
    super.type,
    required this.error,
  });
}

class FormatterException extends BaseException implements Exception {
  Error error;
  FormatterException({
    super.exceptionDetails,
    super.type,
    required this.error,
  });
}

class FileSizeRequiredException extends BaseException implements Exception {
  Error error;
  FileSizeRequiredException({
    super.exceptionDetails,
    super.type,
    required this.error,
  });
}

abstract interface class UncaughtErrorCallback {
  void platformErrorCallback(
    final Object exception,
    final StackTrace stackTrace,
  );
  void flutterErrorCallback(final FlutterErrorDetails errorDetails);
}
