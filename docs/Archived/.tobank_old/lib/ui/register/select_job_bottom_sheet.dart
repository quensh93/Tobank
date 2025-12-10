import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/register/response/get_jobs_list_response_data.dart';
import '../../../util/theme/theme_util.dart';

class SelectJobBottomSheet extends StatelessWidget {
  const SelectJobBottomSheet({required this.jobList, required this.selectJob, super.key});

  final List<JobModel> jobList;
  final Function(JobModel job) selectJob;

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 36,
                    height: 4,
                    decoration:
                        BoxDecoration(color: context.theme.dividerColor, borderRadius: BorderRadius.circular(4))),
              ],
            ),
            const SizedBox(
              height: 24.0,
            ),
            Text(locale.select_activity_field_prompt, style: ThemeUtil.titleStyle),
            const SizedBox(
              height: 24.0,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return InkWell(
                        borderRadius: BorderRadius.circular(8.0),
                        onTap: () {
                          selectJob(jobList[index]);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            jobList[index].faTitle ?? '',
                            textDirection: TextDirection.rtl,
                            overflow: TextOverflow.visible,
                            style: TextStyle(
                              color: ThemeUtil.textTitleColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(thickness: 1);
                    },
                    itemCount: jobList.length),
              ),
            )
          ],
        ),
      ),
    );
  }
}
