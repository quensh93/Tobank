import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../debug_panel_widget.dart';
import '../models/device_info.dart';
import '../state/accessibility_state.dart';

void main() {
  group('DebugPanel', () {
    testWidgets('renders child when enabled', (WidgetTester tester) async {
      const testWidget = Text('Test Widget');
      
      await tester.pumpWidget(
        MaterialApp(
          home: DebugPanel(
            enabled: true,
            child: testWidget,
          ),
        ),
      );

      expect(find.text('Test Widget'), findsOneWidget);
    });

    testWidgets('renders only child when disabled', (WidgetTester tester) async {
      const testWidget = Text('Test Widget');
      
      await tester.pumpWidget(
        MaterialApp(
          home: DebugPanel(
            enabled: false,
            child: testWidget,
          ),
        ),
      );

      expect(find.text('Test Widget'), findsOneWidget);
      // Debug panel should not be visible
      expect(find.byType(ToolPanel), findsNothing);
    });

    testWidgets('shows device preview tab by default', (WidgetTester tester) async {
      const testWidget = Text('Test Widget');
      
      await tester.pumpWidget(
        MaterialApp(
          home: DebugPanel(
            enabled: true,
            child: testWidget,
          ),
        ),
      );

      // Should show device preview tab
      expect(find.text('Device'), findsOneWidget);
      expect(find.text('Logs'), findsOneWidget);
      expect(find.text('Accessibility'), findsOneWidget);
    });
  });

  group('DeviceInfo', () {
    test('creates device info with correct properties', () {
      const device = DeviceInfo(
        name: 'Test Device',
        identifier: DeviceIdentifier(
          platform: TargetPlatform.iOS,
          type: DeviceType.phone,
          id: 'test-device',
        ),
        screenSize: Size(375, 667),
        pixelRatio: 2.0,
        safeAreas: EdgeInsets.only(top: 20),
      );

      expect(device.name, 'Test Device');
      expect(device.identifier.platform, TargetPlatform.iOS);
      expect(device.identifier.type, DeviceType.phone);
      expect(device.screenSize, const Size(375, 667));
      expect(device.pixelRatio, 2.0);
    });
  });

  group('AccessibilityIssue', () {
    test('creates accessibility issue with correct properties', () {
      const issue = AccessibilityIssue(
        title: 'Test Issue',
        description: 'Test description',
        type: AccessibilityIssueType.colorContrast,
        severity: AccessibilitySeverity.high,
        details: 'Test details',
        suggestedFix: 'Test fix',
      );

      expect(issue.title, 'Test Issue');
      expect(issue.description, 'Test description');
      expect(issue.type, AccessibilityIssueType.colorContrast);
      expect(issue.severity, AccessibilitySeverity.high);
      expect(issue.details, 'Test details');
      expect(issue.suggestedFix, 'Test fix');
    });
  });
}
