import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../model/add_deposit/response/deposit_list_data_response.dart';
import '../../../../util/app_util.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/svg/svg_icon.dart';

class DestinationDepositItemWidget extends StatelessWidget {
  const DestinationDepositItemWidget({
    required this.depositDataModel,
    required this.selectDepositDataFunction,
    super.key,
    this.isIban,
  });

  final DepositDataModel depositDataModel;
  final Function(DepositDataModel depositModel) selectDepositDataFunction;
  final bool? isIban;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(
        Radius.circular(8.0),
      ),
      onTap: () {
        selectDepositDataFunction(depositDataModel);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: context.theme.dividerColor,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
          child: Row(
            children: <Widget>[
              if (isIban == true)
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: context.theme.dividerColor,
                      width: 0.5,
                    ),
                  ),
                  width: 36.0,
                  height: 36.0,
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: depositDataModel.bankInfo != null
                        ? SvgPicture.network(
                            AppUtil.baseUrlStatic() + depositDataModel.bankInfo!.symbol!,
                            semanticsLabel: '',
                            height: 30.0,
                            width: 30.0,
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
                          )
                        : Container(),
                  ),
                )
              else
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: context.theme.dividerColor,
                      width: 0.5,
                    ),
                  ),
                  width: 36.0,
                  height: 36.0,
                  child: const Padding(
                    padding: EdgeInsets.all(6.0),
                    child: SvgIcon(
                      SvgIcons.gardeshgari,
                    ),
                  ),
                ),
              const SizedBox(
                width: 8.0,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isIban == true ? depositDataModel.iban! : depositDataModel.accountNumber!,
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: ThemeUtil.textTitleColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      depositDataModel.title ?? '',
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
      ),
    );
  }
}
