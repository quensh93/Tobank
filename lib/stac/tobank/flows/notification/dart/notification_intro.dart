import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'notification_intro')
StacWidget notificationRealIntro() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {'key': 'ntfGeneralCard1Unread', 'value': true},
        {'key': 'ntfGeneralCard2Unread', 'value': true},
        {'key': 'ntfGeneralCard3Unread', 'value': true},
        {'key': 'ntfGeneralCard4Unread', 'value': true},
        {'key': 'ntfGeneralCard5Unread', 'value': true},
        {'key': 'ntfGeneralCard6Unread', 'value': true},
        {'key': 'ntfUpdateCard1Unread', 'value': true},
        {'key': 'ntfUpdateCard2Unread', 'value': false},
        {'key': 'ntfUpdateCard3Unread', 'value': false},
      ],
    ),
    child: StacScaffold(
      backgroundColor: '{{appColors.current.background.surface}}',
      appBar: buildTobankFlowAppBar(
        title: 'اعلان‌ها',
        showSupport: true,
        showBack: true,
      ),
      body: StacDefaultTabController(
        length: 2,
        initialIndex: 1,
        child: StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          children: [
            StacSizedBox(height: 8),
            _buildTopTabs(),
            StacSizedBox(height: 10),
            StacExpanded(
              child: StacTabBarView(
                children: [_buildUpdatesTab(), _buildGeneralNotificationsTab()],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

StacWidget _buildTopTabs() {
  return StacContainer(
    margin: StacEdgeInsets.symmetric(horizontal: 16),
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surfaceContainer}}',
      borderRadius: StacBorderRadius.circular(14),
    ),
    child: StacStack(
      children: [
        StacTabBar(
          dividerColor: '#00000000',
          indicatorColor: '{{appColors.current.primary.color}}',
          indicatorWeight: 3,
          indicatorSize: StacTabBarIndicatorSize.tab,
          indicatorPadding: StacEdgeInsets.only(left: 34, top: 50, right: 34),
          labelStyle: StacCustomTextStyle(
            fontSize: 18,
            fontWeight: StacFontWeight.w700,
          ),
          unselectedLabelStyle: StacCustomTextStyle(
            fontSize: 18,
            fontWeight: StacFontWeight.w500,
          ),
          labelColor: '{{appColors.current.text.title}}',
          unselectedLabelColor: '{{appColors.current.text.hint}}',
          tabs: const [
            StacTab(text: 'بروزرسانی‌ها', height: 54),
            StacTab(text: 'اعلان‌های عمومی', height: 54),
          ],
        ),
        StacPositioned(
          top: 12,
          bottom: 12,
          left: 0,
          right: 0,
          child: StacCenter(
            child: StacContainer(
              width: 1,
              color: '{{appColors.current.input.borderEnabled}}',
            ),
          ),
        ),
      ],
    ),
  );
}

StacWidget _buildGeneralNotificationsTab() {
  return StacSingleChildScrollView(
    child: StacPadding(
      padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          _buildNotificationCard(
            title: 'بازپرداخت به کیف پول توبانک',
            description:
                'کاربر عزیز\nمبلغ ۳۱۳,۰۰۰ ریال کارمزد صدور سفته با شماره پیگیری ۲۹۲۹ به کیف پول شما بازگشت.',
            dateText: '۲۲ اردیبهشت ۱۴۰۵ - ۱۱:۲۸',
            unreadKey: 'ntfGeneralCard1Unread',
          ),
          StacSizedBox(height: 12),
          _buildNotificationCard(
            title: 'پرداخت موفق',
            description:
                'کاربر عزیز\nمبلغ ۳۱۳,۰۰۰ ریال با شماره پیگیری ۷۳۵۴۱۴۷۴۴ پرداخت شد.',
            dateText: '۲۲ اردیبهشت ۱۴۰۵ - ۱۱:۲۸',
            unreadKey: 'ntfGeneralCard2Unread',
          ),
          StacSizedBox(height: 12),
          _buildNotificationCard(
            title: 'انتقال وجه به کیف پول',
            description:
                'کاربر عزیز\nمبلغ ۱۰,۰۰۰ ریال با شماره پیگیری ۷۳۴۳۸۸۸۵۲۵ انتقال یافت.',
            dateText: '۲۲ اردیبهشت ۱۴۰۵ - ۱۱:۲۰',
            unreadKey: 'ntfGeneralCard3Unread',
          ),
          StacSizedBox(height: 12),
          _buildNotificationCard(
            title: 'انتقال وجه به کیف پول',
            description:
                'کاربر عزیز\nمبلغ ۲۱۰,۰۰۰ ریال با شماره پیگیری ۷۳۳۶۳۵۳۰۶ انتقال یافت.',
            dateText: '۲۲ اردیبهشت ۱۴۰۵ - ۱۱:۱۹',
            unreadKey: 'ntfGeneralCard4Unread',
          ),
          StacSizedBox(height: 12),
          _buildNotificationCard(
            title: 'واریز سود سپرده',
            description:
                'کاربر عزیز\nسود سپرده شما به مبلغ ۴۵۰,۰۰۰ ریال به حساب معرفی‌شده واریز شد.',
            dateText: '۲۱ اردیبهشت ۱۴۰۵ - ۰۹:۴۸',
            unreadKey: 'ntfGeneralCard5Unread',
          ),
          StacSizedBox(height: 12),
          _buildNotificationCard(
            title: 'تایید برداشت از کیف پول',
            description:
                'کاربر عزیز\nبرداشت مبلغ ۸۵,۰۰۰ ریال از کیف پول توبانک با موفقیت انجام شد.',
            dateText: '۲۱ اردیبهشت ۱۴۰۵ - ۰۸:۳۲',
            unreadKey: 'ntfGeneralCard6Unread',
          ),
          StacSizedBox(height: 10),
        ],
      ),
    ),
  );
}

