import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac/tobank/flows/profile_real/dart/widgets/profile_real_app_bar.dart';

@StacScreen(screenName: 'dashboard_real_cards_management')
StacWidget dashboardRealCardsManagement() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildProfileRealAppBar(title: 'مدیریت کارت‌ها'),
    body: StacSingleChildScrollView(
      padding: StacEdgeInsets.only(left: 16, right: 16, top: 16, bottom: 24),
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacTobankCardManagementSlider(
            height: 206,
            initialPage: 6,
            indicatorTopSpacing: 16,
            indicatorActiveColor: '#E31A2F',
            indicatorInactiveColor: '#F2F4F7',
            indicatorSpacing: 8,
            indicatorSize: 12,
            selectedEnabledKey: 'cardsManagement.selectedEnabled',
            enabledStates: const [true, false, true, true, true, true, true],
            pages: [
              _buildEnabledWalletCard(balance: '۸۴,۶۰۰').toJson(),
              _buildDisabledCard(cardNumber: '۵۰۵۴ ۱۶۱۶ ۵۰۱۷ ۴۷۸۶').toJson(),
              _buildEnabledWalletCard(balance: '۱۲۱,۰۰۰').toJson(),
              _buildEnabledWalletCard(balance: '۲۲۵,۵۰۰').toJson(),
              _buildEnabledWalletCard(balance: '۴۹,۰۰۰').toJson(),
              _buildEnabledWalletCard(balance: '۹۷,۳۰۰').toJson(),
              _buildEnabledWalletCard(balance: '۱۸۴,۶۰۰').toJson(),
            ],
          ),
          StacSizedBox(height: 24),
          StacCustomVisibility(
            visible: '[[cardsManagement.selectedEnabled]]',
            child: _buildEnabledServices().toJson(),
            replacement: _buildDisabledServices().toJson(),
          ),
        ],
      ),
    ),
  );
}

