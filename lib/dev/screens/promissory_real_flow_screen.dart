import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stac/stac.dart';
import '../../stac/tobank/flows/login/dart/login_splash.dart' as splash;
import 'package:tobank_sdui/stac_core/services/theme/theme_controller_provider.dart';
import '../../core/helpers/logger.dart';

/// Renders the Promissory Real Flow starting with Onboarding.
class PromissoryRealFlowScreen extends ConsumerWidget {
  const PromissoryRealFlowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeControllerProvider);

    final themeMode = themeState.maybeWhen(
      data: (mode) => mode,
      orElse: () => ThemeMode.system,
    );

    AppLogger.dc(
      LogCategory.theme,
      'PromissoryRealFlowScreen rebuilding with theme: ${themeMode.name}',
    );

    final stacWidget = splash.loginSplash();
    final json = stacWidget.toJson();

    final rendered = Stac.fromJson(json, context) ?? const SizedBox.shrink();

    return rendered;
  }
}

class LoginFlowJsonScreen extends StatefulWidget {
  const LoginFlowJsonScreen({super.key});

  @override
  State<LoginFlowJsonScreen> createState() => _LoginFlowJsonScreenState();
}

class _LoginFlowJsonScreenState extends State<LoginFlowJsonScreen> {
  late final Future<Map<String, dynamic>> _jsonFuture = _loadJson();

  Future<Map<String, dynamic>> _loadJson() async {
    final raw = await rootBundle.loadString(
      'lib/stac/tobank/flows/login/json/login_splash.json',
    );
    return jsonDecode(raw) as Map<String, dynamic>;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _jsonFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError || !snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(title: const Text('Main Flow JSON')),
            body: Center(
              child: Text('Failed to load login JSON: ${snapshot.error}'),
            ),
          );
        }
        return Stac.fromJson(snapshot.data!, context) ??
            const SizedBox.shrink();
      },
    );
  }
}
