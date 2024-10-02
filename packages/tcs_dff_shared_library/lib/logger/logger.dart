import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:tcs_dff_types/ilogger.dart';

class ConsoleLogger extends ILogger {
  late final Logger logger;
  static final ConsoleLogger _singleton = ConsoleLogger._internal();
  ConsoleLogger._internal() {
    logger = Logger('ConsoleLogger');
    init();
  }

  factory ConsoleLogger() => _singleton;

  @override
  void error(final String message) {
    logger.severe(message);
  }

  @override
  void log(final String message) {
    logger.info(message);
  }

  @override
  void warn(final String message) {
    logger.warning(message);
  }

  void init() {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((final record) {
      if (!kReleaseMode) {
        developer
            .log('${record.level.name}: ${record.time}: ${record.message}');
      }
    });
  }
}
