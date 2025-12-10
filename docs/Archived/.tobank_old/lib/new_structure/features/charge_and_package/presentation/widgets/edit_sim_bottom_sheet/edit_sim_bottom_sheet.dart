import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../../../../../widget/svg/svg_icon.dart';
import '../../../../../core/entities/edit_sim_params.dart';
import '../../../../../core/entities/enums.dart';
import '../../../../../core/entities/sim_list_entity.dart';
import '../../../../../core/injection/injection.dart';
import '../../../../../core/theme/main_theme.dart';
import '../../../../../core/widgets/buttons/main_button.dart';
import '../../../../../core/widgets/buttons/main_text_field.dart';
import '../../bloc/edit_sim_bloc/edit_sim_bloc.dart';

class EditSimBottomSheet extends StatefulWidget {
  final SimListEntity data;
  final Function loadSuccess;

  const EditSimBottomSheet({required this.data, required this.loadSuccess, super.key});

  @override
  State<EditSimBottomSheet> createState() => _EditSimBottomSheetState();
}

class _EditSimBottomSheetState extends State<EditSimBottomSheet> {
  final TextEditingController textController = TextEditingController();
  final EditSimBloc _editSimBloc = getIt<EditSimBloc>();
  late List<SimListEntity> simList = [];

  @override
  void initState() {
    textController.text = widget.data.title;
    super.initState();
  }

  void editSimCard({required String title}) {
    _editSimBloc.add(EditSimEvent.getEditSim(EditSimCardParams(
      deleteNumber: false,
      title: title,
      simcard: widget.data.simcard,
    )));
  }

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
      child: SingleChildScrollView(
        padding: EdgeInsets.zero,
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
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: MainTheme.of(context).white,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: MainTheme.of(context).surfaceContainerLowest)),
              child: SvgIcon(
                widget.data.simcardOperator.getIcon(context),
                size: 40.0,
              ),
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
            MainTextField(
              textController: textController,
              onChanged: () {
                setState(() {});
              },
              isDigit: false,
              hintText: locale.enter_name,
              maxLength: 20,
              isShowCounter: true,
            ),
            MainButton(
              widget: BlocProvider(
                create: (BuildContext context) => _editSimBloc,
                child: BlocConsumer<EditSimBloc, EditSimState>(
                  listener: (context, state) {
                    state.maybeMap(
                        loading: (_) {},
                        orElse: () {},
                        loadFailure: (e) {},
                        loadSuccess: (state) {
                          simList = state.editSimResponse;
                          Get.back();
                          widget.loadSuccess();
                        });
                  },
                  builder: (context, state) {
                    //locale
                    final locale = AppLocalizations.of(context)!;
                    return state.maybeMap(
                      loadSuccess: (_) {
                        return Text(
                          locale.save,
                          textAlign: TextAlign.center,
                          style: MainTheme.of(context).textTheme.titleMedium.copyWith(
                                color: MainTheme.of(context).white,
                              ),
                        );
                      },
                      loadFailure: (_) {
                        return Text(
                          locale.save,
                          textAlign: TextAlign.center,
                          style: MainTheme.of(context).textTheme.titleMedium.copyWith(
                                color: MainTheme.of(context).white,
                              ),
                        );
                      },
                      orElse: () {
                        return Text(
                          locale.save,
                          textAlign: TextAlign.center,
                          style: MainTheme.of(context).textTheme.titleMedium.copyWith(
                                color: MainTheme.of(context).white,
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
                editSimCard(
                  title: textController.text,
                );
              },
              disable: textController.text == '',
            )
          ],
        ),
      ),
    );
  }
}
