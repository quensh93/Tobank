import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac/tobank/flows/profile_real/dart/widgets/profile_real_app_bar.dart';

@StacScreen(screenName: 'profile_real_destinations')
StacWidget profileRealDestinations() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildProfileRealAppBar(title: 'مخاطبین'),
    body: StacSingleChildScrollView(
      padding: StacEdgeInsets.all(16),
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacContainer(
            padding: StacEdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: StacBoxDecoration(
              color: '{{appColors.current.background.surface}}',
              borderRadius: StacBorderRadius.all(12),
              border: StacBorder.all(
                color: '{{appColors.current.input.borderEnabled}}',
                width: 1,
              ),
            ),
            child: StacRow(
              textDirection: StacTextDirection.rtl,
              children: [
                _tabItem(label: 'کارت', isActive: true),
                _tabItem(label: 'سپرده'),
                _tabItem(label: 'شبا'),
              ],
            ),
          ),
          StacSizedBox(height: 14),
          _destinationCard(title: 'yuy', subtitle: '۵۵۰۴ - ۱۶۱۰ - ۱۲۹۰ - ۶۵۶۵'),
          StacSizedBox(height: 12),
          _destinationCard(
            title: 'گردشگری - شعبه مجازی',
            subtitle: '۵۵۰۴ - ۱۶۱۷ - ۰۴۸۲ - ۲۳۳۳',
          ),
          StacSizedBox(height: 12),
          _destinationCard(
            title: 'مهیار خلیجی',
            subtitle: '۵۸۵۹ - ۸۳۱۸ - ۲۴۶۱ - ۷۰۳۸',
          ),
          StacSizedBox(height: 12),
          _destinationCard(title: 'blu', subtitle: '۶۲۱۹ - ۸۶۱۹ - ۰۷۷۷ - ۹۵۵۷'),
          StacSizedBox(height: 24),
          StacCenter(
            child: StacFilledButton(
              onPressed: const StacShowResultAction(
                title: 'افزودن کارت مقصد',
                content: 'این بخش به زودی فعال می‌شود.',
              ),
              style: StacButtonStyle(
                padding: StacEdgeInsets.symmetric(horizontal: 22, vertical: 14),
                backgroundColor:
                    '{{appColors.current.button.primary.backgroundColor}}',
              ),
              child: StacRow(
                mainAxisSize: StacMainAxisSize.min,
                textDirection: StacTextDirection.rtl,
                children: [
                  StacIcon(
                    icon: 'add_circle_outline',
                    size: 20,
                    color:
                        '{{appColors.current.button.primary.foregroundColor}}',
                  ),
                  StacSizedBox(width: 8),
                  StacText(
                    data: 'افزودن کارت مقصد',
                    style: StacCustomTextStyle(
                      fontSize: 16,
                      fontWeight: StacFontWeight.w700,
                      color:
                          '{{appColors.current.button.primary.foregroundColor}}',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

StacWidget _tabItem({required String label, bool isActive = false}) {
  return StacExpanded(
    child: StacContainer(
      padding: StacEdgeInsets.symmetric(vertical: 10),
      decoration: StacBoxDecoration(
        border: isActive
            ? StacBorder(bottom: StacBorderSide(color: '#D32F2F', width: 2))
            : null,
      ),
      child: StacText(
        data: label,
        textDirection: StacTextDirection.rtl,
        textAlign: StacTextAlign.center,
        style: StacCustomTextStyle(
          fontSize: 16,
          fontWeight: isActive ? StacFontWeight.w700 : StacFontWeight.w500,
          color: isActive
              ? '{{appColors.current.text.title}}'
              : '{{appColors.current.text.subtitle}}',
        ),
      ),
    ),
  );
}

StacWidget _destinationCard({required String title, required String subtitle}) {
  return StacContainer(
    padding: StacEdgeInsets.symmetric(horizontal: 12, vertical: 14),
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surface}}',
      borderRadius: StacBorderRadius.all(12),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
    ),
    child: StacRow(
      textDirection: StacTextDirection.rtl,
      children: [
        StacIcon(
          icon: 'account_balance_wallet_outlined',
          size: 26,
          color: '{{appColors.current.text.subtitle}}',
        ),
        StacSizedBox(width: 10),
        StacExpanded(
          child: StacColumn(
            crossAxisAlignment: StacCrossAxisAlignment.stretch,
            children: [
              StacText(
                data: title,
                textDirection: StacTextDirection.rtl,
                textAlign: StacTextAlign.right,
                style: StacCustomTextStyle(
                  fontSize: 16,
                  fontWeight: StacFontWeight.w600,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
              StacSizedBox(height: 8),
              StacText(
                data: subtitle,
                textDirection: StacTextDirection.rtl,
                textAlign: StacTextAlign.right,
                style: StacCustomTextStyle(
                  fontSize: 19,
                  fontWeight: StacFontWeight.w700,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
            ],
          ),
        ),
        StacSizedBox(width: 8),
        StacIconButton(
          onPressed: const StacShowResultAction(
            title: 'گزینه‌ها',
            content: 'مدیریت مقصد به زودی فعال می‌شود.',
          ),
          icon: StacIcon(
            icon: 'more_vert',
            size: 20,
            color: '{{appColors.current.text.subtitle}}',
          ),
        ),
      ],
    ),
  );
}
