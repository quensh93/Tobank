import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';
import 'package:tobank_sdui/core/stac/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/stac/tobank/flows/transaction_real/dart/widgets/transaction_real_app_bar.dart';

@StacScreen(screenName: 'transaction_real_filter')
StacWidget transactionRealFilter() {
  return StacStatefulWidget(
    child: StacScaffold(
      backgroundColor: '#F4F5F8',
      appBar: buildTransactionRealAppBar(title: 'فیلتر تراکنش‌ها'),
      body: StacSingleChildScrollView(
        padding: StacEdgeInsets.all(16),
        child: StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          children: [
            StacSizedBox(height: 8),
            _buildDirectionRow(),
            StacSizedBox(height: 24),
            _sectionTitle('بازه زمانی'),
            StacSizedBox(height: 12),
            StacRow(
              textDirection: StacTextDirection.rtl,
              children: [
                StacExpanded(child: _buildDateField(title: 'از تاریخ')),
                StacSizedBox(width: 10),
                StacExpanded(child: _buildDateField(title: 'تا تاریخ')),
              ],
            ),
            StacSizedBox(height: 24),
            _sectionTitle('نوع تراکنش'),
            StacSizedBox(height: 12),
            _buildTypeChips(),
            StacSizedBox(height: 24),
            _sectionTitle('وضعیت تراکنش'),
            StacSizedBox(height: 12),
            _buildStatusRow(),
            StacSizedBox(height: 28),
            StacFilledButton(
              onPressed: _applyAndBackAction(),
              style: StacButtonStyle(
                minimumSize: StacSize(double.infinity, 54),
                backgroundColor: '#D90429',
                foregroundColor: '#FFFFFF',
                shape: StacRoundedRectangleBorder(
                  borderRadius: StacBorderRadius.all(12),
                ),
              ),
              child: StacText(
                data: 'فیلتر نتایج',
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  fontSize: 17,
                  fontWeight: StacFontWeight.w700,
                  color: '#FFFFFF',
                ),
              ),
            ),
            StacSizedBox(height: 12),
          ],
        ),
      ),
    ),
  );
}

StacAction _applyAndBackAction() {
  return const StacSequenceAction(
    actions: [
      StacCustomSetValueAction(
        values: [
          {'key': 'trIntroIsTobankTab', 'value': true},
          {
            'key': 'trIntroChipWalletSelected',
            'value': true,
            'condition': 'trFilterWalletTypeSelected',
          },
          {
            'key': 'trIntroChipAllSelected',
            'value': false,
            'condition': 'trFilterWalletTypeSelected',
          },
          {
            'key': 'trIntroChipWalletSelected',
            'value': false,
            'condition': '!trFilterWalletTypeSelected',
          },
          {
            'key': 'trIntroChipAllSelected',
            'value': true,
            'condition': '!trFilterWalletTypeSelected',
          },
          {
            'key': 'trIntroShowSuccessTx',
            'value': true,
            'condition': 'trFilterStatusNoLimit',
          },
          {
            'key': 'trIntroShowFailedTx',
            'value': true,
            'condition': 'trFilterStatusNoLimit',
          },
          {
            'key': 'trIntroShowSuccessTx',
            'value': true,
            'condition': 'trFilterStatusSuccessSelected',
          },
          {
            'key': 'trIntroShowFailedTx',
            'value': false,
            'condition': 'trFilterStatusSuccessSelected',
          },
          {
            'key': 'trIntroShowSuccessTx',
            'value': false,
            'condition': 'trFilterStatusFailedSelected',
          },
          {
            'key': 'trIntroShowFailedTx',
            'value': true,
            'condition': 'trFilterStatusFailedSelected',
          },
        ],
      ),
      StacNavigateAction(navigationStyle: NavigationStyle.pop),
    ],
  );
}

StacWidget _sectionTitle(String title) {
  return StacText(
    data: title,
    textDirection: StacTextDirection.rtl,
    textAlign: StacTextAlign.right,
    style: StacCustomTextStyle(
      fontSize: 32,
      fontWeight: StacFontWeight.w700,
      color: '#1F2937',
    ),
  );
}

