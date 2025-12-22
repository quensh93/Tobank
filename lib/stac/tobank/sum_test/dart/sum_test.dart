import 'package:stac_core/stac_core.dart';

/// Tobank Sum Test Screen - Simple calculator that adds two numbers
///
/// This screen has:
/// - Two text inputs (A and B) for entering numbers
/// - One text input (C) that shows the sum of A and B in real-time
@StacScreen(screenName: 'tobank_sum_test')
StacWidget tobankSumTestDart() {
  return StacScaffold(
    appBar: StacAppBar(
      title: StacText(
        data: 'تست جمع',
        textDirection: StacTextDirection.rtl,
        style: StacCustomTextStyle(
          fontSize: 20,
          fontWeight: StacFontWeight.bold,
          color: '{{appColors.current.text.title}}',
        ),
      ),
      centerTitle: true,
    ),
    body: StacForm(
      child: StacSingleChildScrollView(
        padding: StacEdgeInsets.all(16),
        child: StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          textDirection: StacTextDirection.rtl,
          children: [
            StacSizedBox(height: 24),
            
            // Input A
            StacText(
              data: 'A',
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w600,
                color: '{{appColors.current.text.title}}',
              ),
            ),
            StacSizedBox(height: 8),
            StacTextFormField(
              id: 'input_a',
              textDirection: StacTextDirection.rtl,
              textAlign: StacTextAlign.right,
              keyboardType: StacTextInputType.number,
              decoration: StacInputDecoration(
                hintText: 'عدد را وارد کنید',
                filled: true,
                fillColor: '{{appColors.current.background.surface}}',
                contentPadding: StacEdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                // NOTE: Border properties need to be added manually to generated JSON
              ),
              style: StacCustomTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w600,
                color: '{{appColors.current.text.title}}',
              ),
              // onChanged action will be added in JSON manually
            ),
            
            StacSizedBox(height: 24),
            
            // Input B
            StacText(
              data: 'B',
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w600,
                color: '{{appColors.current.text.title}}',
              ),
            ),
            StacSizedBox(height: 8),
            StacTextFormField(
              id: 'input_b',
              textDirection: StacTextDirection.rtl,
              textAlign: StacTextAlign.right,
              keyboardType: StacTextInputType.number,
              decoration: StacInputDecoration(
                hintText: 'عدد را وارد کنید',
                filled: true,
                fillColor: '{{appColors.current.background.surface}}',
                contentPadding: StacEdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                // NOTE: Border properties need to be added manually to generated JSON
              ),
              style: StacCustomTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w600,
                color: '{{appColors.current.text.title}}',
              ),
              // onChanged action will be added in JSON manually
            ),
            
            StacSizedBox(height: 24),
            
            // Result C
            StacText(
              data: 'C (نتیجه)',
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w600,
                color: '{{appColors.current.text.title}}',
              ),
            ),
            StacSizedBox(height: 8),
            StacTextFormField(
              id: 'input_c',
              textDirection: StacTextDirection.rtl,
              textAlign: StacTextAlign.right,
              keyboardType: StacTextInputType.number,
              readOnly: true,
              decoration: StacInputDecoration(
                hintText: 'نتیجه',
                filled: true,
                fillColor: '{{appColors.current.background.surface}}',
                contentPadding: StacEdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                // NOTE: Border properties need to be added manually to generated JSON
              ),
              style: StacCustomTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w600,
                color: '{{appColors.current.text.title}}',
              ),
            ),
            
            StacSizedBox(height: 24),
          ],
        ),
      ),
    ),
  );
}

