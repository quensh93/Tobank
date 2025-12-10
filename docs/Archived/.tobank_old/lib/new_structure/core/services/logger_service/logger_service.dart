import 'package:talker/talker.dart';

import '../../injection/injection.dart';
import 'talker/talker.dart';

class Logger {
  //singleton
  static final Logger _instance = Logger._internal();
  factory Logger() => _instance;
  Logger._internal();
  static final Talker _talker = getIt<TalkerService>().talker;

  static void infoLog(String message) => _talker.logCustom(InfoLog(message));
  static void dangerLog(String message) => _talker.logCustom(DangerLog(message));
  static void warnLog(String message) => _talker.logCustom(WarnLog(message));
  static void curlLog(String message) => _talker.logCustom(CurlLog(message));
  static void exception(dynamic exception, StackTrace? stackTrace) =>
      _talker.handle(exception, stackTrace, 'Exception logged');
}

class InfoLog extends TalkerLog {
  InfoLog(String super.message);

  @override
  String get title => 'Info';

  @override
  AnsiPen get pen => AnsiPen()..gray();

  @override
  String? get message => '❕ ${super.message}';
}

class DangerLog extends TalkerLog {
  DangerLog(String super.message);

  @override
  String get title => 'Danger';

  @override
  AnsiPen get pen => AnsiPen()..red();

  @override
  String? get message => '❌ ${super.message}';
}

class WarnLog extends TalkerLog {
  WarnLog(String super.message);

  @override
  String get title => 'Warn';

  @override
  AnsiPen get pen => AnsiPen()..yellow();

  @override
  String? get message => '❗ ${super.message}';
}

class CurlLog extends TalkerLog {
  CurlLog(String super.message);

  @override
  String get title => '';

  @override
  AnsiPen get pen => AnsiPen()..yellow();

  @override
  String generateTextMessage({TimeFormat timeFormat = TimeFormat.timeAndSeconds}) {
    return message ?? '';
  }
}

class ApiLog extends TalkerLog {
  ApiLog(String super.message);

  @override
  String get title => '🛜 Api';

  @override
  AnsiPen get pen => AnsiPen()..green();

  @override
  String generateTextMessage({TimeFormat timeFormat = TimeFormat.timeAndSeconds}) {
    return message ?? '[No Message]';
  }
}