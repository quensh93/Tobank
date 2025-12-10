import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../util/data_constants.dart';
import '../../../../util/snack_bar_util.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/button/continue_button_widget.dart';

class CheckReceiveDenyBottomSheet extends StatefulWidget {
  const CheckReceiveDenyBottomSheet({required this.returnRejectCheckFunction, super.key});

  final Function(List<int>) returnRejectCheckFunction;

  @override
  CheckReceiveDenyBottomSheetState createState() => CheckReceiveDenyBottomSheetState();
}

class CheckReceiveDenyBottomSheetState extends State<CheckReceiveDenyBottomSheet> {
  final List<int> _selectedIdList = [];

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
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
              Text(locale.reject_cheque, style: ThemeUtil.titleStyle),
              const SizedBox(
                height: 16.0,
              ),
              Text(
                locale.reasons_should_not_transferred_message,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: context.theme.textTheme.bodyMedium!.color,
                  fontFamily: 'IranYekan',
                  height: 1.6,
                  fontSize: 14.0,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: context.theme.dividerColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Checkbox(
                            activeColor: context.theme.colorScheme.secondary,
                            fillColor: WidgetStateProperty.resolveWith((states) {
                              if (!states.contains(WidgetState.selected)) {
                                return Colors.transparent;
                              }
                              return null;
                            }),
                            value: _selectedIdList.contains(DataConstants.getRejectReasonList()[index].id),
                            onChanged: (bool? newValue) {
                              setState(() {
                                if (newValue!) {
                                  _selectedIdList.add(DataConstants.getRejectReasonList()[index].id);
                                } else {
                                  _selectedIdList.remove(DataConstants.getRejectReasonList()[index].id);
                                }
                              });
                            },
                          ),
                          Text(
                            DataConstants.getRejectReasonList()[index].title,
                            style:
                                TextStyle(color: ThemeUtil.textTitleColor, fontWeight: FontWeight.w500, fontSize: 16.0),
                          )
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 16.0,
                  );
                },
                itemCount: DataConstants.getRejectReasonList().length,
              ),
              const SizedBox(
                height: 40.0,
              ),
              ContinueButtonWidget(
                callback: () {
                  _validate();
                },
                isLoading: false,
                buttonTitle: locale.reject_cheque,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _validate() {
    //locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (_selectedIdList.isNotEmpty) {
      widget.returnRejectCheckFunction(_selectedIdList);
      Get.back();
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.please_select_reason,
      );
    }
  }
}
