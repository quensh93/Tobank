import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../../../../util/theme/theme_util.dart';
import '../../../../../../widget/svg/svg_icon.dart';
import '../../../../../core/entities/edit_sim_params.dart';
import '../../../../../core/entities/enums.dart';
import '../../../../../core/entities/sim_list_entity.dart';
import '../../../../../core/injection/injection.dart';
import '../../../../../core/theme/main_theme.dart';
import '../../../../../core/widgets/bottom_sheets/bottom_sheet_handler.dart';
import '../../../../../core/widgets/buttons/main_button.dart';
import '../../../../../core/widgets/dialogs/dialog_handler.dart';
import '../../bloc/edit_sim_bloc/edit_sim_bloc.dart';
import '../edit_sim_bottom_sheet/edit_sim_bottom_sheet.dart';
class SimInfoBottomSheet extends StatefulWidget {
  final Function loadSuccess;
  final SimListEntity data;

  const SimInfoBottomSheet({
    required this.data,
    required this.loadSuccess,
    super.key,
  });

  @override
  State<SimInfoBottomSheet> createState() => _SimInfoBottomSheetState();
}

class _SimInfoBottomSheetState extends State<SimInfoBottomSheet> {
  final EditSimBloc _editSimBloc = getIt<EditSimBloc>();
  late List<SimListEntity> simList = [];

  void editSimCard() {
    _editSimBloc.add(EditSimEvent.getEditSim(EditSimCardParams(
      deleteNumber: true,
      title: widget.data.title,
      simcard: widget.data.simcard,
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
              widget.data.title,
              style: ThemeUtil.titleStyle,
            ),
            const SizedBox(
              height: 16.0,
            ),
            Text(
              widget.data.simcard,
              style: MainTheme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 16.0,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                    showMainBottomSheet(
                        context: context,
                        bottomSheetWidget: EditSimBottomSheet(
                          loadSuccess: () {
                            widget.loadSuccess();
                          },
                          data: widget.data,
                        ));
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
                    child: Row(
                      children: [
                        const SvgIcon(
                          SvgIcons.icEditAccountImage,
                          size: 17.0,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          locale.edit,
                          textAlign: TextAlign.right,
                          style: MainTheme.of(context).textTheme.titleSmall,
                        )
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: 16,
                  thickness: 1,
                  color:  MainTheme.of(context).onSurface,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        DialogHandler.showDialogMessage(
                          buildContext: context,
                          message: widget.data.simcard,
                          description: locale.after_confirm_sim_card_will_delete,
                          positiveMessage: locale.deleting,
                          negativeMessage: locale.cancel,
                          iconWidget: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 48,
                                width: 48,
                                decoration: BoxDecoration(
                                    color: MainTheme.of(context).white,
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(width: 2, color: MainTheme.of(context).onSurface)),
                                padding: const EdgeInsets.all(8),
                                child: SvgIcon(
                                  widget.data.simcardOperator.getIcon(context),
                                  size: 17.0,
                                ),
                              ),
                            ],
                          ),
                          positiveFunction: () async {
                            Get.back();
                            editSimCard();
                          },
                          negativeFunction: () {
                            Get.back();
                          },
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
                        child: Row(
                          children: [
                            SvgIcon(
                              SvgIcons.icDelete,
                              size: 17.0,
                              color: MainTheme.of(context).primary,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              locale.deleting,
                              textAlign: TextAlign.right,
                              style: MainTheme.of(context).textTheme.titleMedium.copyWith(color: MainTheme.of(context).primary),
                            )
                          ],
                        ),
                      ),
                    ),
                    BlocProvider(
                      create: (BuildContext context) => _editSimBloc,
                      child: BlocConsumer<EditSimBloc, EditSimState>(
                        listener: (context, state) {
                          state.maybeMap(
                              loading: (_) {},
                              orElse: () {},
                              loadFailure: (e) {},
                              loadSuccess: (state) {
                                Get.back();
                                widget.loadSuccess();
                              });
                        },
                        builder: (context, state) {
                          return state.maybeMap(
                            loadSuccess: (_) {
                              return const SizedBox();
                            },
                            loadFailure: (_) {
                              return const SizedBox();
                            },
                            orElse: () {
                              return const SizedBox();
                            },
                            loading: (_) {
                              return SpinKitFadingCircle(
                                itemBuilder: (_, int index) {
                                  return DecoratedBox(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: MainTheme.of(context).black,
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
                  ],
                ),
              ],
            ),
            MainButton(
              title: locale.cancel,
              onTap: () {
                Get.back();
              },
              disable: false,
            )
          ],
        ),
      ),
    );
  }
}
