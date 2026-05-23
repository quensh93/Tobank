import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';
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

const List<Map<String, String>> _inBankMyAccounts = [
  {'number': '۱۱۰.۹۹۹۲.۱۷۹۳۸۵۸.۱', 'title': 'سپرده سرمایه گذاری کوتاه مدت'},
  {'number': '۱۱۰.۷۹۱.۱۷۹۳۸۵۸.۱', 'title': 'حساب قرض الحسنه جاری حقیقی توبانک'},
];

const List<Map<String, String>> _inBankOtherAccounts = [
  {'number': '۱۱۰.۹۹۹۳.۷۶۳۴۰۵۰.۱', 'title': 'علیرضا حیدریان'},
  {'number': '۱۱۰.۹۹۹۲.۱۷۹۴۸۸۵.۱', 'title': 'مهدی جمشید پور'},
];

const List<Map<String, String>> _cardDestinations = [
  {
    'number': '۵۰۵۴ ۱۶۱۰ ۱۸۱۶ ۸۰۵۸',
    'title': 'سیدعلیرضا نعمتی شیل سر',
    'icon': 'assets/icons/ic_gardeshgari.svg',
  },
  {
    'number': '۵۰۵۴ ۱۶۱۷ ۰۲۸۴ ۴۶۹۱',
    'title': 'علی سینایی اصل',
    'icon': 'assets/icons/ic_gardeshgari.svg',
  },
  {
    'number': '۵۰۵۴ ۱۶۱۷ ۰۲۹۹ ۴۷۱۰',
    'title': 'گردشگری - شعبه مجازی',
    'icon': 'assets/icons/ic_gardeshgari.svg',
  },
  {
    'number': '۵۰۲۲ ۹۱۳۱ ۰۰۹۳ ۹۴۶۷',
    'title': 'ندا رحمانی پور',
    'icon': 'assets/icons/ic_iranconcert_dark.svg',
  },
  {
    'number': '۵۰۴۱ ۷۷۱۰ ۸۰۷۶ ۶۰۲۶',
    'title': 'سجاد رحمانی پور',
    'icon': 'assets/icons/ic_in.svg',
  },
];

const List<String> _cardFilterValues = [
  '5054161018168058',
  '5054161702844691',
  '5054161702994710',
  '5022913100939467',
  '5041771080766026',
];

const List<String> _cardVisibleKeys = [
  'transferApiCardVisible1',
  'transferApiCardVisible2',
  'transferApiCardVisible3',
  'transferApiCardVisible4',
  'transferApiCardVisible5',
];

const String _defaultCardSourceName = 'سجاد رحمانی پور';
const String _defaultCardSourceNumber = '۵۰۵۴ ۱۶۱۷ ۰۲۹۹ ۴۷۱۰';
const String _defaultCardSourceIcon = 'assets/icons/ic_gardeshgari.svg';

