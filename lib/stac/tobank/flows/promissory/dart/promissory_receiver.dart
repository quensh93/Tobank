import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';

/// Promissory Flow - Receiver Information Page
///
/// This screen collects the receiver (ذینفع) information.
/// Supports both Individual (حقیقی) and Legal (حقوقی) receiver types.
///
/// Reference: docs/promissory_docs/request_promissory_receiver_page.dart
@StacScreen(screenName: 'promissory_receiver')
StacWidget promissoryReceiver() {
  return StacStatefulWidget(
    onInit: StacMultiAction(
      actions: [
        // Receiver type: true = Individual, false = Legal
        StacCustomSetValueAction(key: 'isIndividualSelected', value: true),
        StacCustomSetValueAction(key: 'isLegalSelected', value: false),
        StacCustomSetValueAction(key: 'isGardeshgariSelected', value: false),
        StacCustomSetValueAction(key: 'hasReceiverData', value: false),
      ],
    ),
    child: StacScaffold(
      appBar: StacAppBar(
        title: StacText(
          data: 'اطلاعات ذینفع',
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
      body: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacExpanded(
            child: StacSingleChildScrollView(
              padding: StacEdgeInsets.symmetric(horizontal: 16),
              child: StacColumn(
                crossAxisAlignment: StacCrossAxisAlignment.stretch,
                children: [
                  StacSizedBox(height: 16),
                  // Title
                  StacText(
                    data: 'اطلاعات ذینفع (دریافت‌کننده)',
                    textDirection: StacTextDirection.rtl,
                    style: StacCustomTextStyle(
                      fontSize: 16,
                      fontWeight: StacFontWeight.w700,
                      color: '{{appColors.current.text.title}}',
                    ),
                  ),
                  StacSizedBox(height: 16),

                  // Receiver Type Selection Row
                  StacRow(
                    textDirection: StacTextDirection.rtl,
                    children: [
                      // Individual Button
                      StacExpanded(
                        child: _buildReceiverTypeButton(
                          title: 'حقیقی',
                          selectedKey: 'isIndividualSelected',
                          otherKey: 'isLegalSelected',
                        ),
                      ),
                      StacSizedBox(width: 8),
                      // Legal Button
                      StacExpanded(
                        child: _buildReceiverTypeButton(
                          title: 'حقوقی',
                          selectedKey: 'isLegalSelected',
                          otherKey: 'isIndividualSelected',
                        ),
                      ),
                    ],
                  ),
                  StacSizedBox(height: 16),

                  // Individual Form (shown when isIndividualSelected is true)
                  StacRawJsonWidget({
                    'type': 'opacity',
                    'opacity': '{{isIndividualSelected ? 1.0 : 0.0}}',
                    'child': StacRawJsonWidget({
                      'type': 'visibility',
                      'visible': '{{isIndividualSelected}}',
                      'child': _buildIndividualForm().toJson(),
                    }).toJson(),
                  }),

                  // Legal Form (shown when isLegalSelected is true)
                  StacRawJsonWidget({
                    'type': 'opacity',
                    'opacity': '{{isLegalSelected ? 1.0 : 0.0}}',
                    'child': StacRawJsonWidget({
                      'type': 'visibility',
                      'visible': '{{isLegalSelected}}',
                      'child': _buildLegalForm().toJson(),
                    }).toJson(),
                  }),

                  StacSizedBox(height: 40),
                ],
              ),
            ),
          ),
          // Continue Button
          StacPadding(
            padding: StacEdgeInsets.all(16),
            child: StacRawJsonWidget({
              'type': 'reactiveElevatedButton',
              'enabledKey': 'hasReceiverData',
              'onPressed': {
                'actionType': 'navigate',
                'widgetType': 'promissory_data',
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
  );
}

/// Builds a receiver type selection button (Individual or Legal)
StacWidget _buildReceiverTypeButton({
  required String title,
  required String selectedKey,
  required String otherKey,
}) {
  return StacGestureDetector(
    onTap: StacMultiAction(
      actions: [
        StacCustomSetValueAction(key: selectedKey, value: true),
        StacCustomSetValueAction(key: otherKey, value: false),
      ],
    ),
    child: StacContainer(
      padding: StacEdgeInsets.symmetric(vertical: 12),
      decoration: StacBoxDecoration(
        color:
            '{{$selectedKey ? appColors.current.primary.color : appColors.current.background.surfaceContainer}}',
        borderRadius: StacBorderRadius.all(8),
        border: StacBorder.all(
          color:
              '{{$selectedKey ? appColors.current.primary.color : appColors.current.input.borderEnabled}}',
          width: 1,
        ),
      ),
      child: StacCenter(
        child: StacText(
          data: title,
          textDirection: StacTextDirection.rtl,
          style: StacCustomTextStyle(
            fontSize: 14,
            fontWeight: StacFontWeight.w600,
            color:
                '{{$selectedKey ? appColors.current.primary.onPrimary : appColors.current.text.title}}',
          ),
        ),
      ),
    ),
  );
}

/// Builds the Individual receiver form
StacWidget _buildIndividualForm() {
  return StacColumn(
    crossAxisAlignment: StacCrossAxisAlignment.stretch,
    children: [
      // National Code Field
      StacText(
        data: 'کد ملی',
        textDirection: StacTextDirection.rtl,
        style: StacCustomTextStyle(
          fontSize: 14,
          fontWeight: StacFontWeight.w600,
          color: '{{appColors.current.text.title}}',
        ),
      ),
      StacSizedBox(height: 8),
      StacTextFormField(
        id: 'receiver_national_code',
        keyboardType: StacTextInputType.number,
        textInputAction: StacTextInputAction.next,
        textDirection: StacTextDirection.ltr,
        textAlign: StacTextAlign.right,
        maxLength: 10,
        decoration: StacInputDecoration(
          hintText: 'کد ملی ذینفع را وارد نمایید',
          filled: false,
          contentPadding: StacEdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
      StacSizedBox(height: 16),

      // Mobile Number Field
      StacText(
        data: 'شماره همراه',
        textDirection: StacTextDirection.rtl,
        style: StacCustomTextStyle(
          fontSize: 14,
          fontWeight: StacFontWeight.w600,
          color: '{{appColors.current.text.title}}',
        ),
      ),
      StacSizedBox(height: 8),
      StacTextFormField(
        id: 'receiver_mobile',
        keyboardType: StacTextInputType.phone,
        textInputAction: StacTextInputAction.next,
        textDirection: StacTextDirection.ltr,
        textAlign: StacTextAlign.right,
        maxLength: 11,
        decoration: StacInputDecoration(
          hintText: 'شماره همراه ذینفع را وارد نمایید',
          filled: false,
          contentPadding: StacEdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
      StacSizedBox(height: 16),

      // Birthdate Field
      StacText(
        data: 'تاریخ تولد',
        textDirection: StacTextDirection.rtl,
        style: StacCustomTextStyle(
          fontSize: 14,
          fontWeight: StacFontWeight.w600,
          color: '{{appColors.current.text.title}}',
        ),
      ),
      StacSizedBox(height: 8),
      StacGestureDetector(
        onTap: StacRawJsonAction({
          'actionType': 'showDatePicker',
          'resultKey': 'receiverBirthdate',
        }),
        child: StacContainer(
          padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: StacBoxDecoration(
            color: '{{appColors.current.background.surfaceContainer}}',
            borderRadius: StacBorderRadius.all(10),
            border: StacBorder.all(
              color: '{{appColors.current.input.borderEnabled}}',
              width: 1,
            ),
          ),
          child: StacRow(
            textDirection: StacTextDirection.rtl,
            mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
            children: [
              StacText(
                data:
                    '{{receiverBirthdate ?? "تاریخ تولد ذینفع را انتخاب نمایید"}}',
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  fontSize: 14,
                  fontWeight: StacFontWeight.w500,
                  color: '{{appColors.current.text.subtitle}}',
                ),
              ),
              StacImage(
                src: 'assets/icons/ic_calendar.svg',
                imageType: StacImageType.asset,
                width: 24,
                height: 24,
                color: '{{appColors.current.text.subtitle}}',
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

/// Builds the Legal receiver form
StacWidget _buildLegalForm() {
  return StacColumn(
    crossAxisAlignment: StacCrossAxisAlignment.stretch,
    children: [
      // Bank Selection Toggle
      StacRow(
        textDirection: StacTextDirection.rtl,
        children: [
          // Toggle Switch
          StacGestureDetector(
            onTap: StacRawJsonAction({
              'actionType': 'setValue',
              'key': 'isGardeshgariSelected',
              'value': '{{isGardeshgariSelected ? false : true}}',
            }),
            child: StacContainer(
              width: 44,
              height: 24,
              decoration: StacBoxDecoration(
                color:
                    '{{isGardeshgariSelected ? appColors.current.primary.color : appColors.current.background.surfaceContainer}}',
                borderRadius: StacBorderRadius.all(12),
                border: StacBorder.all(
                  color:
                      '{{isGardeshgariSelected ? appColors.current.primary.color : appColors.current.input.borderEnabled}}',
                  width: 1,
                ),
              ),
              child: StacRow(
                textDirection: StacTextDirection.ltr,
                mainAxisAlignment: StacMainAxisAlignment.start,
                children: [
                  // Left spacer (visible when ON)
                  StacRawJsonWidget({
                    'type': 'sizedBox',
                    'width': '{{isGardeshgariSelected ? 20.0 : 2.0}}',
                  }),
                  // Toggle circle
                  StacContainer(
                    width: 20,
                    height: 20,
                    decoration: StacBoxDecoration(
                      shape: StacBoxShape.circle,
                      color: '#FFFFFF',
                    ),
                  ),
                ],
              ),
            ),
          ),
          StacSizedBox(width: 8),
          StacImage(
            src: 'assets/icons/ic_bank.svg',
            imageType: StacImageType.asset,
            width: 24,
            height: 24,
            color: '{{appColors.current.text.title}}',
          ),
          StacSizedBox(width: 8),
          StacExpanded(
            child: StacText(
              data: 'انتخاب بانک به عنوان ذینفع',
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 14,
                fontWeight: StacFontWeight.w600,
                color: '{{appColors.current.text.title}}',
              ),
            ),
          ),
        ],
      ),
      StacSizedBox(height: 16),

      // National ID Field
      StacText(
        data: 'شناسه ملی',
        textDirection: StacTextDirection.rtl,
        style: StacCustomTextStyle(
          fontSize: 14,
          fontWeight: StacFontWeight.w600,
          color: '{{appColors.current.text.title}}',
        ),
      ),
      StacSizedBox(height: 8),
      StacTextFormField(
        id: 'receiver_national_id',
        keyboardType: StacTextInputType.number,
        textInputAction: StacTextInputAction.next,
        textDirection: StacTextDirection.ltr,
        textAlign: StacTextAlign.right,
        maxLength: 11,
        decoration: StacInputDecoration(
          hintText: 'شناسه ملی شرکت را وارد نمایید',
          filled: false,
          contentPadding: StacEdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
      StacSizedBox(height: 16),

      // Contact Number Field
      StacText(
        data: 'شماره تماس',
        textDirection: StacTextDirection.rtl,
        style: StacCustomTextStyle(
          fontSize: 14,
          fontWeight: StacFontWeight.w600,
          color: '{{appColors.current.text.title}}',
        ),
      ),
      StacSizedBox(height: 8),
      StacTextFormField(
        id: 'receiver_contact',
        keyboardType: StacTextInputType.phone,
        textInputAction: StacTextInputAction.done,
        textDirection: StacTextDirection.ltr,
        textAlign: StacTextAlign.right,
        decoration: StacInputDecoration(
          hintText: 'شماره تماس شرکت را وارد نمایید',
          filled: false,
          contentPadding: StacEdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    ],
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
