import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stac/stac.dart';
import 'package:tobank_sdui/core/stac/flow/flow_manager.dart';
import 'package:tobank_sdui/core/stac/services/widget/stac_widget_loader.dart';

/// Login Flow Overview Screen - Shows flow steps from config and allows running the flow
///
/// This screen reads from login_flow_config.json and:
/// 1. Displays flow info (title, description)
/// 2. Shows all steps (from config array order)
/// 3. Allows tapping individual steps or starting the full flow
class LoginFlowScreen extends StatefulWidget {
  final String configPath;
  final bool useApiPath;

  const LoginFlowScreen({
    super.key,
    this.configPath =
        'lib/stac/tobank/flows/login_flow/json/login_flow_config.json',
    this.useApiPath = false,
  });

  @override
  State<LoginFlowScreen> createState() => _LoginFlowScreenState();
}

class _LoginFlowScreenState extends State<LoginFlowScreen> {
  FlowConfig? _config;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadConfig();
  }

  Future<void> _loadConfig() async {
    try {
      final path = widget.useApiPath
          ? 'lib/stac/tobank/flows/login_flow/api/GET_login_flow_config.json'
          : widget.configPath;

      final jsonString = await rootBundle.loadString(path);
      var json = jsonDecode(jsonString) as Map<String, dynamic>;

      // If API format, extract data
      if (json.containsKey('GET')) {
        json =
            (json['GET'] as Map<String, dynamic>)['data']
                as Map<String, dynamic>;
      }

      setState(() {
        _config = FlowConfig.fromJson(json);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Error loading flow config: $e';
        _isLoading = false;
      });
    }
  }

  void _startFlow() {
    if (_config == null || _config!.steps.isEmpty) return;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FlowManagerWidget(
          configPath: widget.useApiPath
              ? 'lib/stac/tobank/flows/login_flow/api/GET_login_flow_config.json'
              : widget.configPath,
          useApiPath: widget.useApiPath,
        ),
      ),
    );
  }

  void _navigateToStep(FlowStep step) {
    // Load the step's widget and navigate to it
    final json = StacWidgetLoader.loadWidgetJson(step.widgetType);
    if (json != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Stac.fromJson(json, context) ?? const SizedBox.shrink(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF101828) : const Color(0xFFFAFAFC);
    final surfaceColor = isDark
        ? const Color(0xFF1D2939)
        : const Color(0xFFF2F4F7);
    final titleColor = isDark
        ? const Color(0xFFF9FAFB)
        : const Color(0xFF101828);
    final subtitleColor = isDark
        ? const Color(0xFFBFCCE0)
        : const Color(0xFF667085);
    final primaryColor = const Color(0xFFD61F2C);

    if (_isLoading) {
      return Scaffold(
        backgroundColor: bgColor,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_error != null) {
      return Scaffold(
        backgroundColor: bgColor,
        body: Center(
          child: Text(_error!, style: TextStyle(color: subtitleColor)),
        ),
      );
    }

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_forward_ios, color: titleColor, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          _config?.title ?? 'روند لاگین',
          style: TextStyle(
            color: titleColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Flow Description Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'توضیحات روند',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: titleColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _config?.description ?? '',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontSize: 14,
                      color: subtitleColor,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Steps Title
            Text(
              'مراحل روند (قابل تغییر از Config)',
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: titleColor,
              ),
            ),
            const SizedBox(height: 16),

            // Steps List
            Expanded(
              child: ListView.builder(
                itemCount: _config?.allSteps.length ?? 0,
                itemBuilder: (context, index) {
                  final step = _config!.allSteps[index];
                  final isEnabled = step.enabled;

                  return Column(
                    children: [
                      // Step Card
                      Opacity(
                        opacity: isEnabled ? 1.0 : 0.5,
                        child: InkWell(
                          onTap: isEnabled ? () => _navigateToStep(step) : null,
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: surfaceColor,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isEnabled
                                    ? Colors.grey.withValues(alpha: 0.3)
                                    : Colors.grey.withValues(alpha: 0.1),
                              ),
                            ),
                            child: Row(
                              textDirection: TextDirection.rtl,
                              children: [
                                // Step Number
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: isEnabled
                                        ? primaryColor
                                        : Colors.grey,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: Text(
                                      _toPersianNumber(index + 1),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                // Step Info
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          if (!isEnabled)
                                            Container(
                                              margin: const EdgeInsets.only(
                                                left: 8,
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 2,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: Colors.orange,
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: const Text(
                                                'غیرفعال',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          Text(
                                            step.title,
                                            textDirection: TextDirection.rtl,
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: titleColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        step.description,
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: subtitleColor,
                                        ),
                                      ),
                                      if (step.duration != null)
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 4,
                                          ),
                                          child: Text(
                                            '⏱ ${step.duration! ~/ 1000} ثانیه',
                                            textDirection: TextDirection.rtl,
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: primaryColor,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_back_ios,
                                  size: 16,
                                  color: subtitleColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Connector Line
                      if (index < _config!.allSteps.length - 1)
                        Row(
                          textDirection: TextDirection.rtl,
                          children: [
                            const SizedBox(width: 36),
                            Container(
                              width: 2,
                              height: 24,
                              color:
                                  isEnabled &&
                                      _config!.allSteps[index + 1].enabled
                                  ? primaryColor
                                  : Colors.grey.withValues(alpha: 0.3),
                            ),
                          ],
                        ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            // Start Flow Button
            ElevatedButton(
              onPressed: _startFlow,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'شروع روند از ابتدا',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _toPersianNumber(int number) {
    const persianDigits = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    return number.toString().split('').map((d) {
      final digit = int.tryParse(d);
      return digit != null ? persianDigits[digit] : d;
    }).join();
  }
}

class LoginFlowOverviewParser extends StacParser<Map<String, dynamic>> {
  @override
  String get type => 'loginFlowOverview';

  @override
  Map<String, dynamic> getModel(Map<String, dynamic> json) => json;

  @override
  Widget parse(BuildContext context, Map<String, dynamic> model) {
    return LoginFlowScreen(
      configPath:
          model['configPath'] ??
          'lib/stac/tobank/flows/login_flow/json/login_flow_config.json',
      useApiPath: model['useApiPath'] ?? false,
    );
  }
}
