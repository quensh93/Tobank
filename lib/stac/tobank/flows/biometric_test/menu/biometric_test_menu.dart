import 'package:stac_core/stac_core.dart';

@StacScreen(screenName: 'biometric_test_menu')
StacWidget biometricTestMenu() {
  return StacScaffold(
    appBar: StacAppBar(
      title: StacText(
        data: 'تست بیومتریک',
        textDirection: StacTextDirection.rtl,
        style: StacCustomTextStyle(
          fontSize: 18,
          fontWeight: StacFontWeight.w700,
          color: '{{appColors.current.text.title}}',
        ),
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
      padding: StacEdgeInsets.all(16),
      child: StacSingleChildScrollView(
        child: StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          children: [
            _buildActionButton(
              title: 'بررسی در دسترس بودن بیومتریک',
              description:
                  'فقط بررسی می‌کند که این پلتفرم اصولا امکان استفاده از بیومتریک یا Passkey را دارد یا نه.',
              action: const StacAction(
                jsonData: {
                  'actionType': 'biometricDebug',
                  'operation': 'checkAvailability',
                },
              ),
            ),
            StacSizedBox(height: 12),
            _buildActionButton(
              title: 'بررسی وضعیت ثبت بیومتریک',
              description:
                  'وضعیت ثبت فعلی را نشان می‌دهد و مشخص می‌کند ماژول از قبل برای کاربر فعال شده است یا نه.',
              action: const StacAction(
                jsonData: {
                  'actionType': 'biometricDebug',
                  'operation': 'checkRegistration',
                },
              ),
            ),
            StacSizedBox(height: 12),
            _buildActionButton(
              title: 'بررسی وضعیت Passkey',
              description:
                  'فقط وجود Credential واقعی WebAuthn/Passkey را چک می‌کند و Password fallback را حساب نمی‌کند.',
              action: const StacAction(
                jsonData: {
                  'actionType': 'biometricDebug',
                  'operation': 'checkPasskeyRegistration',
                },
              ),
            ),
            StacSizedBox(height: 12),
            _buildActionButton(
              title: 'ایجاد Credential بیومتریک',
              description:
                  'مسیر اصلی ساخت Credential جدید برای کاربر. این مسیر فقط ثبت می‌کند و احراز هویت اجرایی انجام نمی‌دهد.',
              action: const StacAction(
                jsonData: {
                  'actionType': 'biometricRegister',
                  'title': 'ایجاد Credential بیومتریک',
                  'description':
                      'این مسیر فقط Credential را ایجاد می‌کند و احراز هویت انجام نمی‌دهد.',
                  'userId': 'biometric_test_user',
                  'passkeyOnly': true,
                  'onSuccess': {
                    'actionType': 'customSnackBar',
                    'message': 'Credential بیومتریک ایجاد شد',
                  },
                  'onFailure': {
                    'actionType': 'customSnackBar',
                    'message': 'ایجاد Credential بیومتریک ناموفق بود',
                    'backgroundColor': '#B00020',
                  },
                },
              ),
            ),
            StacSizedBox(height: 12),
            _buildActionButton(
              title: 'ایجاد Credential بیومتریک (گزارش دیباگ)',
              description:
                  'همان ثبت Credential است، با این تفاوت که نتیجه را در دیالوگ جزئیات‌دار برای تست سریع‌تر نشان می‌دهد.',
              action: const StacAction(
                jsonData: {
                  'actionType': 'biometricDebug',
                  'operation': 'createCredential',
                  'userId': 'biometric_test_user',
                },
              ),
            ),
            StacSizedBox(height: 12),
            _buildActionButton(
              title: 'احراز هویت سرویسی (بدون ایجاد)',
              description:
                  'فقط مسیر authenticate سرویس را صدا می‌زند. اگر چیزی ثبت نشده باشد، نباید Credential جدید بسازد.',
              action: const StacAction(
                jsonData: {
                  'actionType': 'biometricDebug',
                  'operation': 'authenticate',
                  'reason': 'Biometric module test',
                  'userId': 'biometric_test_user',
                },
              ),
            ),
            StacSizedBox(height: 12),
            _buildActionButton(
              title: 'احراز هویت با fingerPrint (بدون ایجاد)',
              description:
                  'همان اکشن اصلی STAC را تست می‌کند. این مسیر باید فقط احراز هویت کند و ثبت جدید انجام ندهد.',
              action: const StacAction(
                jsonData: {
                  'actionType': 'fingerPrint',
                  'title': 'تست بیومتریک',
                  'description':
                      'برای ادامه، فقط احراز هویت انجام می‌شود و Credential جدید ساخته نمی‌شود.',
                  'userId': 'biometric_test_user',
                  'onSuccess': {
                    'actionType': 'customSnackBar',
                    'message': 'احراز هویت موفق بود',
                  },
                  'onFailure': {
                    'actionType': 'customSnackBar',
                    'message': 'احراز هویت ناموفق بود یا لغو شد',
                    'backgroundColor': '#B00020',
                  },
                },
              ),
            ),
            StacSizedBox(height: 12),
            _buildActionButton(
              title: 'حذف Credential وب',
              description:
                  'Credential ذخیره‌شده وب را پاک می‌کند تا بتوانی سناریوهای ثبت مجدد و عدم ثبت را تست کنی.',
              action: const StacAction(
                jsonData: {
                  'actionType': 'biometricDebug',
                  'operation': 'clearCredential',
                },
              ),
            ),
            StacSizedBox(height: 12),
            _buildActionButton(
              title: 'تست لاگر بیومتریک',
              description:
                  'چند لاگ نمونه از ماژول بیومتریک تولید می‌کند تا رفتار لاگر و ردیابی رویدادها بررسی شود.',
              action: const StacAction(
                jsonData: {
                  'actionType': 'biometricDebug',
                  'operation': 'logProbe',
                  'message': 'biometric_test_menu_log_probe',
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

StacWidget _buildActionButton({
  required String title,
  required String description,
  required StacAction action,
}) {
  return StacColumn(
    crossAxisAlignment: StacCrossAxisAlignment.stretch,
    children: [
      StacFilledButton(
        onPressed: action,
        style: StacButtonStyle(
          padding: StacEdgeInsets.symmetric(vertical: 14, horizontal: 16),
          shape: StacRoundedRectangleBorder(
            borderRadius: StacBorderRadius.all(10),
          ),
          backgroundColor:
              '{{appColors.current.button.primary.backgroundColor}}',
          foregroundColor:
              '{{appColors.current.button.primary.foregroundColor}}',
        ),
        child: StacText(
          data: title,
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.center,
          style: StacTextStyle(fontSize: 15, fontWeight: StacFontWeight.w600),
        ),
      ),
      StacSizedBox(height: 6),
      StacPadding(
        padding: StacEdgeInsets.symmetric(horizontal: 4),
        child: StacText(
          data: description,
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.right,
          style: StacTextStyle(
            fontSize: 11,
            height: 1.45,
            color: '{{appColors.current.text.subtitle}}',
          ),
        ),
      ),
    ],
  );
}
