import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../model/add_deposit/response/deposit_list_data_response.dart';
import '../../../../util/app_util.dart';
import '../../../../util/enums_constants.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/svg/svg_icon.dart';

class DepositNotebookItem extends StatelessWidget {
  const DepositNotebookItem({
    required this.depositDataModel,
    required this.selectedDepositDataModel,
    required this.isDeleteLoading,
    required this.editCallBack,
    required this.deleteCallBack,
    super.key,
  });

  final DepositDataModel depositDataModel;
  final DepositDataModel? selectedDepositDataModel;
  final Function(DepositDataModel depositDataModel) editCallBack;
  final Function(DepositDataModel depositDataModel) deleteCallBack;
  final bool isDeleteLoading;

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.all(color: context.theme.dividerColor),
          ),
          child: InkWell(
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  if (depositDataModel.bankInfo != null)
                    if (depositDataModel.type == DestinationType.iban)
                      Card(
                        elevation: Get.isDarkMode ? 1 : 0,
                        margin: EdgeInsets.zero,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.network(
                            AppUtil.baseUrlStatic() + depositDataModel.bankInfo!.symbol!,
                            semanticsLabel: '',
                            height: 24.0,
                            width: 24.0,
                            placeholderBuilder: (BuildContext context) => SpinKitFadingCircle(
                              itemBuilder: (_, int index) {
                                return DecoratedBox(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: context.theme.iconTheme.color,
                                  ),
                                );
                              },
                              size: 24.0,
                            ),
                          ),
                        ),
                      )
                    else
                      Card(
                        elevation: Get.isDarkMode ? 1 : 0,
                        margin: EdgeInsets.zero,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: SvgIcon(
                            SvgIcons.gardeshgari,
                            size: 20.0,
                          ),
                        ),
                      )
                  else
                    const SizedBox(width: 24.0, height: 24.0),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          depositDataModel.title ?? '',
                          style: TextStyle(
                            color: ThemeUtil.textSubtitleColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          depositDataModel.type == DestinationType.iban
                              ? depositDataModel.iban!
                              : depositDataModel.accountNumber!,
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: ThemeUtil.textTitleColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 16.0,
                    width: 2.0,
                    decoration: BoxDecoration(color: context.theme.dividerColor),
                  ),
                  PopupMenuButton<int>(
                    onSelected: (value) {
                      if (value == 1) {
                        editCallBack(depositDataModel);
                      } else {
                        deleteCallBack(depositDataModel);
                      }
                    },
                    position: PopupMenuPosition.under,
                    padding: const EdgeInsets.all(0),
                    itemBuilder: (BuildContext context) => <PopupMenuItem<int>>[
                      PopupMenuItem<int>(
                        value: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              locale.edit,
                              style: TextStyle(
                                color: ThemeUtil.textTitleColor,
                              ),
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            SvgIcon(
                              Get.isDarkMode ? SvgIcons.editDark : SvgIcons.edit,
                            ),
                          ],
                        ),
                      ),
                      PopupMenuItem<int>(
                        value: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              locale.delete,
                              style: TextStyle(
                                color: ThemeUtil.textTitleColor,
                              ),
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            SvgIcon(
                              Get.isDarkMode ? SvgIcons.deleteDark : SvgIcons.delete,
                            ),
                          ],
                        ),
                      ),
                    ],
                    child: AbsorbPointer(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgIcon(
                          SvgIcons.moreOptions,
                          colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
