import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/helpers/logger.dart';
import '../../../../dummy/stac_test_page.dart';
import '../../../../dummy/register_form_page.dart';
import '../../../../dummy/digital_clock_page.dart';
import '../../../../dummy/simple_api_test_page.dart';
import '../../../../dummy/news_api_test_page.dart';
import '../../providers/theme_controller_provider.dart';
import '../widgets/menu_card.dart';
import '../widgets/debug_tool_item.dart';

/// Server token constant for development/testing
const String serverToken = 'wCgGVu&kbWHxkAkLzvptAa@VcLak+NCbGBcXK!eb7Q@#R8WzfsfdsfdfdsfdsfdssfdsfdZ5BZ7Qr';

/// Pre Launch Screen - Initial entry point for the application
/// 
/// Provides developers with quick access to test pages and debug tools.
/// Features organized sections for Main Menu (test pages) and Debug Tools.
class PreLaunchScreen extends ConsumerStatefulWidget {
  const PreLaunchScreen({super.key});

  @override
  ConsumerState<PreLaunchScreen> createState() => _PreLaunchScreenState();
}

class _PreLaunchScreenState extends ConsumerState<PreLaunchScreen> {
  final _storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final themeAsync = ref.watch(themeControllerProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pre Launch Screen'),
        actions: [
          IconButton(
            icon: Icon(
              themeAsync.value == ThemeMode.dark 
                  ? Icons.light_mode 
                  : Icons.dark_mode,
            ),
            onPressed: () async {
              await ref.read(themeControllerProvider.notifier).toggleMode();
            },
            tooltip: 'Toggle theme',
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Main Menu Section
                _buildSectionTitle('Main Menu', theme),
                const SizedBox(height: 16),
                _buildMainMenuGrid(),
                
                const SizedBox(height: 40),
                
                // Debug Tools Section
                _buildSectionTitle('Debug Tools', theme),
                const SizedBox(height: 16),
                _buildDebugToolsList(colorScheme),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Build section title widget
  Widget _buildSectionTitle(String title, ThemeData theme) {
    return Text(
      title,
      style: theme.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w600,
      ),
    );
  }

  /// Build Main Menu grid with test page cards
  Widget _buildMainMenuGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      childAspectRatio: 1.2,
      children: [
        MenuCard(
          icon: Icons.palette,
          title: 'STAC Test Page',
          subtitle: 'Test STAC framework',
          onTap: () => _navigateToPage(const StacTestPage(), '/stac-test'),
        ),
        MenuCard(
          icon: Icons.app_registration,
          title: 'Registration Form',
          subtitle: 'Form validation test',
          onTap: () => _navigateToPage(const RegisterFormPage(), '/register-form'),
        ),
        MenuCard(
          icon: Icons.access_time,
          title: 'Digital Clock',
          subtitle: 'STAC widget example',
          onTap: () => _navigateToPage(const DigitalClockPage(), '/digital-clock'),
        ),
        MenuCard(
          icon: Icons.api,
          title: 'HTTPBin API Test',
          subtitle: 'API testing',
          onTap: () => _navigateToPage(const SimpleApiTestPage(), '/simple-api-test'),
        ),
        MenuCard(
          icon: Icons.network_check,
          title: 'Network Layer Test',
          subtitle: 'Network layer testing',
          onTap: () => _navigateToPage(const NetworkLayerTestPage(), '/network-layer-test'),
        ),
      ],
    );
  }

