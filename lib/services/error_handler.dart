
import 'package:farm_system/services/logger.dart';

class ErrorHandler {
  static handleError(e) {
    FormLogger.e(e);
    throw e;
  }
}