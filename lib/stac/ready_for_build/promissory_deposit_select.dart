import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';

/// Promissory Flow - Request Promissory Deposit Page
///
/// This screen allows the user to select a deposit for the promissory note.
/// Converted from BottomSheet to Page as requested.
///
/// Deposits are stored in: api/deposits_data.json
/// Selected deposit is saved to form.* for persistence.
///
/// Reference: docs/promissory_docs/request_promissory_deposit_bottom_sheet.dart
@StacScreen(screenName: 'promissory_deposit_select')
StacWidget promissoryDepositSelectPage() {
  // Define deposit data as a constant list (matches deposits_data.json)
  const deposits = [
    {
      'id': 'dep_001',
      'title': 'حساب جاری اصلی',
      'depositNumber': '۱۲۳۴۵۶۷۸۹۰',
      'shabaNumber': 'IR۱۲۱۰۱۲۳۴۵۶۷۸۹۰۱۲۳۴۵۶۷۸۹۰۱',
    },
    {
      'id': 'dep_002',
      'title': 'حساب پس‌انداز',
      'depositNumber': '۰۹۸۷۶۵۰۴۳۲۱',
      'shabaNumber': 'IR۱۲۱۰۰۰۹۸۷۶۵۰۴۳۲۱۰۹۸۷۶۵۰۴۳۲۱۰',
    },
    {
      'id': 'dep_003',
      'title': 'حساب قرض‌الحسنه',
      'depositNumber': '۱۱۲۲۳۳۴۴۵۵',
      'shabaNumber': 'IR۱۲۱۰۱۱۲۲۳۳۴۴۵۵۰۱۱۲۲۳۳۴۴۵۵۶',
    },
  ];

  return StacStatefulWidget(
    // On init, restore selection state from form.selected_deposit_id
    // On init, restore selection state from form.selected_deposit_id
    // On init, restore selection state from form.selected_deposit_id
    onInit: StacRawJsonAction({
      'actionType': 'sequence',
      'actions': [
        // Restore selection states based on saved deposit ID in form
        {
          'actionType': 'setValue',
          'key': 'isDeposit0Selected',
          'value': '{{form.selected_deposit_id == "dep_001"}}',
        },
        {
          'actionType': 'setValue',
          'key': 'isDeposit1Selected',
          'value': '{{form.selected_deposit_id == "dep_002"}}',
        },
        {
          'actionType': 'setValue',
          'key': 'isDeposit2Selected',
          'value': '{{form.selected_deposit_id == "dep_003"}}',
        },
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
                    // Deposit Card 1
                    _buildDepositCard(index: 0, deposit: deposits[0]),
                    StacSizedBox(height: 16),
                    // Deposit Card 2
                    _buildDepositCard(index: 1, deposit: deposits[1]),
                    StacSizedBox(height: 16),
                    // Deposit Card 3
                    _buildDepositCard(index: 2, deposit: deposits[2]),
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
                  'widgetType': 'promissory_sign',
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
}) {
  final String id = deposit['id']!;
  final String title = deposit['title']!;
  final String depositNumber = deposit['depositNumber']!;
  final String shabaNumber = deposit['shabaNumber']!;
  final String selectedKey = 'isDeposit${index}Selected';

  return StacGestureDetector(
    onTap: StacMultiAction(
      actions: [
        // Reset all selections
        StacCustomSetValueAction(key: 'isDeposit0Selected', value: false),
        StacCustomSetValueAction(key: 'isDeposit1Selected', value: false),
        StacCustomSetValueAction(key: 'isDeposit2Selected', value: false),
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
              StacText(
                data: title,
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  fontSize: 16,
                  fontWeight: StacFontWeight.w600,
                  color: '{{appColors.current.text.title}}',
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
