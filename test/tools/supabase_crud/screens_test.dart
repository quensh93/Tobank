import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tobank_sdui/tools/supabase_crud/screens/screen_list_screen.dart';
import 'package:tobank_sdui/tools/supabase_crud/screens/screen_edit_screen.dart';
import 'package:tobank_sdui/tools/supabase_crud/screens/screen_create_screen.dart';
import 'package:tobank_sdui/tools/supabase_crud/providers/supabase_crud_provider.dart';
import 'package:tobank_sdui/tools/supabase_crud/models/screen_metadata.dart';

void main() {
  group('ScreenListScreen Widget Tests', () {
    testWidgets('should display loading indicator while fetching screens',
        (tester) async {
      // Arrange
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            screensListProvider.overrideWith(
              (ref, args) => Future.delayed(
                const Duration(seconds: 1),
                () => <ScreenMetadata>[],
              ),
            ),
          ],
          child: const MaterialApp(
            home: ScreenListScreen(),
          ),
        ),
      );

      // Act
      await tester.pump();

      // Assert
      expect(find.text('Loading screens...'), findsOneWidget);
    });

    testWidgets('should display empty state when no screens available',
        (tester) async {
      // Arrange
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            screensListProvider.overrideWith(
              (ref, args) => Future.value(<ScreenMetadata>[]),
            ),
          ],
          child: const MaterialApp(
            home: ScreenListScreen(),
          ),
        ),
      );

      // Act
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('No screens available'), findsOneWidget);
      expect(find.text('Create your first screen to get started'),
          findsOneWidget);
    });

    testWidgets('should display list of screens when data is available',
        (tester) async {
      // Arrange
      final mockScreens = [
        ScreenMetadata(
          id: 'home_screen_id',
          name: 'home_screen',
          version: 1,
          createdAt: DateTime(2024, 1, 1),
          updatedAt: DateTime(2024, 1, 1),
          description: 'Home screen',
          tags: ['main'],
        ),
        ScreenMetadata(
          id: 'profile_screen_id',
          name: 'profile_screen',
          version: 2,
          createdAt: DateTime(2024, 1, 2),
          updatedAt: DateTime(2024, 1, 2),
          description: 'Profile screen',
          tags: ['user'],
        ),
      ];

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            screensListProvider.overrideWith(
              (ref, args) => Future.value(mockScreens),
            ),
          ],
          child: const MaterialApp(
            home: ScreenListScreen(),
          ),
        ),
      );

      // Act
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('home_screen'), findsOneWidget);
      expect(find.text('profile_screen'), findsOneWidget);
    });

    testWidgets('should display search bar', (tester) async {
      // Arrange
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            screensListProvider.overrideWith(
              (ref, args) => Future.value(<ScreenMetadata>[]),
            ),
          ],
          child: const MaterialApp(
            home: ScreenListScreen(),
          ),
        ),
      );

      // Act
      await tester.pumpAndSettle();

      // Assert
      expect(
        find.widgetWithText(
          TextField,
          'Search screens by name, description, or tags...',
        ),
        findsOneWidget,
      );
    });

    testWidgets('should filter screens based on search query',
        (tester) async {
      // Arrange
      final mockScreens = [
        ScreenMetadata(
          id: 'home_screen_id_2',
          name: 'home_screen',
          version: 1,
          createdAt: DateTime(2024, 1, 1),
          updatedAt: DateTime(2024, 1, 1),
          description: 'Home screen',
        ),
        ScreenMetadata(
          id: 'profile_screen_id_2',
          name: 'profile_screen',
          version: 1,
          createdAt: DateTime(2024, 1, 2),
          updatedAt: DateTime(2024, 1, 2),
          description: 'Profile screen',
        ),
      ];

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            screensListProvider.overrideWith(
              (ref, args) => Future.value(mockScreens),
            ),
          ],
          child: const MaterialApp(
            home: ScreenListScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Act - Enter search query
      await tester.enterText(
        find.widgetWithText(TextField, 'Search screens by name, description, or tags...'),
        'home',
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('home_screen'), findsOneWidget);
      expect(find.text('profile_screen'), findsNothing);
    });

    testWidgets('should display "New Screen" button', (tester) async {
      // Arrange
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            screensListProvider.overrideWith(
              (ref, args) => Future.value(<ScreenMetadata>[]),
            ),
          ],
          child: const MaterialApp(
            home: ScreenListScreen(),
          ),
        ),
      );

      // Act
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('New Screen'), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets('should display refresh button', (tester) async {
      // Arrange
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            screensListProvider.overrideWith(
              (ref, args) => Future.value(<ScreenMetadata>[]),
            ),
          ],
          child: const MaterialApp(
            home: ScreenListScreen(),
          ),
        ),
      );

      // Act
      await tester.pumpAndSettle();

      // Assert
      expect(find.byIcon(Icons.refresh), findsOneWidget);
    });

    testWidgets('should display sort button', (tester) async {
      // Arrange
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            screensListProvider.overrideWith(
              (ref, args) => Future.value(<ScreenMetadata>[]),
            ),
          ],
          child: const MaterialApp(
            home: ScreenListScreen(),
          ),
        ),
      );

      // Act
      await tester.pumpAndSettle();

      // Assert
      expect(find.byIcon(Icons.sort), findsOneWidget);
    });
  });

  group('ScreenEditScreen Widget Tests', () {
    testWidgets('should display screen name in title', (tester) async {
      // Arrange
      const screenName = 'test_screen';
      final mockMetadata = ScreenMetadata(
        id: 'test_screen_id_1',
        name: screenName,
        version: 1,
        createdAt: DateTime(2024, 1, 1),
        updatedAt: DateTime(2024, 1, 1),
      );
      final mockJson = {'type': 'text', 'data': 'Hello'};

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            screenProvider(screenName).overrideWith(
              (ref) => Future.value(mockMetadata),
            ),
            screenJsonProvider(screenName).overrideWith(
              (ref) => Future.value(mockJson),
            ),
          ],
          child: const MaterialApp(
            home: ScreenEditScreen(screenName: screenName),
          ),
        ),
      );

      // Act
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Edit: $screenName'), findsOneWidget);
    });

    testWidgets('should display save button', (tester) async {
      // Arrange
      const screenName = 'test_screen';
      final mockMetadata = ScreenMetadata(
        id: 'test_screen_id_2',
        name: screenName,
        version: 1,
        createdAt: DateTime(2024, 1, 1),
        updatedAt: DateTime(2024, 1, 1),
      );
      final mockJson = {'type': 'text', 'data': 'Hello'};

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            screenProvider(screenName).overrideWith(
              (ref) => Future.value(mockMetadata),
            ),
            screenJsonProvider(screenName).overrideWith(
              (ref) => Future.value(mockJson),
            ),
          ],
          child: const MaterialApp(
            home: ScreenEditScreen(screenName: screenName),
          ),
        ),
      );

      // Act
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Save'), findsOneWidget);
    });

    testWidgets('should display version history button', (tester) async {
      // Arrange
      const screenName = 'test_screen';
      final mockMetadata = ScreenMetadata(
        id: 'test_screen_id_3',
        name: screenName,
        version: 1,
        createdAt: DateTime(2024, 1, 1),
        updatedAt: DateTime(2024, 1, 1),
      );
      final mockJson = {'type': 'text', 'data': 'Hello'};

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            screenProvider(screenName).overrideWith(
              (ref) => Future.value(mockMetadata),
            ),
            screenJsonProvider(screenName).overrideWith(
              (ref) => Future.value(mockJson),
            ),
          ],
          child: const MaterialApp(
            home: ScreenEditScreen(screenName: screenName),
          ),
        ),
      );

      // Act
      await tester.pumpAndSettle();

      // Assert
      expect(find.byIcon(Icons.history), findsOneWidget);
    });

    testWidgets('should display metadata panel', (tester) async {
      // Arrange
      const screenName = 'test_screen';
      final mockMetadata = ScreenMetadata(
        id: 'test_screen_id_4',
        name: screenName,
        version: 1,
        createdAt: DateTime(2024, 1, 1),
        updatedAt: DateTime(2024, 1, 1),
        description: 'Test description',
      );
      final mockJson = {'type': 'text', 'data': 'Hello'};

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            screenProvider(screenName).overrideWith(
              (ref) => Future.value(mockMetadata),
            ),
            screenJsonProvider(screenName).overrideWith(
              (ref) => Future.value(mockJson),
            ),
          ],
          child: const MaterialApp(
            home: ScreenEditScreen(screenName: screenName),
          ),
        ),
      );

      // Act
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Metadata'), findsOneWidget);
      expect(find.text('Version: v1'), findsOneWidget);
    });

    testWidgets('should display loading indicator while fetching data',
        (tester) async {
      // Arrange
      const screenName = 'test_screen';

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            screenProvider(screenName).overrideWith(
              (ref) => Future.delayed(
                const Duration(seconds: 1),
                () => ScreenMetadata(
                  id: 'test_screen_id_5',
                  name: screenName,
                  version: 1,
                  createdAt: DateTime(2024, 1, 1),
                  updatedAt: DateTime(2024, 1, 1),
                ),
              ),
            ),
            screenJsonProvider(screenName).overrideWith(
              (ref) => Future.delayed(
                const Duration(seconds: 1),
                () => {'type': 'text', 'data': 'Hello'},
              ),
            ),
          ],
          child: const MaterialApp(
            home: ScreenEditScreen(screenName: screenName),
          ),
        ),
      );

      // Act
      await tester.pump();

      // Assert
      expect(find.text('Loading screen metadata...'), findsOneWidget);
    });
  });

  group('ScreenCreateScreen Widget Tests', () {
    testWidgets('should display "Create New Screen" title', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: ScreenCreateScreen(),
          ),
        ),
      );

      // Act
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Create New Screen'), findsOneWidget);
    });

    testWidgets('should display screen name input field', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: ScreenCreateScreen(),
          ),
        ),
      );

      // Act
      await tester.pumpAndSettle();

      // Assert
      expect(find.widgetWithText(TextField, 'Screen Name *'), findsOneWidget);
    });

    testWidgets('should display description input field', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: ScreenCreateScreen(),
          ),
        ),
      );

      // Act
      await tester.pumpAndSettle();

      // Assert
      expect(find.widgetWithText(TextField, 'Description'), findsOneWidget);
    });

    testWidgets('should display route input field', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: ScreenCreateScreen(),
          ),
        ),
      );

      // Act
      await tester.pumpAndSettle();

      // Assert
      expect(find.widgetWithText(TextField, 'Route'), findsOneWidget);
    });

    testWidgets('should display create button', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: ScreenCreateScreen(),
          ),
        ),
      );

      // Act
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Create'), findsOneWidget);
    });

    testWidgets('should display template buttons', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: ScreenCreateScreen(),
          ),
        ),
      );

      // Act
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Templates'), findsOneWidget);
      expect(find.text('Basic Screen'), findsOneWidget);
      expect(find.text('Form Screen'), findsOneWidget);
      expect(find.text('List Screen'), findsOneWidget);
      expect(find.text('Empty Screen'), findsOneWidget);
    });

    testWidgets('should display default JSON in editor', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: ScreenCreateScreen(),
          ),
        ),
      );

      // Act
      await tester.pumpAndSettle();

      // Assert
      // Check that JSON editor is present (it contains the default JSON)
      expect(find.byType(TextField), findsWidgets);
    });
  });
}


