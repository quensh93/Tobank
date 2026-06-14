import 'package:stac/stac.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'child_loan_task_list')
StacWidget childLoanTaskListScreen() {
  return StacScaffold(
    appBar: buildTobankFlowAppBar(
      title: 'تسهیلات فرزندآوری',
      showBack: true,
      showSupport: true,
    ),
    body: StacSingleChildScrollView(
      padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacRawJsonWidget({
            'type': 'visibility',
            'visible': '[[!childLoanTaskResidenceCompleted]]',
            'child': _taskItemCard(
              'اطلاعات محل سکونت متقاضی',
              routeName: 'child_loan_guarantee_address',
            ).toJson(),
          }),
          StacSizedBox(height: 14),
          StacRawJsonWidget({
            'type': 'visibility',
            'visible': '[[!childLoanTaskChildInfoCompleted]]',
            'child': _taskItemCard(
              'اطلاعات فرزند متقاضی',
              routeName: 'child_loan_child_check',
            ).toJson(),
          }),
          StacSizedBox(height: 14),
          StacRawJsonWidget({
            'type': 'visibility',
            'visible': '[[!childLoanTaskDocsCompleted]]',
            'child': _taskItemCard(
              'مدارک متقاضی',
              routeName: 'child_loan_customer_document',
            ).toJson(),
          }),
        ],
      ),
    ),
  );
}

StacWidget _taskItemCard(String title, {required String routeName}) {
  return StacContainer(
    decoration: StacBoxDecoration(
      borderRadius: StacBorderRadius.all(10),
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
          child: StacText(
            data: title,
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.right,
            style: StacTextStyle(
              fontSize: 16,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
            ),
          ),
        ),
        StacContainer(
          height: 1,
          color: '{{appColors.current.input.borderEnabled}}',
        ),
        StacPadding(
          padding: StacEdgeInsets.all(16),
          child: StacRow(
            textDirection: StacTextDirection.rtl,
            mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
            crossAxisAlignment: StacCrossAxisAlignment.center,
            children: [
              _statusChip(),
              StacGestureDetector(
                onTap: NavigationAction(fileName: routeName, navMode: NavModes.dart, navigationStyle: NavigationStyle.push),
                child: StacRow(
                  textDirection: StacTextDirection.rtl,
                  children: [
                    StacText(
                      data: 'تکمیل',
                      textDirection: StacTextDirection.rtl,
                      style: StacTextStyle(
                        fontSize: 16,
                        fontWeight: StacFontWeight.w600,
                        color: '{{appColors.current.text.title}}',
                      ),
                    ),
                    StacSizedBox(width: 8),
                    StacImage(
                      src: '{{appAssets.icons.arrowLeft}}',
                      imageType: StacImageType.asset,
                      width: 30,
                      height: 30,
                      color: '{{appColors.current.primary.color}}',
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

StacWidget _statusChip() {
  return StacContainer(
    padding: StacEdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: StacBoxDecoration(
      color: '{{appColors.current.secondary.secondaryContainer}}',
      borderRadius: StacBorderRadius.all(8),
    ),
    child: StacRow(
      textDirection: StacTextDirection.rtl,
      mainAxisSize: StacMainAxisSize.min,
      children: [
        StacContainer(
          width: 14,
          height: 14,
          decoration: StacBoxDecoration(
            color: '{{appColors.current.secondary.color}}',
            borderRadius: StacBorderRadius.all(999),
          ),
        ),
        StacSizedBox(width: 8),
        StacText(
          data: 'در انتظار تکمیل',
          textDirection: StacTextDirection.rtl,
          style: StacTextStyle(
            fontSize: 12,
            fontWeight: StacFontWeight.w600,
            color: '{{appColors.current.secondary.color}}',
          ),
        ),
      ],
    ),
  );
}
