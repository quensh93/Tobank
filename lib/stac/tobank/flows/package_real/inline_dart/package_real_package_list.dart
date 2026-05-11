import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';
import 'package:tobank_sdui/core/stac/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'package_real_package_list')
StacWidget packageRealPackageList() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {'key': 'crPkgTabDaily', 'value': false},
        {'key': 'crPkgTabWeekly', 'value': false},
        {'key': 'crPkgTabMonthly', 'value': false},
        {'key': 'crPkgTabOther', 'value': true},
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
          child: StacColumn(
            crossAxisAlignment: StacCrossAxisAlignment.stretch,
            children: [
              StacRow(
                textDirection: StacTextDirection.rtl,
                children: [
                  StacExpanded(
                    child: _buildTabItem(
                      title: 'روزانه',
                      selectedKey: 'crPkgTabDaily',
                      onTap: _selectTab('daily'),
                    ),
                  ),
                  StacSizedBox(width: 8),
                  StacExpanded(
                    child: _buildTabItem(
                      title: 'هفتگی',
                      selectedKey: 'crPkgTabWeekly',
                      onTap: _selectTab('weekly'),
                    ),
                  ),
                  StacSizedBox(width: 8),
                  StacExpanded(
                    child: _buildTabItem(
                      title: 'ماهانه',
                      selectedKey: 'crPkgTabMonthly',
                      onTap: _selectTab('monthly'),
                    ),
                  ),
                  StacSizedBox(width: 8),
                  StacExpanded(
                    child: _buildTabItem(
                      title: 'سایر',
                      selectedKey: 'crPkgTabOther',
                      onTap: _selectTab('other'),
                    ),
                  ),
                ],
              ),
              StacSizedBox(height: 16),
              StacExpanded(
                child: StacCustomVisibility(
                  visible: '[[crPkgTabMonthly]]',
                  child: _buildMonthlyEmptyState().toJson(),
                  replacement: _buildPackageList().toJson(),
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
  );
}

StacAction _selectTab(String key) {
  return StacCustomSetValueAction(
    values: [
      {'key': 'crPkgTabDaily', 'value': key == 'daily'},
      {'key': 'crPkgTabWeekly', 'value': key == 'weekly'},
      {'key': 'crPkgTabMonthly', 'value': key == 'monthly'},
      {'key': 'crPkgTabOther', 'value': key == 'other'},
      {'key': 'crPkgContinueEnabled', 'value': false},
      {'key': 'crPkgSel1', 'value': false},
      {'key': 'crPkgSel2', 'value': false},
      {'key': 'crPkgSel3', 'value': false},
      {'key': 'crPkgSel4', 'value': false},
      {'key': 'crPkgSel5', 'value': false},
      {'key': 'crPkgSel6', 'value': false},
    ],
  );
}

StacWidget _buildTabItem({
  required String title,
  required String selectedKey,
  required StacAction onTap,
}) {
  return StacGestureDetector(
    onTap: onTap,
    child: StacCustomVisibility(
      visible: '[[$selectedKey]]',
      child: StacContainer(
        padding: StacEdgeInsets.symmetric(vertical: 10),
        decoration: StacBoxDecoration(
          color: '#EAFBFD',
          borderRadius: StacBorderRadius.all(10),
          border: StacBorder.all(color: '#20C4D8', width: 1),
        ),
        child: StacText(
          data: title,
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.center,
          style: StacCustomTextStyle(
            fontSize: 16,
            fontWeight: StacFontWeight.w600,
            color: '{{appColors.current.text.title}}',
          ),
        ),
      ).toJson(),
      replacement: StacContainer(
        padding: StacEdgeInsets.symmetric(vertical: 10),
        decoration: StacBoxDecoration(
          color: '{{appColors.current.background.surface}}',
          borderRadius: StacBorderRadius.all(10),
          border: StacBorder.all(
            color: '{{appColors.current.input.borderEnabled}}',
            width: 1,
          ),
        ),
        child: StacText(
          data: title,
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.center,
          style: StacCustomTextStyle(
            fontSize: 16,
            fontWeight: StacFontWeight.w500,
            color: '{{appColors.current.text.title}}',
          ),
        ),
      ).toJson(),
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
              routeName: 'package_real_payment',
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
