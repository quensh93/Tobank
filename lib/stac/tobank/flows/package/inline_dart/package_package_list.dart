import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';
import 'package:tobank_sdui/core/stac/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'package_package_list')
StacWidget packageRealPackageList() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {'key': 'crPkgContinueEnabled', 'value': false},
        {'key': 'crPkgSel1', 'value': false},
        {'key': 'crPkgSel2', 'value': false},
        {'key': 'crPkgSel3', 'value': false},
        {'key': 'crPkgSel4', 'value': false},
        {'key': 'crPkgSel5', 'value': false},
        {'key': 'crPkgSel6', 'value': false},
      ],
    ),
    child: StacScaffold(
      backgroundColor: '{{appColors.current.background.surface}}',
      appBar: buildTobankFlowAppBar(
        showSupport: true,
        showBack: true,
        title: 'اینترنت',
      ),
      body: StacSafeArea(
        top: false,
        child: StacPadding(
          padding: StacEdgeInsets.all(16),
          child: StacDefaultTabController(
            length: 4,
            initialIndex: 0,
            child: StacColumn(
              crossAxisAlignment: StacCrossAxisAlignment.stretch,
              children: [
                _buildTabs(),
                StacSizedBox(height: 16),
                StacExpanded(
                  child: StacTabBarView(
                    children: [
                      _buildPackageList(),
                      _buildMonthlyEmptyState(),
                      _buildPackageList(),
                      _buildPackageList(),
                    ],
                  ),
                ),
                StacCustomVisibility(
                  visible: '[[!crPkgContinueEnabled]]',
                  child: _buildContinueButton(enabled: false).toJson(),
                  replacement: _buildContinueButton(enabled: true).toJson(),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

StacWidget _buildTabs() {
  return StacContainer(
    color: '{{appColors.current.background.surface}}',
    child: StacStack(
      children: [
        StacTabBar(
          enableFeedback: false,
          isScrollable: false,
          dividerColor: '#00000000',
          indicator: StacBoxDecoration(
            color: '#EAFBFD',
            borderRadius: StacBorderRadius.all(10),
            border: StacBorder.all(color: '#20C4D8', width: 1),
          ),
          indicatorSize: StacTabBarIndicatorSize.tab,
          indicatorPadding: StacEdgeInsets.all(0),
          labelStyle: StacCustomTextStyle(
            fontSize: 16,
            fontWeight: StacFontWeight.w600,
          ),
          unselectedLabelStyle: StacCustomTextStyle(
            fontSize: 16,
            fontWeight: StacFontWeight.w500,
          ),
          labelColor: '{{appColors.current.text.title}}',
          unselectedLabelColor: '{{appColors.current.text.title}}',
          tabs: const [
            StacTab(text: 'سایر', height: 40),
            StacTab(text: 'ماهانه', height: 40),
            StacTab(text: 'هفتگی', height: 40),
            StacTab(text: 'روزانه', height: 40),
          ],
        ),
        StacPositioned(
          top: 8,
          bottom: 8,
          left: 0,
          right: 0,
          child: StacRow(
            children: [
              StacExpanded(child: StacSizedBox()),
              StacContainer(
                width: 1,
                color: '{{appColors.current.input.borderEnabled}}',
              ),
              StacExpanded(child: StacSizedBox()),
              StacContainer(
                width: 1,
                color: '{{appColors.current.input.borderEnabled}}',
              ),
              StacExpanded(child: StacSizedBox()),
              StacContainer(
                width: 1,
                color: '{{appColors.current.input.borderEnabled}}',
              ),
              StacExpanded(child: StacSizedBox()),
            ],
          ),
        ),
      ],
    ),
  );
}

StacWidget _buildPackageList() {
  return StacSingleChildScrollView(
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        _packageItem(
          selectedKey: 'crPkgSel1',
          title: 'بسته اینترنت ۳۵ روزه ۲۵۰۰ مگابایت +\nمالیات',
          amount: '۵۳,۱۶۰',
          onTap: _selectPackage(1),
        ),
        _packageItem(
          selectedKey: 'crPkgSel2',
          title: 'بسته اینترنت ۳۵ روزه ۲۵۰۰ مگابایت +\nمالیات',
          amount: '۵۳,۱۶۰',
          onTap: _selectPackage(2),
        ),
        _packageItem(
          selectedKey: 'crPkgSel3',
          title: 'بسته اینترنت ۳۵ روزه ۲۵۰۰ مگابایت +\nمالیات',
          amount: '۵۳,۱۶۰',
          onTap: _selectPackage(3),
        ),
        _packageItem(
          selectedKey: 'crPkgSel4',
          title: 'بسته اینترنت ۳۵ روزه ۲۵۰۰ مگابایت +\nمالیات',
          amount: '۵۳,۱۶۰',
          onTap: _selectPackage(4),
        ),
        _packageItem(
          selectedKey: 'crPkgSel5',
          title: 'بسته اینترنت ۳۵ روزه ۲۵۰۰ مگابایت +\nمالیات',
          amount: '۵۳,۱۶۰',
          onTap: _selectPackage(5),
        ),
        _packageItem(
          selectedKey: 'crPkgSel6',
          title: 'بسته اینترنت ۳۵ روزه ۲۵۰۰ مگابایت +\nمالیات',
          amount: '۵۳,۱۶۰',
          onTap: _selectPackage(6),
        ),
      ],
    ),
  );
}

StacWidget _packageItem({
  required String selectedKey,
  required String title,
  required String amount,
  required StacAction onTap,
}) {
  final base = StacContainer(
    padding: StacEdgeInsets.symmetric(horizontal: 12, vertical: 12),
    child: StacRow(
      textDirection: StacTextDirection.rtl,
      children: [
        StacImage(
          src: 'assets/icons/ic_package.svg',
          imageType: StacImageType.asset,
          width: 34,
          height: 34,
          color: '{{appColors.current.text.disable}}',
        ),
        StacSizedBox(width: 8),
        StacExpanded(
          child: StacText(
            data: title,
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.right,
            style: StacCustomTextStyle(
              fontSize: 14,
              fontWeight: StacFontWeight.w500,
              color: '{{appColors.current.text.title}}',
            ),
          ),
        ),
        StacSizedBox(width: 8),
        StacText(
          data: amount,
          textDirection: StacTextDirection.ltr,
          style: StacCustomTextStyle(
            fontSize: 16,
            fontWeight: StacFontWeight.w600,
            color: '{{appColors.current.text.title}}',
          ),
        ),
        StacSizedBox(width: 8),
        StacIcon(
          icon: 'chevron_left',
          size: 24,
          color: '{{appColors.current.text.title}}',
        ),
      ],
    ),
  );

  return StacGestureDetector(
    onTap: onTap,
    child: StacPadding(
      padding: StacEdgeInsets.only(bottom: 10),
      child: StacCustomVisibility(
        visible: '[[$selectedKey]]',
        child: StacContainer(
          decoration: StacBoxDecoration(
            color: '#F4FDFF',
            borderRadius: StacBorderRadius.all(8),
            border: StacBorder.all(color: '#20C4D8', width: 1),
          ),
          child: base,
        ).toJson(),
        replacement: StacContainer(
          decoration: StacBoxDecoration(
            color: '{{appColors.current.background.surfaceContainer}}',
            borderRadius: StacBorderRadius.all(8),
          ),
          child: base,
        ).toJson(),
      ),
    ),
  );
}

StacAction _selectPackage(int index) {
  return StacCustomSetValueAction(
    values: [
      {'key': 'crPkgSel1', 'value': index == 1},
      {'key': 'crPkgSel2', 'value': index == 2},
      {'key': 'crPkgSel3', 'value': index == 3},
      {'key': 'crPkgSel4', 'value': index == 4},
      {'key': 'crPkgSel5', 'value': index == 5},
      {'key': 'crPkgSel6', 'value': index == 6},
      {'key': 'crPkgContinueEnabled', 'value': true},
      {'key': 'crPkgSelectedAmount', 'value': '۱۵۰,۰۰۰'},
      {
        'key': 'crPkgSelectedName',
        'value': 'بسته اینترنت ۳۵ روزه ۲۵۰۰ مگابایت',
      },
    ],
  );
}

StacWidget _buildMonthlyEmptyState() {
  return StacCenter(
    child: StacColumn(
      mainAxisSize: StacMainAxisSize.min,
      children: [
        StacImage(
          src: 'assets/icons/ic_package_empty_list_light.svg',
          imageType: StacImageType.asset,
          width: 144,
          height: 144,
          fit: StacBoxFit.contain,
        ),
        StacText(
          data: 'بسته‌ی اینترنتی ماهانه در حال موجود نمی‌باشد',
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.center,
          style: StacCustomTextStyle(
            fontSize: 18,
            fontWeight: StacFontWeight.w600,
            color: '{{appColors.current.text.title}}',
          ),
        ),
      ],
    ),
  );
}

StacWidget _buildContinueButton({required bool enabled}) {
  return StacPadding(
    padding: StacEdgeInsets.only(bottom: 6),
    child: StacFilledButton(
      onPressed: enabled
          ? const StacNavigateAction(
              routeName: 'package_payment',
              navigationStyle: NavigationStyle.push,
            )
          : null,
      style: StacButtonStyle(
        fixedSize: StacSize(999999, 56),
        backgroundColor: enabled
            ? '{{appColors.current.primary.color}}'
            : '#D0D5DD',
        foregroundColor: enabled
            ? '{{appColors.current.primary.onPrimary}}'
            : '#667085',
        shape: StacRoundedRectangleBorder(
          borderRadius: StacBorderRadius.all(10),
        ),
        elevation: 0,
      ),
      child: StacText(
        data: 'ادامه',
        textDirection: StacTextDirection.rtl,
        style: StacCustomTextStyle(
          fontSize: 16,
          fontWeight: StacFontWeight.w700,
          color: enabled
              ? '{{appColors.current.primary.onPrimary}}'
              : '#667085',
        ),
      ),
    ),
  );
}