StacWidget _buildUpdatesTab() {
  return StacSingleChildScrollView(
    child: StacPadding(
      padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          _buildNotificationCard(
            title: 'نسخه جدید اپلیکیشن در دسترس است',
            description:
                'برای استفاده از قابلیت‌های جدید و بهبود امنیت، لطفا اپلیکیشن را به آخرین نسخه بروزرسانی کنید.',
            dateText: '۲۰ اردیبهشت ۱۴۰۵ - ۰۹:۱۵',
            unreadKey: 'ntfUpdateCard1Unread',
          ),
          StacSizedBox(height: 12),
          _buildNotificationCard(
            title: 'بهبود عملکرد بخش تراکنش‌ها',
            description:
                'مشکل نمایش برخی تراکنش‌های کیف پول برطرف شد. در صورت نیاز، یکبار از حساب خارج و مجددا وارد شوید.',
            dateText: '۱۸ اردیبهشت ۱۴۰۵ - ۱۷:۴۰',
            unreadKey: 'ntfUpdateCard2Unread',
          ),
          StacSizedBox(height: 12),
          _buildNotificationCard(
            title: 'افزودن میانبرهای جدید',
            description:
                'میانبرهای سریع برای انتقال وجه و خرید شارژ به صفحه اصلی اضافه شد.',
            dateText: '۱۵ اردیبهشت ۱۴۰۵ - ۱۲:۰۵',
            unreadKey: 'ntfUpdateCard3Unread',
          ),
          StacSizedBox(height: 10),
        ],
      ),
    ),
  );
}

