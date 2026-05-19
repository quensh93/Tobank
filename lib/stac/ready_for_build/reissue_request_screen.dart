import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'dashboard_card_reissue_request')
StacWidget dashboardCardReissueRequest() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildTobankFlowAppBar(title: 'صدور کارت المثنی', showBack: true),
    body: StacSingleChildScrollView(
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
            decoration: {
              'enabledBorder': {
                'type': 'outline',
                'borderSide': {
                  'color': '{{appColors.current.input.borderEnabled}}',
                  'width': 1,
                },
                'borderRadius': {'all': 12},
              },
              'focusedBorder': {
                'type': 'outline',
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
          _addressLabel(text: 'شهرستان'),
          StacSizedBox(height: 8),
          StacCustomTextFormField(
            id: 'reissue_county',
            textDirection: 'rtl',
            textAlign: 'right',
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
                'type': 'outline',
                'borderSide': {
                  'color': '{{appColors.current.input.borderEnabled}}',
                  'width': 1,
                },
                'borderRadius': {'all': 12},
              },
              'focusedBorder': {
                'type': 'outline',
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
                'type': 'outline',
                'borderSide': {
                  'color': '{{appColors.current.input.borderEnabled}}',
                  'width': 1,
                },
                'borderRadius': {'all': 12},
              },
              'focusedBorder': {
                'type': 'outline',
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
                'type': 'outline',
                'borderSide': {
                  'color': '{{appColors.current.input.borderEnabled}}',
                  'width': 1,
                },
                'borderRadius': {'all': 12},
              },
              'focusedBorder': {
                'type': 'outline',
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
                'type': 'outline',
                'borderSide': {
                  'color': '{{appColors.current.input.borderEnabled}}',
                  'width': 1,
                },
                'borderRadius': {'all': 12},
              },
              'focusedBorder': {
                'type': 'outline',
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
                'type': 'outline',
                'borderSide': {
                  'color': '{{appColors.current.input.borderEnabled}}',
                  'width': 1,
                },
                'borderRadius': {'all': 12},
              },
              'focusedBorder': {
                'type': 'outline',
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
          StacSizedBox(height: 16),
          StacGestureDetector(
            onTap: const StacCustomSnackBarAction(
              title: 'انتخاب آدرس روی نقشه (mock)',
              detail: 'این قابلیت در نسخه واقعی فعال می‌شود.',
              duration: 2000,
            ),
            child: StacRow(
              textDirection: StacTextDirection.rtl,
              mainAxisAlignment: StacMainAxisAlignment.end,
              children: [
                StacImage(
                  src: '{{appAssets.current.icons.location}}',
                  imageType: StacImageType.asset,
                  width: 20,
                  height: 20,
                  color: '{{appColors.current.button.primary.backgroundColor}}',
                ),
                StacSizedBox(width: 4),
                StacText(
                  data: 'انتخاب آدرس روی نقشه (اختیاری)',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 13,
                    fontWeight: StacFontWeight.w500,
                    color:
                        '{{appColors.current.button.primary.backgroundColor}}',
                  ),
                ),
              ],
            ),
          ),
          StacSizedBox(height: 24),
          StacFilledButton(
            onPressed: StacRawJsonAction({
              'actionType': 'navigate',
              'widgetType': 'dashboard_card_reissue_select_card_color',
              'navigationStyle': 'push',
            }),
            style: StacButtonStyle(
              padding: StacEdgeInsets.symmetric(vertical: 16),
              backgroundColor:
                  '{{appColors.current.button.primary.backgroundColor}}',
              foregroundColor:
                  '{{appColors.current.button.primary.foregroundColor}}',
              shape: StacRoundedRectangleBorder(
                borderRadius: StacBorderRadius.all(16),
              ),
            ),
            child: StacText(
              data: 'تایید و ادامه',
              textDirection: StacTextDirection.rtl,
              style: StacTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    ),
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
