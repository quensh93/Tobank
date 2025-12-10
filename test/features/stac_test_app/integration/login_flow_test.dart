import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tobank_sdui/features/stac_test_app/presentation/providers/stac_test_app_providers.dart';
import 'package:tobank_sdui/features/stac_test_app/domain/models/entry_point_config.dart';

/// Integration tests for login flow
///
/// Tests the complete login flow from JSON loading to navigation
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Login Flow Integration Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('should load entry point configuration', () async {
      // Arrange
      const entryPointPath = 'mock/stac_test_app/app_entry_point.json';

      // Act
      final configAsync = container.read(
        entryPointConfigProvider(entryPointPath),
      );

      // Assert
      await expectLater(
        configAsync,
        completion(isA<EntryPointConfig>()),
      );
    });

    test('should have login screen in entry point', () async {
      // Arrange
      const entryPointPath = 'mock/stac_test_app/app_entry_point.json';

      // Act
      final config = await container.read(
        entryPointConfigProvider(entryPointPath).future,
      );

      // Assert
      expect(config.screens.containsKey('login'), isTrue);
      expect(config.initialScreen, isNotNull);
    });

    test('should load login screen template and data', () async {
      // Arrange
      const entryPointPath = 'mock/stac_test_app/app_entry_point.json';
      final config = await container.read(
        entryPointConfigProvider(entryPointPath).future,
      );
      final loginScreen = config.screens['login']!;
      final entryPointDir = 'mock/stac_test_app';

      // Act
      final screenDataAsync = container.read(
        screenDataProvider(
          ScreenLoadParams(
            screenName: 'login',
            templatePath: loginScreen.template,
            dataPath: loginScreen.data,
            entryPointDir: entryPointDir,
          ),
        ),
      );

      // Assert
      await expectLater(
        screenDataAsync,
        completion(isA<Map<String, dynamic>>()),
      );
    });

    test('should have form fields in login screen', () async {
      // Arrange
      const entryPointPath = 'mock/stac_test_app/app_entry_point.json';
      final config = await container.read(
        entryPointConfigProvider(entryPointPath).future,
      );
      final loginScreen = config.screens['login']!;
      final entryPointDir = 'mock/stac_test_app';

      // Act
      final screenData = await container.read(
        screenDataProvider(
          ScreenLoadParams(
            screenName: 'login',
            templatePath: loginScreen.template,
            dataPath: loginScreen.data,
            entryPointDir: entryPointDir,
          ),
        ).future,
      );

      // Assert
      expect(screenData, isA<Map<String, dynamic>>());
      // The screen data should contain STAC JSON structure
      expect(screenData.containsKey('type'), isTrue);
    });

    group('Navigation State Management', () {
      test('should initialize with null screen', () {
        // Arrange
        final screenNotifier = container.read(currentScreenProvider);

        // Assert
        expect(screenNotifier.screen, isNull);
      });

      test('should set screen name', () {
        // Arrange
        final screenNotifier = container.read(currentScreenProvider);

        // Act
        screenNotifier.setScreen('login');

        // Assert
        expect(screenNotifier.screen, 'login');
      });

      test('should update screen name', () {
        // Arrange
        final screenNotifier = container.read(currentScreenProvider);
        screenNotifier.setScreen('login');

        // Act
        screenNotifier.setScreen('home');

        // Assert
        expect(screenNotifier.screen, 'home');
      });

      test('should clear screen name', () {
        // Arrange
        final screenNotifier = container.read(currentScreenProvider);
        screenNotifier.setScreen('login');

        // Act
        screenNotifier.clear();

        // Assert
        expect(screenNotifier.screen, isNull);
      });
    });

    group('Entry Point State Management', () {
      test('should initialize with null entry point', () {
        // Arrange
        final entryPointNotifier = container.read(currentEntryPointProvider);

        // Assert
        expect(entryPointNotifier.entryPoint, isNull);
      });

      test('should set entry point path', () {
        // Arrange
        final entryPointNotifier = container.read(currentEntryPointProvider);
        const path = 'mock/stac_test_app/app_entry_point.json';

        // Act
        entryPointNotifier.setEntryPoint(path);

        // Assert
        expect(entryPointNotifier.entryPoint, path);
      });

      test('should clear entry point', () {
        // Arrange
        final entryPointNotifier = container.read(currentEntryPointProvider);
        entryPointNotifier.setEntryPoint('mock/stac_test_app/app_entry_point.json');

        // Act
        entryPointNotifier.clear();

        // Assert
        expect(entryPointNotifier.entryPoint, isNull);
      });
    });

    group('Hot Reload and Restart Triggers', () {
      test('should initialize hot reload trigger', () {
        // Arrange
        final hotReloadNotifier = container.read(hotReloadTriggerProvider);

        // Assert
        expect(hotReloadNotifier.trigger, 0);
      });

      test('should increment hot reload trigger', () {
        // Arrange
        final hotReloadNotifier = container.read(hotReloadTriggerProvider);

        // Act
        hotReloadNotifier.triggerReload();

        // Assert
        expect(hotReloadNotifier.trigger, 1);
      });

      test('should initialize restart trigger', () {
        // Arrange
        final restartNotifier = container.read(restartTriggerProvider);

        // Assert
        expect(restartNotifier.trigger, 0);
      });

      test('should increment restart trigger', () {
        // Arrange
        final restartNotifier = container.read(restartTriggerProvider);

        // Act
        restartNotifier.triggerRestart();

        // Assert
        expect(restartNotifier.trigger, 1);
      });
    });
  });
}

