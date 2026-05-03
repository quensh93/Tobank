import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';
import 'package:tobank_sdui/core/stac/builders/stac_stateful_widget.dart';

const List<String> _ibanValues = [
  '830700001000117894304001',
  '490100000000340340070004',
  '980640011070075034070001',
  '240750005151124000000156',
  '860130100000003318427752',
];

const List<String> _ibanNames = [
  'سجاد رحمانی پور',
  'مینا عاشوری',
  'محسن مقدم',
  'یکانه سادات ترابی خرق',
  'سید پارسا بنی طبا',
];

const List<String> _ibanVisibleKeys = [
  'transferApiIbanVisible1',
  'transferApiIbanVisible2',
  'transferApiIbanVisible3',
  'transferApiIbanVisible4',
  'transferApiIbanVisible5',
];

@StacScreen(screenName: 'transfer_real_amount')
StacWidget transferRealAmount() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {'key': 'transferApiTabIban', 'value': true},
        {'key': 'transferApiTabInBank', 'value': false},
        {'key': 'transferApiTabCard', 'value': false},
        {'key': 'transferApiContinueEnabled', 'value': false},
        {'key': 'transferApiIsSearching', 'value': false},
        {'key': 'transferApiIbanVisible1', 'value': true},
        {'key': 'transferApiIbanVisible2', 'value': true},
        {'key': 'transferApiIbanVisible3', 'value': true},
        {'key': 'transferApiIbanVisible4', 'value': true},
        {'key': 'transferApiIbanVisible5', 'value': true},
      ],
    ),
    child: StacScaffold(
      backgroundColor: '{{appColors.current.background.surface}}',
      appBar: StacAppBar(
        title: StacText(
          data: 'انتقال وجه',
          textDirection: StacTextDirection.rtl,
          style: StacAliasTextStyle('{{appStyles.appbarStyle}}'),
        ),
        centerTitle: true,
        leading: StacIconButton(
          onPressed: const StacNavigateAction(
            navigationStyle: NavigationStyle.pop,
          ),
          icon: StacImage(
            src: '{{appAssets.icons.arrowRight}}',
            imageType: StacImageType.asset,
            width: 24,
            height: 24,
            color: '{{appColors.current.text.title}}',
          ),
        ),
      ),
      body: StacPadding(
        padding: StacEdgeInsets.only(left: 16, top: 16, right: 16, bottom: 23),
        child: StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          children: [
            _transferTabs(),
            StacSizedBox(height: 18),
            StacCustomVisibility(
              visible: '[[transferApiTabIban]]',
              child: _ibanInputSection().toJson(),
              replacement: StacSizedBox().toJson(),
            ),

            StacSizedBox(height: 22),
            StacExpanded(
              child: StacCustomVisibility(
                visible: '[[transferApiTabIban]]',
                child: _ibanListScrollable().toJson(),
                replacement: _otherTabContent().toJson(),
              ),
            ),
            StacSizedBox(height: 12),
            _continueButton(),
          ],
        ),
      ),
    ),
  );
}

StacWidget _transferTabs() {
  return StacContainer(
    padding: StacEdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surfaceContainer}}',
      borderRadius: StacBorderRadius.all(12),
    ),
    child: StacRow(
      textDirection: StacTextDirection.rtl,
      children: [
        _tabItem(
          label: 'بین بانکی',
          activeKey: 'transferApiTabIban',
          onTap: const StacCustomSetValueAction(
            values: [
              {'key': 'transferApiTabIban', 'value': true},
              {'key': 'transferApiTabInBank', 'value': false},
              {'key': 'transferApiTabCard', 'value': false},
            ],
          ),
        ),
        _tabDivider(),
        _tabItem(
          label: 'درون بانکی',
          activeKey: 'transferApiTabInBank',
          onTap: const StacCustomSetValueAction(
            values: [
              {'key': 'transferApiTabIban', 'value': false},
              {'key': 'transferApiTabInBank', 'value': true},
              {'key': 'transferApiTabCard', 'value': false},
            ],
          ),
        ),
        _tabDivider(),
        _tabItem(
          label: 'کارت',
          activeKey: 'transferApiTabCard',
          onTap: const StacCustomSetValueAction(
            values: [
              {'key': 'transferApiTabIban', 'value': false},
              {'key': 'transferApiTabInBank', 'value': false},
              {'key': 'transferApiTabCard', 'value': true},
            ],
          ),
        ),
      ],
    ),
  );
}

