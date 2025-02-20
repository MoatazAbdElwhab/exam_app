// core/logger/app_logger.dart
import 'package:logger/logger.dart';

class Log<T> {
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

  static void d<T>(dynamic message) => _logger.d(_formatMessage<T>(message));
  static void i<T>(dynamic message) => _logger.i(_formatMessage<T>(message));
  static void w<T>(dynamic message) => _logger.w(_formatMessage<T>(message));
  static void e<T>(dynamic message) => _logger.e(_formatMessage<T>(message));

  static String _formatMessage<T>(dynamic message) {
    return '[${T.toString()}] ${message ?? 'No message'}';
  }
}
