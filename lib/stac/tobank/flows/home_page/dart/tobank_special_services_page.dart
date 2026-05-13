import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';

@StacScreen(screenName: 'tobank_special_services_page')
StacWidget tobankSpecialServicesPage() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: StacAppBar(
      title: StacText(
        data: 'خدمات ویژه توبانک',
        textDirection: StacTextDirection.rtl,
        style: StacAliasTextStyle('{{appStyles.appbarStyle}}'),
      ),
      centerTitle: true,
      leading: StacPadding(
        padding: StacEdgeInsets.only(left: 12),
        child: StacCenter(
          child: StacContainer(
            width: 42,
            height: 42,
            child: StacCenter(
              child: StacImage(
                src: '{{appAssets.icons.support}}',
                imageType: StacImageType.asset,
                width: 24,
                height: 24,
                color: '{{appColors.current.text.title}}',
              ),
            ),
          ),
        ),
      ),
      actions: [
        StacPadding(
          padding: StacEdgeInsets.only(right: 15),
          child: StacIconButton(
            onPressed: const StacNavigateAction(
              navigationStyle: NavigationStyle.pop,
            ),
            icon: StacImage(
              src: '{{appAssets.icons.arrowBack}}',
              imageType: StacImageType.asset,
              width: 30,
              height: 30,
              color: '{{appColors.current.text.title}}',
            ),
          ),
        ),
      ],
    ),
    body: StacSingleChildScrollView(
      padding: StacEdgeInsets.only(left: 16, top: 24, right: 16, bottom: 24),
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          _buildServicesRow(
            first: _buildServiceTile(
              title: 'خدمات موبایل بانک',
              subtitle: 'فعال سازی خدمات و صدور رمز',
              iconPath: 'assets/icons/ic_menu_mobile.svg',
              onTap: _mobileBankServicesBottomSheetAction(),
            ),
            second: _buildServiceTile(
              title: 'خدمات اینترنت بانک',
              subtitle: 'فعال سازی خدمات و صدور رمز',
              iconPath: 'assets/icons/ic_menu_internet.svg',
              onTap: const StacNavigateAction(
                routeName: 'charge_real_intro',
                navigationStyle: NavigationStyle.push,
              ),
            ),
          ),
          StacSizedBox(height: 16),
          _buildServicesRow(
            first: _buildServiceTile(
              title: 'صندوق امانات',
              subtitle: 'اجاره صندوق، رزرو زمان بازدید',
              iconPath: 'assets/icons/ic_safe_box.svg',
            ),
            second: _buildServiceTile(
              title: 'ضمانت نامه نظام وظیفه',
              subtitle: 'ثبت ضمانتنامه',
              iconPath: 'assets/icons/ic_military_guarantee.svg',
            ),
          ),
          StacSizedBox(height: 16),
          _buildServicesRow(
            first: _buildServiceTile(
              title: 'سفته آنلاین',
              subtitle: 'صدور و خدمات',
              iconPath: 'assets/icons/ic_promissory.svg',
              onTap: const StacNavigateAction(
                routeName: 'promissory_real_intro',
                navigationStyle: NavigationStyle.push,
              ),
            ),
            second: _buildServiceTile(
              title: 'اعتبارسنجی',
              subtitle: 'اعتبارسنجی خود و سایرین',
              iconPath: 'assets/icons/ic_cbs_search.svg',
            ),
          ),
        ],
      ),
    ),
  );
}

StacWidget _buildServicesRow({
  required StacWidget first,
  required StacWidget second,
}) {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    crossAxisAlignment: StacCrossAxisAlignment.start,
    children: [
      StacExpanded(child: first),
      StacSizedBox(width: 16),
      StacExpanded(child: second),
    ],
  );
}

StacWidget _buildServiceTile({
  required String title,
  required String subtitle,
  required String iconPath,
  double height = 176,
  StacAction? onTap,
}) {
  final tile = StacContainer(
    height: height,
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surfaceContainerLowest}}',
      borderRadius: StacBorderRadius.all(16),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
    ),
    child: StacPadding(
      padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: StacColumn(
        mainAxisAlignment: StacMainAxisAlignment.center,
        crossAxisAlignment: StacCrossAxisAlignment.center,
        children: [
          StacImage(
            src: iconPath,
            imageType: StacImageType.asset,
            width: 32,
            height: 32,
          ),
          StacSizedBox(height: 18),
          StacText(
            data: title,
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.center,
            style: StacCustomTextStyle(
              fontSize: 14,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
              height: 1.5,
            ),
          ),
          StacSizedBox(height: 12),
          StacText(
            data: subtitle,
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.center,
            style: StacCustomTextStyle(
              fontSize: 12,
              fontWeight: StacFontWeight.w500,
              color: '{{appColors.current.text.subtitle}}',
              height: 1.65,
            ),
          ),
        ],
      ),
    ),
  );

  if (onTap == null) {
    return tile;
  }

  return StacGestureDetector(onTap: onTap, child: tile);
}