StacWidget _tabDivider() {
  return StacContainer(
    width: 1,
    height: 24,
    color: '{{appColors.current.input.borderEnabled}}',
  );
}

StacWidget _tabItem({
  required String label,
  required String activeKey,
  required StacAction onTap,
}) {
  return StacExpanded(
    child: StacGestureDetector(
      onTap: onTap,
      child: StacContainer(
        padding: StacEdgeInsets.symmetric(vertical: 10),
        child: StacColumn(
          mainAxisSize: StacMainAxisSize.min,
          children: [
            StacCustomVisibility(
              visible: '[[$activeKey]]',
              child: StacText(
                data: label,
                textDirection: StacTextDirection.rtl,
                textAlign: StacTextAlign.center,
                style: StacCustomTextStyle(
                  fontSize: 17,
                  fontWeight: StacFontWeight.w800,
                  color: '{{appColors.current.text.title}}',
                ),
              ).toJson(),
              replacement: StacText(
                data: label,
                textDirection: StacTextDirection.rtl,
                textAlign: StacTextAlign.center,
                style: StacCustomTextStyle(
                  fontSize: 17,
                  fontWeight: StacFontWeight.w500,
                  color: '{{appColors.current.text.subtitle}}',
                ),
              ).toJson(),
            ),
            StacSizedBox(height: 8),
            StacCustomVisibility(
              visible: '[[$activeKey]]',
              child: StacContainer(
                width: 56,
                height: 3,
                decoration: StacBoxDecoration(
                  color: '{{appColors.current.primary.color}}',
                  borderRadius: StacBorderRadius.all(3),
                ),
              ).toJson(),
              replacement: StacContainer(
                width: 56,
                height: 3,
                color: '#00000000',
              ).toJson(),
            ),
          ],
        ),
      ),
    ),
  );
}

StacWidget _ibanInputSection() {
  return StacColumn(
    crossAxisAlignment: StacCrossAxisAlignment.stretch,
    children: [
      StacText(
        data: 'شماره شبا',
        textDirection: StacTextDirection.rtl,
        textAlign: StacTextAlign.right,
        style: StacCustomTextStyle(
          fontSize: 19,
          fontWeight: StacFontWeight.w700,
          color: '{{appColors.current.text.title}}',
        ),
      ),
      StacSizedBox(height: 10),
      StacRawJsonWidget({
        'type': 'textFormField',
        'id': 'transferApiIbanInput',
        'textDirection': 'ltr',
        'textAlign': 'right',
        'keyboardType': 'number',
        'maxLength': 24,
        'onChanged': _filterAction().toJson(),
        'style': StacCustomTextStyle(
          fontSize: 16,
          fontWeight: StacFontWeight.w600,
          color: '{{appColors.current.text.title}}',
        ).toJson(),
        'decoration': StacInputDecoration(
          hintText: 'شماره شبا را وارد کنید',
          hintStyle: StacCustomTextStyle(
            fontSize: 16,
            fontWeight: StacFontWeight.w500,
            color: '{{appColors.current.text.hint}}',
          ),
          contentPadding: StacEdgeInsets.symmetric(
            horizontal: 16,
            vertical: 19.5,
          ),
          filled: false,
          prefixIcon: StacPadding(
            padding: StacEdgeInsets.only(
              left: 12,
              top: 10,
              right: 8,
              bottom: 10,
            ),
            child: StacText(
              data: 'IR',
              textDirection: StacTextDirection.ltr,
              style: StacCustomTextStyle(
                fontSize: 22,
                fontWeight: StacFontWeight.w700,
                color: '{{appColors.current.text.title}}',
              ),
            ),
          ),
        ).toJson(),
      }),
    ],
  );
}