StacWidget _buildDirectionRow() {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    mainAxisAlignment: StacMainAxisAlignment.end,
    children: [
      _buildDirectionChip(
        title: 'دریافت وجه',
        icon: 'south',
        selectedVisible: '[[trFilterDirectionReceive]]',
        selectedColor: '#26B366',
        onTap: const StacSequenceAction(
          actions: [
            StacCustomSetValueAction(
              key: 'trFilterDirectionReceive',
              value: '{{!trFilterDirectionReceive}}',
            ),
            StacCustomSetValueAction(
              key: 'trFilterDirectionSend',
              value: false,
            ),
          ],
        ),
      ),
      StacSizedBox(width: 8),
      _buildDirectionChip(
        title: 'ارسال وجه',
        icon: 'north',
        selectedVisible: '[[trFilterDirectionSend]]',
        selectedColor: '#F4B500',
        onTap: const StacSequenceAction(
          actions: [
            StacCustomSetValueAction(
              key: 'trFilterDirectionSend',
              value: '{{!trFilterDirectionSend}}',
            ),
            StacCustomSetValueAction(
              key: 'trFilterDirectionReceive',
              value: false,
            ),
          ],
        ),
      ),
    ],
  );
}

StacWidget _buildDirectionChip({
  required String title,
  required String icon,
  required String selectedVisible,
  required String selectedColor,
  required StacAction onTap,
}) {
  return StacGestureDetector(
    onTap: onTap,
    child: StacCustomVisibility(
      visible: selectedVisible,
      child: StacContainer(
        padding: StacEdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: StacBoxDecoration(
          color: selectedColor,
          borderRadius: StacBorderRadius.all(10),
        ),
        child: StacRow(
          textDirection: StacTextDirection.rtl,
          children: [
            StacIcon(icon: icon, size: 16, color: '#FFFFFF'),
            StacSizedBox(width: 6),
            StacText(
              data: title,
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 14,
                fontWeight: StacFontWeight.w600,
                color: '#FFFFFF',
              ),
            ),
          ],
        ),
      ).toJson(),
      replacement: StacContainer(
        padding: StacEdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: StacBoxDecoration(
          color: '#FFFFFF',
          borderRadius: StacBorderRadius.all(10),
          border: StacBorder.all(color: '#DDE2E8', width: 1),
        ),
        child: StacRow(
          textDirection: StacTextDirection.rtl,
          children: [
            StacIcon(icon: icon, size: 16, color: '#9AA3AF'),
            StacSizedBox(width: 6),
            StacText(
              data: title,
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 14,
                fontWeight: StacFontWeight.w600,
                color: '#6B7280',
              ),
            ),
          ],
        ),
      ).toJson(),
    ),
  );
}

