import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';

@StacScreen(screenName: 'marriage_loan_task_list')
StacWidget marriageLoanTaskListScreen() {
  return StacScaffold(
    appBar: buildTobankFlowAppBar(
      title: '{{appStrings.generated.marriage_loan.marriage_loan_menu.title}}',
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
            'visible': '[[!marriageLoanTaskSpouseFlowCompleted]]',
            'child': _taskItemCard(
              '{{appStrings.generated.marriage_loan.marriage_loan_task_list.spouse_information}}',
              routeName: 'marriage_loan_spouse_check',
            ).toJson(),
          }),
          StacSizedBox(height: 14),
          StacRawJsonWidget({
            'type': 'visibility',
            'visible': '[[!marriageLoanTaskDocsCompleted]]',
            'child': _taskItemCard(
              '{{appStrings.generated.marriage_loan.marriage_loan_task_list.applicant_documents}}',
              routeName: 'marriage_loan_applicant_document',
            ).toJson(),
          }),
          StacSizedBox(height: 14),
          StacRawJsonWidget({
            'type': 'visibility',
            'visible': '[[!marriageLoanTaskMarriageLicenseCompleted]]',
            'child': _taskItemCard(
              '{{appStrings.generated.marriage_loan.marriage_loan_task_list.marriage_license_information}}',
              routeName: 'marriage_loan_marriage_license',
            ).toJson(),
          }),
        ],
      ),
    ),
  );
}

StacWidget _taskItemCard(String title, {String? routeName}) {
  return StacContainer(
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surfaceContainer}}',
      borderRadius: StacBorderRadius.all(10),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
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
            children: [
              _statusChip(),
              StacGestureDetector(
                onTap: routeName == null
                    ? const StacShowResultAction(
                        title: 'تسهیلات ازدواج',
                        content: 'این مرحله در نسخه UI آماده شده است.',
                      )
                    : StacAction(
                        jsonData: {
                          'actionType': 'navigate',
                          'fileName': routeName,
                          'navMode': '{{marriageLoanFlowNavMode}}',
                          'navigationStyle': 'push',
                        },
                      ),
                child: StacRow(
                  textDirection: StacTextDirection.rtl,
                  children: [
                    StacText(
                      data:
                          '{{appStrings.generated.marriage_loan.marriage_loan_task_list.complete_action}}',
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
          data:
              '{{appStrings.generated.marriage_loan.marriage_loan_task_list.waiting_status}}',
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
