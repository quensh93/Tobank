import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/stac_core/navigation/nav_modes.dart';

@StacScreen(screenName: 'cartable_intro')
StacWidget cartableRealIntro() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
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
      body: StacDefaultTabController(
        length: 2,
        initialIndex: 1,
        child: StacColumn(
          children: [
            StacSizedBox(height: 52),
            _buildMainSelector(),
            StacSizedBox(height: 8),
            StacExpanded(
              child: StacTabBarView(
                children: [_buildProcessPage(), _buildCardboardPage()],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

StacWidget _buildMainSelector() {
  return StacContainer(
    color: '{{appColors.current.background.surfaceContainer}}',
    child: StacStack(
      children: [
        StacTabBar(
          enableFeedback: false,
          indicatorColor: '{{appColors.current.primary.color}}',
          indicatorWeight: 3,
          indicatorSize: StacTabBarIndicatorSize.tab,
          indicatorPadding: StacEdgeInsets.only(left: 70, top: 54, right: 70),
          dividerColor: '{{appColors.current.input.borderEnabled}}',
          dividerHeight: 1,
          labelStyle: StacCustomTextStyle(
            fontSize: 18,
            fontWeight: StacFontWeight.w700,
          ),
          unselectedLabelStyle: StacCustomTextStyle(
            fontSize: 18,
            fontWeight: StacFontWeight.w500,
          ),
          labelColor: '{{appColors.current.text.title}}',
          unselectedLabelColor: '{{appColors.current.text.subtitle}}',
          tabs: const [
            StacTab(
              text:
                  '{{appStrings.generated.cartable.cartable_intro.date_active}}',
              height: 62,
            ),
            StacTab(text: '{{appStrings.menu.items.inbox}}', height: 62),
          ],
        ),
        StacPositioned(
          top: 12,
          bottom: 12,
          left: 0,
          right: 0,
          child: StacCenter(
            child: StacContainer(
              width: 1,
              color: '{{appColors.current.input.borderEnabled}}',
            ),
          ),
        ),
      ],
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
                data: '{{appStrings.generated.cartable.cartable_intro.title}}',
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
                children: [
                  StacText(
                    data:
                        '{{appStrings.generated.cartable.cartable_intro.next_step}}',
                    textDirection: StacTextDirection.rtl,
                    textAlign: StacTextAlign.right,
                    style: StacCustomTextStyle(
                      color: '{{appColors.current.text.subtitle}}',
                      fontWeight: StacFontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  StacSizedBox(width: 24),
                  StacExpanded(
                    child: StacText(
                      data:
                          '{{appStrings.generated.cartable.cartable_intro.information_place}}',
                      textDirection: StacTextDirection.rtl,
                      textAlign: StacTextAlign.left,
                      maxLines: 1,
                      softWrap: false,
                      overflow: StacTextOverflow.ellipsis,
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
            textDirection: StacTextDirection.rtl,
            children: [
              StacExpanded(
                child: _buildCardboardFooterAction(
                  title:
                      '{{appStrings.generated.card_management.card_management_root.details}}',
                  iconAsset: 'assets/icons/ic_detail.svg',
                  onTap: _buildOpenProcessDetailsAction(
                    caseId: 'marriage_loan',
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
                  title:
                      '{{appStrings.generated.cartable.cartable_intro.continue_process}}',
                  iconAsset: 'assets/icons/ic_continue_process.svg',
                  onTap: const StacShowResultAction(
                    title:
                        '{{appStrings.generated.cartable.cartable_intro.continue_process}}',
                    content:
                        '{{appStrings.generated.cartable.cartable_intro.continue_active_process}}',
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
              title:
                  '{{appStrings.generated.cartable.cartable_intro.all_filter}}',
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
              title: '{{appStrings.generated.cartable.cartable_intro.request}}',
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
              title:
                  '{{appStrings.generated.cartable.cartable_intro.request_package}}',
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
                        title:
                            '{{appStrings.generated.cartable.cartable_detail.loan}}',
                        status:
                            '{{appStrings.generated.cartable.cartable_detail.open_status}}',
                        date:
                            '{{appStrings.generated.cartable.cartable_intro.amount_value}}',
                        detailCaseId: 'marriage_loan',
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
                        title:
                            '{{appStrings.generated.cartable.cartable_detail.documents_complete}}',
                        status:
                            '{{appStrings.generated.cartable.cartable_detail.package}}',
                        date:
                            '{{appStrings.generated.cartable.cartable_intro.amount_value_message}}',
                        detailCaseId: 'docs_done',
                      ),
                      StacSizedBox(height: 16),
                      _buildProcessItem(
                        title:
                            '{{appStrings.generated.cartable.cartable_detail.documents_complete}}',
                        status:
                            '{{appStrings.generated.cartable.cartable_detail.package}}',
                        date:
                            '{{appStrings.generated.cartable.cartable_intro.amount_value_label}}',
                        detailCaseId: 'docs_empty',
                      ),
                      StacSizedBox(height: 16),
                      _buildProcessItem(
                        title:
                            '{{appStrings.generated.cartable.cartable_detail.documents_complete}}',
                        status:
                            '{{appStrings.generated.cartable.cartable_detail.package}}',
                        date:
                            '{{appStrings.generated.cartable.cartable_intro.amount_value_label}}',
                        detailCaseId: 'child_loan',
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
  required String detailCaseId,
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
                  _buildRtlLabelWithColon(
                    title:
                        '{{appStrings.generated.cartable.cartable_intro.status_request}}',
                  ),
                  StacText(
                    data: status,
                    textDirection: StacTextDirection.rtl,
                    textAlign: StacTextAlign.left,
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
                  _buildRtlLabelWithColon(
                    title:
                        '{{appStrings.generated.cartable.cartable_intro.date_submit_request}}',
                  ),
                  StacText(
                    data: date,
                    textDirection: StacTextDirection.rtl,
                    textAlign: StacTextAlign.left,
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
            onTap: _buildOpenProcessDetailsAction(caseId: detailCaseId),
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
                    data:
                        '{{appStrings.generated.card_management.card_management_root.details}}',
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

StacAction _buildOpenProcessDetailsAction({required String caseId}) {
  final bool isMarriageLoan = caseId == 'marriage_loan';
  final bool isChildLoan = caseId == 'child_loan';
  final bool isDocsDone = caseId == 'docs_done';
  final bool isDocsEmpty = caseId == 'docs_empty';

  return StacSequenceAction(
    actions: [
      StacCustomSetValueAction(
        values: [
          {'key': 'crDetailVariantMarriageLoan', 'value': isMarriageLoan},
          {'key': 'crDetailVariantChildLoan', 'value': isChildLoan},
          {'key': 'crDetailVariantCompleteDocsDone', 'value': isDocsDone},
          {'key': 'crDetailVariantCompleteDocsEmpty', 'value': isDocsEmpty},
        ],
      ),
      NavigationAction(fileName: 'cartable_detail', navMode: NavModes.dart),
    ],
  );
}

StacWidget _buildRtlLabelWithColon({required String title}) {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    mainAxisSize: StacMainAxisSize.min,
    children: [
      StacText(
        data: title,
        textDirection: StacTextDirection.rtl,
        textAlign: StacTextAlign.right,
        style: StacCustomTextStyle(
          color: '{{appColors.current.text.subtitle}}',
          fontWeight: StacFontWeight.w500,
          fontSize: 14,
        ),
      ),
      StacSizedBox(width: 2),
      StacText(
        data: ':',
        textDirection: StacTextDirection.ltr,
        style: StacCustomTextStyle(
          color: '{{appColors.current.text.subtitle}}',
          fontWeight: StacFontWeight.w500,
          fontSize: 14,
        ),
      ),
    ],
  );
}
