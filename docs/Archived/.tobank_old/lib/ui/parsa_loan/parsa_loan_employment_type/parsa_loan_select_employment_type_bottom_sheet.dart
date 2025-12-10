import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/parsa_loan/parsa_loan_employment_type_controller.dart';
import '../../../../util/theme/theme_util.dart';

class SelectEmploymentTypeBottomSheet extends StatelessWidget {
  const SelectEmploymentTypeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<ParsaLoanEmploymentTypeController>(
        builder: (controller) {
          return Padding(
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
                  height: 16.0,
                ),
                Text(
                  locale.job_type,
                  style: ThemeUtil.titleStyle,
                ),
                const SizedBox(height: 12.0),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.employmentTypeDataList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = controller.employmentTypeDataList[index];
                    return InkWell(
                      onTap: () {
                        controller.setSelectedEmploymentType(item);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          item.faTitle!,
                          style: TextStyle(
                            color: ThemeUtil.textTitleColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(thickness: 1);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
