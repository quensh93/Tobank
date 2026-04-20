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
      backgroundColor: '#F4F5F8',
      body: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacSizedBox(height: 46),
          _buildTopTabs(),
          StacSizedBox(height: 8),
          StacExpanded(
            child: StacPadding(
              padding: StacEdgeInsets.symmetric(horizontal: 14),
              child: StacCustomVisibility(
                visible: '[[isCartableTab]]',
                child: _buildCartableContent().toJson(),
                replacement: _buildHistoryContent().toJson(),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

StacWidget _buildTopTabs() {
  return StacContainer(
    margin: StacEdgeInsets.symmetric(horizontal: 14),
    padding: StacEdgeInsets.symmetric(horizontal: 12, vertical: 12),
    decoration: StacBoxDecoration(
      color: '#FFFFFF',
      borderRadius: StacBorderRadius.all(12),
      border: StacBorder.all(color: '#DDE2E8', width: 1),
    ),
    child: StacRow(
      textDirection: StacTextDirection.rtl,
      children: [
        StacExpanded(
          child: _buildTopTabItem(
            title: 'کارتابل',
            selectedVisible: '[[isCartableTab]]',
            onTap: const StacCustomSetValueAction(
              key: 'isCartableTab',
              value: true,
            ),
          ),
        ),
        StacContainer(width: 1, height: 26, color: '#E5E7EB'),
        StacExpanded(
          child: _buildTopTabItem(
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

StacWidget _buildTopTabItem({
  required String title,
  required String selectedVisible,
  required StacAction onTap,
}) {
  return StacGestureDetector(
    onTap: onTap,
    child: StacContainer(
      width: 999999,
      height: 52,
      color: 'transparent',
      child: StacColumn(
        mainAxisAlignment: StacMainAxisAlignment.center,
        children: [
          StacCustomVisibility(
            visible: selectedVisible,
            child: StacText(
              data: title,
              textDirection: StacTextDirection.rtl,
              textAlign: StacTextAlign.center,
              style: StacCustomTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w700,
                color: '#1F2937',
              ),
            ).toJson(),
            replacement: StacText(
              data: title,
              textDirection: StacTextDirection.rtl,
              textAlign: StacTextAlign.center,
              style: StacCustomTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w500,
                color: '#6B7280',
              ),
            ).toJson(),
          ),
          StacSizedBox(height: 8),
          StacCustomVisibility(
            visible: selectedVisible,
            child: StacContainer(
              width: 56,
              height: 3,
              decoration: StacBoxDecoration(
                color: '#D32F2F',
                borderRadius: StacBorderRadius.all(3),
              ),
            ).toJson(),
            replacement: StacContainer(
              height: 3,
              width: 56,
              color: 'transparent',
            ).toJson(),
          ),
        ],
      ),
    ),
  );
}

StacWidget _buildCartableContent() {
  return StacSingleChildScrollView(
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacSizedBox(height: 12),
        StacContainer(
          decoration: StacBoxDecoration(
            color: '#FFFFFF',
            borderRadius: StacBorderRadius.all(12),
            border: StacBorder.all(color: '#DDE2E8', width: 1),
          ),
          child: StacColumn(
            crossAxisAlignment: StacCrossAxisAlignment.stretch,
            children: [
              StacPadding(
                padding: StacEdgeInsets.all(14),
                child: StacColumn(
                  crossAxisAlignment: StacCrossAxisAlignment.stretch,
                  children: [
                    StacText(
                      data: 'نوع درخواست: تسهیلات قرض الحسنه ازدواج',
                      textDirection: StacTextDirection.rtl,
                      textAlign: StacTextAlign.right,
                      style: StacCustomTextStyle(
                        fontSize: 16,
                        fontWeight: StacFontWeight.w700,
                        color: '#1F2937',
                      ),
                    ),
                    StacSizedBox(height: 14),
                    StacRow(
                      textDirection: StacTextDirection.rtl,
                      mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
                      children: [
                        StacText(
                          data: 'مرحله بعد',
                          style: StacCustomTextStyle(
                            fontSize: 14,
                            fontWeight: StacFontWeight.w500,
                            color: '#7C8796',
                          ),
                        ),
                        StacExpanded(
                          child: StacText(
                            data: 'اصلاح اطلاعات محل سکونت متقاضی',
                            textDirection: StacTextDirection.rtl,
                            textAlign: StacTextAlign.right,
                            style: StacCustomTextStyle(
                              fontSize: 15,
                              fontWeight: StacFontWeight.w600,
                              color: '#1F2937',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              StacContainer(height: 1, color: '#E5E7EB'),
              StacPadding(
                padding: StacEdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: StacRow(
                  textDirection: StacTextDirection.rtl,
                  children: [
                    StacExpanded(
                      child: _buildFooterAction(
                        title: 'جزئیات',
                        icon: 'list_alt_outlined',
                        onTap: const StacShowResultAction(
                          title: 'جزئیات',
                          content: 'جزئیات به زودی فعال می‌شود.',
                        ),
                      ),
                    ),
                    StacContainer(width: 1, height: 28, color: '#E5E7EB'),
                    StacExpanded(
                      child: _buildFooterAction(
                        title: 'ادامه فرآیند',
                        icon: 'trending_up',
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
        ),
      ],
    ),
  );
}

StacWidget _buildHistoryContent() {
  return StacSingleChildScrollView(
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacSizedBox(height: 12),
        StacRow(
          textDirection: StacTextDirection.rtl,
          children: [
            StacExpanded(
              child: _buildFilterChip(
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
            ),
            StacSizedBox(width: 8),
            StacExpanded(
              child: _buildFilterChip(
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
            ),
            StacSizedBox(width: 8),
            StacExpanded(
              child: _buildFilterChip(
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
            ),
          ],
        ),
        StacSizedBox(height: 12),
        StacCustomVisibility(
          visible: '[[historyShowOpenCard]]',
          child: StacColumn(
            children: [
              _buildHistoryCard(
                title: 'وام قرض الحسنه ازدواج',
                status: 'باز',
                date: '۶ دی ۱۴۰۴',
              ),
              StacSizedBox(height: 12),
            ],
          ).toJson(),
          replacement: StacSizedBox().toJson(),
        ),
        StacCustomVisibility(
          visible: '[[historyShowClosedCards]]',
          child: StacColumn(
            children: [
              _buildHistoryCard(
                title: 'تکمیل مدارک',
                status: 'بسته',
                date: '۲۴ فروردین ۱۴۰۵',
              ),
              StacSizedBox(height: 12),
              _buildHistoryCard(
                title: 'تکمیل مدارک',
                status: 'بسته',
                date: '۲۳ فروردین ۱۴۰۵',
              ),
              StacSizedBox(height: 12),
              _buildHistoryCard(
                title: 'تکمیل مدارک',
                status: 'بسته',
                date: '۲۳ فروردین ۱۴۰۵',
              ),
              StacSizedBox(height: 8),
            ],
          ).toJson(),
          replacement: StacSizedBox().toJson(),
        ),
      ],
    ),
  );
}

StacWidget _buildFilterChip({
  required String title,
  required String selectedVisible,
  required StacAction onTap,
}) {
  return StacGestureDetector(
    onTap: onTap,
    child: StacCustomVisibility(
      visible: selectedVisible,
      child: StacContainer(
        padding: StacEdgeInsets.symmetric(vertical: 10),
        decoration: StacBoxDecoration(
          color: '#E8FBFE',
          borderRadius: StacBorderRadius.all(10),
          border: StacBorder.all(color: '#23C4D8', width: 1),
        ),
        child: StacText(
          data: title,
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.center,
          style: StacCustomTextStyle(
            fontSize: 14,
            fontWeight: StacFontWeight.w600,
            color: '#06A7BC',
          ),
        ),
      ).toJson(),
      replacement: StacContainer(
        padding: StacEdgeInsets.symmetric(vertical: 10),
        decoration: StacBoxDecoration(
          color: '#FFFFFF',
          borderRadius: StacBorderRadius.all(10),
          border: StacBorder.all(color: '#DDE2E8', width: 1),
        ),
        child: StacText(
          data: title,
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.center,
          style: StacCustomTextStyle(
            fontSize: 14,
            fontWeight: StacFontWeight.w500,
            color: '#4B5563',
          ),
        ),
      ).toJson(),
    ),
  );
}

StacWidget _buildHistoryCard({
  required String title,
  required String status,
  required String date,
}) {
  return StacContainer(
    decoration: StacBoxDecoration(
      color: '#FFFFFF',
      borderRadius: StacBorderRadius.all(12),
      border: StacBorder.all(color: '#DDE2E8', width: 1),
    ),
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacPadding(
          padding: StacEdgeInsets.all(14),
          child: StacColumn(
            crossAxisAlignment: StacCrossAxisAlignment.stretch,
            children: [
              StacText(
                data: title,
                textDirection: StacTextDirection.rtl,
                textAlign: StacTextAlign.right,
                style: StacCustomTextStyle(
                  fontSize: 17,
                  fontWeight: StacFontWeight.w700,
                  color: '#1F2937',
                ),
              ),
              StacSizedBox(height: 16),
              _buildInfoRow(label: 'وضعیت درخواست:', value: status),
              StacSizedBox(height: 10),
              _buildInfoRow(label: 'تاریخ ثبت درخواست:', value: date),
            ],
          ),
        ),
        StacContainer(height: 1, color: '#E5E7EB'),
        StacPadding(
          padding: StacEdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: _buildFooterAction(
            title: 'جزئیات',
            icon: 'list_alt_outlined',
            onTap: const StacShowResultAction(
              title: 'جزئیات',
              content: 'جزئیات به زودی فعال می‌شود.',
            ),
          ),
        ),
      ],
    ),
  );
}

StacWidget _buildInfoRow({required String label, required String value}) {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
    children: [
      StacText(
        data: label,
        style: StacCustomTextStyle(
          fontSize: 14,
          fontWeight: StacFontWeight.w500,
          color: '#7C8796',
        ),
      ),
      StacText(
        data: value,
        style: StacCustomTextStyle(
          fontSize: 14,
          fontWeight: StacFontWeight.w700,
          color: '#1F2937',
        ),
      ),
    ],
  );
}

StacWidget _buildFooterAction({
  required String title,
  required String icon,
  required StacAction onTap,
}) {
  return StacGestureDetector(
    onTap: onTap,
    child: StacRow(
      mainAxisAlignment: StacMainAxisAlignment.center,
      textDirection: StacTextDirection.rtl,
      children: [
        StacIcon(icon: icon, size: 21, color: '#3F4B5B'),
        StacSizedBox(width: 8),
        StacText(
          data: title,
          style: StacCustomTextStyle(
            fontSize: 15,
            fontWeight: StacFontWeight.w600,
            color: '#1F2937',
          ),
        ),
      ],
    ),
  );
}
