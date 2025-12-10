import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/gift_card/response/list_event_plan_data.dart';
import '../../../util/app_util.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/svg/svg_icon.dart';

class GiftCardPlanItem extends StatelessWidget {
  const GiftCardPlanItem({
    required this.plan,
    required this.returnSelectedFunction,
    required this.reloadFunction,
    required this.isLoading,
    super.key,
    this.selectedPlan,
  });

  final Plan? selectedPlan;
  final Plan plan;
  final Function(Plan plan) returnSelectedFunction;
  final Function reloadFunction;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: context.theme.dividerColor),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8.0),
        onTap: () {
          if (!isLoading) {
            returnSelectedFunction(plan);
          }
        },
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                child: FastCachedImage(
                  fit: BoxFit.fill,
                  width: double.infinity,
                  url: AppUtil.baseUrlStatic() + plan.image!,
                  loadingBuilder: (context, progress) => const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  errorBuilder: (context, url, error) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              reloadFunction();
                            },
                            child: SvgIcon(
                              SvgIcons.imageLoadError,
                              colorFilter: ColorFilter.mode(ThemeUtil.textSubtitleColor, BlendMode.srcIn),
                              size: 32,
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            locale.gift_card_image_not_found,
                            style: TextStyle(
                              color: ThemeUtil.textSubtitleColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 10.0,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            if (selectedPlan != null && isLoading && selectedPlan!.id == plan.id)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SpinKitFadingCircle(
                      itemBuilder: (_, int index) {
                        return DecoratedBox(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: context.theme.iconTheme.color!,
                          ),
                        );
                      },
                      size: 32.0,
                    )
                  ],
                ),
              )
            else
              Row(
                children: [
                  Radio(
                    activeColor: context.theme.colorScheme.secondary,
                    value: plan,
                    groupValue: selectedPlan,
                    onChanged: (Plan? value) {
                      returnSelectedFunction(value!);
                    },
                  ),
                  Flexible(
                    child: Text(
                      plan.title ?? '',
                      style: TextStyle(
                        color: ThemeUtil.textTitleColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
