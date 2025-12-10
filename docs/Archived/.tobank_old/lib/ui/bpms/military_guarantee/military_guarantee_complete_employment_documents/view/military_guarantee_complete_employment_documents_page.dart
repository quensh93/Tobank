import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../../controller/bpms/military_guarantee/military_guarantee_complete_employment_documents_controller.dart';
import '../../../../../../util/theme/theme_util.dart';
import '../../../../../../widget/button/continue_button_widget.dart';

class MilitaryGuaranteeCompleteEmploymentDocumentsPage extends StatelessWidget {
  const MilitaryGuaranteeCompleteEmploymentDocumentsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<MilitaryGuaranteeCompleteEmploymentDocumentsController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
               locale.applicant_employment_information_registration,
                style: ThemeUtil.titleStyle,
              ),
              const SizedBox(
                height: 16.0,
              ),
              Text(
               locale.confirm_employment_document_upload_prompt,
                style: TextStyle(
                  color: ThemeUtil.textSubtitleColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 1.6,
                ),
              ),
              Expanded(child: Container()),
              Row(
                children: [
                  Expanded(
                      child: SizedBox(
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        controller.validateConfirmCompleteEmploymentDocuments(isConfirmed: false);
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
                              locale.not_interested,
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
                        controller.validateConfirmCompleteEmploymentDocuments(isConfirmed: true);
                      },
                      isLoading: controller.isLoading,
                      buttonTitle:locale.interested,
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
