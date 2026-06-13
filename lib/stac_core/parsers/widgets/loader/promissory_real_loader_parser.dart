import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import 'package:tobank_sdui/core/api/config_api/config_api.dart';
import 'package:tobank_sdui/core/helpers/logger.dart';
import 'package:tobank_sdui/stac_core/loaders/tobank_assets_loader.dart';
import 'package:tobank_sdui/stac_core/loaders/tobank_colors_loader.dart';
import 'package:tobank_sdui/stac_core/loaders/tobank_strings_loader.dart';
import 'package:tobank_sdui/stac_core/config/sdui_config.dart';

class PromissoryRealLoaderParser extends StacParser<Map<String, dynamic>> {
  const PromissoryRealLoaderParser();

  @override
  String get type => 'promissory_loader';

  @override
  Map<String, dynamic> getModel(Map<String, dynamic> json) => json;

  @override
  Widget parse(BuildContext context, Map<String, dynamic> model) {
    return const PromissoryRealLoaderScreen();
  }
}

/// The actual Flutter widget that fetches and renders SDUI from API
class PromissoryRealLoaderScreen extends StatefulWidget {
  const PromissoryRealLoaderScreen({super.key});

  @override
  State<PromissoryRealLoaderScreen> createState() =>
      _PromissoryRealLoaderScreenState();
}

class _PromissoryRealLoaderScreenState
    extends State<PromissoryRealLoaderScreen> {
  /// API service for fetching SDUI config
  late final ConfigApiService _configApiService;

  /// Loading state
  bool _isLoading = true;

  /// Error message if any
  String? _errorMessage;

  /// SDUI JSON data
  Map<String, dynamic>? _sduiData;

  @override
  void initState() {
    super.initState();
    _configApiService = ConfigApiService();
    _fetchSduiConfig();
  }

  @override
  void dispose() {
    _configApiService.dispose();
    super.dispose();
  }

  /// Load the 3 design configs (strings/colors/assets) from the REAL backend.
  ///
  /// Colors first (other configs may reference theme). Rethrows on failure so
  /// the caller can surface the block + retry UI.
  Future<void> _loadRealConfigs() async {
    await TobankColorsLoader.loadColorsFromBackend(
      _configApiService,
      forceReload: true,
    );
    await TobankStringsLoader.loadStringsFromBackend(
      _configApiService,
      forceReload: true,
    );
    await TobankAssetsLoader.loadAssetsFromBackend(
      _configApiService,
      forceReload: true,
    );
    AppLogger.ic(
      LogCategory.network,
      'Loaded 3 design configs from REAL backend for API flow',
    );
  }

  /// Fetch SDUI configuration from the API
  Future<void> _fetchSduiConfig() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // API mode: swap the 3 design configs to the REAL backend first.
      // Any failure here drops into the error/retry branch below.
      await _loadRealConfigs();

      final sduiJson = await _configApiService.fetchSduiConfig(
        pathKey: SduiConfig.loginRealSplash,
        build: SduiConfig.configBuild,
      );

      AppLogger.ic(LogCategory.network, 'SDUI config fetched successfully');

      if (mounted) {
        setState(() {
          _sduiData = sduiJson;
          _isLoading = false;
        });
      }
    } on ConfigApiException catch (e) {
      if (mounted) {
        // Log simple message without stack trace to avoid clutter in debug panel
        AppLogger.d('Failed to fetch SDUI config: ${e.message}');
        setState(() {
          _errorMessage = e.message;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        // Log unexpected errors simply too
        AppLogger.e('Unexpected error fetching SDUI config: $e');
        setState(() {
          _errorMessage = 'Unexpected error occurred';
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return _buildLoadingScreen(context);
    }

    if (_errorMessage != null) {
      return _buildErrorScreen(context);
    }

    if (_sduiData != null) {
      return _buildSduiScreen(context);
    }

    return _buildEmptyScreen(context);
  }

  /// Build loading screen
  Widget _buildLoadingScreen(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('سفته (API واقعی)'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('در حال دریافت اطلاعات...'),
          ],
        ),
      ),
    );
  }

  /// Build error screen
  Widget _buildErrorScreen(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('سفته (API واقعی)'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                'خطا در دریافت اطلاعات',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                _errorMessage ?? 'خطای ناشناخته',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
                textDirection: TextDirection.ltr,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _fetchSduiConfig,
                icon: const Icon(Icons.refresh),
                label: const Text('تلاش مجدد'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build SDUI screen from fetched JSON
  Widget _buildSduiScreen(BuildContext context) {
    try {
      // Use Stac.fromJson to build the widget from SDUI JSON
      return Stac.fromJson(_sduiData!, context) ?? const SizedBox.shrink();
    } catch (e) {
      AppLogger.ec(LogCategory.widget, 'Error rendering SDUI', e);

      return Scaffold(
        appBar: AppBar(
          title: const Text('سفته (API واقعی)'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.warning_amber_rounded,
                  size: 64,
                  color: Colors.orange,
                ),
                const SizedBox(height: 16),
                Text(
                  'خطا در نمایش صفحه',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  e.toString(),
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.ltr,
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  /// Build empty screen
  Widget _buildEmptyScreen(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('سفته (API واقعی)'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: const Center(child: Text('داده‌ای دریافت نشد')),
    );
  }
}