StacWidget _buildDateField({required String title}) {
  return StacGestureDetector(
    onTap: const StacShowResultAction(
      title: 'انتخاب تاریخ',
      content: 'این بخش در این مرحله به صورت نمایشی است.',
    ),
    child: StacContainer(
      height: 56,
      padding: StacEdgeInsets.symmetric(horizontal: 12),
      decoration: StacBoxDecoration(
        color: '#FFFFFF',
        borderRadius: StacBorderRadius.all(12),
        border: StacBorder.all(color: '#DDE2E8', width: 1),
      ),
      child: StacRow(
        textDirection: StacTextDirection.rtl,
        children: [
          StacImage(
            src: '{{appAssets.icons.calendar}}',
            imageType: StacImageType.asset,
            width: 20,
            height: 20,
            color: '#23C4D8',
          ),
          StacSizedBox(width: 8),
          StacExpanded(
            child: StacText(
              data: title,
              textDirection: StacTextDirection.rtl,
              textAlign: StacTextAlign.right,
              style: StacCustomTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w600,
                color: '#4B5563',
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

StacWidget _buildTypeChips() {
  return StacColumn(
    children: [
      _buildTypeRow(
        left: _buildTypeChip(
          title: 'خرید کارت هدیه',
          key: 'trFilterTypeGiftCard',
        ),
        center: _buildTypeChip(
          title: 'انتقال کیف پول',
          key: 'trFilterTypeTransferWallet',
          onTap: const StacSequenceAction(
            actions: [
              StacCustomSetValueAction(
                key: 'trFilterTypeTransferWallet',
                value: '{{!trFilterTypeTransferWallet}}',
              ),
              StacCustomSetValueAction(
                key: 'trFilterWalletTypeSelected',
                value: '{{trFilterTypeTransferWallet}}',
              ),
            ],
          ),
        ),
        right: _buildTypeChip(
          title: 'کارت به کارت',
          key: 'trFilterTypeCardToCard',
        ),
      ),
      StacSizedBox(height: 8),
      _buildTypeRow(
        left: _buildTypeChip(
          title: 'خرید بسته اینترنتی',
          key: 'trFilterTypeBuyInternet',
        ),
        center: _buildTypeChip(
          title: 'خرید شارژ مستقیم',
          key: 'trFilterTypeBuyRecharge',
        ),
        right: _buildTypeChip(title: 'نیکوکاری', key: 'trFilterTypeCharity'),
      ),
      StacSizedBox(height: 8),
      _buildTypeRow(
        left: _buildTypeChip(
          title: 'شارژ کیف پول',
          key: 'trFilterTypeWalletCharge',
          onTap: const StacSequenceAction(
            actions: [
              StacCustomSetValueAction(
                key: 'trFilterTypeWalletCharge',
                value: '{{!trFilterTypeWalletCharge}}',
              ),
              StacCustomSetValueAction(
                key: 'trFilterWalletTypeSelected',
                value: '{{trFilterTypeWalletCharge}}',
              ),
            ],
          ),
        ),
        center: _buildTypeChip(
          title: 'پرداخت قبوض',
          key: 'trFilterTypeBillPayment',
        ),
        right: _buildTypeChip(
          title: 'پرداخت گروهی قبوض',
          key: 'trFilterTypeGroupBill',
        ),
      ),
      StacSizedBox(height: 8),
      _buildTypeRow(
        left: _buildTypeChip(
          title: 'استرداد وجه',
          key: 'trFilterTypeRefund',
          onTap: const StacSequenceAction(
            actions: [
              StacCustomSetValueAction(
                key: 'trFilterTypeRefund',
                value: '{{!trFilterTypeRefund}}',
              ),
              StacCustomSetValueAction(
                key: 'trFilterWalletTypeSelected',
                value: '{{trFilterTypeRefund}}',
              ),
            ],
          ),
        ),
        center: _buildTypeChip(
          title: 'صندوق امانات',
          key: 'trFilterTypeSafeBox',
        ),
        right: StacSizedBox(),
      ),
    ],
  );
}

StacWidget _buildTypeRow({
  required StacWidget left,
  required StacWidget center,
  required StacWidget right,
}) {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    children: [
      StacExpanded(child: left),
      StacSizedBox(width: 8),
      StacExpanded(child: center),
      StacSizedBox(width: 8),
      StacExpanded(child: right),
    ],
  );
}

StacWidget _buildTypeChip({
  required String title,
  required String key,
  StacAction? onTap,
}) {
  return StacGestureDetector(
    onTap: onTap ?? StacCustomSetValueAction(key: key, value: '{{!$key}}'),
    child: StacCustomVisibility(
      visible: '[[$key]]',
      child: StacContainer(
        height: 42,
        decoration: StacBoxDecoration(
          color: '#23C4D8',
          borderRadius: StacBorderRadius.all(10),
        ),
        child: StacCenter(
          child: StacText(
            data: title,
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.center,
            style: StacCustomTextStyle(
              fontSize: 13,
              fontWeight: StacFontWeight.w600,
              color: '#FFFFFF',
            ),
          ),
        ),
      ).toJson(),
      replacement: StacContainer(
        height: 42,
        decoration: StacBoxDecoration(
          color: '#FFFFFF',
          borderRadius: StacBorderRadius.all(10),
          border: StacBorder.all(color: '#E4E7EC', width: 1),
        ),
        child: StacCenter(
          child: StacText(
            data: title,
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.center,
            style: StacCustomTextStyle(
              fontSize: 13,
              fontWeight: StacFontWeight.w500,
              color: '#7C8796',
            ),
          ),
        ),
      ).toJson(),
    ),
  );
}

StacWidget _buildStatusRow() {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    children: [
      StacExpanded(
        child: _buildStatusChip(
          title: 'پرداخت موفق',
          icon: 'check_circle_outline',
          selectedVisible: '[[trFilterStatusSuccessSelected]]',
          selectedColor: '#26B366',
          onTap: const StacSequenceAction(
            actions: [
              StacCustomSetValueAction(
                key: 'trFilterStatusSuccessSelected',
                value: '{{!trFilterStatusSuccessSelected}}',
              ),
              StacCustomSetValueAction(
                key: 'trFilterStatusFailedSelected',
                value: false,
              ),
              StacCustomSetValueAction(
                key: 'trFilterStatusNoLimit',
                value: '{{!trFilterStatusSuccessSelected}}',
              ),
            ],
          ),
        ),
      ),
      StacSizedBox(width: 10),
      StacExpanded(
        child: _buildStatusChip(
          title: 'پرداخت ناموفق',
          icon: 'highlight_off',
          selectedVisible: '[[trFilterStatusFailedSelected]]',
          selectedColor: '#E53935',
          onTap: const StacSequenceAction(
            actions: [
              StacCustomSetValueAction(
                key: 'trFilterStatusFailedSelected',
                value: '{{!trFilterStatusFailedSelected}}',
              ),
              StacCustomSetValueAction(
                key: 'trFilterStatusSuccessSelected',
                value: false,
              ),
              StacCustomSetValueAction(
                key: 'trFilterStatusNoLimit',
                value: '{{!trFilterStatusFailedSelected}}',
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

StacWidget _buildStatusChip({
  required String title,
  required String icon,
  required String selectedVisible,
  required String selectedColor,
  required StacAction onTap,
}) {
  return StacGestureDetector(
    onTap: onTap,
    child: StacCustomVisibility(
      visible: selectedVisible,
      child: StacContainer(
        height: 44,
        padding: StacEdgeInsets.symmetric(horizontal: 12),
        decoration: StacBoxDecoration(
          color: selectedColor,
          borderRadius: StacBorderRadius.all(10),
        ),
        child: StacRow(
          mainAxisAlignment: StacMainAxisAlignment.center,
          textDirection: StacTextDirection.rtl,
          children: [
            StacIcon(icon: icon, size: 16, color: '#FFFFFF'),
            StacSizedBox(width: 8),
            StacText(
              data: title,
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 14,
                fontWeight: StacFontWeight.w600,
                color: '#FFFFFF',
              ),
            ),
          ],
        ),
      ).toJson(),
      replacement: StacContainer(
        height: 44,
        padding: StacEdgeInsets.symmetric(horizontal: 12),
        decoration: StacBoxDecoration(
          color: '#FFFFFF',
          borderRadius: StacBorderRadius.all(10),
          border: StacBorder.all(color: '#DDE2E8', width: 1),
        ),
        child: StacRow(
          mainAxisAlignment: StacMainAxisAlignment.center,
          textDirection: StacTextDirection.rtl,
          children: [
            StacIcon(icon: icon, size: 16, color: '#9AA3AF'),
            StacSizedBox(width: 8),
            StacText(
              data: title,
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 14,
                fontWeight: StacFontWeight.w600,
                color: '#6B7280',
              ),
            ),
          ],
        ),
      ).toJson(),
    ),
  );
}
