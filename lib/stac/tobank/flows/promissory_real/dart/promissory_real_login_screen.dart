import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import 'package:stac_core/stac_core.dart' hide StacTheme;
import '../../../../../core/stac/services/widget/stac_widget_loader.dart';
import '../../../../../core/stac/services/widget/stac_widget_resolver.dart';
import '../service/promissory_real_auth_service.dart';

@StacScreen(screenName: 'promissory_real_login_form')
class PromissoryRealLoginScreen extends StatefulWidget {
  const PromissoryRealLoginScreen({super.key});

  @override
  State<PromissoryRealLoginScreen> createState() =>
      _PromissoryRealLoginScreenState();
}

class _PromissoryRealLoginScreenState extends State<PromissoryRealLoginScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers - Only needed inputs based on request
  final _mobileNumberController = TextEditingController();
  final _nationalIdController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _gpayTokenController = TextEditingController();
  final _cifController = TextEditingController();

  final PromissoryRealAuthService _authService = PromissoryRealAuthService();
  bool _isLoading = false;

  @override
  void dispose() {
    _mobileNumberController.dispose();
    _nationalIdController.dispose();
    _birthDateController.dispose();
    _gpayTokenController.dispose();
    _cifController.dispose();
    super.dispose();
  }

  Future<void> _submitFormat() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    final data = {
      "nationalId": _nationalIdController.text,
      "mobileNumber": _mobileNumberController.text,
      "gpayToken": _gpayTokenController.text,
      "birthDate": _birthDateController.text.replaceAll(
        '/',
        '',
      ), // Ensure format matches API expectation if needed
      "cif": _cifController.text,
    };

    final success = await _authService.login(context, data);

    if (mounted) {
      setState(() {
        _isLoading = false;
      });

      if (success) {
        // Success handled in service (SnackBar + Token Save)
        // Navigate to Promissory Real Receiver Screen
        if (context.mounted) {
          final widgetJson = StacWidgetLoader.loadWidgetJson(
            'promissory_real_receiver',
          );
          if (widgetJson != null) {
            final widget = StacWidgetResolver.resolveFromJson(
              context,
              widgetJson,
            );
            if (widget != null && context.mounted) {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => widget));
            }
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Basic theme colors simulation since we are not fully in STAC JSON context here
    // but we can try to use Theme.of(context) which StacApp should have set up.

    return Scaffold(
      appBar: AppBar(
        title: const Text('ورود دستی (Dynamic)'),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'لطفا اطلاعات زیر را وارد کنید',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),

                // Mobile Number
                const Text('شماره موبایل'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _mobileNumberController,
                  decoration: const InputDecoration(
                    hintText: 'مثال: 09123456789',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'شماره موبایل الزامی است';
                    if (!RegExp(r'^09\d{9}$').hasMatch(value))
                      return 'فرمت شماره موبایل صحیح نیست';
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // National Code
                const Text('کد ملی'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _nationalIdController,
                  decoration: const InputDecoration(
                    hintText: 'کد ملی 10 رقمی',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'کد ملی الزامی است';
                    if (!RegExp(r'^\d{10}$').hasMatch(value))
                      return 'کد ملی باید 10 رقم باشد';
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // GPay Token
                const Text('GPay Token'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _gpayTokenController,
                  decoration: const InputDecoration(
                    hintText: 'مثال: 1234',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'GPay Token الزامی است';
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // CIF
                const Text('CIF'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _cifController,
                  decoration: const InputDecoration(
                    hintText: 'مثال: 123',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'CIF الزامی است';
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Birth Date
                const Text('تاریخ تولد'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _birthDateController,
                  decoration: const InputDecoration(
                    hintText: 'مثال: 13700101',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    helperText: 'فرمت: سال ماه روز (۸ رقم پیوسته)',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'تاریخ تولد الزامی است';
                    // Basic length check for yyyymmdd
                    if (value.length != 8)
                      return 'تاریخ تولد باید ۸ رقم باشد (مثال: 13750101)';
                    return null;
                  },
                ),

                const SizedBox(height: 32),

                ElevatedButton(
                  onPressed: _isLoading ? null : _submitFormat,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.blueAccent, // Or theme color
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'ورود و ذخیره توکن',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
