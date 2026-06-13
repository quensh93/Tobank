import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import 'package:tobank_sdui/core/api/config_api/config_api.dart';
import 'package:tobank_sdui/core/helpers/logger.dart';
import 'package:tobank_sdui/stac_core/config/sdui_config.dart';

class RealConfigLoaderParser extends StacParser<Map<String, dynamic>> {
  const RealConfigLoaderParser();

  @override
  String get type => 'real_config_loader';

  @override
  Map<String, dynamic> getModel(Map<String, dynamic> json) => json;

  @override
  Widget parse(BuildContext context, Map<String, dynamic> model) {
    return RealConfigLoaderScreen(model: model);
  }
}

class RealConfigLoaderScreen extends StatefulWidget {
  const RealConfigLoaderScreen({super.key, required this.model});

  final Map<String, dynamic> model;

  @override
  State<RealConfigLoaderScreen> createState() => _RealConfigLoaderScreenState();
}

class _RealConfigLoaderScreenState extends State<RealConfigLoaderScreen> {
  late final ConfigApiService _configApiService;

  bool _isLoading = true;
  String? _errorMessage;
  Map<String, dynamic>? _sduiData;

  String get _configName => (widget.model['configName'] as String?) ?? '';
  String get _pathKey {
    final explicitPathKey = widget.model['pathKey'] as String?;
    if (explicitPathKey != null && explicitPathKey.isNotEmpty) {
      return explicitPathKey;
    }
    return SduiConfig.pathKey(_configName);
  }

  String get _title =>
      (widget.model['title'] as String?) ?? 'API Real Loader';

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
        pathKey: _pathKey,
        build: SduiConfig.configBuild,
      );

      if (!mounted) return;
      setState(() {
        _sduiData = sduiJson;
        _isLoading = false;
      });
    } on ConfigApiException catch (e) {
      if (!mounted) return;
      AppLogger.d('Failed to fetch real config $_pathKey: ${e.message}');
      setState(() {
        _errorMessage = e.message;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      AppLogger.e('Unexpected error fetching real config $_pathKey: $e');
      setState(() {
        _errorMessage = 'Unexpected error occurred';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text(_title),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_errorMessage != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(_title),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(_errorMessage!, textAlign: TextAlign.center),
          ),
        ),
      );
    }

    if (_sduiData != null) {
      return Stac.fromJson(_sduiData!, context) ?? const SizedBox.shrink();
    }

    return const SizedBox.shrink();
  }
}
