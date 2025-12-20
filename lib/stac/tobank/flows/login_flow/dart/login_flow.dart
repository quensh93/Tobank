import 'package:stac_core/stac_core.dart';

/// Login Flow Screen - Orchestrates the complete login flow
///
/// This flow connects the following screens in sequence:
/// 1. Splash Screen - App branding and initialization
/// 2. Onboarding Screen - Introduction to app features
/// 3. Login Screen - Phone number input for authentication
/// 4. Verify OTP Screen - OTP verification to complete login
///
/// Each step provides navigation to the next step in the flow.
@StacScreen(screenName: 'tobank_login_flow_dart')
StacWidget tobankLoginFlowDart() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: StacAppBar(
      backgroundColor: '{{appColors.current.background.surface}}',
      elevation: 0,
      leading: StacIconButton(
        onPressed: StacAction(
          jsonData: {'actionType': 'navigate', 'navigationStyle': 'pop'},
        ),
        icon: StacImage(
          src: '{{appAssets.icons.arrowRight}}',
          imageType: StacImageType.asset,
          width: 24,
          height: 24,
          color: '{{appColors.current.text.title}}',
        ),
      ),
      title: StacText(
        data: 'روند لاگین',
        textDirection: StacTextDirection.rtl,
        style: StacCustomTextStyle(
          fontSize: 18,
          fontWeight: StacFontWeight.bold,
          color: '{{appColors.current.text.title}}',
        ),
      ),
      centerTitle: true,
    ),
    body: StacPadding(
      padding: StacEdgeInsets.all(16),
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          // Flow Description
          StacContainer(
            padding: StacEdgeInsets.all(16),
            decoration: StacBoxDecoration(
              color: '{{appColors.current.background.surfaceContainer}}',
              borderRadius: StacBorderRadius.all(12),
            ),
            child: StacColumn(
              crossAxisAlignment: StacCrossAxisAlignment.end,
              children: [
                StacText(
                  data: 'توضیحات روند',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 16,
                    fontWeight: StacFontWeight.bold,
                    color: '{{appColors.current.text.title}}',
                  ),
                ),
                StacSizedBox(height: 8),
                StacText(
                  data:
                      'این روند شامل تمام مراحل ورود به اپلیکیشن از صفحه اسپلش تا تایید کد ورود می‌باشد.',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 14,
                    color: '{{appColors.current.text.subtitle}}',
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),

          StacSizedBox(height: 24),

          // Flow Steps Title
          StacText(
            data: 'مراحل روند',
            textDirection: StacTextDirection.rtl,
            style: StacCustomTextStyle(
              fontSize: 16,
              fontWeight: StacFontWeight.bold,
              color: '{{appColors.current.text.title}}',
            ),
          ),

          StacSizedBox(height: 16),

          // Step 1: Splash (with 2 second timer)
          _buildFlowStep(
            stepNumber: '۱',
            title: 'اسپلش',
            description: 'نمایش لوگو و نسخه برنامه (۲ ثانیه)',
            widgetType: 'tobank_splash_timed',
            isFirst: true,
          ),

          // Connector Line
          _buildConnectorLine(),

          // Step 2: Onboarding (flow - navigates to login)
          _buildFlowStep(
            stepNumber: '۲',
            title: 'آنبردینگ',
            description: 'معرفی قابلیت‌ها و رفتن به لاگین',
            widgetType: 'tobank_onboarding_flow',
            isFirst: false,
          ),

          // Connector Line
          _buildConnectorLine(),

          // Step 3: Login
          _buildFlowStep(
            stepNumber: '۳',
            title: 'ورود',
            description: 'وارد کردن شماره موبایل',
            widgetType: 'tobank_login_dart',
            isFirst: false,
          ),

          // Connector Line
          _buildConnectorLine(),

          // Step 4: Verify OTP
          _buildFlowStep(
            stepNumber: '۴',
            title: 'تایید کد ورود',
            description: 'تایید کد پیامک شده',
            widgetType: 'tobank_verify_otp_dart',
            isFirst: false,
            isLast: true,
          ),

          StacSizedBox(height: 32),

          // Start Flow Button - uses timed splash
          StacContainer(
            child: StacFilledButton(
              onPressed: StacAction(
                jsonData: {
                  'actionType': 'navigate',
                  'widgetType': 'tobank_splash_timed',
                },
              ),
              child: StacPadding(
                padding: StacEdgeInsets.symmetric(vertical: 8),
                child: StacText(
                  data: 'شروع روند از ابتدا',
                  style: StacCustomTextStyle(
                    fontSize: 16,
                    fontWeight: StacFontWeight.w600,
                    color: '{{appColors.current.primary.onPrimary}}',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

/// Builds a flow step card with step number, title, description and navigation
StacWidget _buildFlowStep({
  required String stepNumber,
  required String title,
  required String description,
  required String widgetType,
  bool isFirst = false,
  bool isLast = false,
}) {
  return StacInkWell(
    onTap: StacAction(
      jsonData: {'actionType': 'navigate', 'widgetType': widgetType},
    ),
    child: StacContainer(
      padding: StacEdgeInsets.all(16),
      decoration: StacBoxDecoration(
        color: '{{appColors.current.background.surfaceContainer}}',
        borderRadius: StacBorderRadius.all(12),
        border: StacBorder.all(
          color: '{{appColors.current.input.borderEnabled}}',
          width: 1,
        ),
      ),
      child: StacRow(
        textDirection: StacTextDirection.rtl,
        children: [
          // Step Number Circle
          StacContainer(
            width: 40,
            height: 40,
            decoration: StacBoxDecoration(
              color: '{{appColors.current.primary.color}}',
              borderRadius: StacBorderRadius.all(20),
            ),
            child: StacCenter(
              child: StacText(
                data: stepNumber,
                style: StacCustomTextStyle(
                  fontSize: 16,
                  fontWeight: StacFontWeight.bold,
                  color: '{{appColors.current.primary.onPrimary}}',
                ),
              ),
            ),
          ),

          StacSizedBox(width: 16),

          // Step Info
          StacExpanded(
            child: StacColumn(
              crossAxisAlignment: StacCrossAxisAlignment.end,
              children: [
                StacText(
                  data: title,
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 15,
                    fontWeight: StacFontWeight.w600,
                    color: '{{appColors.current.text.title}}',
                  ),
                ),
                StacSizedBox(height: 4),
                StacText(
                  data: description,
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 13,
                    color: '{{appColors.current.text.subtitle}}',
                  ),
                ),
              ],
            ),
          ),

          // Arrow Icon
          StacImage(
            src: '{{appAssets.icons.arrowLeft}}',
            imageType: StacImageType.asset,
            width: 16,
            height: 16,
            color: '{{appColors.current.text.subtitle}}',
          ),
        ],
      ),
    ),
  );
}

/// Builds a vertical connector line between flow steps
StacWidget _buildConnectorLine() {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    mainAxisAlignment: StacMainAxisAlignment.start,
    children: [
      StacSizedBox(width: 36),
      StacContainer(
        width: 2,
        height: 24,
        color: '{{appColors.current.primary.color}}',
      ),
    ],
  );
}
