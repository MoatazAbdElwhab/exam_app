// core/logger/app_logger.dart
import 'package:logger/logger.dart';

class Log {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 50,
      colors: true,
      printEmojis: true,
    ),
  );

  Log._();

  // Simple one-word logging methods with null safety
  static void d(dynamic message) => _logger.d(message ?? 'No message');
  static void i(dynamic message) => _logger.i(message ?? 'No message');
  static void w(dynamic message) => _logger.w(message ?? 'No message');
  static void e(dynamic message) => _logger.e(message ?? 'No message');
}
