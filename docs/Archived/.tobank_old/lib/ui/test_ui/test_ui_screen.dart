import 'package:flutter/material.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../common/custom_app_bar.dart';

class TestUIScreen extends StatelessWidget {
  const TestUIScreen({super.key});

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(
        titleString:locale.design_test,
        context: context,
      ),
      body: const SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 56,
                        child: Card(
                          elevation: 0,
                          shadowColor: Colors.transparent,
                          child: Center(child: Text('Elevation 0')),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      SizedBox(
                        height: 56,
                        child: Card(
                          elevation: 1,
                          shadowColor: Colors.transparent,
                          child: Center(child: Text('Elevation 1')),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      SizedBox(
                        height: 56,
                        child: Card(
                          elevation: 2,
                          shadowColor: Colors.transparent,
                          child: Center(child: Text('Elevation 2')),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      SizedBox(
                        height: 56,
                        child: Card(
                          elevation: 3,
                          shadowColor: Colors.transparent,
                          child: Center(child: Text('Elevation 3')),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      SizedBox(
                        height: 56,
                        child: Card(
                          elevation: 4,
                          shadowColor: Colors.transparent,
                          child: Center(child: Text('Elevation 4')),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      SizedBox(
                        height: 56,
                        child: Card(
                          elevation: 5,
                          shadowColor: Colors.transparent,
                          child: Center(child: Text('Elevation 5')),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      SizedBox(
                        height: 56,
                        child: Card(
                          elevation: 6,
                          shadowColor: Colors.transparent,
                          child: Center(child: Text('Elevation 6')),
                        ),
                      ),
                      SizedBox(height: 16.0),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
