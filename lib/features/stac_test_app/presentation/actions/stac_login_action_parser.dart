import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import '../../../../core/helpers/logger.dart';
import '../../../../core/stac/registry/custom_component_registry.dart';
import 'stac_login_action.dart';

/// Global navigation handler for login action
/// This allows the login action parser to trigger navigation state updates
class LoginNavigationHandler {
  static Function(String screenName)? onNavigate;

  static void setHandler(Function(String screenName) handler) {
    onNavigate = handler;
  }

  static void clearHandler() {
    onNavigate = null;
  }
}

/// Login Action Parser
///
/// Handles login authentication by:
/// 1. Getting username and password from form scope
/// 2. Validating credentials (admin/admin)
/// 3. Navigating to home on success
/// 4. Showing error dialog on failure
class StacLoginActionParser extends StacActionParser<StacLoginAction> {
  const StacLoginActionParser();

  @override
  String get actionType => 'loginAction';

  @override
  StacLoginAction getModel(Map<String, dynamic> json) =>
      StacLoginAction.fromJson(json);

  @override
  FutureOr onCall(BuildContext context, StacLoginAction model) {
    // Get form scope to access form data
    final formScope = StacFormScope.of(context);
    
    if (formScope == null) {
      AppLogger.w('LoginAction: No form scope found');
      _showErrorDialog(context, 'Form error', 'Please fill in all fields');
      return null;
    }

    // Get form values
    final username = formScope.formData['username']?.toString().trim() ?? '';
    final password = formScope.formData['password']?.toString().trim() ?? '';

    AppLogger.i('Login attempt: username=$username, password=***');

    // Validate credentials (mock: admin/admin)
    if (username == 'admin' && password == 'admin') {
      AppLogger.i('✅ Login successful');
      
      // Update screen state to home
      LoginNavigationHandler.onNavigate?.call('home');
      
      // Also trigger STAC navigation for consistency
      // Note: This won't actually navigate since we're managing state ourselves
      // But it's good to have for future compatibility
    } else {
      AppLogger.w('❌ Login failed: Invalid credentials');
      _showErrorDialog(
        context,
        'Login Failed',
        'Invalid username or password. Please try again.',
      );
    }

    return null;
  }

  /// Show error dialog
  void _showErrorDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

/// Register the login action parser
void registerLoginActionParser() {
  // Register with custom component registry
  CustomComponentRegistry.instance.registerAction(
    const StacLoginActionParser(),
  );
  
  // Also register with STAC registry so it can be found
  StacRegistry.instance.registerAction(
    const StacLoginActionParser(),
  );
  
  AppLogger.i('✅ Login action parser registered');
}

