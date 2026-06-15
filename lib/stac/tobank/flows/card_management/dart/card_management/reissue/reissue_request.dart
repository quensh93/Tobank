import 'package:stac/stac.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'card_management_reissue_request')
StacWidget dashboardCardReissueRequest() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {'key': 'cardsManagement.reissue.addressNextEnabled', 'value': false},
      ],
    ),
    child: StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildTobankFlowAppBar(title: 'صدور کارت المثنی', showBack: true, backOnRight: true),
    body: StacForm(
      child: StacSingleChildScrollView(
      padding: StacEdgeInsets.all(16),
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          _addressLabel(text: 'شهر/شهرستان'),
          StacSizedBox(height: 8),
          StacCustomTextFormField(
            id: 'reissue_city',
            textDirection: 'rtl',
            textAlign: 'right',
            initialValue: 'تهران/تهران',
            readOnly: true,
            enabled: false,
            style: {
              'color': '{{appColors.current.text.hint}}',
              'fontSize': 14,
            },
            decoration: {
              'filled': true,
              'fillColor': '{{appColors.current.background.surfaceContainerLow}}',
              'disabledBorder': {
                'type': 'outlineInputBorder',
                'borderSide': {
                  'color': '{{appColors.current.input.borderEnabled}}',
                  'width': 1,
                },
                'borderRadius': {'all': 12},
              },
              'enabledBorder': {
                'type': 'outlineInputBorder',
                'borderSide': {
                  'color': '{{appColors.current.input.borderEnabled}}',
                  'width': 1,
                },
                'borderRadius': {'all': 12},
              },
              'contentPadding': {
                'left': 16,
                'top': 16,
                'right': 16,
                'bottom': 16,
              },
            },
          ),
          StacSizedBox(height: 20),
          _addressLabel(text: 'شهرستان'),
          StacSizedBox(height: 8),
          StacCustomTextFormField(
            id: 'reissue_county',
            textDirection: 'rtl',
            textAlign: 'right',
            onChanged: _addressValidateAction(),
            decoration: {
              'hintText': 'شهرستان خود را وارد نمایید',
              'hintStyle': {
                'textDirection': 'rtl',
                'style': {
                  'color': '{{appColors.current.text.hint}}',
                  'fontSize': 14,
                },
              },
              'enabledBorder': {
                'type': 'outlineInputBorder',
                'borderSide': {
                  'color': '{{appColors.current.input.borderEnabled}}',
                  'width': 1,
                },
                'borderRadius': {'all': 12},
              },
              'focusedBorder': {
                'type': 'outlineInputBorder',
                'borderSide': {
                  'color':
                      '{{appColors.current.button.primary.backgroundColor}}',
                  'width': 1.5,
                },
                'borderRadius': {'all': 12},
              },
              'contentPadding': {
                'left': 16,
                'top': 16,
                'right': 16,
                'bottom': 16,
              },
            },
          ),
          StacSizedBox(height: 20),
          _addressLabel(text: 'خیابان اصلی'),
          StacSizedBox(height: 8),
          StacCustomTextFormField(
            id: 'reissue_street',
            textDirection: 'rtl',
            textAlign: 'right',
            onChanged: _addressValidateAction(),
            decoration: {
              'hintText': 'خیابان اصلی خود را وارد نمایید',
              'hintStyle': {
                'textDirection': 'rtl',
                'style': {
                  'color': '{{appColors.current.text.hint}}',
                  'fontSize': 14,
                },
              },
              'enabledBorder': {
                'type': 'outlineInputBorder',
                'borderSide': {
                  'color': '{{appColors.current.input.borderEnabled}}',
                  'width': 1,
                },
                'borderRadius': {'all': 12},
              },
              'focusedBorder': {
                'type': 'outlineInputBorder',
                'borderSide': {
                  'color':
                      '{{appColors.current.button.primary.backgroundColor}}',
                  'width': 1.5,
                },
                'borderRadius': {'all': 12},
              },
              'contentPadding': {
                'left': 16,
                'top': 16,
                'right': 16,
                'bottom': 16,
              },
            },
          ),
          StacSizedBox(height: 20),
          _addressLabel(text: 'خیابان فرعی'),
          StacSizedBox(height: 8),
          StacCustomTextFormField(
            id: 'reissue_alley',
            textDirection: 'rtl',
            textAlign: 'right',
            onChanged: _addressValidateAction(),
            decoration: {
              'hintText': 'خیابان فرعی خود را وارد نمایید',
              'hintStyle': {
                'textDirection': 'rtl',
                'style': {
                  'color': '{{appColors.current.text.hint}}',
                  'fontSize': 14,
                },
              },
              'enabledBorder': {
                'type': 'outlineInputBorder',
                'borderSide': {
                  'color': '{{appColors.current.input.borderEnabled}}',
                  'width': 1,
                },
                'borderRadius': {'all': 12},
              },
              'focusedBorder': {
                'type': 'outlineInputBorder',
                'borderSide': {
                  'color':
                      '{{appColors.current.button.primary.backgroundColor}}',
                  'width': 1.5,
                },
                'borderRadius': {'all': 12},
              },
              'contentPadding': {
                'left': 16,
                'top': 16,
                'right': 16,
                'bottom': 16,
              },
            },
          ),
          StacSizedBox(height: 20),
          _addressLabel(text: 'پلاک'),
          StacSizedBox(height: 8),
          StacCustomTextFormField(
            id: 'reissue_plaque',
            textDirection: 'rtl',
            textAlign: 'right',
            keyboardType: 'number',
            onChanged: _addressValidateAction(),
            decoration: {
              'hintText': 'پلاک خود را وارد نمایید',
              'hintStyle': {
                'textDirection': 'rtl',
                'style': {
                  'color': '{{appColors.current.text.hint}}',
                  'fontSize': 14,
                },
              },
              'enabledBorder': {
                'type': 'outlineInputBorder',
                'borderSide': {
                  'color': '{{appColors.current.input.borderEnabled}}',
                  'width': 1,
                },
                'borderRadius': {'all': 12},
              },
              'focusedBorder': {
                'type': 'outlineInputBorder',
                'borderSide': {
                  'color':
                      '{{appColors.current.button.primary.backgroundColor}}',
                  'width': 1.5,
                },
                'borderRadius': {'all': 12},
              },
              'contentPadding': {
                'left': 16,
                'top': 16,
                'right': 16,
                'bottom': 16,
              },
            },
          ),
          StacSizedBox(height: 20),
          _addressLabel(text: 'واحد'),
          StacSizedBox(height: 8),
          StacCustomTextFormField(
            id: 'reissue_unit',
            textDirection: 'rtl',
            textAlign: 'right',
            keyboardType: 'number',
            onChanged: _addressValidateAction(),
            decoration: {
              'hintText': 'واحد خود را وارد نمایید',
              'hintStyle': {
                'textDirection': 'rtl',
                'style': {
                  'color': '{{appColors.current.text.hint}}',
                  'fontSize': 14,
                },
              },
              'enabledBorder': {
                'type': 'outlineInputBorder',
                'borderSide': {
                  'color': '{{appColors.current.input.borderEnabled}}',
                  'width': 1,
                },
                'borderRadius': {'all': 12},
              },
              'focusedBorder': {
                'type': 'outlineInputBorder',
                'borderSide': {
                  'color':
                      '{{appColors.current.button.primary.backgroundColor}}',
                  'width': 1.5,
                },
                'borderRadius': {'all': 12},
              },
              'contentPadding': {
                'left': 16,
                'top': 16,
                'right': 16,
                'bottom': 16,
              },
            },
          ),
          StacSizedBox(height: 24),
          StacCustomReactiveElevatedButton(
            enabledKey: 'cardsManagement.reissue.addressNextEnabled',
            onPressed: NavigationAction(fileName: 'card_management_reissue_color', navMode: NavModes.dart, navigationStyle: NavigationStyle.push),
            style: StacButtonStyle(
              padding: StacEdgeInsets.symmetric(vertical: 8),
              minimumSize: const StacSize(0, 56),
              backgroundColor:
                  '{{appColors.current.button.primary.backgroundColor}}',
              foregroundColor:
                  '{{appColors.current.button.primary.foregroundColor}}',
              elevation: 0,
              shape: StacRoundedRectangleBorder(
                borderRadius: StacBorderRadius.all(8),
              ),
            ).toJson(),
            disabledStyle: StacButtonStyle(
              padding: StacEdgeInsets.symmetric(vertical: 8),
              minimumSize: const StacSize(0, 56),
              backgroundColor:
                  '{{appColors.current.background.surfaceContainerHigh}}',
              foregroundColor: '{{appColors.current.text.hint}}',
              elevation: 0,
              shape: StacRoundedRectangleBorder(
                borderRadius: StacBorderRadius.all(8),
              ),
            ).toJson(),
            child: StacText(
              data: 'تایید و ادامه',
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 14,
                fontWeight: StacFontWeight.w700,
              ),
            ).toJson(),
          ),
        ],
      ),
      ),
    ),
    ),
  );
}

StacAction _addressValidateAction() {
  return const StacValidateFieldsAction(
    resultKey: 'cardsManagement.reissue.addressNextEnabled',
    fields: [
      {'id': 'reissue_county'},
      {'id': 'reissue_street'},
      {'id': 'reissue_alley'},
      {'id': 'reissue_plaque'},
      {'id': 'reissue_unit'},
    ],
  );
}

StacWidget _addressLabel({required String text}) {
  return StacText(
    data: text,
    textDirection: StacTextDirection.rtl,
    textAlign: StacTextAlign.right,
    style: StacCustomTextStyle(
      fontSize: 14,
      fontWeight: StacFontWeight.w600,
      color: '{{appColors.current.text.title}}',
    ),
  );
}