StacAction _filterAction() {
  return StacRawJsonAction({
    'actionType': 'filterTransferIbanList',
    'fieldId': 'transferApiIbanInput',
    'ibanValues': _ibanValues,
    'visibleKeys': _ibanVisibleKeys,
    'continueEnabledKey': 'transferApiContinueEnabled',
    'isSearchingKey': 'transferApiIsSearching',
  });
}

StacWidget _ibanListScrollable() {
  return StacSingleChildScrollView(
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacCustomVisibility(
          visible: '[[transferApiIbanVisible1]]',
          child: StacColumn(
            children: [
              _ibanCard(
                displayIban: 'IR۸۳۰۷۰۰۰۰۱۰۰۰۱۱۷۸۹۴۳۰۴۰۰۱',
                title: 'سجاد رحمانی پور',
                rawIbanNoPrefix: _ibanValues[0],
              ),
              StacSizedBox(height: 12),
            ],
          ).toJson(),
        ),
        StacCustomVisibility(
          visible: '[[transferApiIbanVisible2]]',
          child: StacColumn(
            children: [
              _ibanCard(
                displayIban: 'IR۴۹۰۱۰۰۰۰۰۰۰۰۳۴۰۳۴۰۰۷۰۰۰۴',
                title: 'مینا عاشوری',
                rawIbanNoPrefix: _ibanValues[1],
              ),
              StacSizedBox(height: 12),
            ],
          ).toJson(),
        ),
        StacCustomVisibility(
          visible: '[[transferApiIbanVisible3]]',
          child: StacColumn(
            children: [
              _ibanCard(
                displayIban: 'IR۹۸۰۶۴۰۰۱۱۰۷۰۰۷۵۰۳۴۰۷۰۰۱',
                title: 'محسن مقدم',
                rawIbanNoPrefix: _ibanValues[2],
              ),
              StacSizedBox(height: 12),
            ],
          ).toJson(),
        ),
        StacCustomVisibility(
          visible: '[[transferApiIbanVisible4]]',
          child: StacColumn(
            children: [
              _ibanCard(
                displayIban: 'IR۲۴۰۷۵۰۰۰۵۱۵۱۱۲۴۰۰۰۰۰۰۱۵۶',
                title: 'یکانه سادات ترابی خرق',
                rawIbanNoPrefix: _ibanValues[3],
              ),
              StacSizedBox(height: 12),
            ],
          ).toJson(),
        ),
        StacCustomVisibility(
          visible: '[[transferApiIbanVisible5]]',
          child: StacColumn(
            children: [
              _ibanCard(
                displayIban: 'IR۸۶۰۱۳۰۱۰۰۰۰۰۰۰۳۳۱۸۴۲۷۵۲',
                title: 'سید پارسا بنی طبا',
                rawIbanNoPrefix: _ibanValues[4],
              ),
              StacSizedBox(height: 12),
            ],
          ).toJson(),
        ),
      ],
    ),
  );
}

