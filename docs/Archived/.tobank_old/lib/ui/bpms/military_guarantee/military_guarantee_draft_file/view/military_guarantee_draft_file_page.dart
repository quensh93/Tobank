import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../../controller/bpms/military_guarantee/military_guarantee_draft_file_controller.dart';
import '../../../../../../util/theme/theme_util.dart';
import '../../../../../../widget/button/continue_button_widget.dart';
import '../../../../common/contract/contract_widget.dart';

class MilitaryGuaranteeDraftFilePage extends StatelessWidget {
  const MilitaryGuaranteeDraftFilePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<MilitaryGuaranteeDraftFileController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                locale.draft_guarantee_commitment_advance,
                style: ThemeUtil.titleStyle,
              ),
              const SizedBox(
                height: 16.0,
              ),
              Expanded(
                child: ContractWidget(
                  rejectReason: null,
                  pdfData: base64Decode(controller.draftBase64!),
                  previewFunction: () => controller.showPreviewScreen(),
                  showShare: false,
                  shareFunction: () => () {},
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
              Row(
                children: [
                  Expanded(
                      child: SizedBox(
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        controller.validateDraftFile(isAccepted: false);
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: context.theme.colorScheme.surface,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: ThemeUtil.primaryColor,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                      ),
                      child: controller.isLoading
                          ? SpinKitFadingCircle(
                              itemBuilder: (_, int index) {
                                return DecoratedBox(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: context.theme.iconTheme.color,
                                  ),
                                );
                              },
                              size: 24.0,
                            )
                          : Text(
                             locale.edit_information,
                              style: TextStyle(
                                color: ThemeUtil.primaryColor,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  )),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    child: ContinueButtonWidget(
                      callback: () {
                        controller.validateDraftFile(isAccepted: true);
                      },
                      isLoading: controller.isLoading,
                      buttonTitle: locale.confirmation,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
