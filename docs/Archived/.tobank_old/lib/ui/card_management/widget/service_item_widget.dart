import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/card/pin_type_data.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/svg/svg_icon.dart';

class ServiceItemWidget extends StatelessWidget {
  const ServiceItemWidget({
    required this.serviceTypeData,
    required this.returnDataFunction,
    super.key,
    this.selectedService,
  });

  final PinTypeData serviceTypeData;
  final PinTypeData? selectedService;
  final Function(PinTypeData) returnDataFunction;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(
        Radius.circular(12.0),
      ),
      onTap: () {
        returnDataFunction(serviceTypeData);
      },
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selectedService != null && serviceTypeData.eventId == selectedService!.eventId
                ? ThemeUtil.primaryColor
                : context.theme.dividerColor,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: Row(
          children: <Widget>[
            Card(
              elevation: 0,
              shadowColor: Colors.transparent,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),
                side: BorderSide(color: context.theme.dividerColor, width: 0.5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgIcon(
                  Get.isDarkMode ? serviceTypeData.iconDark : serviceTypeData.icon,
                  size: 24.0,
                ),
              ),
            ),
            const SizedBox(
              width: 12.0,
            ),
            Text(
              serviceTypeData.title,
              style: TextStyle(
                color: ThemeUtil.textTitleColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
