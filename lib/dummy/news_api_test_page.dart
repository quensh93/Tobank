// ignore_for_file: provider_parameters
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../data/providers/api_providers.dart';

class NetworkLayerTestPage extends ConsumerWidget {
  const NetworkLayerTestPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Network Layer Test'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Network Layer Features Test',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Dio • Retrofit • fpdart • Riverpod',
                style: TextStyle(fontSize: 14, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              _buildSection(
                title: 'GET Request with fpdart',
                subtitle: 'TaskEither error handling',
                icon: Icons.download,
                color: Colors.blue,
                onPressed: () => _testGet(context, ref),
              ),

              const SizedBox(height: 16),

              _buildSection(
                title: 'POST Request',
                subtitle: 'Send JSON data',
                icon: Icons.upload,
                color: Colors.green,
                onPressed: () => _testPost(context, ref),
              ),

              const SizedBox(height: 16),

              _buildSection(
                title: 'PUT Request',
                subtitle: 'Update data',
                icon: Icons.edit,
                color: Colors.orange,
                onPressed: () => _testPut(context, ref),
              ),

              const SizedBox(height: 16),

              _buildSection(
                title: 'DELETE Request',
                subtitle: 'Remove data',
                icon: Icons.delete,
                color: Colors.red,
                onPressed: () => _testDelete(context, ref),
              ),

              const SizedBox(height: 16),

              _buildSection(
                title: 'Headers Test',
                subtitle: 'Check request headers',
                icon: Icons.info,
                color: Colors.teal,
                onPressed: () => _testHeaders(context, ref),
              ),

              const SizedBox(height: 16),

              _buildSection(
                title: 'User Agent',
                subtitle: 'Browser identification',
                icon: Icons.computer,
                color: Colors.indigo,
                onPressed: () => _testUserAgent(context, ref),
              ),

              const SizedBox(height: 24),

              const Divider(),
              const SizedBox(height: 16),

              const Text(
                'Features Demonstrated:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              _buildFeatureItem('✅ Retrofit with type-safe HTTP calls'),
              _buildFeatureItem('✅ Dio interceptors (Logging, Error handling)'),
              _buildFeatureItem(
                '✅ fpdart TaskEither for functional error handling',
              ),
              _buildFeatureItem(
                '✅ Riverpod providers for dependency injection',
              ),
              _buildFeatureItem('✅ Sealed error classes for type-safe errors'),
              _buildFeatureItem('✅ Repository pattern with clean architecture'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 32),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 12, color: Colors.white70),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(children: [Text(text, style: const TextStyle(fontSize: 14))]),
    );
  }

  Future<void> _testGet(BuildContext context, WidgetRef ref) async {
    _showLoading(context);

    try {
      final provider = getDataProvider(const {'test': 'value', 'lang': 'dart'});
      final result = await ref
          .read(provider.future)
          .timeout(const Duration(seconds: 10));

      if (context.mounted) {
        _hideLoading(context);
        _showResult(context, result, 'GET Success');
      }
    } catch (e) {
      if (context.mounted) {
        _hideLoading(context);
        _showError(context, 'GET Error: $e');
      }
    }
  }

  Future<void> _testPost(BuildContext context, WidgetRef ref) async {
    _showLoading(context);

    try {
      final provider = postDataProvider(const {
        'name': 'Flutter Test',
        'framework': 'Flutter',
        'language': 'Dart',
      });
      final result = await ref
          .read(provider.future)
          .timeout(const Duration(seconds: 10));

      if (context.mounted) {
        _hideLoading(context);
        _showResult(context, result, 'POST Success');
      }
    } catch (e) {
      if (context.mounted) {
        _hideLoading(context);
        _showError(context, 'POST Error: $e');
      }
    }
  }

  Future<void> _testPut(BuildContext context, WidgetRef ref) async {
    _showLoading(context);

    try {
      final provider = putDataProvider(const {
        'id': 1,
        'name': 'Updated Name',
        'status': 'updated',
      });
      final result = await ref
          .read(provider.future)
          .timeout(const Duration(seconds: 10));

      if (context.mounted) {
        _hideLoading(context);
        _showResult(context, result, 'PUT Success');
      }
    } catch (e) {
      if (context.mounted) {
        _hideLoading(context);
        _showError(context, 'PUT Error: $e');
      }
    }
  }

  Future<void> _testDelete(BuildContext context, WidgetRef ref) async {
    _showLoading(context);

    try {
      final result = await ref
          .read(deleteDataProvider.future)
          .timeout(const Duration(seconds: 10));

      if (context.mounted) {
        _hideLoading(context);
        _showResult(context, result, 'DELETE Success');
      }
    } catch (e) {
      if (context.mounted) {
        _hideLoading(context);
        _showError(context, 'DELETE Error: $e');
      }
    }
  }

  Future<void> _testHeaders(BuildContext context, WidgetRef ref) async {
    _showLoading(context);

    try {
      final result = await ref
          .read(getHeadersProvider.future)
          .timeout(const Duration(seconds: 10));

      if (context.mounted) {
        _hideLoading(context);
        _showResult(context, result, 'Headers');
      }
    } catch (e) {
      if (context.mounted) {
        _hideLoading(context);
        _showError(context, 'Headers Error: $e');
      }
    }
  }

  Future<void> _testUserAgent(BuildContext context, WidgetRef ref) async {
    _showLoading(context);

    try {
      final result = await ref
          .read(getUserAgentProvider.future)
          .timeout(const Duration(seconds: 10));

      if (context.mounted) {
        _hideLoading(context);
        _showResult(context, result, 'User Agent');
      }
    } catch (e) {
      if (context.mounted) {
        _hideLoading(context);
        _showError(context, 'User Agent Error: $e');
      }
    }
  }

  void _showLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Loading...'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _hideLoading(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _showResult(
    BuildContext context,
    Map<String, dynamic> result,
    String title,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 28),
            const SizedBox(width: 8),
            Text(title),
          ],
        ),
        content: SingleChildScrollView(
          child: Text(
            result.toString(),
            style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showError(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.error, color: Colors.red, size: 28),
            SizedBox(width: 8),
            Text('Error'),
          ],
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
