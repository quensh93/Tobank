import 'package:stac/stac.dart';
import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';

/// Promissory Flow - Request Promissory Deposit Page
///
/// This screen allows the user to select a deposit for the promissory note.
/// Converted from BottomSheet to Page as requested.
///
/// Deposits can be:
/// 1. Provided as parameter (for static/mock data)
/// 2. Read from registry (deposits.rawData) - for real API data
/// 3. Fallback to static list if neither is available
///
/// Selected deposit is saved to form.* for persistence.
///
/// Reference: docs/promissory_docs/request_promissory_deposit_bottom_sheet.dart
@StacScreen(screenName: 'request_promissory_deposit')
StacWidget requestPromissoryDepositPage({List<Map<String, String>>? deposits}) {
  // If deposits are provided, use them directly (for static/mock data)
  if (deposits != null) {
    return _buildDepositPageWithData(deposits);
  }
  
  // For real API data, we need to make the child reactive
  // The problem: _buildReactiveDepositContent() is called once, so it reads
  // from registry at that moment. When registry changes, the widget rebuilds,
  // but _buildReactiveDepositContent() is NOT called again.
  //
  // SOLUTION: We need to make the child JSON contain a template variable that
  // conditionally changes the structure. But since _buildReactiveDepositContent()
  // returns a widget, not JSON with template variables, we need a different approach.
  //
  // The real solution: Make the child use a template variable that forces
  // re-evaluation. We can do this by using a StacRawJsonWidget with a template
  // variable in the key, and making the child JSON structure depend on that variable.
  //
  // But wait - the child JSON is still static because _buildReactiveDepositContent()
  // is called once. So we need to make _buildReactiveDepositContent() return
  // JSON with template variables, not a widget.
  //
  // Actually, the simplest solution: Make the child a StacStatefulWidget that
  // rebuilds, and use onBuild to trigger a rebuild of the child when deposits.isLoaded changes.
  // But onBuild runs after build, so that won't help.
  //
  // REAL SOLUTION: We need to make the child JSON contain a template variable
  // that conditionally changes the structure. Since we can't do that with a Dart function,
  // we need to use a different approach: Make the child use a template variable that
  // conditionally shows different widgets based on deposits.isLoaded.
  //
  // But we can't do that either because _buildReactiveDepositContent() returns a widget.
  //
  // FINAL SOLUTION: We need to make _buildReactiveDepositContent() return JSON
  // with template variables, not a widget. But that's complex.
  //
  // SIMPLER SOLUTION: Use a StacStatefulWidget that rebuilds, and make the child
  // use a template variable that forces re-evaluation. We can do this by using
  // a StacRawJsonWidget with a template variable in the key.
  return StacStatefulWidget(
    // The child will be re-parsed on each rebuild
    // We need to ensure it reads fresh data from registry
    child: _buildReactiveDepositContent(),
  );
}

/// Builds reactive deposit content that reads from registry
/// Returns a StacStatefulWidget that rebuilds when registry changes
/// The child will be re-parsed on each rebuild, and we use a helper function
/// that reads from registry to build the appropriate widget
StacWidget _buildReactiveDepositContent() {
  // Return a StacStatefulWidget that rebuilds when registry changes
  // The child is built by a function that reads from registry
  // Since the child is evaluated once, we need to ensure it reads fresh data
  // The solution: Use a StacStatefulWidget with onBuild that triggers a rebuild
  // and make the child use template variables that force re-evaluation
  return StacStatefulWidget(
    // onBuild will be called on each rebuild, but that's not enough
    // We need the child to actually read fresh data
    // The solution: Make the child a StacStatefulWidget that also rebuilds
    child: StacStatefulWidget(
      // This inner widget will rebuild when registry changes
      // The child will be re-parsed, but we need to ensure it reads fresh data
      child: _buildDepositContentFromRegistry(),
    ),
  );
}

