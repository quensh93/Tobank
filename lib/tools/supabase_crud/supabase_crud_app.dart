import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'screens/screen_list_screen.dart';
import 'screens/screen_edit_screen.dart';
import 'screens/screen_create_screen.dart';
import 'screens/bulk_operations_screen.dart';

/// Supabase CRUD Web Application
///
/// A web-based interface for managing STAC JSON configurations in Supabase.
/// Provides CRUD operations (Create, Read, Update, Delete) for screen configurations.
class SupabaseCrudApp extends StatelessWidget {
  const SupabaseCrudApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'STAC Supabase Manager',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.light,
          ),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            centerTitle: false,
            elevation: 2,
          ),
          cardTheme: CardThemeData(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            filled: true,
          ),
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            centerTitle: false,
            elevation: 2,
          ),
          cardTheme: CardThemeData(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            filled: true,
          ),
        ),
        themeMode: ThemeMode.system,
        initialRoute: '/',
        routes: {
          '/': (context) => const ScreenListScreen(),
          '/create': (context) => const ScreenCreateScreen(),
          '/bulk': (context) => const BulkOperationsScreen(),
        },
        onGenerateRoute: (settings) {
          // Handle dynamic routes for editing screens
          if (settings.name?.startsWith('/edit/') ?? false) {
            final screenName = settings.name!.substring(6); // Remove '/edit/'
            return MaterialPageRoute(
              builder: (context) => ScreenEditScreen(screenName: screenName),
              settings: settings,
            );
          }
          return null;
        },
      ),
    );
  }
}

/// Main layout widget for the CRUD interface
///
/// Provides a consistent layout with app bar and navigation
class CrudLayout extends StatelessWidget {
  final String title;
  final Widget body;
  final List<Widget>? actions;
  final Widget? floatingActionButton;

  const CrudLayout({
    super.key,
    required this.title,
    required this.body,
    this.actions,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.cloud_outlined, size: 28),
            const SizedBox(width: 12),
            Text(title),
          ],
        ),
        actions: actions,
      ),
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}

/// Navigation helper methods
class CrudNavigation {
  /// Navigate to screen list
  static void toScreenList(BuildContext context) {
    Navigator.of(context).pushReplacementNamed('/');
  }

  /// Navigate to create screen
  static void toCreateScreen(BuildContext context) {
    Navigator.of(context).pushNamed('/create');
  }

  /// Navigate to edit screen
  static void toEditScreen(BuildContext context, String screenName) {
    Navigator.of(context).pushNamed('/edit/$screenName');
  }

  /// Navigate to bulk operations
  static void toBulkOperations(BuildContext context) {
    Navigator.of(context).pushNamed('/bulk');
  }

  /// Go back
  static void back(BuildContext context) {
    Navigator.of(context).pop();
  }
}