@StacScreen(screenName: 'transfer_amount')
StacWidget transferRealAmount() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {'key': 'transferApiContinueEnabled', 'value': false},
        {'key': 'transferApiIsSearching', 'value': false},
        {'key': 'transferApiIbanVisible1', 'value': true},
        {'key': 'transferApiIbanVisible2', 'value': true},
        {'key': 'transferApiIbanVisible3', 'value': true},
        {'key': 'transferApiIbanVisible4', 'value': true},
        {'key': 'transferApiIbanVisible5', 'value': true},
        {'key': 'transferApiInBankMyTab', 'value': true},
        {'key': 'transferApiInBankOthersTab', 'value': false},
        {'key': 'transferApiInBankHasText', 'value': false},
        {'key': 'transferApiCardHasText', 'value': false},
        {'key': 'transferApiCardVisible1', 'value': true},
        {'key': 'transferApiCardVisible2', 'value': true},
        {'key': 'transferApiCardVisible3', 'value': true},
        {'key': 'transferApiCardVisible4', 'value': true},
        {'key': 'transferApiCardVisible5', 'value': true},
        {'key': 'transferApiCardSourceName', 'value': _defaultCardSourceName},
        {
          'key': 'transferApiCardSourceNumber',
          'value': _defaultCardSourceNumber,
        },
        {'key': 'transferApiCardSourceIcon', 'value': _defaultCardSourceIcon},
      ],
    ),
    child: StacScaffold(
      backgroundColor: '{{appColors.current.background.surface}}',
      appBar: buildTobankFlowAppBar(
        showSupport: true,
        title: 'انتقال وجه',
      ),
      body: StacForm(
        child: StacPadding(
          padding: StacEdgeInsets.only(
            left: 16,
            top: 16,
            right: 16,
            bottom: 23,
          ),
          child: StacDefaultTabController(
            length: 3,
            initialIndex: 2,
            child: StacColumn(
              crossAxisAlignment: StacCrossAxisAlignment.stretch,
              children: [
                _transferTabs(),
                StacSizedBox(height: 18),
                StacExpanded(
                  child: StacTabBarView(
                    children: [
                      _cardTabPane(),
                      _inBankTabPane(),
                      _ibanTabPane(),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
    child: StacStack(
      children: [
        StacTabBar(
          enableFeedback: false,
          dividerColor: '#00000000',
          indicatorColor: '{{appColors.current.primary.color}}',
          indicatorWeight: 2,
          indicatorSize: StacTabBarIndicatorSize.tab,
          indicatorPadding: StacEdgeInsets.only(left: 26, top: 44, right: 26),
          labelStyle: StacCustomTextStyle(
            fontSize: 15,
            fontWeight: StacFontWeight.w700,
          ),
          unselectedLabelStyle: StacCustomTextStyle(
            fontSize: 15,
            fontWeight: StacFontWeight.w500,
          ),
          labelColor: '{{appColors.current.text.title}}',
          unselectedLabelColor: '{{appColors.current.text.subtitle}}',
          tabs: const [
            StacTab(text: 'کارت', height: 46),
            StacTab(text: 'درون بانکی', height: 46),
            StacTab(text: 'بین بانکی', height: 46),
          ],
        ),
        StacPositioned(
          top: 10,
          bottom: 10,
          left: 0,
          right: 0,
          child: StacRow(
            children: [
              StacExpanded(child: StacSizedBox()),
              StacContainer(
                width: 1,
                color: '{{appColors.current.input.borderEnabled}}',
              ),
              StacExpanded(child: StacSizedBox()),
              StacContainer(
                width: 1,
                color: '{{appColors.current.input.borderEnabled}}',
              ),
              StacExpanded(child: StacSizedBox()),
            ],
          ),
        ),
      ],
    ),
  );
}

StacWidget _ibanTabPane() {
  return StacColumn(
    crossAxisAlignment: StacCrossAxisAlignment.stretch,
    children: [
      _ibanInputSection(),
      StacSizedBox(height: 22),
      StacExpanded(child: _ibanListScrollable()),
      StacSizedBox(height: 12),
      _interBankContinueButton(),
    ],
  );
}

StacWidget _inBankTabPane() {
  return StacColumn(
    crossAxisAlignment: StacCrossAxisAlignment.stretch,
    children: [
      _inBankInputSection(),
      StacSizedBox(height: 22),
      StacExpanded(child: _inBankContent()),
      StacSizedBox(height: 12),
      _inBankContinueButton(),
    ],
  );
}

StacWidget _cardTabPane() {
  return StacColumn(
    crossAxisAlignment: StacCrossAxisAlignment.stretch,
    children: [
      _cardInputSection(),
      StacSizedBox(height: 22),
      StacExpanded(child: _cardContent()),
      StacSizedBox(height: 12),
      _cardBottomButton(),
    ],
  );
}

StacWidget _inBankInputSection() {
  return StacColumn(
    crossAxisAlignment: StacCrossAxisAlignment.stretch,
    children: [
      StacText(
        data: 'شماره حساب',
        textDirection: StacTextDirection.rtl,
        textAlign: StacTextAlign.right,
        style: StacCustomTextStyle(
          fontSize: 19,
          fontWeight: StacFontWeight.w700,
          color: '{{appColors.current.text.title}}',
        ),
      ),
      StacSizedBox(height: 10),
      StacCustomTextFormField(
        id: 'transferApiInBankAccountInput',
        textDirection: 'ltr',
        textAlign: 'right',
        keyboardType: 'number',
        maxLength: 18,
        inputFormatters: const [
          {'type': 'allow', 'rule': '[0-9.]'},
        ],
        onChanged: _inBankInputChangedAction(),
        style: StacCustomTextStyle(
          fontSize: 16,
          fontWeight: StacFontWeight.w600,
          color: '{{appColors.current.text.title}}',
        ).toJson(),
        decoration: StacInputDecoration(
          hintText: 'شماره حساب را وارد کنید',
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
          prefixIcon: StacRawJsonWidget({
            'type': 'visibility',
            'visible': '[[transferApiInBankHasText]]',
            'child': StacGestureDetector(
              onTap: _clearInBankInputAction(),
              child: StacPadding(
                padding: StacEdgeInsets.all(12),
                child: StacIcon(
                  icon: StacIcons.close,
                  size: 20,
                  color: '{{appColors.current.text.subtitle}}',
                ),
              ),
            ).toJson(),
          }),
        ).toJson(),
      ),
    ],
  );
}

StacWidget _cardInputSection() {
  return StacColumn(
    crossAxisAlignment: StacCrossAxisAlignment.stretch,
    children: [
      StacText(
        data: 'شماره کارت مقصد',
        textDirection: StacTextDirection.rtl,
        textAlign: StacTextAlign.right,
        style: StacCustomTextStyle(
          fontSize: 19,
          fontWeight: StacFontWeight.w700,
          color: '{{appColors.current.text.title}}',
        ),
      ),
      StacSizedBox(height: 10),
      StacCustomTextFormField(
        id: 'transferApiCardInput',
        textDirection: 'ltr',
        textAlign: 'right',
        keyboardType: 'number',
        maxLength: 16,
        inputFormatters: const [
          {'type': 'allow', 'rule': '[0-9]'},
        ],
        onChanged: _cardFilterAction(),
        style: StacCustomTextStyle(
          fontSize: 18,
          fontWeight: StacFontWeight.w600,
          color: '{{appColors.current.text.title}}',
        ).toJson(),
        decoration: StacInputDecoration(
          hintText: 'شماره کارت مقصد را وارد یا انتخاب کنید',
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
          prefixIcon: StacRawJsonWidget({
            'type': 'visibility',
            'visible': '[[transferApiCardHasText]]',
            'child': StacGestureDetector(
              onTap: _clearCardInputAction(),
              child: StacPadding(
                padding: StacEdgeInsets.all(12),
                child: StacIcon(
                  icon: StacIcons.close,
                  size: 20,
                  color: '{{appColors.current.text.subtitle}}',
                ),
              ),
            ).toJson(),
          }),
        ).toJson(),
      ),
    ],
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
      StacCustomTextFormField(
        id: 'transferApiIbanInput',
        textDirection: 'ltr',
        textAlign: 'left',
        keyboardType: 'number',
        maxLength: 24,
        inputFormatters: const [
          {'type': 'allow', 'rule': '[0-9]'},
        ],
        onChanged: _filterAction().toJson(),
        style: StacCustomTextStyle(
          fontSize: 16,
          fontWeight: StacFontWeight.w600,
          color: '{{appColors.current.text.title}}',
        ).toJson(),
        decoration: {
          ...StacInputDecoration(
            hintText: 'شماره شبا را وارد کنید',
            hintStyle: StacCustomTextStyle(
              fontSize: 16,
              fontWeight: StacFontWeight.w500,
              color: '{{appColors.current.text.hint}}',
            ),
            contentPadding: StacEdgeInsets.only(
              left: 8,
              right: 16,
              top: 19.5,
              bottom: 19.5,
            ),
            filled: false,
            prefixIcon: StacSizedBox(
              width: 74,
              child: StacPadding(
                padding: StacEdgeInsets.only(
                  left: 4,
                  top: 10,
                  right: 2,
                  bottom: 10,
                ),
                child: StacRow(
                  textDirection: StacTextDirection.ltr,
                  mainAxisAlignment: StacMainAxisAlignment.center,
                  children: [
                    StacText(
                      data: 'IR',
                      textDirection: StacTextDirection.ltr,
                      style: StacCustomTextStyle(
                        fontSize: 22,
                        fontWeight: StacFontWeight.w700,
                        color: '{{appColors.current.text.title}}',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            suffixIcon: StacRawJsonWidget({
              'type': 'visibility',
              'visible': '[[transferApiIsSearching]]',
              'child': StacGestureDetector(
                onTap: _clearIbanInputAction(),
                child: StacPadding(
                  padding: StacEdgeInsets.only(left: 10, right: 10),
                  child: StacIcon(
                    icon: StacIcons.close,
                    size: 19,
                    color: '{{appColors.current.text.subtitle}}',
                  ),
                ),
              ).toJson(),
              'replacement': StacSizedBox(width: 24).toJson(),
            }),
          ).toJson(),
          'hintTextDirection': 'rtl',
          'hintTextAlign': 'right',
        },
      ),
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

StacAction _clearIbanInputAction() {
  return StacSequenceAction(
    actions: [
      const StacCustomSetValueAction(
        values: [
          {'key': 'transferApiIbanInput', 'value': ''},
          {'key': 'transferApiDestinationIban', 'value': ''},
          {'key': 'transferApiDestinationName', 'value': ''},
        ],
      ),
      _filterAction(),
    ],
  );
}

StacAction _cardFilterAction() {
  return StacRawJsonAction({
    'actionType': 'filterTransferIbanList',
    'fieldId': 'transferApiCardInput',
    'ibanValues': _cardFilterValues,
    'visibleKeys': _cardVisibleKeys,
    'isSearchingKey': 'transferApiCardHasText',
  });
}

StacAction _clearCardInputAction() {
  return StacSequenceAction(
    actions: [
      const StacCustomSetValueAction(
        values: [
          {'key': 'transferApiCardInput', 'value': ''},
          {'key': 'transferApiCardDestinationNumber', 'value': ''},
          {'key': 'transferApiCardDestinationName', 'value': ''},
          {'key': 'transferApiCardDestinationIcon', 'value': ''},
        ],
      ),
      _cardFilterAction(),
    ],
  );
}

StacAction _inBankInputChangedAction() {
  return StacRawJsonAction({
    'actionType': 'setTransferInBankContinueEnabled',
    'fieldId': 'transferApiInBankAccountInput',
    'rawValueKey': 'transferApiInBankAccountRaw',
    'continueEnabledKey': 'transferApiContinueEnabled',
    'hasTextKey': 'transferApiInBankHasText',
    'destinationIbanKey': 'transferApiDestinationIban',
    'minLengthExclusive': 15,
    'maxLength': 18,
  });
}

StacAction _clearInBankInputAction() {
  return StacSequenceAction(
    actions: [
      const StacCustomSetValueAction(
        values: [
          {'key': 'transferApiInBankAccountInput', 'value': ''},
          {'key': 'transferApiInBankAccountRaw', 'value': ''},
          {'key': 'transferApiInBankHasText', 'value': false},
          {'key': 'transferApiContinueEnabled', 'value': false},
          {'key': 'transferApiDestinationIban', 'value': ''},
        ],
      ),
      _inBankInputChangedAction(),
    ],
  );
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

StacWidget _inBankContent() {
  return StacColumn(
    crossAxisAlignment: StacCrossAxisAlignment.stretch,
    children: [
      _inBankSourceTabs(),
      StacSizedBox(height: 16),
      StacExpanded(
        child: StacSingleChildScrollView(
          child: StacCustomVisibility(
            visible: '[[transferApiInBankMyTab]]',
            child: _inBankAccountList(_inBankMyAccounts).toJson(),
            replacement: _inBankAccountList(_inBankOtherAccounts).toJson(),
          ),
        ),
      ),
    ],
  );
}

StacWidget _inBankSourceTabs() {
  return StacColumn(
    crossAxisAlignment: StacCrossAxisAlignment.stretch,
    children: [
      StacRow(
        textDirection: StacTextDirection.rtl,
        children: [
          StacExpanded(
            child: StacGestureDetector(
              onTap: const StacCustomSetValueAction(
                values: [
                  {'key': 'transferApiInBankMyTab', 'value': true},
                  {'key': 'transferApiInBankOthersTab', 'value': false},
                ],
              ),
              child: StacColumn(
                children: [
                  StacRow(
                    mainAxisAlignment: StacMainAxisAlignment.center,
                    children: [
                      StacImage(
                        src: 'assets/icons/ic_person.svg',
                        imageType: StacImageType.asset,
                        width: 16,
                        height: 16,
                        color: '{{appColors.current.text.title}}',
                      ),
                      StacSizedBox(width: 6),
                      StacText(
                        data: 'حساب‌های خودم',
                        textDirection: StacTextDirection.rtl,
                        textAlign: StacTextAlign.center,
                        style: StacCustomTextStyle(
                          fontSize: 17,
                          fontWeight: StacFontWeight.w600,
                          color: '{{appColors.current.text.title}}',
                        ),
                      ),
                    ],
                  ),
                  StacSizedBox(height: 10),
                  StacCustomVisibility(
                    visible: '[[transferApiInBankMyTab]]',
                    child: StacContainer(
                      height: 3,
                      color: '{{appColors.current.primary.color}}',
                    ).toJson(),
                    replacement: StacContainer(
                      height: 3,
                      color: '#00000000',
                    ).toJson(),
                  ),
                ],
              ),
            ),
          ),
          StacExpanded(
            child: StacGestureDetector(
              onTap: const StacCustomSetValueAction(
                values: [
                  {'key': 'transferApiInBankMyTab', 'value': false},
                  {'key': 'transferApiInBankOthersTab', 'value': true},
                ],
              ),
              child: StacColumn(
                children: [
                  StacRow(
                    mainAxisAlignment: StacMainAxisAlignment.center,
                    children: [
                      StacImage(
                        src: 'assets/icons/ic_others.svg',
                        imageType: StacImageType.asset,
                        width: 16,
                        height: 16,
                        color: '{{appColors.current.text.title}}',
                      ),
                      StacSizedBox(width: 6),
                      StacText(
                        data: 'حساب‌های دیگران',
                        textDirection: StacTextDirection.rtl,
                        textAlign: StacTextAlign.center,
                        style: StacCustomTextStyle(
                          fontSize: 17,
                          fontWeight: StacFontWeight.w600,
                          color: '{{appColors.current.text.title}}',
                        ),
                      ),
                    ],
                  ),
                  StacSizedBox(height: 10),
                  StacCustomVisibility(
                    visible: '[[transferApiInBankOthersTab]]',
                    child: StacContainer(
                      height: 3,
                      color: '{{appColors.current.primary.color}}',
                    ).toJson(),
                    replacement: StacContainer(
                      height: 3,
                      color: '#00000000',
                    ).toJson(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      StacContainer(
        height: 1,
        color: '{{appColors.current.input.borderEnabled}}',
      ),
    ],
  );
}

StacWidget _inBankAccountList(List<Map<String, String>> accounts) {
  return StacColumn(
    crossAxisAlignment: StacCrossAxisAlignment.stretch,
    children: [
      for (var i = 0; i < accounts.length; i++) ...[
        _inBankAccountCard(
          accountNumber: accounts[i]['number'] ?? '',
          title: accounts[i]['title'] ?? '',
        ),
        if (i != accounts.length - 1) StacSizedBox(height: 12),
      ],
    ],
  );
}

StacWidget _inBankAccountCard({
  required String accountNumber,
  required String title,
}) {
  return StacGestureDetector(
    onTap: StacSequenceAction(
      actions: [
        StacCustomSetValueAction(
          values: [
            {'key': 'transferApiInBankAccountInput', 'value': accountNumber},
            {'key': 'transferApiDestinationIban', 'value': accountNumber},
            {'key': 'transferApiDestinationName', 'value': title},
          ],
        ),
        _inBankInputChangedAction(),
      ],
    ),
    child: StacContainer(
      padding: StacEdgeInsets.symmetric(horizontal: 14, vertical: 18),
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
        crossAxisAlignment: StacCrossAxisAlignment.start,
        children: [
          StacExpanded(
            child: StacText(
              data: accountNumber,
              textDirection: StacTextDirection.ltr,
              textAlign: StacTextAlign.right,
              style: StacCustomTextStyle(
                fontSize: 17,
                fontWeight: StacFontWeight.w700,
                color: '{{appColors.current.text.title}}',
              ),
            ),
          ),
          StacSizedBox(width: 12),
          StacExpanded(
            child: StacText(
              data: title,
              textDirection: StacTextDirection.rtl,
              textAlign: StacTextAlign.right,
              style: StacCustomTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w500,
                color: '{{appColors.current.text.subtitle}}',
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

StacWidget _cardContent() {
  return StacSingleChildScrollView(
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        for (var i = 0; i < _cardDestinations.length; i++) ...[
          StacCustomVisibility(
            visible: '[[${_cardVisibleKeys[i]}]]',
            child: _cardDestinationItem(
              cardNumber: _cardDestinations[i]['number'] ?? '',
              rawCardNumber: _cardFilterValues[i],
              title: _cardDestinations[i]['title'] ?? '',
              iconAsset:
                  _cardDestinations[i]['icon'] ??
                  'assets/icons/ic_gardeshgari.svg',
            ).toJson(),
            replacement: StacSizedBox().toJson(),
          ),
          if (i != _cardDestinations.length - 1) StacSizedBox(height: 12),
        ],
      ],
    ),
  );
}

StacWidget _cardDestinationItem({
  required String cardNumber,
  required String rawCardNumber,
  required String title,
  required String iconAsset,
}) {
  return StacGestureDetector(
    onTap: StacSequenceAction(
      actions: [
        StacCustomSetValueAction(
          values: [
            {'key': 'transferApiCardInput', 'value': rawCardNumber},
            {'key': 'transferApiCardHasText', 'value': true},
            {'key': 'transferApiDestinationIban', 'value': rawCardNumber},
            {'key': 'transferApiCardDestinationNumber', 'value': cardNumber},
            {'key': 'transferApiCardDestinationName', 'value': title},
            {'key': 'transferApiCardDestinationIcon', 'value': iconAsset},
          ],
        ),
        _cardFilterAction(),
      ],
    ),
    child: StacContainer(
      padding: StacEdgeInsets.symmetric(horizontal: 14, vertical: 16),
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
          StacImage(
            src: iconAsset,
            imageType: StacImageType.asset,
            width: 26,
            height: 26,
          ),
          StacSizedBox(width: 12),
          StacExpanded(
            child: StacColumn(
              crossAxisAlignment: StacCrossAxisAlignment.stretch,
              children: [
                StacText(
                  data: cardNumber,
                  textDirection: StacTextDirection.ltr,
                  textAlign: StacTextAlign.right,
                  style: StacCustomTextStyle(
                    fontSize: 17,
                    fontWeight: StacFontWeight.w700,
                    color: '{{appColors.current.text.title}}',
                  ),
                ),
                StacSizedBox(height: 6),
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

StacWidget _cardBottomButton() {
  return StacCustomVisibility(
    visible: '[[transferApiCardHasText]]',
    child: _cardContinueButton().toJson(),
    replacement: _cardScanButton().toJson(),
  );
}

StacWidget _cardScanButton() {
  return StacOutlinedButton(
    onPressed: StacRawJsonAction({
      'actionType': 'showTransferCardScanner',
      'fieldId': 'transferApiCardInput',
      'successAction': _cardFilterAction().toJson(),
      'failedAction': const StacCustomSnackBarAction(
        title: 'خطا',
        detail: 'اسکن کارت ناموفق بود.',
        duration: 2600,
      ).toJson(),
    }),
    style: StacButtonStyle(
      fixedSize: const StacSize(999999, 57),
      side: StacBorderSide(color: '{{appColors.current.text.title}}'),
      shape: StacRoundedRectangleBorder(borderRadius: StacBorderRadius.all(12)),
      foregroundColor: '{{appColors.current.text.title}}',
    ),
    child: StacRow(
      mainAxisAlignment: StacMainAxisAlignment.center,
      children: [
        StacText(
          data: 'اسکن کارت',
          textDirection: StacTextDirection.rtl,
          style: StacCustomTextStyle(
            fontSize: 18,
            fontWeight: StacFontWeight.w600,
            color: '{{appColors.current.text.title}}',
          ),
        ),
        StacSizedBox(width: 10),
        StacImage(
          src: 'assets/icons/ic_card_default.svg',
          imageType: StacImageType.asset,
          width: 24,
          height: 24,
          color: '{{appColors.current.text.title}}',
        ),
      ],
    ),
  );
}

StacWidget _cardContinueButton() {
  return StacFilledButton(
    onPressed: _cardContinueAction(),
    style: StacButtonStyle(
      fixedSize: const StacSize(999999, 57),
      shape: StacRoundedRectangleBorder(borderRadius: StacBorderRadius.all(12)),
      backgroundColor: '{{appColors.current.primary.color}}',
      foregroundColor: '{{appColors.current.text.onPrimary}}',
    ),
    child: StacText(
      data: 'ادامه',
      textDirection: StacTextDirection.rtl,
      style: StacCustomTextStyle(
        fontSize: 19,
        fontWeight: StacFontWeight.w700,
        color: '{{appColors.current.text.onPrimary}}',
      ),
    ),
  );
}

StacAction _cardContinueAction() {
  return StacSequenceAction(
    actions: [
      StacCustomSetValueAction(
        values: [
          {
            'key': 'transferApiCardDestinationNumber',
            'value': StacGetFormValueAction(id: 'transferApiCardInput'),
          },
          {'key': 'transferApiCardDestinationName', 'value': 'کارت مقصد'},
          {
            'key': 'transferApiCardDestinationIcon',
            'value': 'assets/icons/ic_gardeshgari.svg',
          },
        ],
      ),
      StacRawJsonAction({
        'actionType': 'validateTransferCardContinue',
        'fieldId': 'transferApiCardInput',
        'requiredLength': 16,
        'destinationCardKey': 'transferApiDestinationIban',
        'destinationDisplayNumberKey': 'transferApiCardDestinationNumber',
        'destinationNameKey': 'transferApiCardDestinationName',
        'destinationIconKey': 'transferApiCardDestinationIcon',
        'cardValues': _cardFilterValues,
        'cardDisplayValues': _cardDestinations
            .map((e) => e['number'] ?? '')
            .toList(),
        'cardNames': _cardDestinations.map((e) => e['title'] ?? '').toList(),
        'cardIcons': _cardDestinations.map((e) => e['icon'] ?? '').toList(),
        'validAction': const StacNavigateAction(
          routeName: 'transfer_card_details',
          navigationStyle: NavigationStyle.push,
        ).toJson(),
        'invalidAction': const StacCustomSnackBarAction(
          title: 'خطا',
          detail: 'شماره کارت مقصد باید ۱۶ رقم باشد.',
          duration: 2600,
        ).toJson(),
      }),
    ],
  );
}

StacWidget _interBankContinueButton() {
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
          routeName: 'transfer_details',
          navigationStyle: NavigationStyle.push,
        ),
      ],
    ),
    style: _continueButtonStyle(),
    disabledStyle: _continueButtonDisabledStyle(),
    child: _continueButtonChild().toJson(),
  );
}

StacWidget _inBankContinueButton() {
  return StacCustomReactiveElevatedButton(
    enabledKey: 'transferApiContinueEnabled',
    onPressed: const StacSequenceAction(
      actions: [
        StacCustomSetValueAction(
          key: 'transferApiTransferTypeTitle',
          value: 'درون بانکی',
        ),
        StacNavigateAction(
          routeName: 'transfer_in_bank_details',
          navigationStyle: NavigationStyle.push,
        ),
      ],
    ),
    style: _continueButtonStyle(),
    disabledStyle: _continueButtonDisabledStyle(),
    child: _continueButtonChild().toJson(),
  );
}

Map<String, dynamic> _continueButtonStyle() {
  return StacButtonStyle(
    fixedSize: const StacSize(999999, 57),
    shape: StacRoundedRectangleBorder(borderRadius: StacBorderRadius.all(10)),
    backgroundColor: '{{appColors.current.button.primary.backgroundColor}}',
    foregroundColor: '{{appColors.current.button.primary.foregroundColor}}',
  ).toJson();
}

Map<String, dynamic> _continueButtonDisabledStyle() {
  return StacButtonStyle(
    fixedSize: const StacSize(999999, 57),
    shape: StacRoundedRectangleBorder(borderRadius: StacBorderRadius.all(10)),
    backgroundColor: '{{appColors.current.background.surfaceContainerHigh}}',
    foregroundColor: '{{appColors.current.text.hint}}',
  ).toJson();
}

StacText _continueButtonChild() {
  return StacText(
    data: 'ادامه',
    style: StacCustomTextStyle(
      fontSize: 18,
      fontWeight: StacFontWeight.w700,
      color: '{{appColors.current.button.primary.foregroundColor}}',
    ),
  );
}
