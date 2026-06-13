import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'gift_card_image_selector')
StacWidget giftCardRealImageSelector() {
  return StacStatefulWidget(
    onInit: const StacSetValueAction(
      values: [
        {'key': 'giftCardRealCustomImagePath', 'value': ''},
        {'key': 'giftCardRealCustomImageName', 'value': ''},
        {'key': 'giftCardRealCustomHasImage', 'value': false},
        {'key': 'giftCardRealCustomContinueEnabled', 'value': false},
      ],
    ),
    child: StacScaffold(
      backgroundColor: '{{appColors.current.background.surface}}',
      appBar: buildTobankFlowAppBar(
        showSupport: true,
        showBack: true,
        title: 'کارت هدیه',
        backAction: const StacSequenceAction(
          actions: [
            StacSetValueAction(
              values: [
                {'key': 'giftCardRealCustomImagePath', 'value': ''},
                {'key': 'giftCardRealCustomImageName', 'value': ''},
                {'key': 'giftCardRealCustomHasImage', 'value': false},
                {'key': 'giftCardRealCustomContinueEnabled', 'value': false},
              ],
            ),
            StacNavigateAction(navigationStyle: NavigationStyle.pop),
          ],
        ),
      ),
      body: StacForm(
        child: StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          children: [
            StacExpanded(
              child: StacSingleChildScrollView(
                padding: StacEdgeInsets.only(left: 16, right: 16, top: 18),
                child: StacCustomRegistryReactive(
                  child: StacColumn(
                    crossAxisAlignment: StacCrossAxisAlignment.stretch,
                    children: [
                      StacContainer(
                        decoration: StacBoxDecoration(
                          color: '{{appColors.current.background.surface}}',
                          borderRadius: StacBorderRadius.all(10),
                          border: StacBorder.all(
                            color: '{{appColors.current.input.borderEnabled}}',
                            width: 1,
                          ),
                        ),
                        child: StacPadding(
                          padding: StacEdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                          child: StacText(
                            data:
                                'بخش مورد نظر عکس خود را در کادر بدون رنگ قرار دهید',
                            textDirection: StacTextDirection.rtl,
                            textAlign: StacTextAlign.center,
                            style: StacCustomTextStyle(
                              fontSize: 14,
                              fontWeight: StacFontWeight.w600,
                              color: '{{appColors.current.text.subtitle}}',
                            ),
                          ),
                        ),
                      ),
                      StacSizedBox(height: 16),
                      StacGestureDetector(
                        onTap: StacSequenceAction(
                          actions: [
                            const StacFilePickerAction(
                              fileType: 'image',
                              targetKey: 'giftCardRealCustomImagePath',
                              hasValueKey: 'giftCardRealCustomHasImage',
                              fileNameKey: 'giftCardRealCustomImageName',
                              source: 'gallery',
                              cropImage: true,
                              cropAspectRatioX: 3,
                              cropAspectRatioY: 1,
                              previewBeforeConfirm: true,
                              previewSheetTitle:
                                  'تصویر انتخاب شده مورد تایید شما است؟',
                              confirmButtonText: 'تایید',
                              retryButtonText: 'بازگشت',
                            ),
                            StacValidateFieldsAction(
                              resultKey: 'giftCardRealCustomMessageValid',
                              fields: const [
                                {
                                  'id': 'gift_card_custom_design_message',
                                  'rule': r'^.{1,40}$',
                                },
                              ],
                            ),
                            const StacCustomSetValueAction(
                              key: 'giftCardRealCustomContinueEnabled',
                              value:
                                  '{{giftCardRealCustomHasImage ? giftCardRealCustomMessageValid : false}}',
                            ),
                          ],
                        ),
                        child: StacContainer(
                          decoration: StacBoxDecoration(
                            color: '{{appColors.current.background.surface}}',
                            borderRadius: StacBorderRadius.all(10),
                            border: StacBorder.all(
                              color:
                                  '{{appColors.current.input.borderEnabled}}',
                              width: 1,
                            ),
                          ),
                          child: StacCustomVisibility(
                            visible: '[[giftCardRealCustomHasImage]]',
                            replacement: StacPadding(
                              padding: StacEdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 22,
                              ),
                              child: StacText(
                                data: 'انتخاب عکس از گالری',
                                textDirection: StacTextDirection.rtl,
                                textAlign: StacTextAlign.center,
                                style: StacCustomTextStyle(
                                  fontSize: 17,
                                  fontWeight: StacFontWeight.w700,
                                  color: '{{appColors.current.text.title}}',
                                ),
                              ),
                            ).toJson(),
                            child: StacContainer(
                              child: _buildSelectedImagePreview(),
                            ).toJson(),
                          ),
                        ),
                      ),
                      StacCustomVisibility(
                        visible: '[[giftCardRealCustomHasImage]]',
                        child: StacPadding(
                          padding: StacEdgeInsets.only(top: 10),
                          child: StacRow(
                            textDirection: StacTextDirection.rtl,
                            mainAxisAlignment: StacMainAxisAlignment.center,
                            children: [
                              StacGestureDetector(
                                onTap: const StacCustomSetValueAction(
                                  values: [
                                    {
                                      'key': 'giftCardRealCustomImagePath',
                                      'value': '',
                                    },
                                    {
                                      'key': 'giftCardRealCustomImageName',
                                      'value': '',
                                    },
                                    {
                                      'key': 'giftCardRealCustomHasImage',
                                      'value': false,
                                    },
                                    {
                                      'key':
                                          'giftCardRealCustomContinueEnabled',
                                      'value': false,
                                    },
                                  ],
                                ),
                                child: StacRow(
                                  mainAxisSize: StacMainAxisSize.min,
                                  textDirection: StacTextDirection.rtl,
                                  children: [
                                    StacIcon(
                                      icon: 'delete_outline',
                                      size: 20,
                                      color:
                                          '{{appColors.current.primary.color}}',
                                    ),
                                    StacSizedBox(width: 6),
                                    StacText(
                                      data: 'حذف',
                                      textDirection: StacTextDirection.rtl,
                                      style: StacCustomTextStyle(
                                        fontSize: 15,
                                        fontWeight: StacFontWeight.w600,
                                        color:
                                            '{{appColors.current.primary.color}}',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ).toJson(),
                      ),
                      StacSizedBox(height: 18),
                      StacContainer(
                        height: 1,
                        color: '{{appColors.current.input.borderEnabled}}',
                      ),
                      StacSizedBox(height: 22),
                      StacText(
                        data: 'متن کارت هدیه',
                        textDirection: StacTextDirection.rtl,
                        textAlign: StacTextAlign.right,
                        style: StacCustomTextStyle(
                          fontSize: 18,
                          fontWeight: StacFontWeight.w700,
                          color: '{{appColors.current.text.title}}',
                        ),
                      ),
                      StacSizedBox(height: 14),
                      StacContainer(
                        decoration: StacBoxDecoration(
                          borderRadius: StacBorderRadius.all(12),
                          border: StacBorder.all(
                            color: '{{appColors.current.input.borderEnabled}}',
                            width: 1,
                          ),
                        ),
                        child: StacCustomTextFormField(
                          id: 'gift_card_custom_design_message',
                          textDirection: 'rtl',
                          textAlign: 'right',
                          minLines: 3,
                          maxLines: 4,
                          maxLength: 40,
                          keyboardType: 'multiline',
                          textInputAction: 'newline',
                          style: StacCustomTextStyle(
                            fontSize: 16,
                            fontWeight: StacFontWeight.w600,
                            color: '{{appColors.current.text.title}}',
                          ).toJson(),
                          decoration: StacInputDecoration(
                            hintText:
                                'متن دلخواهتان را بنویسید (تا ۴۰ کاراکتر)',
                            hintStyle: StacCustomTextStyle(
                              fontSize: 16,
                              fontWeight: StacFontWeight.w500,
                              color: '{{appColors.current.text.hint}}',
                            ),
                            filled: false,
                            contentPadding: StacEdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                          ).toJson(),
                          onChanged: StacSequenceAction(
                            actions: [
                              const StacCustomSetValueAction(
                                key: 'giftCardRealCustomMessage',
                                value: StacGetFormValueAction(
                                  id: 'gift_card_custom_design_message',
                                ),
                              ),
                              StacValidateFieldsAction(
                                resultKey: 'giftCardRealCustomMessageValid',
                                fields: const [
                                  {
                                    'id':
                                        'gift_card_custom_design_message',
                                    'rule': r'^.{1,40}$',
                                  },
                                ],
                              ),
                              const StacCustomSetValueAction(
                                key: 'giftCardRealCustomContinueEnabled',
                                value:
                                    '{{giftCardRealCustomHasImage ? giftCardRealCustomMessageValid : false}}',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ).toJson(),
                ),
              ),
            ),
            StacPadding(
              padding: StacEdgeInsets.only(left: 16, right: 16, bottom: 24),
              child: StacCustomReactiveElevatedButton(
                enabledKey: 'giftCardRealCustomContinueEnabled',
                onPressed: StacSequenceAction(
                  actions: [
                    const StacCustomSetValueAction(
                      key: 'giftCardRealCustomMessage',
                      value: StacGetFormValueAction(
                        id: 'gift_card_custom_design_message',
                      ),
                    ),
                    const StacCustomSetValueAction(
                      values: [
                        {
                          'key': 'giftCardRealFinalMessage',
                          'value': '{{giftCardRealCustomMessage}}',
                        },
                        {
                          'key': 'giftCardRealSelectedPlanImageUrl',
                          'value': '{{giftCardRealCustomImagePath}}',
                        },
                        {'key': 'giftCardRealHasSelection', 'value': false},
                        {
                          'key': 'giftCardRealCustomHasSelection',
                          'value': false,
                        },
                        {
                          'key': 'giftCardRealSelectedCategory',
                          'value': 'طرح سفارشی',
                        },
                      ],
                    ),
                    NavigationAction(fileName: 'gift_card_custom_select_design', navMode: NavModes.dart, navigationStyle: NavigationStyle.push),
                  ],
                ),
                style: StacButtonStyle(
                  fixedSize: StacSize(999999, 62),
                  backgroundColor: '{{appColors.current.primary.color}}',
                  foregroundColor: '{{appColors.current.primary.onPrimary}}',
                  shape: StacRoundedRectangleBorder(
                    borderRadius: StacBorderRadius.all(14),
                  ),
                  elevation: 0,
                ).toJson(),
                disabledStyle: StacButtonStyle(
                  fixedSize: StacSize(999999, 62),
                  backgroundColor:
                      '{{appColors.current.button.disabled.backgroundColor}}',
                  foregroundColor:
                      '{{appColors.current.button.disabled.foregroundColor}}',
                  shape: StacRoundedRectangleBorder(
                    borderRadius: StacBorderRadius.all(14),
                  ),
                  elevation: 0,
                ).toJson(),
                child: StacText(
                  data: 'ادامه',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 18,
                    fontWeight: StacFontWeight.w700,
                    color: '{{appColors.current.primary.onPrimary}}',
                  ),
                ).toJson(),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

StacWidget _buildSelectedImagePreview() {
  return StacContainer(
    clipBehavior: StacClip.hardEdge,
    decoration: StacBoxDecoration(
      borderRadius: StacBorderRadius.all(10),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
      color: '{{appColors.current.background.surface}}',
    ),
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacContainer(
          height: 45,
          padding: StacEdgeInsets.symmetric(horizontal: 8),
          color: '#F7FAFD',
          child: StacRow(
            textDirection: StacTextDirection.rtl,
            mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
            crossAxisAlignment: StacCrossAxisAlignment.center,
            children: [
              StacImage(
                src: 'assets/icons/gardeshgary.svg',
                imageType: StacImageType.asset,
                width: 120,
                height: 30,
                fit: StacBoxFit.contain,
              ),
              StacImage(
                src: 'assets/icons/shetab.svg',
                imageType: StacImageType.asset,
                width: 62,
                height: 25,
                fit: StacBoxFit.contain,
              ),
            ],
          ),
        ),
        StacSizedBox(height: 4),
        StacContainer(
          height: 118,
          child: StacRawJsonWidget({
            'type': 'registryReactive',
            'child': {
              'type': 'image',
              'src': '{{giftCardRealCustomImagePath}}',
              'registryKey': 'giftCardRealCustomImagePath',
              'fit': 'cover',
              'errorBuilder': {
                'type': 'center',
                'child': {
                  'type': 'icon',
                  'icon': 'image_outlined',
                  'size': 32,
                  'color': '{{appColors.current.text.subtitle}}',
                },
              },
            },
          }),
        ),
        StacContainer(height: 51, color: '#F7FAFD'),
      ],
    ),
  );
}