StacShowBottomSheetAction _mobileBankServicesBottomSheetAction() {
  return StacShowBottomSheetAction(
    backgroundColor: '#00000000',
    sheet: _mobileBankServicesSheet().toJson(),
  );
}

StacWidget _mobileBankServicesSheet() {
  return StacContainer(
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surface}}',
      borderRadius: const StacBorderRadius.only(topLeft: 18, topRight: 18),
    ),
    child: StacPadding(
      padding: StacEdgeInsets.only(left: 16, top: 10, right: 16, bottom: 16),
      child: StacColumn(
        mainAxisSize: StacMainAxisSize.min,
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacCenter(
            child: StacContainer(
              width: 46,
              height: 6,
              decoration: StacBoxDecoration(
                color: '{{appColors.current.input.borderEnabled}}',
                borderRadius: StacBorderRadius.all(999),
              ),
            ),
          ),
          StacSizedBox(height: 20),
          StacText(
            data: 'خدمات موبایل بانک',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.right,
            style: StacCustomTextStyle(
              fontSize: 16,
              fontWeight: StacFontWeight.w800,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(height: 16),
          _mobileBankSheetItem(
            title: 'صدور اولیه رمز موبایل بانک',
            iconPath: 'assets/icons/ic_bank_lock.svg',
            resultAction: _mobileBankActivationConfirmAction(),
          ),
          StacSizedBox(height: 12),
          _mobileBankSheetItem(
            title: 'بازیابی رمز موبایل بانک',
            iconPath: 'assets/icons/ic_lock_retrieval.svg',
            resultAction: _mobileBankRecoveryUsernameAction(),
          ),
          StacSizedBox(height: 8),
        ],
      ),
    ),
  );
}

StacAction _mobileBankActivationConfirmAction() {
  return StacShowBottomSheetAction(
    backgroundColor: '#00000000',
    sheet: _mobileBankActivationConfirmSheet().toJson(),
  );
}

StacAction _mobileBankRecoveryUsernameAction() {
  return StacShowBottomSheetAction(
    backgroundColor: '#00000000',
    sheet: _mobileBankRecoveryUsernameSheet().toJson(),
  );
}

