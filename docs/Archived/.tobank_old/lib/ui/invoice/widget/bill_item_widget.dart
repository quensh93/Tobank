import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/invoice/response/bill_data_response.dart';
import '../../../util/data_constants.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/svg/svg_icon.dart';

class BillItemWidget extends StatelessWidget {
  const BillItemWidget({
    required this.billData,
    required this.isLoading,
    required this.isDeleteLoading,
    required this.editBillDataFunction,
    required this.deleteBillDataFunction,
    required this.inquiryFunction,
    super.key,
    this.clickedBillDataItem,
  });

  final BillData billData;
  final BillData? clickedBillDataItem;
  final Function(BillData billData) editBillDataFunction;
  final Function(BillData billData) deleteBillDataFunction;
  final Function(BillData billData) inquiryFunction;
  final bool isLoading;
  final bool isDeleteLoading;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    String? billName = '';
    SvgIcons billLogo = SvgIcons.nullIcon;
    final list = DataConstants.getBllTypeDataListMinify().where((element) => element.id == billData.typeId).toList();
    if (list.length == 1) {
      billName = list[0].title;
      billLogo = Get.isDarkMode ? list[0].iconDark : list[0].icon;
    }
    String subtitle = '';
    if (billData.typeId == 4) {
      subtitle = '$billName: ${billData.phone}';
    } else if (billData.typeId == 5) {
      subtitle = '$billName: ${billData.mobile}';
    } else if (billData.typeId == 2 || billData.typeId == 1 || billData.typeId == 3) {
      subtitle = '$billName: ${billData.billIdentifier}';
    }
    bool isItc = false;
    if (billData.typeId == 4 || billData.typeId == 5) {
      isItc = true;
    }
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      onTap: () {
        if (!isLoading) {
          inquiryFunction(billData);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(
            color: context.theme.dividerColor,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  Card(
                    elevation: 0,
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      side: BorderSide(color: context.theme.dividerColor, width: 0.5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: isLoading && clickedBillDataItem != null && clickedBillDataItem!.id == billData.id
                          ? SpinKitFadingCircle(
                              itemBuilder: (_, int index) {
                                return DecoratedBox(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: context.theme.iconTheme.color,
                                  ),
                                );
                              },
                              size: 24.0,
                            )
                          : SvgIcon(
                              billLogo,
                              size: 24.0,
                            ),
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          billData.title!,
                          style: TextStyle(
                            color: ThemeUtil.textTitleColor,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            height: 1.6,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              subtitle,
                              style: TextStyle(
                                color: ThemeUtil.textSubtitleColor,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            if (isItc)
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  Container(
                                    height: 16.0,
                                    width: 2.0,
                                    decoration: BoxDecoration(color: context.theme.dividerColor),
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  Text(
                                    billData.midterm! ? locale.midterm : locale.endterm,
                                    style: TextStyle(
                                        color: ThemeUtil.textSubtitleColor,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              )
                            else
                              Container(),
                          ],
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
                        editBillDataFunction(billData);
                      } else {
                        deleteBillDataFunction(billData);
                      }
                    },
                    tooltip: locale.bill_operations_tooltip,
                    position: PopupMenuPosition.under,
                    padding: const EdgeInsets.all(0),
                    itemBuilder: (BuildContext context) => <PopupMenuItem<int>>[
                      PopupMenuItem<int>(
                        value: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              locale.bill_edit_option,
                              style: TextStyle(color: ThemeUtil.textTitleColor),
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
                              locale.bill_delete_option,
                              style: TextStyle(color: ThemeUtil.textTitleColor),
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
            ],
          ),
        ),
      ),
    );
  }
}
