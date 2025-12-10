import 'package:flutter/material.dart';

/// Visual Editor Screen (Disabled)
/// 
/// This screen is currently disabled as it requires additional dependencies
/// and complex widget tree manipulation that's not yet implemented.
class VisualEditorScreen extends StatelessWidget {
  const VisualEditorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visual Editor'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.construction,
              size: 64,
              color: Colors.orange,
            ),
            SizedBox(height: 16),
            Text(
              'Visual Editor',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'This feature is currently under development',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'The visual editor will allow you to:\n'
              '• Drag and drop STAC components\n'
              '• Edit widget properties visually\n'
              '• Preview changes in real-time\n'
              '• Export to JSON format',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}