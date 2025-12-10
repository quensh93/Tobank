import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stac/stac.dart';
import 'dart:convert';
import '../../../../core/helpers/logger.dart';
import '../../../../features/stac_test_app/data/utils/stac_error_handler.dart';

/// Tobank Mock New Screen
/// 
/// This screen loads and renders the Tobank menu from local JSON file.
/// It uses STAC to render the server-driven UI.
class TobankMockNewScreen extends ConsumerStatefulWidget {
  const TobankMockNewScreen({super.key});

  @override
  ConsumerState<TobankMockNewScreen> createState() => _TobankMockNewScreenState();
}

class _TobankMockNewScreenState extends ConsumerState<TobankMockNewScreen> {
  /// Creates a theme with transparent input borders for all states
  /// Uses InputBorder.none to completely remove borders
  /// Also sets button color to purple to test if STAC uses theme colors
  ThemeData _getThemeWithTransparentBorders(BuildContext context) {
    final baseTheme = Theme.of(context);
    return baseTheme.copyWith(
      // Override colorScheme.primary so buttons without explicit style use purple
      colorScheme: baseTheme.colorScheme.copyWith(
        primary: Colors.purple,
        onPrimary: Colors.white,
      ),
      inputDecorationTheme: InputDecorationTheme(
        // Use InputBorder.none to completely remove all borders
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        border: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.purple,
          side: const BorderSide(color: Colors.purple),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.purple,
        ),
      ),
    );
  }

  /// Wraps a widget with Theme that has transparent input borders
  Widget _wrapWithTransparentBorderTheme(BuildContext context, Widget child) {
    return Theme(
      data: _getThemeWithTransparentBorders(context),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Load JSON from local file
    return FutureBuilder<Map<String, dynamic>>(
      future: _loadMenuJson(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasError) {
          AppLogger.e('Failed to load Tobank menu', snapshot.error);
          return Scaffold(
            appBar: AppBar(
              title: const Text('Tobank Mock - Error'),
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Failed to load Tobank menu:\n${snapshot.error}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {}); // Retry
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(
              child: Text('No data available'),
            ),
          );
        }

        // Render STAC JSON
        try {
          final widget = Stac.fromJson(snapshot.data!, context);
          if (widget == null) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Tobank Mock - Error'),
              ),
              body: const Center(
                child: Text('Failed to render STAC widget'),
              ),
            );
          }
          
          // Wrap with Theme to force transparent input borders
          return _wrapWithTransparentBorderTheme(context, widget);
        } catch (e, stackTrace) {
          AppLogger.e('STAC parsing error', e, stackTrace);
          final userMessage = StacErrorHandler.getUserFriendlyMessage(e);
          return Scaffold(
            appBar: AppBar(
              title: const Text('Tobank Mock - Error'),
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'STAC parsing error:\n$userMessage',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  /// Load menu JSON from STAC build output
  /// 
  /// Loads directly from stac/.build/ which is STAC's default output directory.
  /// This avoids unnecessary file copying - files are used where STAC generates them.
  /// Uses Flutter's asset system which works on all platforms (mobile, web, desktop)
  Future<Map<String, dynamic>> _loadMenuJson() async {
    try {
      // Load directly from STAC build output directory (no copying needed)
      const assetPath = 'lib/stac/.build/tobank_menu.json';
      
      AppLogger.i('Loading Tobank menu from STAC build output: $assetPath');
      
      // Load JSON string from assets
      final jsonString = await rootBundle.loadString(assetPath);
      
      // Parse JSON
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      
      AppLogger.i('✅ Successfully loaded Tobank menu JSON from STAC build output');
      return json;
    } catch (e, stackTrace) {
      AppLogger.e('Failed to load Tobank menu JSON from STAC build output', e, stackTrace);
      rethrow;
    }
  }
}
