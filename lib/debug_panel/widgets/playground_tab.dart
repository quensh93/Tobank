import 'package:flutter/material.dart';
import '../screens/stac_test_app_playground_screen.dart';

/// Playground tab widget that embeds the STAC Test App Playground screen
///
/// This tab provides an interface for editing entry point JSON files
/// and controlling the STAC test app (hot reload, restart, etc.)
class PlaygroundTab extends StatelessWidget {
  const PlaygroundTab({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context),
      home: const StacTestAppPlaygroundScreen(),
    );
  }
}
