import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../model/service_item_data.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/svg/svg_icon.dart';

class CardServiceItemWidget extends StatelessWidget {
  const CardServiceItemWidget({
    required this.serviceItemData,
    required this.clickedServiceItemData,
    required this.returnDataFunction,
    required this.isLoading,
    super.key,
  });

  final ServiceItemData serviceItemData;
  final ServiceItemData? clickedServiceItemData;
  final Function(ServiceItemData serviceItemData) returnDataFunction;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(color: context.theme.dividerColor, width: 0.5),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8.0),
        onTap: () {
          if (!isLoading) {
            returnDataFunction(serviceItemData);
          }
        },
        child: isLoading &&
                clickedServiceItemData != null &&
                clickedServiceItemData!.eventCode == serviceItemData.eventCode
            ? SpinKitFadingCircle(
                itemBuilder: (_, int index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.theme.iconTheme.color!,
                    ),
                  );
                },
                size: 24.0,
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgIcon(Get.isDarkMode ? serviceItemData.iconDark : serviceItemData.icon),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(serviceItemData.title,
                      style: TextStyle(
                        color: ThemeUtil.textTitleColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ))
                ],
              ),
      ),
    );
  }
}