  /// Build Debug Tools list
  Widget _buildDebugToolsList(ColorScheme colorScheme) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.5),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          DebugToolItem(
            icon: Icons.copy,
            title: 'Copy User Token',
            subtitle: 'Copy auth token to clipboard',
            onTap: _copyUserToken,
          ),
          Divider(height: 1, color: colorScheme.outline.withValues(alpha: 0.3)),
          DebugToolItem(
            icon: Icons.vpn_key,
            title: 'Copy Server Token',
            subtitle: 'Copy server token to clipboard',
            onTap: _copyServerToken,
          ),
          Divider(height: 1, color: colorScheme.outline.withValues(alpha: 0.3)),
          DebugToolItem(
            icon: Icons.delete_forever,
            title: 'Delete Storage',
            subtitle: 'Clear all secure storage',
            onTap: _deleteStorage,
          ),
          Divider(height: 1, color: colorScheme.outline.withValues(alpha: 0.3)),
          DebugToolItem(
            icon: Icons.delete,
            title: 'Delete User Token',
            subtitle: 'Remove auth and refresh tokens',
            onTap: _deleteUserToken,
          ),
          Divider(height: 1, color: colorScheme.outline.withValues(alpha: 0.3)),
          DebugToolItem(
            icon: Icons.chat,
            title: 'Talker',
            subtitle: 'View application logs',
            onTap: _openTalker,
          ),
          Divider(height: 1, color: colorScheme.outline.withValues(alpha: 0.3)),
          DebugToolItem(
            icon: Icons.edit,
            title: 'Set User Token Manual',
            subtitle: 'Manually enter auth token',
            onTap: _setUserTokenManual,
            isLast: true,
          ),
        ],
      ),
    );
  }

  /// Navigate to a test page
  void _navigateToPage(Widget page, String routeName) {
    AppLogger.i('Navigating to $routeName');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => page,
        settings: RouteSettings(name: routeName),
      ),
    );
  }

  /// Copy user token from secure storage to clipboard
  Future<void> _copyUserToken() async {
    try {
      final token = await _storage.read(key: 'auth_token');
      
      if (token == null || token.isEmpty) {
        if (!mounted) return;
        _showSnackBar('No user token found in storage');
        AppLogger.w('No user token found in storage');
        return;
      }
      
      await Clipboard.setData(ClipboardData(text: token));
      if (!mounted) return;
      _showSnackBar('User token copied to clipboard');
      AppLogger.i('User token copied to clipboard');
    } catch (e) {
      AppLogger.e('Failed to copy user token: $e');
      if (!mounted) return;
      _showSnackBar('Error copying user token');
    }
  }

  /// Copy server token to clipboard
  Future<void> _copyServerToken() async {
    try {
      await Clipboard.setData(const ClipboardData(text: serverToken));
      if (!mounted) return;
      _showSnackBar('Server token copied to clipboard');
      AppLogger.i('Server token copied to clipboard');
    } catch (e) {
      AppLogger.e('Failed to copy server token: $e');
      if (!mounted) return;
      _showSnackBar('Error copying server token');
    }
  }

  /// Delete all data from secure storage
  Future<void> _deleteStorage() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    
    try {
      await _storage.deleteAll();
      AppLogger.i('All secure storage deleted');
      if (!mounted) return;
      _showSnackBarWithMessenger(scaffoldMessenger, 'All storage deleted');
    } catch (e) {
      AppLogger.e('Failed to delete storage: $e');
      if (!mounted) return;
      _showSnackBarWithMessenger(scaffoldMessenger, 'Error deleting storage');
    }
  }

  /// Delete user tokens (auth_token and refresh_token)
  Future<void> _deleteUserToken() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    
    try {
      await _storage.delete(key: 'auth_token');
      await _storage.delete(key: 'refresh_token');
      AppLogger.i('User tokens deleted');
      if (!mounted) return;
      _showSnackBarWithMessenger(scaffoldMessenger, 'User tokens deleted');
    } catch (e) {
      AppLogger.e('Failed to delete user tokens: $e');
      if (!mounted) return;
      _showSnackBarWithMessenger(scaffoldMessenger, 'Error deleting tokens');
    }
  }

  /// Open Talker logs screen
  void _openTalker() {
    // Note: Talker integration is not currently set up in this project
    // This is a placeholder for future implementation
    AppLogger.w('Talker screen not yet implemented');
    _showSnackBar('Talker screen not yet implemented');
  }

  /// Show dialog to manually set user token
  Future<void> _setUserTokenManual() async {
    final controller = TextEditingController();
    
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Set User Token'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Auth Token',
            hintText: 'Enter token value',
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    
    if (result == true && controller.text.isNotEmpty) {
      final scaffoldMessenger = ScaffoldMessenger.of(context);
      
      try {
        await _storage.write(key: 'auth_token', value: controller.text);
        AppLogger.i('User token saved manually');
        if (!mounted) return;
        _showSnackBarWithMessenger(scaffoldMessenger, 'Token saved successfully');
      } catch (e) {
        AppLogger.e('Failed to save token: $e');
        if (!mounted) return;
        _showSnackBarWithMessenger(scaffoldMessenger, 'Error saving token');
      }
    }
    
    controller.dispose();
  }

  /// Show SnackBar with message
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  /// Show SnackBar using captured ScaffoldMessenger (for async operations)
  void _showSnackBarWithMessenger(ScaffoldMessengerState messenger, String message) {
    messenger.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