/// Builds deposit content by reading from registry
/// CRITICAL: This function is called ONCE when the widget is created
/// When the registry changes and the widget rebuilds, this function is NOT called again
/// because the child property is evaluated once
/// 
/// SOLUTION: We need to make the child JSON contain a template variable that
/// conditionally changes the structure. But since this function returns a widget,
/// not JSON with template variables, we need a different approach.
/// 
/// The real solution: Make the child use a template variable that forces
/// the parser to re-evaluate. But we can't do that with a Dart function.
/// 
/// WORKAROUND: Use a StacStatefulWidget with onBuild that updates a trigger key,
/// and make the child depend on that trigger key via a template variable
StacWidget _buildDepositContentFromRegistry() {
  // Read from registry to determine what to show
  // NOTE: This is called ONCE when the widget is created
  final registry = StacRegistry.instance;
  final rawData = registry.getValue('deposits.rawData');
  final isLoaded = registry.getValue('deposits.isLoaded') == true;
  
  // If data is loaded, build the page with data
  if (isLoaded && rawData is List && rawData.isNotEmpty) {
    final transformedDeposits = rawData.map<Map<String, String>>((item) {
      if (item is Map) {
        return {
          'id': item['depositNumber']?.toString() ?? '',
          'title': item['depositTitle']?.toString() ?? 'سپرده',
          'depositNumber': item['depositNumber']?.toString() ?? '',
          'shabaNumber': item['depositIban']?.toString() ?? '',
        };
      }
      return {
        'id': '',
        'title': 'سپرده',
        'depositNumber': '',
        'shabaNumber': '',
      };
    }).toList();
    return _buildDepositPageWithData(transformedDeposits);
  }
  
  // Show loading state - wrapped in StacStatefulWidget so it rebuilds
  return StacStatefulWidget(
    // Use onBuild to update a trigger key when deposits.isLoaded changes
    // This will cause the widget to rebuild
    onBuild: StacRawJsonAction({
      'actionType': 'setValue',
      'key': '_deposits_content_trigger',
      'value': '{{deposits.isLoaded}}',
    }),
    child: StacScaffold(
      appBar: StacAppBar(
        title: StacText(
          data: 'انتخاب سپرده',
          textDirection: StacTextDirection.rtl,
          style: StacAliasTextStyle('{{appStyles.appbarStyle}}'),
        ),
        centerTitle: true,
        leading: StacIconButton(
          onPressed: StacNavigateAction(navigationStyle: NavigationStyle.pop),
          icon: StacImage(
            src: 'assets/icons/ic_right_arrow.svg',
            imageType: StacImageType.asset,
            width: 24,
            height: 24,
            color: '{{appColors.current.text.title}}',
          ),
        ),
      ),
      body: StacCenter(
        child: StacColumn(
          mainAxisSize: StacMainAxisSize.min,
          children: [
            StacCircularProgressIndicator(),
            StacSizedBox(height: 16),
            StacText(
              data: 'در حال دریافت لیست سپرده‌ها...',
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 16,
                color: '{{appColors.current.text.subtitle}}',
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

/// Builds the deposit page with the provided deposits data
StacWidget _buildDepositPageWithData(List<Map<String, String>> effectiveDeposits) {
  // If no deposits available, show loading state
  if (effectiveDeposits.isEmpty) {
    return StacScaffold(
      appBar: StacAppBar(
        title: StacText(
          data: 'انتخاب سپرده',
          textDirection: StacTextDirection.rtl,
          style: StacAliasTextStyle('{{appStyles.appbarStyle}}'),
        ),
        centerTitle: true,
        leading: StacIconButton(
          onPressed: StacNavigateAction(navigationStyle: NavigationStyle.pop),
          icon: StacImage(
            src: 'assets/icons/ic_right_arrow.svg',
            imageType: StacImageType.asset,
            width: 24,
            height: 24,
            color: '{{appColors.current.text.title}}',
          ),
        ),
      ),
      body: StacCenter(
        child: StacColumn(
          mainAxisSize: StacMainAxisSize.min,
          children: [
            StacCircularProgressIndicator(),
            StacSizedBox(height: 16),
            StacText(
              data: 'در حال دریافت لیست سپرده‌ها...',
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 16,
                color: '{{appColors.current.text.subtitle}}',
              ),
            ),
          ],
        ),
      ),
    );
  }
  return StacStatefulWidget(
    // On init, restore selection state from form.selected_deposit_id
    onInit: StacRawJsonAction({
      'actionType': 'sequence',
      'actions': [
        // Restore selection states dynamically
        ...effectiveDeposits.asMap().entries.map((entry) {
          final index = entry.key;
          final id = entry.value['id'];
          return {
            'actionType': 'setValue',
            'key': 'isDeposit${index}Selected',
            'value': '{{form.selected_deposit_id == "$id"}}',
          };
        }),
        // Set hasSelection if any deposit is selected
        {
          'actionType': 'setValue',
          'key': 'hasSelection',
          'value': '{{form.selected_deposit_id ? true : false}}',
        },
      ],
    }),
    child: StacScaffold(
      appBar: StacAppBar(
        title: StacText(
          data: 'انتخاب سپرده',
          textDirection: StacTextDirection.rtl,
          style: StacAliasTextStyle('{{appStyles.appbarStyle}}'),
        ),
        centerTitle: true,
        leading: StacIconButton(
          onPressed: StacNavigateAction(navigationStyle: NavigationStyle.pop),
          icon: StacImage(
            src: 'assets/icons/ic_right_arrow.svg',
            imageType: StacImageType.asset,
            width: 24,
            height: 24,
            color: '{{appColors.current.text.title}}',
          ),
        ),
      ),
      body: StacForm(
        autovalidateMode: StacAutovalidateMode.disabled,
        child: StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          children: [
            StacSizedBox(height: 24),
            // Title
            StacPadding(
              padding: StacEdgeInsets.symmetric(horizontal: 16),
              child: StacText(
                data: 'سپرده خود را جهت صدور سفته انتخاب کنید',
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  fontSize: 16,
                  fontWeight: StacFontWeight.w600,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
            ),
            StacSizedBox(height: 16),

            // Deposit List
            StacExpanded(
              child: StacSingleChildScrollView(
                padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: StacColumn(
                  crossAxisAlignment: StacCrossAxisAlignment.stretch,
                  children: [
                    // Dynamic Deposit List
                    ...effectiveDeposits
                        .asMap()
                        .entries
                        .map(
                          (entry) => StacColumn(
                            crossAxisAlignment: StacCrossAxisAlignment.stretch,
                            children: [
                              _buildDepositCard(
                                index: entry.key,
                                deposit: entry.value,
                                totalCount: effectiveDeposits.length,
                              ),
                              if (entry.key < effectiveDeposits.length - 1)
                                StacSizedBox(height: 16),
                            ],
                          ),
                        )
                        .toList(),
                  ],
                ),
              ),
            ),

            // Continue Button
            StacPadding(
              padding: StacEdgeInsets.all(16),
              child: StacRawJsonWidget({
                'type': 'reactiveElevatedButton',
                'enabledKey': 'hasSelection',
                'onPressed': {
                  'actionType': 'navigate',
                  'widgetType': 'promissory_issuer',
                  'navigationStyle': 'push',
                },
                'style': StacButtonStyle(
                  backgroundColor: '{{appColors.current.primary.color}}',
                  elevation: 0,
                  fixedSize: StacSize(999999, 56),
                  shape: StacRoundedRectangleBorder(
                    borderRadius: StacBorderRadius.all(12),
                  ),
                ).toJson(),
                'child': StacText(
                  data: '{{appStrings.common.continue}}',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 18,
                    fontWeight: StacFontWeight.bold,
                    color: '{{appColors.current.primary.onPrimary}}',
                  ),
                ).toJson(),
              }),
            ),
          ],
        ),
      ),
    ),
  );
}

/// Builds a deposit item card widget
/// Saves selection to form.* prefix for persistence
StacWidget _buildDepositCard({
  required int index,
  required Map<String, String> deposit,
  required int totalCount,
}) {
  final String id = deposit['id']!;
  final String title = deposit['title']!;
  final String depositNumber = deposit['depositNumber']!;
  // Safely handle optional shabaNumber or empty string
  final String shabaNumber = deposit['shabaNumber'] ?? '';
  final String selectedKey = 'isDeposit${index}Selected';

  return StacGestureDetector(
    onTap: StacMultiAction(
      actions: [
        // Reset all selections dynamically
        ...List.generate(
          totalCount,
          (i) => StacCustomSetValueAction(
            key: 'isDeposit${i}Selected',
            value: false,
          ),
        ),
        // Set this one as selected
        StacCustomSetValueAction(key: selectedKey, value: true),
        // Enable button
        StacCustomSetValueAction(key: 'hasSelection', value: true),
        // Save deposit info to form.* for persistence (like login page)
        StacCustomSetValueAction(key: 'form.selected_deposit_id', value: id),
        StacCustomSetValueAction(
          key: 'form.selected_deposit_title',
          value: title,
        ),
        StacCustomSetValueAction(
          key: 'form.selected_deposit_number',
          value: depositNumber,
        ),
        StacCustomSetValueAction(
          key: 'form.selected_shaba_number',
          value: shabaNumber,
        ),
      ],
    ),
    child: StacContainer(
      decoration: StacBoxDecoration(
        color: '{{appColors.current.background.surfaceContainer}}',
        borderRadius: StacBorderRadius.all(8),
        border: StacBorder.all(
          color:
              '{{$selectedKey ? appColors.current.primary.color : appColors.current.input.borderEnabled}}',
          width: 1,
        ),
      ),
      padding: StacEdgeInsets.all(16),
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          // Top Row: Title on right + Radio Button on left (in RTL)
          StacRow(
            textDirection: StacTextDirection.rtl,
            mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
            crossAxisAlignment: StacCrossAxisAlignment.center,
            children: [
              // Title (on right in RTL)
              StacExpanded(
                child: StacText(
                  data: title,
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 16,
                    fontWeight: StacFontWeight.w600,
                    color: '{{appColors.current.text.title}}',
                  ),
                ),
              ),
              // Radio Button (on left in RTL)
              StacContainer(
                width: 24,
                height: 24,
                decoration: StacBoxDecoration(
                  shape: StacBoxShape.circle,
                  border: StacBorder.all(
                    color:
                        '{{$selectedKey ? appColors.current.primary.color : appColors.current.text.subtitle}}',
                    width: 2,
                  ),
                ),
                child: StacCenter(
                  child: StacRawJsonWidget({
                    'type': 'opacity',
                    'opacity': '{{$selectedKey ? 1.0 : 0.0}}',
                    'child': StacContainer(
                      width: 12,
                      height: 12,
                      decoration: StacBoxDecoration(
                        shape: StacBoxShape.circle,
                        color: '{{appColors.current.primary.color}}',
                      ),
                    ).toJson(),
                  }),
                ),
              ),
            ],
          ),
          StacSizedBox(height: 12),
          // Divider
          StacContainer(
            height: 1,
            color: '{{appColors.current.input.borderEnabled}}',
          ),
          StacSizedBox(height: 12),
          // Deposit Number Row
          StacRow(
            textDirection: StacTextDirection.rtl,
            children: [
              StacText(
                data: 'شماره سپرده: ',
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  fontSize: 14,
                  fontWeight: StacFontWeight.w400,
                  color: '{{appColors.current.text.subtitle}}',
                ),
              ),
              StacText(
                data: depositNumber,
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  fontSize: 14,
                  fontWeight: StacFontWeight.w500,
                  color: '{{appColors.current.text.subtitle}}',
                ),
              ),
            ],
          ),
          StacSizedBox(height: 8),
          // Shaba Number Row
          StacRow(
            textDirection: StacTextDirection.rtl,
            children: [
              StacText(
                data: 'شماره شبا: ',
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  fontSize: 14,
                  fontWeight: StacFontWeight.w400,
                  color: '{{appColors.current.text.subtitle}}',
                ),
              ),
              StacExpanded(
                child: StacText(
                  data: shabaNumber,
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 14,
                    fontWeight: StacFontWeight.w500,
                    color: '{{appColors.current.text.subtitle}}',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

/// Custom class to support alias text styles
class StacAliasTextStyle implements StacTextStyle {
  final String alias;
  const StacAliasTextStyle(this.alias);
  @override
  StacTextStyleType get type => StacTextStyleType.custom;
  @override
  Map<String, dynamic> toJson() => {'type': 'alias', 'value': alias};
}

/// Raw JSON widget helper
class StacRawJsonWidget implements StacWidget {
  final Map<String, dynamic> json;
  StacRawJsonWidget(this.json);

  @override
  Map<String, dynamic> get jsonData => json;

  @override
  Map<String, dynamic> toJson() => json;

  @override
  String get type => json['type'] as String;

  String? get id => json['id'] as String?;
}

/// Raw JSON action helper
class StacRawJsonAction extends StacAction {
  final Map<String, dynamic> json;
  StacRawJsonAction(this.json);

  @override
  String get actionType => json['actionType'] as String;

  @override
  Map<String, dynamic> toJson() => json;
}
