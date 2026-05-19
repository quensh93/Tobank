import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'dashboard_cards_management')
StacWidget dashboardCardsManagement() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildTobankFlowAppBar(
      showSupport: true,
      showBack: true,
      title: 'مدیریت کارت‌ها',
    ),
    body: StacSingleChildScrollView(
      padding: StacEdgeInsets.only(left: 16, right: 16, top: 16, bottom: 24),
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacTobankCardManagementSlider(
            height: 186,
            initialPage: 5,
            indicatorTopSpacing: 16,
            indicatorActiveColor: '#E31A2F',
            indicatorInactiveColor: '#F2F4F7',
            indicatorSpacing: 8,
            indicatorSize: 12,
            selectedEnabledKey: 'cardsManagement.selectedEnabled',
            enabledStates: const [true, true, true, false, true, true, true],
            pages: [
              _buildWalletCard(balance: '۱۸۴,۶۰۰').toJson(),
              _buildTobankCard(
                cardNumber: '۵۰۵۴ ۱۶۱۷ ۰۲۸۴ ۴۶۹۱',
                title: 'گردشگری - شعبه مجازی',
                expDate: '۰۶/۰۹',
                showRefresh: true,
              ).toJson(),
              _buildThirdPartyCard(
                bankName: 'بانک سامان',
                cardNumber: '۶۲۱۹ ۸۶۱۰ ۵۵۵۴ ۱۴۲۸',
                owner: 'test',
                expDate: '۰۵/۰۷',
              ).toJson(),
              _buildBlockedCard(
                cardNumber: '۵۰۵۴ ۱۶۱۶ ۵۰۱۷ ۴۷۸۶',
                bankName: 'بانک‌گردشگری',
              ).toJson(),
              _buildTobankCard(
                cardNumber: '۵۰۵۴ ۱۶۱۷ ۰۵۰۳ ۰۶۰۳',
                title: 'گردشگری - سپرده دوم',
                expDate: '۰۷/۱۰',
              ).toJson(),
              _buildThirdPartyCard(
                bankName: 'بانک ملت',
                cardNumber: '۶۱۰۴ ۳۳۷۸ ۱۲۹۰ ۲۲۰۱',
                owner: 'ali',
                expDate: '۰۹/۱۱',
              ).toJson(),
              _buildWalletCard(balance: '۹۷,۳۰۰').toJson(),
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

StacWidget _buildWalletCard({required String balance}) {
  return StacContainer(
    height: 130,
    padding: StacEdgeInsets.all(0),
    decoration: StacBoxDecoration(
      gradient: StacLinearGradient(
        begin: StacAlignment.centerLeft,
        end: StacAlignment.centerRight,
        colors: ['#15A0A0', '#50E8E8'],
      ),
      borderRadius: StacBorderRadius.all(24),
    ),
    child: StacStack(
      children: [
        StacPositioned(
          top: 16,
          right: 16,
          child: StacImage(
            src: '{{appAssets.current.icons.tobankLogo}}',
            imageType: StacImageType.asset,
            width: 38,
            height: 38,
          ),
        ),
        StacPositioned(
          top: 18,
          left: 16,
          child: StacText(
            data: 'کیف پول توبانک',
            textDirection: StacTextDirection.rtl,
            style: StacCustomTextStyle(
              fontSize: 20,
              fontWeight: StacFontWeight.w700,
              color: '#FFFFFF',
            ),
          ),
        ),
        StacPositioned(
          left: 16,
          bottom: 16,
          child: StacRow(
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
        ),
      ],
    ),
  );
}

StacWidget _buildTobankCard({
  required String cardNumber,
  required String title,
  required String expDate,
  bool showRefresh = false,
}) {
  return StacContainer(
    height: 130,
    padding: StacEdgeInsets.symmetric(horizontal: 14, vertical: 12),
    decoration: StacBoxDecoration(
      gradient: StacLinearGradient(
        begin: StacAlignment.centerLeft,
        end: StacAlignment.centerRight,
        colors: ['#EF3A55', '#FF5F87'],
      ),
      borderRadius: StacBorderRadius.all(18),
    ),
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacRow(
          mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
          textDirection: StacTextDirection.rtl,
          children: [
            StacRow(
              mainAxisSize: StacMainAxisSize.min,
              children: [
                if (showRefresh)
                  StacImage(
                    src: '{{appAssets.current.icons.refresh}}',
                    imageType: StacImageType.asset,
                    width: 22,
                    height: 22,
                    color: '#FFFFFF',
                  ),
                if (showRefresh) StacSizedBox(width: 4),
                StacText(
                  data: '- ریال',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 14,
                    fontWeight: StacFontWeight.w500,
                    color: '#FFFFFF',
                  ),
                ),
              ],
            ),
            StacRow(
              mainAxisSize: StacMainAxisSize.min,
              textDirection: StacTextDirection.rtl,
              children: [
                StacText(
                  data: 'بانک‌گردشگری',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 12,
                    fontWeight: StacFontWeight.w700,
                    color: '#FFFFFF',
                  ),
                ),
                StacSizedBox(width: 6),
                StacImage(
                  src: '{{appAssets.current.icons.gardeshgari}}',
                  imageType: StacImageType.asset,
                  width: 24,
                  height: 24,
                  color: '#FFFFFF',
                ),
              ],
            ),
          ],
        ),
        StacSizedBox(height: 10),
        StacRow(
          mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
          textDirection: StacTextDirection.rtl,
          children: [
            StacText(
              data: cardNumber,
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 14,
                fontWeight: StacFontWeight.w600,
                color: '#FFFFFF',
              ),
            ),
            StacText(
              data: title,
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 12,
                fontWeight: StacFontWeight.w500,
                color: '#FFFFFF',
              ),
            ),
          ],
        ),
        StacSizedBox(height: 8),
        StacContainer(height: 1, color: '#FFFFFF66'),
        StacSizedBox(height: 8),
        StacRow(
          mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
          textDirection: StacTextDirection.rtl,
          children: [
            StacText(
              data: 'تاریخ انقضا: $expDate',
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 13,
                fontWeight: StacFontWeight.w500,
                color: '#FFFFFF',
              ),
            ),
            StacRow(
              children: [
                StacImage(
                  src: '{{appAssets.current.icons.shareDeposit}}',
                  imageType: StacImageType.asset,
                  width: 20,
                  height: 20,
                  color: '#FFFFFF',
                ),
                StacSizedBox(width: 12),
                StacImage(
                  src: '{{appAssets.current.icons.more}}',
                  imageType: StacImageType.asset,
                  width: 20,
                  height: 20,
                  color: '#FFFFFF',
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

StacWidget _buildThirdPartyCard({
  required String bankName,
  required String cardNumber,
  required String owner,
  required String expDate,
}) {
  return StacContainer(
    height: 130,
    padding: StacEdgeInsets.symmetric(horizontal: 14, vertical: 12),
    decoration: StacBoxDecoration(
      gradient: StacLinearGradient(
        begin: StacAlignment.centerLeft,
        end: StacAlignment.centerRight,
        colors: ['#1FA3E3', '#83DBF8'],
      ),
      borderRadius: StacBorderRadius.all(18),
    ),
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacRow(
          mainAxisAlignment: StacMainAxisAlignment.end,
          children: [
            StacText(
              data: bankName,
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 12,
                fontWeight: StacFontWeight.w700,
                color: '#FFFFFF',
              ),
            ),
          ],
        ),
        StacSizedBox(height: 10),
        StacRow(
          mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
          textDirection: StacTextDirection.rtl,
          children: [
            StacText(
              data: cardNumber,
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 14,
                fontWeight: StacFontWeight.w600,
                color: '#FFFFFF',
              ),
            ),
            StacText(
              data: owner,
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 12,
                fontWeight: StacFontWeight.w500,
                color: '#FFFFFF',
              ),
            ),
          ],
        ),
        StacSizedBox(height: 8),
        StacContainer(height: 1, color: '#FFFFFF66'),
        StacSizedBox(height: 8),
        StacRow(
          mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
          textDirection: StacTextDirection.rtl,
          children: [
            StacText(
              data: 'تاریخ انقضا: $expDate',
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 13,
                fontWeight: StacFontWeight.w500,
                color: '#FFFFFF',
              ),
            ),
            StacRow(
              children: [
                StacImage(
                  src: '{{appAssets.current.icons.shareDeposit}}',
                  imageType: StacImageType.asset,
                  width: 20,
                  height: 20,
                  color: '#FFFFFF',
                ),
                StacSizedBox(width: 12),
                StacImage(
                  src: '{{appAssets.current.icons.more}}',
                  imageType: StacImageType.asset,
                  width: 20,
                  height: 20,
                  color: '#FFFFFF',
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

StacWidget _buildBlockedCard({
  required String cardNumber,
  required String bankName,
}) {
  return StacContainer(
    height: 130,
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
            StacText(
              data: bankName,
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 13,
                fontWeight: StacFontWeight.w700,
                color: '#FFFFFF',
              ),
            ),
          ],
        ),
        StacSizedBox(height: 6),
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
              width: 58,
              height: 48,
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
              iconAsset:
                  '{{appAssets.current.icons.cardServicePasswordChange}}',
              enabled: false,
            ),
          ),
          StacSizedBox(width: 12),
          StacExpanded(
            child: _serviceTile(
              title: 'رمز دوم',
              iconAsset:
                  '{{appAssets.current.icons.cardServicePasswordChange}}',
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
