import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../../../../util/snack_bar_util.dart';
import '../../../../../../widget/svg/svg_icon.dart';
import '../../../../../core/entities/charge_and_package_list_params.dart';
import '../../../../../core/entities/enums.dart';
import '../../../../../core/entities/sim_list_entity.dart';
import '../../../../../core/injection/injection.dart';
import '../../../../../core/services/network/failures/api_failure/api_failure.dart';
import '../../../../../core/services/network/failures/app_failure/app_failure.dart';
import '../../../../../core/widgets/bottom_sheets/bottom_sheet_handler.dart';
import '../../bloc/charge_and_package_list_bloc/charge_and_package_list_bloc.dart';
import '../../pages/package_list_page.dart';
import '../get_amount/get_amount_bottom_sheet.dart';
import '../select_operator/select_operator_bottom_sheet.dart';
import '../sim_info_bottom_sheet/sim_info_bottom_sheet.dart';

class SimsItem extends StatefulWidget {
  final bool isLoading;
  final int index;
  final SimListEntity data;
  final ChargeAndPackageType type;
  final Function onDone;
  final Function editLoadSuccess;

  const SimsItem({
    required this.index,
    required this.isLoading,
    required this.onDone,
    required this.editLoadSuccess,
    required this.data,
    required this.type,
    super.key,
  });

  @override
  State<SimsItem> createState() => _SimsItemState();
}

class _SimsItemState extends State<SimsItem> {
  late ChargeAndPackageListBloc _chargeAndPackageListBloc;

  @override
  void initState() {
    _chargeAndPackageListBloc = getIt<ChargeAndPackageListBloc>();
    super.initState();
  }

  void getProductData(String number, int index) {
    if (!widget.isLoading) {
      _chargeAndPackageListBloc
          .add(ChargeAndPackageListEvent.getChargeAndPackageList(ChargeAndPackageListParams(
        mobile: number,
        serviceType: widget.type,
      )));
    }
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return InkWell(
      splashColor: widget.isLoading ? Colors.transparent : null,
      onTap: () {
        getProductData(widget.data.simcard, widget.index);
      },
      onLongPress: () {
        showMainBottomSheet(
            context: context,
            bottomSheetWidget: SimInfoBottomSheet(
              loadSuccess: () {
                widget.editLoadSuccess();
              },
              data: widget.data,
            ));
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: ShapeDecoration(
          // color: MainTheme.of(context).onSurface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 30,
              child: SvgIcon(
                widget.data.simcardOperator.getIcon(context),
                size: 21,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.data.title, style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(
                  height: 5,
                ),
                Text(widget.data.simcard, style: Theme.of(context).textTheme.titleSmall),
              ],
            )),
            SizedBox(
              child: BlocProvider(
                create: (BuildContext context) => _chargeAndPackageListBloc,
                child: BlocConsumer<ChargeAndPackageListBloc, ChargeAndPackageListState>(
                  listener: (context, state) {
                    state.maybeMap(loading: (_) {
                      widget.onDone(true);
                      // widget.isLoading = true;
                    }, orElse: () {
                      widget.onDone(false);
                      // widget.isLoading = false;
                    }, loadFailure: (e) {
                      widget.onDone(false);

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
                                  showMainBottomSheet(
                                    context: context,
                                    bottomSheetWidget: SelectOperatorBottomSheet(
                                      phone: widget.data.simcard,
                                      chargeAndPackageType: widget.type,
                                    ),
                                  );
                                } else {
                                  SnackBarUtil.showSnackBar(
                                    title: locale.error_occurred,
                                    message:
                                    e.response!['message'] ?? locale.cant_buy_charge_with_this_number,
                                  );
                                }
                              },
                            );
                          });
                    }, loadSuccess: (state) {
                      widget.onDone(false);
                      // isLoading = false;
                      if (widget.type == ChargeAndPackageType.CHARGE) {
                        if (state.chargeAndPackageListResponse.findAllResponse!.content != null &&
                            state.chargeAndPackageListResponse.findAllResponse!.content!.isNotEmpty) {
                          showMainBottomSheet(
                            context: context,
                            bottomSheetWidget: GetAmountBottomSheet(
                              data: state.chargeAndPackageListResponse,
                              mobile: widget.data.simcard,
                            ),
                          );
                        } else {
                          SnackBarUtil.showSnackBar(
                            title: locale.error_occurred,
                            message: locale.cant_buy_charge_with_this_number,
                          );
                        }
                      } else {
                        Get.to(() => PackageListPage(
                              chargeAndPackages: state.chargeAndPackageListResponse,
                              phone: widget.data.simcard,
                            ));
                      }
                    });
                  },
                  builder: (context, state) {
                    return state.maybeMap(
                      loadSuccess: (_) {
                        return SvgIcon(
                          SvgIcons.arrowLeftNew,
                          colorFilter:
                              ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn),
                        );
                      },
                      loadFailure: (_) {
                        return SvgIcon(
                          SvgIcons.arrowLeftNew,
                          colorFilter:
                              ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn),
                        );
                      },
                      orElse: () {
                        return SvgIcon(
                          SvgIcons.arrowLeftNew,
                          colorFilter:
                              ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn),
                        );
                      },
                      loading: (_) {
                        return SizedBox(
                          child: SpinKitFadingCircle(
                            itemBuilder: (_, int index) {
                              return DecoratedBox(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              );
                            },
                            size: 24.0,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
