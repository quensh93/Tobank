import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'providers/api_providers.dart';

class SimpleApiTestPage extends ConsumerWidget {
  const SimpleApiTestPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple API Test'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'HTTPBin API Test with fpdart',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'Error handling with TaskEither',
                style: TextStyle(fontSize: 14, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              
              // GET test button
              ElevatedButton(
                onPressed: () => _testGet(context, ref),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Test GET'),
              ),
              const SizedBox(height: 16),
              
              // POST test button
              ElevatedButton(
                onPressed: () => _testPost(context, ref),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Test POST'),
              ),
              const SizedBox(height: 16),
              
              // PUT test button
              ElevatedButton(
                onPressed: () => _testPut(context, ref),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Test PUT'),
              ),
              const SizedBox(height: 16),
              
              // DELETE test button
              ElevatedButton(
                onPressed: () => _testDelete(context, ref),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Test DELETE'),
              ),
              const SizedBox(height: 16),
              
              // Headers test button
              ElevatedButton(
                onPressed: () => _testHeaders(context, ref),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Test Headers'),
              ),
              const SizedBox(height: 16),
              
              // User Agent test button
              ElevatedButton(
                onPressed: () => _testUserAgent(context, ref),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Test User Agent'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _testGet(BuildContext context, WidgetRef ref) async {
    final either = await ref.read(getDataProvider({'test': 'value', 'foo': 'bar'}).future);
    if (context.mounted) {
      either.fold(
        (error) => _showError(context, 'GET Error', error.message, error.runtimeType.toString()),
        (data) => _showResult(context, 'GET Response', data),
      );
    }
  }

  Future<void> _testPost(BuildContext context, WidgetRef ref) async {
    final either = await ref.read(postDataProvider({'name': 'John', 'email': 'john@example.com'}).future);
    if (context.mounted) {
      either.fold(
        (error) => _showError(context, 'POST Error', error.message, error.runtimeType.toString()),
        (data) => _showResult(context, 'POST Response', data),
      );
    }
  }

  Future<void> _testPut(BuildContext context, WidgetRef ref) async {
    final either = await ref.read(putDataProvider({'name': 'Jane', 'updated': true}).future);
    if (context.mounted) {
      either.fold(
        (error) => _showError(context, 'PUT Error', error.message, error.runtimeType.toString()),
        (data) => _showResult(context, 'PUT Response', data),
      );
    }
  }

  Future<void> _testDelete(BuildContext context, WidgetRef ref) async {
    final either = await ref.read(deleteDataProvider.future);
    if (context.mounted) {
      either.fold(
        (error) => _showError(context, 'DELETE Error', error.message, error.runtimeType.toString()),
        (data) => _showResult(context, 'DELETE Response', data),
      );
    }
  }

  Future<void> _testHeaders(BuildContext context, WidgetRef ref) async {
    final either = await ref.read(getHeadersProvider.future);
    if (context.mounted) {
      either.fold(
        (error) => _showError(context, 'Headers Error', error.message, error.runtimeType.toString()),
        (data) => _showResult(context, 'Headers Response', data),
      );
    }
  }

  Future<void> _testUserAgent(BuildContext context, WidgetRef ref) async {
    final either = await ref.read(getUserAgentProvider.future);
    if (context.mounted) {
      either.fold(
        (error) => _showError(context, 'User Agent Error', error.message, error.runtimeType.toString()),
        (data) => _showResult(context, 'User Agent Response', data),
      );
    }
  }

  void _showResult(BuildContext context, String title, Map<String, dynamic> data) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.green),
            const SizedBox(width: 8),
            Text(title),
          ],
        ),
        content: SingleChildScrollView(
          child: Text(
            data.toString(),
            style: const TextStyle(fontFamily: 'monospace'),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showError(BuildContext context, String title, String error, String errorType) {
    final Color color;
    final IconData icon;
    
    // Pattern match on error type
    switch (errorType) {
      case 'NetworkError':
        color = Colors.red;
        icon = Icons.error;
        break;
      case 'NotFoundError':
        color = Colors.orange;
        icon = Icons.search_off;
        break;
      case 'ValidationError':
        color = Colors.amber;
        icon = Icons.warning;
        break;
      case 'ServerError':
        color = Colors.red.shade900;
        icon = Icons.cloud_off;
        break;
      default:
        color = Colors.grey;
        icon = Icons.error_outline;
    }
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 8),
            Expanded(
              child: Text(title),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Error Type: $errorType',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(error),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
