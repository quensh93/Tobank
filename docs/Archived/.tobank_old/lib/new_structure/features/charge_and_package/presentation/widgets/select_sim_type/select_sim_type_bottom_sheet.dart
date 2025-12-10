import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../../../../util/snack_bar_util.dart';
import '../../../../../../util/theme/theme_util.dart';
import '../../../../../core/entities/charge_and_package_list_params.dart';
import '../../../../../core/entities/enums.dart';
import '../../../../../core/injection/injection.dart';
import '../../../../../core/services/network/failures/api_failure/api_failure.dart';
import '../../../../../core/services/network/failures/app_failure/app_failure.dart';
import '../../../../../core/theme/main_theme.dart';
import '../../../../../core/widgets/bottom_sheets/bottom_sheet_handler.dart';
import '../../../../../core/widgets/buttons/main_button.dart';
import '../../bloc/charge_and_package_list_bloc/charge_and_package_list_bloc.dart';
import '../../pages/package_list_page.dart';
import '../get_amount/get_amount_bottom_sheet.dart';
import '../select_operator/select_operator_bottom_sheet.dart';

class SelectSimTypeBottomSheet extends StatefulWidget {
  final String phone;
  final OperatorType operatorType;
  final ChargeAndPackageType chargeAndPackageType;

  const SelectSimTypeBottomSheet({
    required this.phone,
    required this.operatorType,
    required this.chargeAndPackageType,
    super.key,
  });

  @override
  State<SelectSimTypeBottomSheet> createState() => _SelectSimTypeBottomSheetState();
}

class _SelectSimTypeBottomSheetState extends State<SelectSimTypeBottomSheet> {
  SimType simType = SimType.PERMANENT;

  final ChargeAndPackageListBloc _chargeAndPackageListBloc = getIt<ChargeAndPackageListBloc>();

  void getListData() {
    _chargeAndPackageListBloc
        .add(ChargeAndPackageListEvent.getChargeAndPackageList(ChargeAndPackageListParams(
      mobile: widget.phone,
      serviceType: widget.chargeAndPackageType,
      operator: widget.operatorType,
      simcardType: simType,
    )));
  }

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
          children: [
            Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: MainTheme.of(context).onSurfaceVariant,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            Text(
              locale.sim_card_type,
              style: ThemeUtil.titleStyle,
            ),
            const SizedBox(
              height: 16.0,
            ),
            Text(
              widget.phone,
              style: MainTheme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 16.0,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                simItemWidget(
                  type: SimType.PERMANENT,
                  title: locale.permanent,
                ),
                const SizedBox(height: 16),
                simItemWidget(
                  type: SimType.PREPAID,
                  title: locale.credit,
                ),
              ],
            ),
            MainButton(
              widget: BlocProvider(
                create: (BuildContext context) => _chargeAndPackageListBloc,
                child: BlocConsumer<ChargeAndPackageListBloc, ChargeAndPackageListState>(
                  listener: (context, state) {
                    state.maybeMap(
                        loading: (_) {},
                        orElse: () {},
                        loadFailure: (e) {

                          e.maybeWhen(
                              orElse: () {},
                              loadFailure: (AppFailure e) {
                                e.maybeWhen(
                                  orElse: () {
                                    return null;
                                  },
                                  apiFailureService: (ApiFailure e) {
                                    if (e.response != null &&
                                        e.response!['data'] != null &&
                                        !(e.response!['data'] is List) &&
                                        e.response!['data']['status'] == 10808) {
                                      Get.back();
                                      showMainBottomSheet(
                                        context: context,
                                        bottomSheetWidget: SelectOperatorBottomSheet(
                                          phone: widget.phone,
                                          chargeAndPackageType: widget.chargeAndPackageType,
                                        ),
                                      );
                                    } else {
                                      Get.back();
                                      SnackBarUtil.showSnackBar(
                                        title: locale.error_occurred,
                                        message:
                                        e.response!['message'] ?? locale.cant_buy_charge_with_this_number,
                                      );
                                    }
                                  },
                                );
                              });
                        },
                        loadSuccess: (state) {
                          if (widget.chargeAndPackageType == ChargeAndPackageType.CHARGE) {
                            if (state.chargeAndPackageListResponse.findAllResponse!.content != null &&
                                state.chargeAndPackageListResponse.findAllResponse!.content!
                                    .isNotEmpty) {
                              showMainBottomSheet(
                                context: context,
                                bottomSheetWidget: GetAmountBottomSheet(
                                  data: state.chargeAndPackageListResponse,
                                  mobile: widget.phone,
                                ),
                              );
                            } else {
                              Get.back();
                              SnackBarUtil.showSnackBar(
                                title: locale.error_occurred,
                                message: locale.cant_buy_charge_with_this_number,
                              );
                            }
                          } else {
                            Get.to(() => PackageListPage(
                                  chargeAndPackages: state.chargeAndPackageListResponse,
                                  phone: widget.phone,
                                ));
                          }
                        });
                  },
                  builder: (context, state) {
                    return state.maybeMap(
                      loadSuccess: (_) {
                        return Text(
                          locale.continue_label,
                          textAlign: TextAlign.center,
                          style: MainTheme.of(context).textTheme.titleMedium.copyWith(
                            color: MainTheme.of(context).staticWhite,
                          ),
                        );
                      },
                      loadFailure: (_) {
                        return Text(
                          locale.continue_label,
                          textAlign: TextAlign.center,
                          style: MainTheme.of(context).textTheme.titleMedium.copyWith(
                            color: MainTheme.of(context).staticWhite,
                          ),
                        );
                      },
                      orElse: () {
                        return Text(
                          locale.continue_label,
                          textAlign: TextAlign.center,
                          style: MainTheme.of(context).textTheme.titleMedium.copyWith(
                            color: MainTheme.of(context).staticWhite,
                          ),
                        );
                      },
                      loading: (_) {
                        return SpinKitFadingCircle(
                          itemBuilder: (_, int index) {
                            return const DecoratedBox(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                            );
                          },
                          size: 24.0,
                        );
                      },
                    );
                  },
                ),
              ),
              onTap: () {
                getListData();
              },
              disable: false,
            )
          ],
        ),
      ),
    );
  }

  Widget simItemWidget({
    required String title,
    required SimType type,
  }) {
    return InkWell(
      onTap: () {
        setState(() {
          simType = type;
        });
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: type == simType ? MainTheme.of(context).secondary : MainTheme.of(context).surfaceContainerLowest,
            )),
        child: Row(
          children: [
            const SizedBox(height: 40),
            Text(
              title,
              textAlign: TextAlign.right,
              style: MainTheme.of(context).textTheme.titleSmall,
            ),
            const Spacer(),
            if (type == simType)
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  color: type == simType ? MainTheme.of(context).secondary : MainTheme.of(context).surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 15,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
