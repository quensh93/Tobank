import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/charity/response/list_charity_data.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/svg/svg_icon.dart';

class CharityItemWidget extends StatelessWidget {
  const CharityItemWidget({
    required this.charityData,
    required this.returnDataFunction,
    super.key,
  });

  final CharityData charityData;
  final Function(CharityData charityData) returnDataFunction;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        returnDataFunction(charityData);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: context.theme.dividerColor,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Card(
                elevation: 1,
                margin: EdgeInsets.zero,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SvgIcon(SvgIcons.charityLogo),
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
                      charityData.title!,
                      style: ThemeUtil.titleStyle,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      charityData.instituteName!,
                      style: TextStyle(
                        color: ThemeUtil.textSubtitleColor,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SvgIcon(
                SvgIcons.arrowLeft,
                colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
