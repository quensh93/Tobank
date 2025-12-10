# Problem: STAC Framework Logs Not Appearing in Debugger Logs Tab

## Problem Description

Certain debug logs from the STAC framework are appearing in the console but **NOT** appearing in the debugger's logs tab (ISpect). These logs are:

1. `🐛 data: [{icon: login, title: احراز هویت, ...}]` - Very long log containing a data array
2. `🐛 Overall dataContext is not a Map, skipping final placeholder processing...` - Warning log with data array

## Key Observations

### What Works
- Most logs from the app (e.g., `🐛 - 08:32:15.061 - 🔍 Mock interceptor: Looking for file...`) appear correctly in both console AND debugger
- These working logs have the format: `🐛 - HH:MM:SS.mmm - message`
- They go through the full logging pipeline successfully

### What Doesn't Work
- The problematic logs appear in console but **NOT** in debugger
- They have the emoji `🐛` but **NO timestamp format** (just `🐛 data: [...]` instead of `🐛 - timestamp - data: [...]`)
- They include stack traces in the console:
  ```
  #0   LogIO.d (package:stac_logger/src/log_io.dart:16:35)
  #1   Log.d (package:stac_logger/src/log.dart:29:45)
  ```

## Technical Context

### Logging Architecture
1. **STAC Logger** (`stac_logger` package) calls `Log.d(message)`
2. **LogIO** (`.stac/packages/stac_logger/lib/src/log_io.dart`) forwards to `AppLogger.d(message)`
3. **AppLogger** (`lib/core/helpers/logger.dart`) uses:
   - `PrettyPrinter` for formatting (adds emoji and timestamp)
   - `ISpectLogOutput` as the output handler
4. **ISpectLogOutput** should forward all logs to ISpect logger

### Source of Problematic Logs
- **File**: `.stac/packages/stac/lib/src/parsers/widgets/stac_dynamic_view/stac_dynamic_view_parser.dart`
- **Line 55**: `Log.d("data: $data");` - where `$data` is a very large array
- **Line 236**: `Log.d("Overall dataContext is not a Map, skipping... DataContext: $data");`

## Investigation Done

### Debug Logging Added
- Added debug messages at the start of `ISpectLogOutput.output()` to detect when these logs arrive
- **Result**: NO debug messages appear, meaning these logs are **NOT reaching** `ISpectLogOutput.output()`

### What This Means
The logs are being printed **directly to the console** (bypassing our output handler), likely by:
- Flutter's debug output system
- An exception being caught silently in the logger
- The logger printing directly before our handler processes it

## Code Locations

### Logger Configuration
- **File**: `lib/core/helpers/logger.dart`
- **AppLogger** uses `ISpectLogOutput(fallback: ConsoleOutput())` as output
- **ISpectLogOutput** should forward to ISpect and also to fallback (console)

### STAC Logger Integration
- **File**: `.stac/packages/stac_logger/lib/src/log_io.dart`
- Forwards all STAC logs to `AppLogger`
- **File**: `.stac/packages/stac_logger/lib/src/log_web.dart`
- Also forwards to `AppLogger` (for web platform)

### Custom Logger Package
- **Location**: `tools/logger/` (local clone of `SourceHorizon/logger`)
- **File**: `tools/logger/lib/src/printers/pretty_printer.dart`
- Formats logs with emoji and timestamp
- **File**: `tools/logger/lib/src/outputs/console_output.dart`
- Uses `print()` to output to console

## Expected Behavior

1. STAC calls `Log.d("data: $data")`
2. Goes through `LogIO.d()` → `AppLogger.d()`
3. `PrettyPrinter` formats it as `🐛 - HH:MM:SS.mmm - data: [...]`
4. `ISpectLogOutput.output()` receives the formatted output
5. Logs are forwarded to ISpect logger AND console
6. Logs appear in both console AND debugger logs tab

## Actual Behavior

1. STAC calls `Log.d("data: $data")`
2. Goes through `LogIO.d()` → `AppLogger.d()`
3. **Something happens here** - logs appear in console with emoji but NO timestamp
4. `ISpectLogOutput.output()` is **NOT called** (no debug messages)
5. Logs appear in console but **NOT** in debugger

## Questions to Investigate

1. **Why are these logs not reaching `ISpectLogOutput.output()`?**
   - Are they being printed directly by Flutter's debug output?
   - Is there an exception being caught silently?
   - Is the logger using a different output path for very long messages?

2. **Why do they have the emoji but no timestamp?**
   - The emoji suggests they went through `PrettyPrinter`
   - But the missing timestamp suggests they didn't go through our output handler
   - Could there be multiple logger instances?

3. **Why do they include stack traces?**
   - Stack traces are added by Flutter's debug output, not our logger
   - This suggests they're being printed directly by Flutter

## Files to Check

1. `lib/core/helpers/logger.dart` - Main logger configuration
2. `.stac/packages/stac_logger/lib/src/log_io.dart` - STAC logger forwarding
3. `tools/logger/lib/src/logger.dart` - Logger core implementation
4. `tools/logger/lib/src/outputs/console_output.dart` - Console output handler
5. `.stac/packages/stac/lib/src/parsers/widgets/stac_dynamic_view/stac_dynamic_view_parser.dart` - Source of problematic logs

## Goal

Make ALL logs from STAC framework (including these very long data logs) appear in the debugger's logs tab, just like the other logs that are working correctly.
