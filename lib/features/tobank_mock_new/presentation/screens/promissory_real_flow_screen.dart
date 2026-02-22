import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stac/stac.dart';
import 'package:stac_core/stac_core.dart';
import '../../../../../stac/tobank/flows/promissory_real/splash/promissory_real_splash.dart'
    as splash;
import '../../../pre_launch/providers/theme_controller_provider.dart';
import '../../../../core/helpers/logger.dart';

/// Renders the Promissory Real Flow starting with Onboarding.
class PromissoryRealFlowScreen extends ConsumerWidget {
  const PromissoryRealFlowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the theme controller - this triggers rebuild when theme changes
    final themeState = ref.watch(themeControllerProvider);

    final themeMode = themeState.maybeWhen(
      data: (mode) => mode,
      orElse: () => ThemeMode.system,
    );

    AppLogger.dc(
      LogCategory.theme,
      'PromissoryRealFlowScreen rebuilding with theme: ${themeMode.name}',
    );

    final stacWidget = splash.promissoryRealSplash();
    final json = stacWidget.toJson();

    final rendered = Stac.fromJson(json, context) ?? const SizedBox.shrink();

    return rendered;
  }
}
