import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerService extends TalkerObserver {
  late final Talker talker;

  TalkerService({bool isDebug = true}) {
    talker = TalkerFlutter.init(
      observer: this,
      settings: TalkerSettings(
        enabled: isDebug,
        useHistory: isDebug,
        useConsoleLogs: isDebug,
      ),
    );
    Bloc.observer = TalkerBlocObserver(
      talker: talker,
      settings: TalkerBlocLoggerSettings(
        enabled: isDebug,
        printChanges: false,
        printEvents: true,
        printTransitions: true,
        printEventFullData: true,
        printClosings: true,
        printCreations: true,
        printStateFullData: false,
      ),
    );
  }
}