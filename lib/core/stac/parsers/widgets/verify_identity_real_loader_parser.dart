import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import 'package:tobank_sdui/core/api/config_api/config_api.dart';
import 'package:tobank_sdui/core/helpers/logger.dart';

class VerifyIdentityRealLoaderParser extends StacParser<Map<String, dynamic>> {
  const VerifyIdentityRealLoaderParser();

  @override
  String get type => 'verify_identity_loader';

  @override
  Map<String, dynamic> getModel(Map<String, dynamic> json) => json;

  @override
  Widget parse(BuildContext context, Map<String, dynamic> model) {
    return const VerifyIdentityRealLoaderScreen();
  }
}

/// The Flutter widget that fetches and renders verify identity SDUI from API.
class VerifyIdentityRealLoaderScreen extends StatefulWidget {
  const VerifyIdentityRealLoaderScreen({super.key});

  @override
  State<VerifyIdentityRealLoaderScreen> createState() =>
      _VerifyIdentityRealLoaderScreenState();
}

class _VerifyIdentityRealLoaderScreenState
    extends State<VerifyIdentityRealLoaderScreen> {
  late final ConfigApiService _configApiService;

  bool _isLoading = true;
  String? _errorMessage;
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

  Future<void> _fetchSduiConfig() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final sduiJson = await _configApiService.fetchSduiConfig(
        pathKey: 'ipaam.builder.form.form.verify_identity_intro',
        build: 1,
      );

      AppLogger.ic(
        LogCategory.network,
        'Verify identity SDUI config fetched successfully',
      );

      if (mounted) {
        setState(() {
          _sduiData = sduiJson;
          _isLoading = false;
        });
      }
    } on ConfigApiException catch (e) {
      if (mounted) {
        AppLogger.d(
          'Failed to fetch verify identity SDUI config: ${e.message}',
        );
        setState(() {
          _errorMessage = e.message;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        AppLogger.e(
          'Unexpected error fetching verify identity SDUI config: $e',
        );
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

  Widget _buildLoadingScreen(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('احراز هویت (API واقعی)'),
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

  Widget _buildErrorScreen(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('احراز هویت (API واقعی)'),
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

  Widget _buildSduiScreen(BuildContext context) {
    try {
      return Stac.fromJson(_sduiData!, context) ?? const SizedBox.shrink();
    } catch (e) {
      AppLogger.ec(
        LogCategory.widget,
        'Error rendering verify identity SDUI',
        e,
      );

      return Scaffold(
        appBar: AppBar(
          title: const Text('احراز هویت (API واقعی)'),
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

  Widget _buildEmptyScreen(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('احراز هویت (API واقعی)'),
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
