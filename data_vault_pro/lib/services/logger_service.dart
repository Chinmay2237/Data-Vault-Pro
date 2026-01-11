import 'package:data_vault_pro/models/log_entry.dart';

class LoggerService {
  void logError(String message) {
    _log(LogLevel.error, message);
  }

  void logWarning(String message) {
    _log(LogLevel.warning, message);
  }

  void logInfo(String message) {
    _log(LogLevel.info, message);
  }

  void _log(LogLevel level, String message) {
    final logEntry = LogEntry(
      level: level,
      message: message,
      timestamp: DateTime.now(),
    );
    // In a real app, you might send this to a remote logging service
    // or save it to a local file.
    print('[${logEntry.level.toString().split('.').last.toUpperCase()}] ${logEntry.timestamp}: ${logEntry.message}');
  }
}
