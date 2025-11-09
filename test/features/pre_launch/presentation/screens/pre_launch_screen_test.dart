import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tobank_sdui/features/pre_launch/presentation/screens/pre_launch_screen.dart';
import 'package:tobank_sdui/dummy/stac_test_page.dart';
import 'package:tobank_sdui/dummy/register_form_page.dart';
import 'package:tobank_sdui/dummy/digital_clock_page.dart';
import 'package:tobank_sdui/dummy/simple_api_test_page.dart';
import 'package:tobank_sdui/dummy/news_api_test_page.dart';

void main() {
  group('PreLaunchScreen Navigation Tests', () {
    testWidgets('should navigate to STAC Test Page when tapping STAC Test Page card', (tester) async {
      // Arrange
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: const PreLaunchScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Find and tap the STAC Test Page card
      final stacCard = find.text('STAC Test Page');
      expect(stacCard, findsOneWidget);
      
      await tester.tap(stacCard);
      await tester.pumpAndSettle();

      // Assert - Verify navigation to StacTestPage
      expect(find.byType(StacTestPage), findsOneWidget);
      // Note: STAC pages may not render fully in tests due to framework limitations
    });

    testWidgets('should navigate to Registration Form when tapping Registration Form card', (tester) async {
      // Arrange
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: const PreLaunchScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Find and tap the Registration Form card
      final registerCard = find.text('Registration Form');
      expect(registerCard, findsOneWidget);
      
      await tester.tap(registerCard);
      await tester.pumpAndSettle();

      // Assert - Verify navigation to RegisterFormPage
      expect(find.byType(RegisterFormPage), findsOneWidget);
      // Note: STAC pages may not render fully in tests due to framework limitations
    });

    testWidgets('should navigate to Digital Clock when tapping Digital Clock card', (tester) async {
      // Arrange
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: const PreLaunchScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Scroll to make Digital Clock card visible and tap it
      final clockCard = find.text('Digital Clock');
      await tester.ensureVisible(clockCard);
      await tester.pumpAndSettle();
      
      await tester.tap(clockCard);
      await tester.pumpAndSettle();

      // Assert - Verify navigation to DigitalClockPage
      expect(find.byType(DigitalClockPage), findsOneWidget);
      expect(find.text('Digital Clock'), findsWidgets); // Title appears in both AppBar and page
    });

    testWidgets('should navigate to HTTPBin API Test when tapping HTTPBin API Test card', (tester) async {
      // Arrange
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: const PreLaunchScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Scroll to make HTTPBin API Test card visible and tap it
      final apiCard = find.text('HTTPBin API Test');
      await tester.ensureVisible(apiCard);
      await tester.pumpAndSettle();
      
      await tester.tap(apiCard);
      await tester.pumpAndSettle();

      // Assert - Verify navigation to SimpleApiTestPage
      expect(find.byType(SimpleApiTestPage), findsOneWidget);
      expect(find.text('Simple API Test'), findsOneWidget);
    });

    testWidgets('should navigate to Network Layer Test when tapping Network Layer Test card', (tester) async {
      // Arrange
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: const PreLaunchScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Scroll to make Network Layer Test card visible and tap it
      final networkCard = find.text('Network Layer Test');
      await tester.ensureVisible(networkCard);
      await tester.pumpAndSettle();
      
      await tester.tap(networkCard);
      await tester.pumpAndSettle();

      // Assert - Verify navigation to NetworkLayerTestPage
      expect(find.byType(NetworkLayerTestPage), findsOneWidget);
      expect(find.text('Network Layer Test'), findsWidgets); // Title appears in AppBar
    });

    testWidgets('should return to PreLaunchScreen when pressing back button from STAC Test Page', (tester) async {
      // Arrange
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: const PreLaunchScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Navigate to STAC Test Page
      await tester.tap(find.text('STAC Test Page'));
      await tester.pumpAndSettle();
      
      // Verify we're on the STAC Test Page
      expect(find.byType(StacTestPage), findsOneWidget);
      
      // Press back button in AppBar
      final backButton = find.byType(BackButton);
      expect(backButton, findsOneWidget);
      await tester.tap(backButton);
      await tester.pumpAndSettle();

      // Assert - Verify we're back on PreLaunchScreen
      expect(find.byType(PreLaunchScreen), findsOneWidget);
      expect(find.text('Pre Launch Screen'), findsOneWidget);
      expect(find.text('Main Menu'), findsOneWidget);
      expect(find.text('Debug Tools'), findsOneWidget);
    });

    testWidgets('should return to PreLaunchScreen when pressing back button from Registration Form', (tester) async {
      // Arrange
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: const PreLaunchScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Navigate to Registration Form
      await tester.tap(find.text('Registration Form'));
      await tester.pumpAndSettle();
      
      // Verify we're on the Registration Form
      expect(find.byType(RegisterFormPage), findsOneWidget);
      
      // Press back button in AppBar
      final backButton = find.byType(BackButton);
      expect(backButton, findsOneWidget);
      await tester.tap(backButton);
      await tester.pumpAndSettle();

      // Assert - Verify we're back on PreLaunchScreen
      expect(find.byType(PreLaunchScreen), findsOneWidget);
      expect(find.text('Pre Launch Screen'), findsOneWidget);
    });

    testWidgets('should return to PreLaunchScreen when pressing back button from Digital Clock', (tester) async {
      // Arrange
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: const PreLaunchScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Scroll to and navigate to Digital Clock
      final clockCard = find.text('Digital Clock');
      await tester.ensureVisible(clockCard);
      await tester.pumpAndSettle();
      await tester.tap(clockCard);
      await tester.pumpAndSettle();
      
      // Verify we're on the Digital Clock page
      expect(find.byType(DigitalClockPage), findsOneWidget);
      
      // Press back button in AppBar
      final backButton = find.byType(BackButton);
      expect(backButton, findsOneWidget);
      await tester.tap(backButton);
      await tester.pumpAndSettle();

      // Assert - Verify we're back on PreLaunchScreen
      expect(find.byType(PreLaunchScreen), findsOneWidget);
      expect(find.text('Pre Launch Screen'), findsOneWidget);
    });

    testWidgets('should return to PreLaunchScreen when pressing back button from HTTPBin API Test', (tester) async {
      // Arrange
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: const PreLaunchScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Scroll to and navigate to HTTPBin API Test
      final apiCard = find.text('HTTPBin API Test');
      await tester.ensureVisible(apiCard);
      await tester.pumpAndSettle();
      await tester.tap(apiCard);
      await tester.pumpAndSettle();
      
      // Verify we're on the API Test page
      expect(find.byType(SimpleApiTestPage), findsOneWidget);
      
      // Press back button in AppBar
      final backButton = find.byType(BackButton);
      expect(backButton, findsOneWidget);
      await tester.tap(backButton);
      await tester.pumpAndSettle();

      // Assert - Verify we're back on PreLaunchScreen
      expect(find.byType(PreLaunchScreen), findsOneWidget);
      expect(find.text('Pre Launch Screen'), findsOneWidget);
    });

    testWidgets('should return to PreLaunchScreen when pressing back button from Network Layer Test', (tester) async {
      // Arrange
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: const PreLaunchScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Act - Scroll to and navigate to Network Layer Test
      final networkCard = find.text('Network Layer Test');
      await tester.ensureVisible(networkCard);
      await tester.pumpAndSettle();
      await tester.tap(networkCard);
      await tester.pumpAndSettle();
      
      // Verify we're on the Network Layer Test page
      expect(find.byType(NetworkLayerTestPage), findsOneWidget);
      
      // Press back button in AppBar
      final backButton = find.byType(BackButton);
      expect(backButton, findsOneWidget);
      await tester.tap(backButton);
      await tester.pumpAndSettle();

      // Assert - Verify we're back on PreLaunchScreen
      expect(find.byType(PreLaunchScreen), findsOneWidget);
      expect(find.text('Pre Launch Screen'), findsOneWidget);
    });

    testWidgets('should navigate to all pages sequentially and return to PreLaunchScreen', (tester) async {
      // Arrange
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: const PreLaunchScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final testPages = [
        ('STAC Test Page', StacTestPage),
        ('Registration Form', RegisterFormPage),
        ('Digital Clock', DigitalClockPage),
        ('HTTPBin API Test', SimpleApiTestPage),
        ('Network Layer Test', NetworkLayerTestPage),
      ];

      // Act & Assert - Test each page navigation
      for (final (cardText, pageType) in testPages) {
        // Scroll to card if needed
        final cardFinder = find.text(cardText);
        await tester.ensureVisible(cardFinder);
        await tester.pumpAndSettle();
        
        // Navigate to page
        await tester.tap(cardFinder);
        await tester.pumpAndSettle();
        
        // Verify we're on the correct page
        expect(find.byType(pageType), findsOneWidget);
        
        // Navigate back using back button
        final backButton = find.byType(BackButton);
        expect(backButton, findsOneWidget);
        await tester.tap(backButton);
        await tester.pumpAndSettle();
        
        // Verify we're back on PreLaunchScreen
        expect(find.byType(PreLaunchScreen), findsOneWidget);
        expect(find.text('Pre Launch Screen'), findsOneWidget);
      }
    });
  });
}
