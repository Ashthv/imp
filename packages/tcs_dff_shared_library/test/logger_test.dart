import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';
import 'package:tcs_dff_shared_library/logger/logger.dart';

void main() {
  late ConsoleLogger consoleLogger;
  late List<LogRecord> logRecords; // To store logged messages

  setUp(() {
    consoleLogger = ConsoleLogger();
    logRecords = [];
    Logger.root.onRecord.listen((final record) => logRecords.add(record));
  });

  tearDown(() {
    logRecords = [];
  });

  test('Error logging', () {
    const expectedMessage = 'Error message';
    consoleLogger.error(expectedMessage);
    expect(logRecords.length, 1);
    expect(logRecords[0].level, Level.SEVERE);
    expect(logRecords[0].message, expectedMessage);
  });

  test('Warning logging', () {
    const expectedMessage = 'Warning message';
    consoleLogger.warn(expectedMessage);
    expect(logRecords.length, 2);
    expect(logRecords[1].level, Level.WARNING);
    expect(logRecords[1].message, expectedMessage);
  });

  test('Info logging', () {
    const expectedMessage = 'Info message';
    consoleLogger.log(expectedMessage);
    expect(logRecords.length, 3);
    expect(logRecords[2].level, Level.INFO);
    expect(logRecords[2].message, expectedMessage);
  });
}
