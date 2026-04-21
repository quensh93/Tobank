import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';
import 'package:tobank_sdui/core/stac/builders/stac_stateful_widget.dart';

@StacScreen(screenName: 'cartable_real_intro')
StacWidget cartableRealIntro() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {'key': 'isCartableTab', 'value': true},
        {'key': 'historyFilter', 'value': 'all'},
        {'key': 'historySelectedAll', 'value': true},
        {'key': 'historySelectedOpen', 'value': false},
        {'key': 'historySelectedClosed', 'value': false},
        {'key': 'historyShowOpenCard', 'value': true},
        {'key': 'historyShowClosedCards', 'value': true},
      ],
    ),
    child: StacScaffold(
      backgroundColor: '{{appColors.current.background.surface}}',
      body: StacColumn(
        children: [
          StacSizedBox(height: 16),
          _buildMainSelector(),
          StacSizedBox(height: 8),
          StacExpanded(
            child: StacCustomVisibility(
              visible: '[[isCartableTab]]',
              child: _buildCardboardPage().toJson(),
              replacement: _buildProcessPage().toJson(),
            ),
          ),
        ],
      ),
    ),
  );
}

StacWidget _buildMainSelector() {
  return StacContainer(
    margin: StacEdgeInsets.symmetric(horizontal: 16),
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surfaceContainer}}',
      borderRadius: StacBorderRadius.all(8),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
    ),
    child: StacRow(
      children: [
        StacExpanded(
          child: _buildSelectorItem(
            title: 'کارتابل',
            selectedVisible: '[[isCartableTab]]',
            onTap: const StacCustomSetValueAction(
              key: 'isCartableTab',
              value: true,
            ),
          ),
        ),
        StacContainer(
          height: 24,
          width: 2,
          color: '{{appColors.current.input.borderEnabled}}',
        ),
        StacExpanded(
          child: _buildSelectorItem(
            title: 'تاریخچه فعالیت‌ها',
            selectedVisible: '[[!isCartableTab]]',
            onTap: const StacCustomSetValueAction(
              key: 'isCartableTab',
              value: false,
            ),
          ),
        ),
      ],
    ),
  );
}

