import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/bpms/response/user_process_instances_response_data.dart';
import '../../../util/date_converter_util.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/svg/svg_icon.dart';

class ProcessItemWidget extends StatelessWidget {
  const ProcessItemWidget({
    required this.processInstance,
    required this.detailButtonTitle,
    required this.showDetailButton,
    required this.detailFunction,
    required this.shareFunction,
    super.key,
  });

  final ProcessInstance processInstance;
  final String detailButtonTitle;
  final bool showDetailButton;
  final Function(ProcessInstance processInstance) detailFunction;
  final Function(ProcessInstance processInstance) shareFunction;

  String getRequestTypeText() {
    return processInstance.processDefinitionName ?? '';
  }

  String getRequestStatusText() {

//locale
    final locale = AppLocalizations.of(Get.context!)!;
    switch (processInstance.state) {
      case 'ACTIVE':
        return locale.active;
      case 'SUSPENDED':
        return locale.suspended;
      case 'COMPLETED':
        return locale.completed_or_terminated;
      case 'EXTERNALLY_TERMINATED':
        return locale.completed_or_terminated;
      case 'INTERNALLY_TERMINATED':
        return locale.completed_or_terminated;
      default:
        return locale.default_unknown;
    }
  }

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0), border: Border.all(color: context.theme.dividerColor)),
      child: Column(
        children: [
          Card(
            elevation: Get.isDarkMode ? 1 : 0,
            margin: EdgeInsets.zero,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: BorderSide(color: context.theme.dividerColor, width: 0.5),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getRequestTypeText(),
                    style: TextStyle(
                      color: ThemeUtil.textTitleColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 16.0,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${locale.status_request}: ',
                        style: TextStyle(
                          color: ThemeUtil.textSubtitleColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          getRequestStatusText(),
                          style: TextStyle(
                            color: ThemeUtil.textTitleColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${locale.registration_date_request}: ',
                        style: TextStyle(
                          color: ThemeUtil.textSubtitleColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          DateConverterUtil.getJalaliFromTimestamp(processInstance.startTime!),
                          style: TextStyle(
                            color: ThemeUtil.textTitleColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 48.0,
            child: Row(
              children: [
                if (showDetailButton)
                  Expanded(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
                        onTap: () {
                          detailFunction(processInstance);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgIcon(
                                Get.isDarkMode ? SvgIcons.detailDark : SvgIcons.detail,
                                size: 24.0,
                              ),
                              const SizedBox(
                                width: 8.0,
                              ),
                              Text(
                                detailButtonTitle,
                                style: TextStyle(
                                  color: ThemeUtil.textTitleColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.0,
                                  height: 1.6,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                else
                  Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
