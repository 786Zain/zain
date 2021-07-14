import 'package:logger/logger.dart';

class FormLogger {
  static final logger = Logger(
      printer: PrettyPrinter(
          colors: true,
          errorMethodCount: 0,
          methodCount: 0,
          printTime: false,
          printEmojis: true));

  static e(val) {
    logger.e(val);
  }

  static i(val) {
    logger.i(val);
  }

  static wtf(val) {
    logger.wtf(val);
  }
}