import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/internet/response/internet_plan_data.dart';
import '../../../util/app_util.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/ui/dotted_line_widget.dart';

class InternetPlanItemWidget extends StatelessWidget {
  const InternetPlanItemWidget({
    required this.dataPlanList,
    required this.isLoading,
    required this.returnDataFunction,
    super.key,
    this.selectedId,
  });

  final DataPlanList dataPlanList;
  final Function(DataPlanList dataPlanList) returnDataFunction;
  final bool isLoading;
  final int? selectedId;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
        border: Border.all(color: context.theme.dividerColor),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
          ),
          onTap: () {
            if (!isLoading) {
              returnDataFunction(dataPlanList);
            }
          },
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      dataPlanList.title ?? '',
                      style: TextStyle(
                        color: ThemeUtil.textTitleColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.0,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    MySeparator(color: context.theme.dividerColor),
                    const SizedBox(
                      height: 24.0,
                    ),
                    Text(
                      locale.amount_including_tax,
                      style: TextStyle(
                        color: ThemeUtil.textSubtitleColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                elevation: 1,
                shadowColor: Colors.transparent,
                margin: const EdgeInsets.only(bottom: 8.0),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  child: isLoading && selectedId != null && selectedId == dataPlanList.id
                      ? SizedBox(
                          width: 80.0,
                          child: SpinKitFadingCircle(
                            itemBuilder: (_, int index) {
                              return DecoratedBox(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: context.theme.colorScheme.secondary,
                                ),
                              );
                            },
                            size: 24.0,
                          ),
                        )
                      : Text(
                          locale.amount_format(AppUtil.formatMoney(dataPlanList.priceWithTax)),
                          style: TextStyle(
                            color: ThemeUtil.textTitleColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
