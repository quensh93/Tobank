import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import 'package:stac_core/stac_core.dart' hide StacTheme;
import '../../../../../core/helpers/logger.dart';
import '../../promissory/dart/request_promissory_deposit_page.dart';
import 'promissory_real_service.dart';

@StacScreen(screenName: 'promissory_real_deposits')
class PromissoryRealDepositsScreen extends StatefulWidget {
  const PromissoryRealDepositsScreen({super.key});

  @override
  State<PromissoryRealDepositsScreen> createState() =>
      _PromissoryRealDepositsScreenState();
}

class _PromissoryRealDepositsScreenState
    extends State<PromissoryRealDepositsScreen> {
  final PromissoryRealService _service = PromissoryRealService();
  bool _isLoading = true;
  String? _errorMessage;
  List<Map<String, String>>? _deposits;

  @override
  void initState() {
    super.initState();
    _fetchDeposits();
  }

  Future<void> _fetchDeposits() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final deposits = await _service.getDeposits(context);

      if (mounted) {
        setState(() {
          _isLoading = false;
          if (deposits != null) {
            _deposits = deposits;
          } else {
            _errorMessage = 'Failed to load deposits';
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = e.toString();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('در حال دریافت لیست سپرده‌ها...'),
            ],
          ),
        ),
      );
    }

    if (_errorMessage != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('خطا'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 60, color: Colors.orange),
              const SizedBox(height: 16),
              Text(
                'خطا در دریافت اطلاعات:\n$_errorMessage',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _fetchDeposits,
                child: const Text('تلاش مجدد'),
              ),
            ],
          ),
        ),
      );
    }

    if (_deposits != null) {
      // Build the SDUI widget dynamically with the fetched data
      try {
        final sduiWidget = requestPromissoryDepositPage(deposits: _deposits!);
        final sduiJson = sduiWidget.toJson();

        // Render efficiently using Stac
        return Stac.fromJson(sduiJson, context) ?? const SizedBox.shrink();
      } catch (e) {
        AppLogger.ec(LogCategory.widget, 'Error building deposits SDUI', e);
        return const Scaffold(body: Center(child: Text('Error rendering UI')));
      }
    }

    return const Scaffold(body: Center(child: Text('No data available')));
  }
}
