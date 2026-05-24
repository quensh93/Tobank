import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';

/// First validation screen (CBS style) based on old app layout.
@StacScreen(screenName: 'tobank_login_dart')
StacWidget tobankLoginDart() {
  return StacScaffold(
    appBar: StacAppBar(
      title: StacText(
        data: 'اعتبارسنجی',
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
      actions: [
        StacIconButton(
          onPressed: const StacAction(jsonData: {'actionType': 'none'}),
          icon: StacImage(
            src: '{{appAssets.icons.support}}',
            imageType: StacImageType.asset,
            width: 24,
            height: 24,
            color: '{{appColors.current.text.title}}',
          ),
        ),
      ],
    ),
    body: StacPadding(
      padding: StacEdgeInsets.all(16),
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        textDirection: StacTextDirection.rtl,
        children: [
          StacContainer(
            padding: StacEdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: StacBoxDecoration(
              color: '{{appColors.current.background.surfaceContainer}}',
              borderRadius: StacBorderRadius.all(16),
            ),
            child: StacRow(
              textDirection: StacTextDirection.rtl,
              children: [
                StacExpanded(
                  child: StacColumn(
                    children: [
                      StacText(
                        data: 'اعتبارسنجی',
                        textDirection: StacTextDirection.rtl,
                        textAlign: StacTextAlign.center,
                        style: StacTextStyle(
                          fontSize: 18,
                          fontWeight: StacFontWeight.w700,
                          color: '{{appColors.current.text.title}}',
                        ),
                      ),
                      StacSizedBox(height: 8),
                      StacContainer(
                        width: 76,
                        height: 4,
                        decoration: StacBoxDecoration(
                          color: '#C8354E',
                          borderRadius: StacBorderRadius.all(4),
                        ),
                      ),
                    ],
                  ),
                ),
                StacContainer(
                  width: 1,
                  height: 30,
                  color: '{{appColors.current.input.borderEnabled}}',
                ),
                StacExpanded(
                  child: StacText(
                    data: 'گزارش‌ها',
                    textDirection: StacTextDirection.rtl,
                    textAlign: StacTextAlign.center,
                    style: StacTextStyle(
                      fontSize: 18,
                      fontWeight: StacFontWeight.w500,
                      color: '{{appColors.current.text.subtitle}}',
                    ),
                  ),
                ),
              ],
            ),
          ),
          StacSizedBox(height: 18),
          StacText(
            data: 'شماره سیم‌کارت',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.right,
            style: StacTextStyle(
              fontSize: 28,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(height: 12),
          StacRow(
            textDirection: StacTextDirection.rtl,
            crossAxisAlignment: StacCrossAxisAlignment.start,
            children: [
              StacExpanded(
                child: StacRawJsonWidget({
                  'type': 'textFormField',
                  'id': 'mobile_number',
                  'textDirection': 'rtl',
                  'textAlign': 'right',
                  'maxLength': 11,
                  'keyboardType': 'number',
                  'inputFormatters': [
                    {'type': 'allow', 'rule': '[0-9]'},
                  ],
                  'style': StacTextStyle(
                    fontSize: 18,
                    fontWeight: StacFontWeight.w500,
                    color: '{{appColors.current.text.title}}',
                  ).toJson(),
                  'decoration': StacInputDecoration(
                    hintText: '09123456789 مانند',
                    hintStyle: StacTextStyle(
                      fontSize: 17,
                      fontWeight: StacFontWeight.w500,
                      color: '{{appColors.current.text.subtitle}}',
                    ),
                    filled: true,
                    fillColor: '{{appColors.current.background.surface}}',
                    contentPadding: StacEdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                  ).toJson(),
                }),
              ),
              StacSizedBox(width: 10),
              _buildIconBox('assets/icons/ic_user_profile.svg'),
              StacSizedBox(width: 10),
              _buildIconBox('assets/icons/ic_contact_list.svg'),
            ],
          ),
          StacExpanded(child: StacSizedBox()),
          StacOutlinedButton(
            style: StacButtonStyle(
              padding: StacEdgeInsets.symmetric(vertical: 18),
              backgroundColor: '#7A808C',
              foregroundColor: '#FFFFFF',
              shape: StacRoundedRectangleBorder(
                borderRadius: StacBorderRadius.all(14),
              ),
            ),
            child: StacText(
              data: 'ادامه',
              textDirection: StacTextDirection.rtl,
              style: StacTextStyle(
                fontSize: 20,
                fontWeight: StacFontWeight.w600,
                color: '#FFFFFF',
              ),
            ),
          ),
          StacSizedBox(height: 6),
        ],
      ),
    ),
  );
}

StacWidget _buildIconBox(String iconPath) {
  return StacContainer(
    width: 52,
    height: 52,
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surfaceContainer}}',
      borderRadius: StacBorderRadius.all(10),
      border: StacBorder(
        width: 1,
        color: '{{appColors.current.input.borderEnabled}}',
      ),
    ),
    child: StacCenter(
      child: StacImage(
        src: iconPath,
        imageType: StacImageType.asset,
        width: 22,
        height: 22,
      ),
    ),
  );
}