StacWidget _mobileBankActivationConfirmSheet() {
  return StacContainer(
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surface}}',
      borderRadius: const StacBorderRadius.only(topLeft: 18, topRight: 18),
    ),
    child: StacPadding(
      padding: StacEdgeInsets.only(left: 16, top: 10, right: 16, bottom: 16),
      child: StacColumn(
        mainAxisSize: StacMainAxisSize.min,
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacCenter(
            child: StacContainer(
              width: 46,
              height: 6,
              decoration: StacBoxDecoration(
                color: '{{appColors.current.input.borderEnabled}}',
                borderRadius: StacBorderRadius.all(999),
              ),
            ),
          ),
          StacSizedBox(height: 20),
          StacRow(
            textDirection: StacTextDirection.rtl,
            mainAxisAlignment: StacMainAxisAlignment.start,
            children: [
              StacImage(
                src: 'assets/icons/ic_info.svg',
                imageType: StacImageType.asset,
                width: 20,
                height: 20,
                color: '{{appColors.current.text.title}}',
              ),
              StacSizedBox(width: 8),
              StacText(
                data: 'توجه',
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  fontSize: 15,
                  fontWeight: StacFontWeight.w700,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
            ],
          ),
          StacSizedBox(height: 14),
          StacText(
            data:
                'کاربر گرامی، جهت دریافت نام‌کاربری و رمزعبور، نیازمند فعال سازی سرویس می‌باشید',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.right,
            style: StacCustomTextStyle(
              fontSize: 13,
              fontWeight: StacFontWeight.w500,
              color: '{{appColors.current.text.title}}',
              height: 1.7,
            ),
          ),
          StacSizedBox(height: 22),
          StacFilledButton(
            onPressed: StacCloseDialogAction(
              result: _buildMobileBankFingerPrintAction(
                description: 'برای صدور اولیه رمز موبایل بانک احراز هویت کنید',
                failureMessage:
                    'احراز هویت ناموفق بود. عملیات "صدور اولیه رمز موبایل بانک" انجام نشد.',
              ).toJson(),
            ),
            style: StacButtonStyle(
              backgroundColor:
                  '{{appColors.current.button.primary.backgroundColor}}',
              foregroundColor:
                  '{{appColors.current.button.primary.foregroundColor}}',
              minimumSize: const StacSize(0, 56),
              padding: StacEdgeInsets.symmetric(vertical: 8),
              shape: StacRoundedRectangleBorder(
                borderRadius: StacBorderRadius.all(8),
              ),
            ),
            child: StacText(
              data: 'فعال‌سازی',
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 14,
                fontWeight: StacFontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

StacWidget _mobileBankRecoveryUsernameSheet() {
  return StacContainer(
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surface}}',
      borderRadius: const StacBorderRadius.only(topLeft: 18, topRight: 18),
    ),
    child: StacPadding(
      padding: StacEdgeInsets.only(left: 16, top: 10, right: 16, bottom: 16),
      child: StacColumn(
        mainAxisSize: StacMainAxisSize.min,
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacCenter(
            child: StacContainer(
              width: 46,
              height: 6,
              decoration: StacBoxDecoration(
                color: '{{appColors.current.input.borderEnabled}}',
                borderRadius: StacBorderRadius.all(999),
              ),
            ),
          ),
          StacSizedBox(height: 20),
          StacText(
            data: 'خدمات موبایل بانک',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.right,
            style: StacCustomTextStyle(
              fontSize: 16,
              fontWeight: StacFontWeight.w800,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(height: 16),
          StacText(
            data: 'نام کاربری موبایل بانک',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.right,
            style: StacCustomTextStyle(
              fontSize: 16,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(height: 8),
          StacContainer(
            decoration: StacBoxDecoration(
              color: '{{appColors.current.background.surfaceContainerLowest}}',
              border: StacBorder.all(
                color: '{{appColors.current.input.borderEnabled}}',
                width: 1,
              ),
              borderRadius: StacBorderRadius.all(12),
            ),
            child: StacRawJsonWidget({
              'type': 'textFormField',
              'id': 'mobileBankRecoveryUsername',
              'textDirection': 'ltr',
              'textAlign': 'right',
              'keyboardType': 'number',
              'decoration': {
                'hintText': 'نام کاربری موبایل بانک',
                'hintStyle': {
                  'type': 'custom',
                  'fontSize': 14,
                  'fontWeight': 'w400',
                  'color': '{{appColors.current.text.hint}}',
                },
                'filled': false,
                'contentPadding': {
                  'left': 16,
                  'right': 16,
                  'top': 20,
                  'bottom': 20,
                },
                'border': {'type': 'none'},
                'enabledBorder': {'type': 'none'},
                'focusedBorder': {'type': 'none'},
                'errorBorder': {'type': 'none'},
                'focusedErrorBorder': {'type': 'none'},
                'disabledBorder': {'type': 'none'},
                'prefixIcon': {
                  'type': 'padding',
                  'padding': {'left': 8, 'right': 8, 'top': 8, 'bottom': 8},
                  'child': {
                    'type': 'icon',
                    'icon': 'close',
                    'size': 18,
                    'color': '{{appColors.current.text.subtitle}}',
                  },
                },
              },
            }),
          ),
          StacSizedBox(height: 24),
          StacFilledButton(
            onPressed: StacCloseDialogAction(
              result: _buildMobileBankFingerPrintAction(
                description: 'برای بازیابی رمز موبایل بانک احراز هویت کنید',
                failureMessage:
                    'احراز هویت ناموفق بود. عملیات "بازیابی رمز موبایل بانک" انجام نشد.',
              ).toJson(),
            ),
            style: StacButtonStyle(
              backgroundColor: '#E31A2F',
              foregroundColor: '#FFFFFF',
              minimumSize: const StacSize(0, 56),
              shape: StacRoundedRectangleBorder(
                borderRadius: StacBorderRadius.all(8),
              ),
              elevation: 0,
            ),
            child: StacText(
              data: 'تایید و بازیابی رمز موبایل بانک',
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w600,
                color: '#FFFFFF',
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

StacAction _buildMobileBankFingerPrintAction({
  required String description,
  required String failureMessage,
}) {
  return StacFingerPrintAction(
    title: 'احراز هویت',
    description: description,
    onSuccess: const StacCustomSnackBarAction(
      title: 'درخواست شما با موفقیت ثبت شد!',
      detail: 'مراتب از طریق پیامک به شما اطلاع داده خواهد شد.',
    ).toJson(),
    onFailure: StacCustomSnackBarAction(
      title: 'احراز هویت ناموفق بود.',
      detail: failureMessage,
    ).toJson(),
  );
}

StacWidget _mobileBankSheetItem({
  required String title,
  required String iconPath,
  required StacAction resultAction,
}) {
  return StacGestureDetector(
    onTap: StacCloseDialogAction(result: resultAction.toJson()),
    child: StacContainer(
      decoration: StacBoxDecoration(
        color: '{{appColors.current.background.surfaceContainerLowest}}',
        borderRadius: StacBorderRadius.all(14),
        border: StacBorder.all(
          color: '{{appColors.current.input.borderEnabled}}',
          width: 1,
        ),
      ),
      child: StacPadding(
        padding: StacEdgeInsets.only(left: 16, top: 8, right: 16, bottom: 8),
        child: StacRow(
          textDirection: StacTextDirection.rtl,
          crossAxisAlignment: StacCrossAxisAlignment.center,
          children: [
            StacContainer(
              width: 44,
              height: 44,
              decoration: StacBoxDecoration(
                color: '{{appColors.current.background.surfaceContainer}}',
                shape: StacBoxShape.circle,
              ),
              child: StacCenter(
                child: StacImage(
                  src: iconPath,
                  imageType: StacImageType.asset,
                  width: 28,
                  height: 28,
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
                  fontSize: 14,
                  fontWeight: StacFontWeight.w700,
                  color: '{{appColors.current.text.title}}',
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
