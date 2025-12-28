import '../log_output.dart';
import '../output_event.dart';

/// Default implementation of [LogOutput].
///
/// It sends everything to the system console.
class ConsoleOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    for (var line in event.lines) {
      if (line.length > 400) {
        // ignore: avoid_print
        print('${line.substring(0, 400)}... (truncated)');
      } else {
        // ignore: avoid_print
        print(line);
      }
    }
  }
}