StacWidget _buildEnabledWalletCard({required String balance}) {
  return StacContainer(
    height: 150,
    padding: StacEdgeInsets.symmetric(horizontal: 18, vertical: 16),
    decoration: StacBoxDecoration(
      gradient: StacLinearGradient(
        begin: StacAlignment.centerLeft,
        end: StacAlignment.centerRight,
        colors: ['#15A0A0', '#50E8E8'],
      ),
      borderRadius: StacBorderRadius.all(24),
    ),
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
      children: [
        StacRow(
          mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
          textDirection: StacTextDirection.rtl,
          children: [
            StacText(
              data: 'کیف پول توبانک',
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 20,
                fontWeight: StacFontWeight.w700,
                color: '#FFFFFF',
              ),
            ),
            StacImage(
              src: '{{appAssets.current.icons.target}}',
              imageType: StacImageType.asset,
              width: 62,
              height: 52,
            ),
          ],
        ),
        StacRow(
          textDirection: StacTextDirection.rtl,
          children: [
            StacText(
              data: 'ریال',
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w500,
                color: '#FFFFFF',
              ),
            ),
            StacSizedBox(width: 8),
            StacText(
              data: balance,
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 24,
                fontWeight: StacFontWeight.w600,
                color: '#FFFFFF',
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

StacWidget _buildDisabledCard({required String cardNumber}) {
  return StacContainer(
    height: 150,
    padding: StacEdgeInsets.symmetric(horizontal: 18, vertical: 16),
    decoration: StacBoxDecoration(
      gradient: StacLinearGradient(
        begin: StacAlignment.centerLeft,
        end: StacAlignment.centerRight,
        colors: ['#B9B9B9', '#8F8F8F'],
      ),
      borderRadius: StacBorderRadius.all(24),
    ),
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacRow(
          mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
          textDirection: StacTextDirection.rtl,
          children: [
            StacText(
              data: cardNumber,
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w600,
                color: '#FFFFFF',
              ),
            ),
            StacImage(
              src: '{{appAssets.current.icons.gardeshgari}}',
              imageType: StacImageType.asset,
              width: 46,
              height: 46,
              color: '#FFFFFF',
            ),
          ],
        ),
        StacSizedBox(height: 10),
        StacText(
          data: 'مسدود شده',
          textDirection: StacTextDirection.rtl,
          style: StacCustomTextStyle(
            fontSize: 16,
            fontWeight: StacFontWeight.w500,
            color: '#FFFFFF',
          ),
        ),
        StacExpanded(
          child: StacCenter(
            child: StacImage(
              src: '{{appAssets.current.icons.block}}',
              imageType: StacImageType.asset,
              width: 78,
              height: 52,
              color: '#1E2538',
            ),
          ),
        ),
      ],
    ),
  );
}

StacWidget _buildEnabledServices() {
  return StacColumn(
    children: [
      StacRow(
        children: [
          StacExpanded(
            child: _serviceTile(
              title: 'افزایش موجودی',
              iconAsset: '{{appAssets.current.icons.cardBalance}}',
              onTap: const StacShowResultAction(
                title: 'افزایش موجودی',
                content: 'این بخش به زودی فعال می‌شود.',
              ),
            ),
          ),
          StacSizedBox(width: 12),
          StacExpanded(
            child: _serviceTile(
              title: 'انتقال وجه',
              iconAsset: '{{appAssets.current.icons.transferAmount}}',
              onTap: const StacShowResultAction(
                title: 'انتقال وجه',
                content: 'این بخش به زودی فعال می‌شود.',
              ),
            ),
          ),
        ],
      ),
      StacSizedBox(height: 12),
      StacRow(
        children: [
          StacExpanded(
            child: _serviceTile(
              title: 'رمز اول',
              iconAsset:
                  '{{appAssets.current.icons.cardServicePasswordChange}}',
              onTap: const StacShowResultAction(
                title: 'رمز اول',
                content: 'این بخش به زودی فعال می‌شود.',
              ),
            ),
          ),
          StacSizedBox(width: 12),
          StacExpanded(
            child: _serviceTile(
              title: 'رمز دوم',
              iconAsset:
                  '{{appAssets.current.icons.cardServicePasswordChange}}',
              onTap: const StacShowResultAction(
                title: 'رمز دوم',
                content: 'این بخش به زودی فعال می‌شود.',
              ),
            ),
          ),
        ],
      ),
      StacSizedBox(height: 12),
      StacRow(
        children: [
          StacExpanded(
            child: _serviceTile(
              title: 'کارت المثنی',
              iconAsset: '{{appAssets.current.icons.refresh}}',
              onTap: const StacShowResultAction(
                title: 'کارت المثنی',
                content: 'این بخش به زودی فعال می‌شود.',
              ),
            ),
          ),
          StacSizedBox(width: 12),
          StacExpanded(
            child: _serviceTile(
              title: 'مسدود سازی کارت',
              iconAsset: '{{appAssets.current.icons.block}}',
              onTap: const StacShowResultAction(
                title: 'مسدود سازی کارت',
                content: 'این بخش به زودی فعال می‌شود.',
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

StacWidget _buildDisabledServices() {
  return StacColumn(
    children: [
      StacRow(
        children: [
          StacExpanded(
            child: _serviceTile(
              title: 'رمز اول',
              iconAsset: '{{appAssets.current.icons.cardServicePasswordChange}}',
              enabled: false,
            ),
          ),
          StacSizedBox(width: 12),
          StacExpanded(
            child: _serviceTile(
              title: 'رمز دوم',
              iconAsset: '{{appAssets.current.icons.cardServicePasswordChange}}',
              enabled: false,
            ),
          ),
        ],
      ),
      StacSizedBox(height: 12),
      StacRow(
        children: [
          StacExpanded(
            child: _serviceTile(
              title: 'کارت المثنی',
              iconAsset: '{{appAssets.current.icons.refresh}}',
              onTap: const StacShowResultAction(
                title: 'کارت المثنی',
                content: 'این بخش به زودی فعال می‌شود.',
              ),
            ),
          ),
          StacSizedBox(width: 12),
          StacExpanded(
            child: _serviceTile(
              title: 'مسدودسازی',
              iconAsset: '{{appAssets.current.icons.block}}',
              enabled: false,
            ),
          ),
        ],
      ),
    ],
  );
}

StacWidget _serviceTile({
  required String title,
  required String iconAsset,
  bool enabled = true,
  StacAction? onTap,
}) {
  final borderColor = '{{appColors.current.input.borderEnabled}}';
  final enabledColor = '{{appColors.current.text.title}}';
  final disabledColor = '{{appColors.current.text.hint}}';
  final foreground = enabled ? enabledColor : disabledColor;

  final tile = StacContainer(
    height: 124,
    padding: StacEdgeInsets.all(16),
    decoration: StacBoxDecoration(
      borderRadius: StacBorderRadius.all(16),
      border: StacBorder.all(color: borderColor, width: 1),
    ),
    child: StacColumn(
      mainAxisAlignment: StacMainAxisAlignment.center,
      children: [
        StacImage(
          src: iconAsset,
          imageType: StacImageType.asset,
          width: 38,
          height: 32,
          color: foreground,
        ),
        StacSizedBox(height: 10),
        StacText(
          data: title,
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.center,
          style: StacCustomTextStyle(
            fontSize: 14,
            fontWeight: StacFontWeight.w500,
            color: foreground,
          ),
        ),
      ],
    ),
  );

  if (!enabled || onTap == null) {
    return tile;
  }
  return StacGestureDetector(onTap: onTap, child: tile);
}
