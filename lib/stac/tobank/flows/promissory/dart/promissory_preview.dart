import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/config/sdui_build_config.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';
import 'package:tobank_sdui/stac/tobank/flows/promissory/dart/widgets/promissory_error_state.dart';
import 'package:tobank_sdui/stac/tobank/flows/promissory/dart/widgets/promissory_loading_state.dart';

/// Promissory Real Flow - Preview Page
///
/// This screen displays a preview of the promissory note:
/// 1. Shows loading spinner while fetching PDF base64.
/// 2. Shows error state if fetch fails.
/// 3. On success, renders the PDF as an image preview + Save/Share buttons.
@StacScreen(screenName: 'promissory_preview')
StacWidget promissoryRealPreview() {
  return StacStatefulWidget(
    onInit: StacSequenceAction(
      actions: [
        // Initialize state flags
        StacCustomSetValueAction(
          values: [
            {'key': 'previewLoading', 'value': true},
            {'key': 'previewError', 'value': false},
            {'key': 'previewLoaded', 'value': false},
          ],
        ),
        // Fetch PDF base64 from the endpoint
        StacNetworkRequestAction(
          url: SduiBuildConfig.bizUrl(
            'files/v1.0/{{serverSignedPdfId}}/download/base64',
          ),
          method: 'get',
          headers: {
            'accept': 'application/json',
            'content-type': 'application/json',
            'app-platform': 'android',
            'app-store': 'application/json',
            'app-version': '456',
            'device-uuid': '5109ab4c-77ca-4f0c-9858-da4df58031d2',
            'serviceauthorization':
                'Basic Z2ZRdDVha3U2anVCQW9DWHhPcEJya3J2S1dRYTpxUmZkUXp5WmhYSFRKcmZ0UGd6Zk9CRFpCUllhbDBaT0RUZ291MEVST2d3YQ==',
            'authorization': '{{auth.accessToken}}',
          },
          results: [
            {
              'statusCode': 200,
              'action': {
                'actionType': 'setValue',
                'values': [
                  {
                    'key': 'serverSignedPdf',
                    'value': '{{data_payload.base64}}',
                  },
                  {'key': 'previewLoading', 'value': false},
                  {'key': 'previewError', 'value': false},
                  {'key': 'previewLoaded', 'value': true},
                ],
              },
            },
            {
              'statusCode': -1,
              'action': {
                'actionType': 'setValue',
                'values': [
                  {'key': 'previewLoading', 'value': false},
                  {'key': 'previewError', 'value': true},
                  {'key': 'previewLoaded', 'value': false},
                ],
              },
            },
          ],
        ),
      ],
    ),
    child: StacScaffold(
      appBar: buildTobankFlowAppBar(
        showSupport: true,
        // ????? ????
        title: '{{appStrings.promissory.previewScreenTitle}}',
      ),
      body: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        textDirection: StacTextDirection.rtl,
        children: [
          StacExpanded(
            child: StacCustomStack(
              children: [
                buildPromissoryLoadingState('previewLoading'),
                buildPromissoryErrorState('previewError'),
                _buildSuccessPreviewState(),
              ],
            ),
          ),

          _buildActionButtons(),
        ],
      ),
    ),
  );
}

Map<String, dynamic> _buildSuccessPreviewState() {
  return StacCustomRegistryReactive(
    registryKey: 'previewLoaded',
    child: StacCustomVisibility(
      visible: '{{previewLoaded}}',
      child: StacSingleChildScrollView(
        padding: StacEdgeInsets.all(16),
        child: StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          textDirection: StacTextDirection.rtl,
          children: [
            StacContainer(
              width: 999999,
              decoration: StacBoxDecoration(
                color: '{{appColors.current.background.surfaceContainer}}',
                borderRadius: StacBorderRadius.all(12),
                border: StacBorder.all(
                  color: '{{appColors.current.input.borderEnabled}}',
                  width: 1,
                ),
              ),
              padding: StacEdgeInsets.all(8),
              child: StacCustomPdfPreview(
                src: '{{serverSignedPdf}}',
                registryKey: 'serverSignedPdf',
                width: 999999,
                height: 500,
              ),
            ),
          ],
        ),
      ).toJson(),
    ).toJson(),
  ).toJson();
}

StacWidget _buildActionButtons() {
  return StacCustomRegistryReactive(
    registryKey: 'previewLoaded',
    child: StacCustomVisibility(
      visible: '{{previewLoaded}}',
      child: StacPadding(
        padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: StacRow(
          textDirection: StacTextDirection.rtl,
          children: [
            // Save Button (Red)
            StacExpanded(
              child: StacElevatedButton(
                onPressed: const StacSaveFileAction(
                  fileName: 'promissory_preview.pdf',
                  registryKey: 'serverSignedPdf',
                  content: '{{serverSignedPdf}}',
                  isBase64: true,
                ),
                style: StacButtonStyle(
                  backgroundColor: '#D32F2F',
                  foregroundColor: '#FFFFFF',
                  elevation: 0,
                  fixedSize: StacSize(999999, 52),
                  shape: StacRoundedRectangleBorder(
                    borderRadius: StacBorderRadius.all(12),
                  ),
                ),
                child: StacText(
                  // ?????
                  data: '{{appStrings.promissory.saveButton}}',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 16,
                    fontWeight: StacFontWeight.bold,
                    color: '#FFFFFF',
                  ),
                ),
              ),
            ),
            StacSizedBox(width: 12),
            // Share Button (Outlined)
            StacExpanded(
              child: StacElevatedButton(
                onPressed: const StacShareFileAction(
                  fileName: 'promissory.pdf',
                  registryKey: 'serverSignedPdf',
                  content: '{{serverSignedPdf}}',
                  mimeType: 'application/pdf',
                ),
                style: StacButtonStyle(
                  backgroundColor: '#FFFFFF',
                  foregroundColor: '#D32F2F',
                  elevation: 0,
                  fixedSize: StacSize(999999, 52),
                  shape: StacRoundedRectangleBorder(
                    borderRadius: StacBorderRadius.all(12),
                    side: const StacBorderSide(color: '#D32F2F', width: 1.5),
                  ),
                ),
                child: StacText(
                  // ?????? ?????
                  data: '{{appStrings.promissory.shareButton}}',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 16,
                    fontWeight: StacFontWeight.bold,
                    color: '#D32F2F',
                  ),
                ),
              ),
            ),
          ],
        ),
      ).toJson(),
    ).toJson(),
  );
}