StacWidget _buildSelectorItem({
  required String title,
  required String selectedVisible,
  required StacAction onTap,
}) {
  return StacGestureDetector(
    onTap: onTap,
    child: StacSizedBox(
      height: 56,
      child: StacPadding(
        padding: StacEdgeInsets.only(top: 8),
        child: StacColumn(
          mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
          children: [
            StacContainer(),
            StacCustomVisibility(
              visible: selectedVisible,
              child: StacText(
                data: title,
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  fontSize: 16,
                  fontWeight: StacFontWeight.w900,
                  color: '{{appColors.current.text.title}}',
                ),
              ).toJson(),
              replacement: StacText(
                data: title,
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  fontSize: 16,
                  fontWeight: StacFontWeight.w400,
                  color: '{{appColors.current.text.subtitle}}',
                ),
              ).toJson(),
            ),
            StacPadding(
              padding: StacEdgeInsets.symmetric(horizontal: 16),
              child: StacCustomVisibility(
                visible: selectedVisible,
                child: StacContainer(
                  height: 3,
                  width: 56,
                  decoration: StacBoxDecoration(
                    color: '{{appColors.current.primary.color}}',
                    borderRadius: StacBorderRadius.all(3),
                  ),
                ).toJson(),
                replacement: StacContainer(
                  height: 3,
                  width: 56,
                  color: 'transparent',
                ).toJson(),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

StacWidget _buildCardboardPage() {
  return StacSingleChildScrollView(
    child: StacPadding(
      padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [_buildCardboardItem(), StacSizedBox(height: 12)],
      ),
    ),
  );
}

StacWidget _buildCardboardItem() {
  return StacContainer(
    decoration: StacBoxDecoration(
      borderRadius: StacBorderRadius.all(8),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
      color: '{{appColors.current.background.surfaceContainer}}',
    ),
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacPadding(
          padding: StacEdgeInsets.all(16),
          child: StacColumn(
            crossAxisAlignment: StacCrossAxisAlignment.stretch,
            children: [
              StacText(
                data: 'نوع درخواست: تسهیلات قرض الحسنه ازدواج',
                textDirection: StacTextDirection.rtl,
                textAlign: StacTextAlign.right,
                style: StacCustomTextStyle(
                  color: '{{appColors.current.text.title}}',
                  fontWeight: StacFontWeight.w600,
                  fontSize: 16,
                ),
              ),
              StacSizedBox(height: 24),
              StacRow(
                textDirection: StacTextDirection.rtl,
                mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
                children: [
                  StacText(
                    data: 'مرحله بعد',
                    style: StacCustomTextStyle(
                      color: '{{appColors.current.text.subtitle}}',
                      fontWeight: StacFontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  StacExpanded(
                    child: StacText(
                      data: 'اصلاح اطلاعات محل سکونت متقاضی',
                      textDirection: StacTextDirection.rtl,
                      textAlign: StacTextAlign.right,
                      style: StacCustomTextStyle(
                        color: '{{appColors.current.text.title}}',
                        fontWeight: StacFontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        StacContainer(
          color: '{{appColors.current.input.borderEnabled}}',
          width: 999999,
          height: 1,
        ),
        StacPadding(
          padding: StacEdgeInsets.symmetric(vertical: 8),
          child: StacRow(
            children: [
              StacExpanded(
                child: _buildCardboardFooterAction(
                  title: 'جزئیات',
                  iconAsset: 'assets/icons/ic_detail.svg',
                  onTap: const StacShowResultAction(
                    title: 'جزئیات',
                    content: 'جزئیات به زودی فعال می‌شود.',
                  ),
                ),
              ),
              StacContainer(
                color: '{{appColors.current.input.borderEnabled}}',
                width: 1,
                height: 32,
              ),
              StacExpanded(
                child: _buildCardboardFooterAction(
                  title: 'ادامه فرآیند',
                  iconAsset: 'assets/icons/ic_continue_process.svg',
                  onTap: const StacShowResultAction(
                    title: 'ادامه فرآیند',
                    content: 'ادامه فرآیند به زودی فعال می‌شود.',
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

StacWidget _buildCardboardFooterAction({
  required String title,
  required String iconAsset,
  required StacAction onTap,
}) {
  return StacGestureDetector(
    onTap: onTap,
    child: StacPadding(
      padding: StacEdgeInsets.all(8),
      child: StacRow(
        mainAxisAlignment: StacMainAxisAlignment.center,
        textDirection: StacTextDirection.rtl,
        children: [
          StacImage(
            src: iconAsset,
            imageType: StacImageType.asset,
            width: 24,
            height: 24,
          ),
          StacSizedBox(width: 8),
          StacText(
            data: title,
            style: StacCustomTextStyle(
              color: '{{appColors.current.text.title}}',
              fontWeight: StacFontWeight.w500,
              fontSize: 14,
            ),
          ),
        ],
      ),
    ),
  );
}

StacWidget _buildProcessPage() {
  return StacColumn(
    children: [
      StacPadding(
        padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: StacRow(
          textDirection: StacTextDirection.rtl,
          children: [
            _buildProcessFilterChip(
              title: 'همه',
              selectedVisible: '[[historySelectedAll]]',
              onTap: const StacCustomSetValueAction(
                values: [
                  {'key': 'historyFilter', 'value': 'all'},
                  {'key': 'historySelectedAll', 'value': true},
                  {'key': 'historySelectedOpen', 'value': false},
                  {'key': 'historySelectedClosed', 'value': false},
                  {'key': 'historyShowOpenCard', 'value': true},
                  {'key': 'historyShowClosedCards', 'value': true},
                ],
              ),
            ),
            StacSizedBox(width: 8),
            _buildProcessFilterChip(
              title: 'درخواست‌های باز',
              selectedVisible: '[[historySelectedOpen]]',
              onTap: const StacCustomSetValueAction(
                values: [
                  {'key': 'historyFilter', 'value': 'open'},
                  {'key': 'historySelectedAll', 'value': false},
                  {'key': 'historySelectedOpen', 'value': true},
                  {'key': 'historySelectedClosed', 'value': false},
                  {'key': 'historyShowOpenCard', 'value': true},
                  {'key': 'historyShowClosedCards', 'value': false},
                ],
              ),
            ),
            StacSizedBox(width: 8),
            _buildProcessFilterChip(
              title: 'درخواست‌های بسته',
              selectedVisible: '[[historySelectedClosed]]',
              onTap: const StacCustomSetValueAction(
                values: [
                  {'key': 'historyFilter', 'value': 'closed'},
                  {'key': 'historySelectedAll', 'value': false},
                  {'key': 'historySelectedOpen', 'value': false},
                  {'key': 'historySelectedClosed', 'value': true},
                  {'key': 'historyShowOpenCard', 'value': false},
                  {'key': 'historyShowClosedCards', 'value': true},
                ],
              ),
            ),
          ],
        ),
      ),
      StacExpanded(
        child: StacSingleChildScrollView(
          child: StacPadding(
            padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: StacColumn(
              children: [
                StacCustomVisibility(
                  visible: '[[historyShowOpenCard]]',
                  child: StacColumn(
                    children: [
                      _buildProcessItem(
                        title: 'وام قرض الحسنه ازدواج',
                        status: 'باز',
                        date: '۶ دی ۱۴۰۴',
                      ),
                      StacSizedBox(height: 16),
                    ],
                  ).toJson(),
                  replacement: StacSizedBox().toJson(),
                ),
                StacCustomVisibility(
                  visible: '[[historyShowClosedCards]]',
                  child: StacColumn(
                    children: [
                      _buildProcessItem(
                        title: 'تکمیل مدارک',
                        status: 'بسته',
                        date: '۲۴ فروردین ۱۴۰۵',
                      ),
                      StacSizedBox(height: 16),
                      _buildProcessItem(
                        title: 'تکمیل مدارک',
                        status: 'بسته',
                        date: '۲۳ فروردین ۱۴۰۵',
                      ),
                      StacSizedBox(height: 16),
                      _buildProcessItem(
                        title: 'تکمیل مدارک',
                        status: 'بسته',
                        date: '۲۳ فروردین ۱۴۰۵',
                      ),
                    ],
                  ).toJson(),
                  replacement: StacSizedBox().toJson(),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

StacWidget _buildProcessFilterChip({
  required String title,
  required String selectedVisible,
  required StacAction onTap,
}) {
  return StacGestureDetector(
    onTap: onTap,
    child: StacCustomVisibility(
      visible: selectedVisible,
      child: StacContainer(
        decoration: StacBoxDecoration(
          borderRadius: StacBorderRadius.all(8),
          color: '{{appColors.current.secondary.secondaryContainer}}',
          border: StacBorder.all(
            color: '{{appColors.current.secondary.color}}',
            width: 1,
          ),
        ),
        child: StacPadding(
          padding: StacEdgeInsets.symmetric(vertical: 6, horizontal: 12),
          child: StacText(
            data: title,
            style: StacCustomTextStyle(
              color: '{{appColors.current.secondary.color}}',
              fontWeight: StacFontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ).toJson(),
      replacement: StacContainer(
        decoration: StacBoxDecoration(
          borderRadius: StacBorderRadius.all(8),
          color: 'transparent',
          border: StacBorder.all(
            color: '{{appColors.current.input.borderEnabled}}',
            width: 1,
          ),
        ),
        child: StacPadding(
          padding: StacEdgeInsets.symmetric(vertical: 6, horizontal: 12),
          child: StacText(
            data: title,
            style: StacCustomTextStyle(
              color: '{{appColors.current.text.title}}',
              fontWeight: StacFontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ).toJson(),
    ),
  );
}

StacWidget _buildProcessItem({
  required String title,
  required String status,
  required String date,
}) {
  return StacContainer(
    decoration: StacBoxDecoration(
      borderRadius: StacBorderRadius.all(8),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
      color: '{{appColors.current.background.surfaceContainer}}',
    ),
    child: StacColumn(
      children: [
        StacPadding(
          padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: StacColumn(
            crossAxisAlignment: StacCrossAxisAlignment.stretch,
            children: [
              StacText(
                data: title,
                textDirection: StacTextDirection.rtl,
                textAlign: StacTextAlign.right,
                style: StacCustomTextStyle(
                  color: '{{appColors.current.text.title}}',
                  fontWeight: StacFontWeight.w700,
                  fontSize: 16,
                ),
              ),
              StacSizedBox(height: 24),
              StacRow(
                textDirection: StacTextDirection.rtl,
                mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
                children: [
                  StacText(
                    data: 'وضعیت درخواست:',
                    style: StacCustomTextStyle(
                      color: '{{appColors.current.text.subtitle}}',
                      fontWeight: StacFontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  StacText(
                    data: status,
                    style: StacCustomTextStyle(
                      color: '{{appColors.current.text.title}}',
                      fontWeight: StacFontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              StacSizedBox(height: 16),
              StacRow(
                textDirection: StacTextDirection.rtl,
                mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
                children: [
                  StacText(
                    data: 'تاریخ ثبت درخواست:',
                    style: StacCustomTextStyle(
                      color: '{{appColors.current.text.subtitle}}',
                      fontWeight: StacFontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  StacText(
                    data: date,
                    style: StacCustomTextStyle(
                      color: '{{appColors.current.text.title}}',
                      fontWeight: StacFontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        StacContainer(
          color: '{{appColors.current.input.borderEnabled}}',
          width: 999999,
          height: 1,
        ),
        StacSizedBox(
          height: 48,
          child: StacGestureDetector(
            onTap: const StacShowResultAction(
              title: 'جزئیات',
              content: 'جزئیات به زودی فعال می‌شود.',
            ),
            child: StacPadding(
              padding: StacEdgeInsets.all(8),
              child: StacRow(
                mainAxisAlignment: StacMainAxisAlignment.center,
                textDirection: StacTextDirection.rtl,
                children: [
                  StacImage(
                    src: 'assets/icons/ic_detail.svg',
                    imageType: StacImageType.asset,
                    width: 24,
                    height: 24,
                  ),
                  StacSizedBox(width: 8),
                  StacText(
                    data: 'جزئیات',
                    style: StacCustomTextStyle(
                      color: '{{appColors.current.text.title}}',
                      fontWeight: StacFontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
