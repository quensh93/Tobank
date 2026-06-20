import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

const List<String> authenticationRealJobTitles = [
  '{{appStrings.authentication.jobPhysician}}',
  '{{appStrings.authentication.jobBusiness}}',
  '{{appStrings.authentication.jobRetired}}',
  '{{appStrings.authentication.jobManufacturing}}',
  '{{appStrings.authentication.jobServices}}',
  '{{appStrings.authentication.jobConstruction}}',
  '{{appStrings.authentication.jobCultural}}',
  '{{appStrings.authentication.jobGovernmentEmployee}}',
  '{{appStrings.authentication.jobRecreational}}',
  '{{appStrings.authentication.jobLawyer}}',
  '{{appStrings.authentication.jobHomemaker}}',
  '{{appStrings.authentication.jobPensioner}}',
  '{{appStrings.authentication.jobStudent}}',
  '{{appStrings.authentication.jobUnemployed}}',
  '{{appStrings.authentication.jobUnemploymentInsured}}',
  '{{appStrings.authentication.jobForeignNoPermit}}',
  '{{appStrings.authentication.jobOtherTourism}}',
];

@StacScreen(screenName: 'authentication_job_selector')
StacWidget authenticationRealJobSelector() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildTobankFlowAppBar(
      title: '{{appStrings.menu.items.authentication}}',
      showSupport: false,
    ),
    body: StacSafeArea(
      bottom: true,
      top: false,
      child: buildAuthenticationRealJobSelectorContent(showHandle: false),
    ),
  );
}

StacWidget buildAuthenticationRealJobSelectorContent({
  required bool showHandle,
}) {
  return StacColumn(
    crossAxisAlignment: StacCrossAxisAlignment.stretch,
    children: [
      if (showHandle) StacSizedBox(height: 8),
      if (showHandle)
        StacCenter(
          child: StacContainer(
            width: 44,
            height: 4,
            decoration: StacBoxDecoration(
              color: '#D9DDE5',
              borderRadius: StacBorderRadius.all(999),
            ),
          ),
        ),
      StacSizedBox(height: showHandle ? 18 : 24),
      StacPadding(
        padding: StacEdgeInsets.symmetric(horizontal: 16),
        child: StacText(
          data: '{{appStrings.authentication.jobSelectorTitle}}',
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.center,
          style: StacCustomTextStyle(
            fontSize: 18,
            fontWeight: StacFontWeight.w700,
            color: '{{appColors.current.text.title}}',
          ),
        ),
      ),
      StacSizedBox(height: 16),
      StacExpanded(
        child: StacSingleChildScrollView(
          child: StacColumn(
            crossAxisAlignment: StacCrossAxisAlignment.stretch,
            children: authenticationRealJobTitles
                .map((title) => _buildJobListItem(title))
                .toList(),
          ),
        ),
      ),
    ],
  );
}

StacWidget _buildJobListItem(String title) {
  return StacGestureDetector(
    onTap: StacSequenceAction(
      actions: [
        StacCustomSetValueAction(
          values: [
            {'key': 'authenticationSelectedJobTitle', 'value': title},
            {'key': 'authenticationHasSelectedJob', 'value': true},
          ],
        ),
        const StacNavigateAction(navigationStyle: NavigationStyle.pop),
      ],
    ),
    child: StacContainer(
      padding: StacEdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: StacBoxDecoration(
        border: StacBorder(
          bottom: StacBorderSide(
            color: '{{appColors.current.background.surfaceContainerHigh}}',
            width: 1,
          ),
        ),
      ),
      child: StacText(
        data: title,
        textDirection: StacTextDirection.rtl,
        textAlign: StacTextAlign.right,
        style: StacCustomTextStyle(
          fontSize: 16,
          fontWeight: StacFontWeight.w600,
          color: '{{appColors.current.text.title}}',
        ),
      ),
    ),
  );
}