StacWidget _ibanCard({
  required String displayIban,
  required String title,
  required String rawIbanNoPrefix,
}) {
  return StacGestureDetector(
    onTap: StacSequenceAction(
      actions: [
        StacCustomSetValueAction(
          key: 'transferApiIbanInput',
          value: rawIbanNoPrefix,
        ),
        StacCustomSetValueAction(
          key: 'transferApiDestinationName',
          value: title,
        ),
        StacCustomSetValueAction(
          key: 'transferApiDestinationIban',
          value: rawIbanNoPrefix,
        ),
        _filterAction(),
      ],
    ),
    child: StacContainer(
      padding: StacEdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: StacBoxDecoration(
        color: '{{appColors.current.background.surface}}',
        borderRadius: StacBorderRadius.all(11),
        border: StacBorder.all(
          color: '{{appColors.current.input.borderEnabled}}',
          width: 1,
        ),
      ),
      child: StacRow(
        textDirection: StacTextDirection.rtl,
        children: [
          StacContainer(
            width: 34,
            height: 34,
            decoration: StacBoxDecoration(
              borderRadius: StacBorderRadius.all(999),
              color: '{{appColors.current.background.surfaceContainer}}',
            ),
            child: StacCenter(
              child: StacImage(
                src: 'assets/icons/ic_gardeshgari.svg',
                imageType: StacImageType.asset,
                width: 24,
                height: 24,
              ),
            ),
          ),
          StacSizedBox(width: 10),
          StacExpanded(
            child: StacColumn(
              crossAxisAlignment: StacCrossAxisAlignment.stretch,
              children: [
                StacText(
                  data: displayIban,
                  textDirection: StacTextDirection.ltr,
                  textAlign: StacTextAlign.right,
                  style: StacCustomTextStyle(
                    fontSize: 16,
                    fontWeight: StacFontWeight.w700,
                    color: '{{appColors.current.text.title}}',
                  ),
                ),
                StacSizedBox(height: 8),
                StacText(
                  data: title,
                  textDirection: StacTextDirection.rtl,
                  textAlign: StacTextAlign.right,
                  style: StacCustomTextStyle(
                    fontSize: 15,
                    fontWeight: StacFontWeight.w500,
                    color: '{{appColors.current.text.subtitle}}',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

StacWidget _otherTabContent() {
  return StacContainer(
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surfaceContainer}}',
      borderRadius: StacBorderRadius.all(12),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
    ),
    child: StacCenter(
      child: StacText(
        data: 'این بخش در حال تکمیل است',
        textDirection: StacTextDirection.rtl,
        style: StacCustomTextStyle(
          fontSize: 14,
          fontWeight: StacFontWeight.w500,
          color: '{{appColors.current.text.subtitle}}',
        ),
      ),
    ),
  );
}

StacWidget _continueButton() {
  return StacCustomReactiveElevatedButton(
    enabledKey: 'transferApiContinueEnabled',
    onPressed: StacSequenceAction(
      actions: [
        StacRawJsonAction({
          'actionType': 'setTransferDestinationFromIban',
          'fieldId': 'transferApiIbanInput',
          'ibanValues': _ibanValues,
          'destinationNames': _ibanNames,
          'destinationIbanKey': 'transferApiDestinationIban',
          'destinationNameKey': 'transferApiDestinationName',
        }),
        const StacCustomSetValueAction(
          key: 'transferApiTransferTypeTitle',
          value: '',
        ),
        StacNavigateAction(
          routeName: 'transfer_real_details',
          navigationStyle: NavigationStyle.push,
        ),
      ],
    ),
    style: StacButtonStyle(
      fixedSize: const StacSize(999999, 57),
      shape: StacRoundedRectangleBorder(borderRadius: StacBorderRadius.all(10)),
      backgroundColor: '{{appColors.current.button.primary.backgroundColor}}',
      foregroundColor: '{{appColors.current.button.primary.foregroundColor}}',
    ).toJson(),
    disabledStyle: StacButtonStyle(
      fixedSize: const StacSize(999999, 57),
      shape: StacRoundedRectangleBorder(borderRadius: StacBorderRadius.all(10)),
      backgroundColor: '{{appColors.current.background.surfaceContainerHigh}}',
      foregroundColor: '{{appColors.current.text.hint}}',
    ).toJson(),
    child: StacText(
      data: 'ادامه',
      style: StacCustomTextStyle(
        fontSize: 18,
        fontWeight: StacFontWeight.w700,
        color: '{{appColors.current.button.primary.foregroundColor}}',
      ),
    ).toJson(),
  );
}