StacWidget _buildNotificationCard({
  required String title,
  required String description,
  required String dateText,
  required String unreadKey,
}) {
  return StacGestureDetector(
    onTap: _openNotificationDetailsSheetAction(
      title: title,
      description: description,
      dateText: dateText,
      unreadKey: unreadKey,
    ),
    child: StacContainer(
      decoration: StacBoxDecoration(
        color: '{{appColors.current.background.surfaceContainer}}',
        borderRadius: StacBorderRadius.all(10.5),
        border: StacBorder.all(
          color: '{{appColors.current.input.borderEnabled}}',
          width: 1,
        ),
      ),
      child: StacPadding(
        padding: StacEdgeInsets.all(16),
        child: StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          children: [
            StacRow(
              mainAxisAlignment: StacMainAxisAlignment.end,
              textDirection: StacTextDirection.rtl,
              children: [
                StacCustomVisibility(
                  visible: '[[$unreadKey]]',
                  child: StacRow(
                    children: [
                      StacSizedBox(width: 6),
                      StacContainer(
                        width: 8,
                        height: 8,
                        decoration: StacBoxDecoration(
                          color: '#D32F2F',
                          borderRadius: StacBorderRadius.circular(999),
                        ),
                      ),
                    ],
                  ).toJson(),
                  replacement: StacSizedBox().toJson(),
                ),
                StacExpanded(
                  child: StacText(
                    data: title,
                    textDirection: StacTextDirection.rtl,
                    textAlign: StacTextAlign.right,
                    style: StacCustomTextStyle(
                      color: '{{appColors.current.text.title}}',
                      fontSize: 16,
                      fontWeight: StacFontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            StacSizedBox(height: 12),
            StacText(
              data: description,
              textDirection: StacTextDirection.rtl,
              textAlign: StacTextAlign.right,
              style: StacCustomTextStyle(
                color: '{{appColors.current.text.subtitle}}',
                fontSize: 14,
                fontWeight: StacFontWeight.w500,
                height: 1.6,
              ),
            ),
            StacSizedBox(height: 8),
            StacText(
              data: dateText,
              textDirection: StacTextDirection.rtl,
              textAlign: StacTextAlign.right,
              style: StacCustomTextStyle(
                color: '{{appColors.current.text.hint}}',
                fontSize: 12,
                fontWeight: StacFontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

StacAction _openNotificationDetailsSheetAction({
  required String title,
  required String description,
  required String dateText,
  required String unreadKey,
}) {
  return StacSequenceAction(
    actions: [
      StacCustomSetValueAction(
        values: [
          {'key': unreadKey, 'value': false},
        ],
      ),
      StacShowBottomSheetAction(
        title: 'notification_filter',
        isScrollControlled: true,
        useSafeArea: true,
        backgroundColor: '#00000000',
        barrierColor: '#8B000000',
        sheet: _buildNotificationDetailsSheet(
          title: title,
          description: description,
          dateText: dateText,
        ).toJson(),
      ),
    ],
  );
}

StacWidget _buildNotificationDetailsSheet({
  required String title,
  required String description,
  required String dateText,
}) {
  return StacContainer(
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surface}}',
      borderRadius: const StacBorderRadius.only(topLeft: 12, topRight: 12),
    ),
    child: StacPadding(
      padding: StacEdgeInsets.only(left: 24, top: 8, right: 24, bottom: 24),
      child: StacColumn(
        mainAxisSize: StacMainAxisSize.min,
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacSizedBox(height: 11),
          StacCenter(
            child: StacContainer(
              width: 48,
              height: 5,
              decoration: StacBoxDecoration(
                color: '#D0D5DD',
                borderRadius: StacBorderRadius.all(99),
              ),
            ),
          ),
          StacSizedBox(height: 22),
          StacText(
            data: title,
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.right,
            style: StacCustomTextStyle(
              fontSize: 18,
              fontWeight: StacFontWeight.bold,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(height: 12),
          StacText(
            data: description,
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.right,
            style: StacCustomTextStyle(
              fontSize: 16,
              fontWeight: StacFontWeight.w500,
              color: '{{appColors.current.text.subtitle}}',
              height: 1.7,
            ),
          ),
          StacSizedBox(height: 10),
          StacText(
            data: dateText,
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.right,
            style: StacCustomTextStyle(
              fontSize: 12,
              fontWeight: StacFontWeight.w500,
              color: '{{appColors.current.text.hint}}',
            ),
          ),
          StacSizedBox(height: 38),
          StacFilledButton(
            onPressed: const StacCloseDialogAction(),
            style: StacButtonStyle(
              fixedSize: const StacSize(999999, 55),
              backgroundColor:
                  '{{appColors.current.button.primary.backgroundColor}}',
              foregroundColor:
                  '{{appColors.current.button.primary.foregroundColor}}',
              shape: StacRoundedRectangleBorder(
                borderRadius: StacBorderRadius.all(10),
              ),
            ),
            child: StacText(
              data: 'بازگشت',
              style: StacCustomTextStyle(
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

