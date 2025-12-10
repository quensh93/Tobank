import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../model/transfer/transfer_method_data.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/svg/svg_icon.dart';

class TransferMethodItemWidget extends StatelessWidget {
  const TransferMethodItemWidget({
    required this.transferMethodData,
    required this.selectedTransferMethodData,
    required this.tapToSelectFunction,
    required this.supportedTransferTypes,
    super.key,
  });

  final TransferMethodData transferMethodData;
  final TransferMethodData? selectedTransferMethodData;
  final Function(TransferMethodData transferMethodData) tapToSelectFunction;
  final List<int> supportedTransferTypes;

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
        border: Border.all(
          color: context.theme.dividerColor,
        ),
      ),
      child: supportedTransferTypes.contains(transferMethodData.id)
          ? InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {
                tapToSelectFunction(transferMethodData);
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Card(
                      elevation: 8,
                      margin: EdgeInsets.zero,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgIcon(
                          Get.isDarkMode ? transferMethodData.iconDark : transferMethodData.icon,
                          size: 24.0,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16.0,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transferMethodData.title,
                            style: TextStyle(
                              color: ThemeUtil.textTitleColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            transferMethodData.description,
                            style: TextStyle(
                              color: ThemeUtil.textSubtitleColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {
                tapToSelectFunction(transferMethodData);
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Card(
                      elevation: 8,
                      margin: EdgeInsets.zero,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgIcon(
                          transferMethodData.icon,
                          colorFilter: ColorFilter.mode(context.theme.disabledColor, BlendMode.srcIn),
                          size: 24.0,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16.0,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transferMethodData.title,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: context.theme.disabledColor,
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            locale.cant_use_this_transfer_method,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: context.theme.disabledColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
