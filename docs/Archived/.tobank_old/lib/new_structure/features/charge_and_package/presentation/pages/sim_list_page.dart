import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../../../../../util/theme/theme_util.dart';
import '../../../../../ui/common/custom_error.dart';
import '../../../../../ui/common/custom_loading.dart';
import '../../../../../widget/svg/svg_icon.dart';
import '../../../../core/entities/charge_and_package_list_data_entity.dart';
import '../../../../core/entities/enums.dart';
import '../../../../core/entities/sim_list_entity.dart';
import '../../../../core/injection/injection.dart';
import '../../../../core/interfaces/usecases/usecase.dart';
import '../../../../core/theme/main_theme.dart';
import '../../../../core/widgets/buttons/main_button.dart';
import '../bloc/get_sim_list_bloc/get_sim_list_bloc.dart';
import '../widgets/sim_list/sims_item.dart';
import 'add_sim_main_page.dart';

class SimListPage extends StatefulWidget {
  final ChargeAndPackageType type;

  const SimListPage({
    required this.type,
    super.key,
  });

  @override
  State<SimListPage> createState() => _SimListPageState();
}

class _SimListPageState extends State<SimListPage> {
  final GetSimListBloc _getSimListBloc = getIt<GetSimListBloc>();
  late List<SimListEntity> simList = [];
  bool isLoading = false;

  late List<ChargeAndPackageListDataEntity> loanPaymentList = [];

  @override
  void initState() {
    getListData();
    super.initState();
  }

  void getListData() {
    _getSimListBloc.add(GetSimListEvent.getSimList(NoParams()));
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 24.0,
            ),
            Text(
              locale.sim_cards,
              style: ThemeUtil.titleStyle,
            ),
            Expanded(
              child: BlocProvider(
                create: (BuildContext context) => _getSimListBloc,
                child: BlocConsumer<GetSimListBloc, GetSimListState>(
                  listener: (context, state) {
                    state.maybeMap(
                      loading: (_) {},
                      orElse: () {},
                      loadFailure: (e) {},
                      loadSuccess: (state) {
                        simList = state.getSimListResponse;
                      },
                    );
                  },
                  builder: (context, state) {
                    return state.maybeMap(
                      loadSuccess: (_) {
                        if (simList.isNotEmpty) {
                          return ListView.separated(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            itemCount: simList.length,
                            physics: const AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return SimsItem(
                                editLoadSuccess: (){
                                  getListData();
                                },
                                onDone: (bool isDone){
                                  setState(() {
                                    isLoading = isDone;
                                  });
                                },
                                isLoading: isLoading,
                                data: simList[index],
                                index: index,
                                type: widget.type,
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: 10);
                            },
                          );
                        } else {
                          return noListItem();
                        }
                      },
                      loadFailure: (state) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: CustomError(
                            message: locale.problem_in_server,
                            retryFunction: () {
                              getListData();
                            },
                            backFunction: () {
                              Get.back();
                            },
                          ),
                        );
                      },
                      orElse: () {
                        return noListItem();
                      },
                      loading: (_) {
                        return const Center(child: CustomLoading());
                      },
                    );
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MainButton(
                  widget: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgIcon(
                          SvgIcons.addPlus,
                          colorFilter: ColorFilter.mode(MainTheme.of(context).staticWhite, BlendMode.srcIn),
                          size: 20.0,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          widget.type == ChargeAndPackageType.CHARGE ? locale.new_charge : locale.new_package,
                          style: MainTheme.of(context).textTheme.titleMedium.copyWith(color: MainTheme.of(context).staticWhite),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Get.to(() => AddSimMainPage(
                          chargeAndPackageType: widget.type,
                        ));
                  },
                  disable: false,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget noListItem() {
    //locale
    final locale = AppLocalizations.of(Get.context!)!;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgIcon(
            widget.type == ChargeAndPackageType.CHARGE
                ?Get.isDarkMode ?SvgIcons.icChargeEmptyListDark: SvgIcons.icChargeEmptyListLight
                : Get.isDarkMode ?SvgIcons.icPackageEmptyListDark:SvgIcons.icPackageEmptyListLight,
            // size: 170.0,
          ),
          const SizedBox(
            height: 24.0,
          ),
          Text(
              widget.type == ChargeAndPackageType.CHARGE
                  ? locale.you_havent_purchased_charge
                  : locale.you_havent_purchased_internet_package,
              style: MainTheme.of(context).textTheme.titleLarge),
          const SizedBox(
            height: 8.0,
          ),
          Text(
              widget.type == ChargeAndPackageType.CHARGE
                  ? locale.buy_first_charge
                  : locale.buy_first_internet_pack,
              style: MainTheme.of(context).textTheme.titleLarge.copyWith(color: MainTheme.of(context).surfaceContainer)),
        ],
      ),
    );
  }
}