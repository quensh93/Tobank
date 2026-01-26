import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import 'package:stac_core/stac_core.dart' hide StacTheme;
import '../../../../../core/api/config_api/config_api.dart';
import '../../../../../core/helpers/logger.dart';

/// Promissory Real Screen - SDUI screen loaded from real API
///
/// This screen fetches the UI configuration from the real configuration API
/// and renders it using the STAC framework.
///
/// Key features:
/// - Fetches SDUI JSON from real API endpoint
/// - Handles loading, error, and success states
/// - Uses ConfigApiService for network layer

/// Entry point function for StacWidgetLoader registration
/// Note: This returns a "loader" widget that shows loading state
/// The actual SDUI will be fetched and rendered by PromissoryRealScreen
@StacScreen(screenName: 'promissory_real_intro')
StacWidget promissoryRealIntro() {
  // Return a wrapper scaffold that tells the app to use our StatefulWidget
  // We use a special pattern: return a scaffold with a "flutterWidget" type
  // that the navigation system will recognize
  return StacScaffold(
    appBar: StacAppBar(
      title: StacText(
        data: 'سفته (API واقعی)',
        style: StacTextStyle(
          color: '{{appColors.current.text.title}}',
          fontSize: 18,
          fontWeight: StacFontWeight.w600,
        ),
      ),
      centerTitle: true,
      backgroundColor: '{{appColors.current.background.surface}}',
      leading: StacIconButton(
        icon: StacImage(
          src: 'assets/icons/ic_right_arrow.svg',
          imageType: StacImageType.asset,
          width: 24,
          height: 24,
          color: '{{appColors.current.text.title}}',
        ),
        onPressed: StacNavigateAction(navigationStyle: NavigationStyle.pop),
      ),
    ),
    body: StacCenter(
      child: StacColumn(
        mainAxisAlignment: StacMainAxisAlignment.center,
        children: [
          StacText(
            data: 'در حال اتصال به سرور...',
            style: StacTextStyle(
              color: '{{appColors.current.text.subtitle}}',
              fontSize: 16,
            ),
          ),
          const StacSizedBox(height: 16),
          StacText(
            data: 'این صفحه SDUI را از API واقعی دریافت می‌کند',
            style: StacTextStyle(
              color: '{{appColors.current.text.hint}}',
              fontSize: 14,
            ),
            textAlign: StacTextAlign.center,
          ),
          const StacSizedBox(height: 24),
          // Show a button to manually trigger the load in the real implementation
          StacFilledButton(
            onPressed: StacRawJsonAction({
              'actionType': 'navigate',
              'widgetType': 'promissory_real_loader',
              'navigationStyle': 'pushReplacement',
            }),
            style: StacButtonStyle(
              backgroundColor:
                  '{{appColors.current.button.primary.backgroundColor}}',
              foregroundColor:
                  '{{appColors.current.button.primary.foregroundColor}}',
              padding: StacEdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
            child: StacText(
              data: 'بارگذاری از API',
              style: StacTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

/// Helper class for JSON actions
class StacRawJsonAction extends StacAction {
  final Map<String, dynamic> _json;
  StacRawJsonAction(this._json);

  @override
  Map<String, dynamic> toJson() => _json;
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

  /// Fetch SDUI configuration from the API
  Future<void> _fetchSduiConfig() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final sduiJson = await _configApiService.fetchSduiConfig(
        pathKey: 'flutter_key_1.flutter_promissory_key_1',
        build: 1,
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
