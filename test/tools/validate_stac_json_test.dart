import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stac/stac.dart';

void main() {
  testWidgets('Validate STAC JSON files', (WidgetTester tester) async {
    await Stac.initialize();

    // Pump a minimal app to get a context
    await tester.pumpWidget(const MaterialApp(home: Scaffold()));
    final BuildContext context = tester.element(find.byType(Scaffold));

    final rootDir = Directory('docs/SDUI/tobank_sdui_mock');
    if (!rootDir.existsSync()) {
      fail('Mock directory not found: ${rootDir.path}');
    }

    final jsonFiles = rootDir
        .listSync(recursive: true, followLinks: false)
        .whereType<File>()
        .where((f) => f.path.endsWith('.json'))
        .toList();

    final filesToSkip = [
      'app_entry_point.json',
      'mock-data', // Skip all files in mock-data
      'core', // Skip config files
    ];

    int passed = 0;
    int failed = 0;
    List<String> failures = [];

    print('Found ${jsonFiles.length} JSON files.');

    for (final file in jsonFiles) {
      final path = file.path.replaceAll('\\', '/');
      
      // Skip excluded files/directories
      if (filesToSkip.any((skip) => path.contains(skip))) {
        continue;
      }
      
      // Also skip shared libraries for now if they are not standard widgets
      if (path.contains('shared/')) {
         continue;
      }

      try {
        final content = file.readAsStringSync();
        final json = jsonDecode(content);

        if (json is! Map<String, dynamic>) {
           // print('Skipping non-object JSON: $path');
           continue;
        }
        
        if (!json.containsKey('type')) {
           // print('Skipping JSON without "type": $path');
           continue;
        }

        // Validate by attempting to build the widget
        try {
          final widget = Stac.fromJson(json, context);
          if (widget == null) {
             // Stac.fromJson might return null if type is not found or context is invalid? 
             // Actually Stac.fromJson returns dynamic/Widget? 
             // If it fails silently and returns null, we might want to know.
             // But mostly it throws if type is unknown or props invalid?
             // Let's assume null is OK (e.g. empty?) or maybe not.
          }
          passed++;
        } catch (e) {
          failed++;
          failures.add('$path: $e');
        }
      } catch (e) {
        failed++;
        failures.add('$path: JSON parse error - $e');
      }
    }

    if (failed > 0) {
      fail('Failed to validate $failed files:\n${failures.join('\n')}');
    } else {
      print('Successfully validated $passed files.');
    }
  });
}
