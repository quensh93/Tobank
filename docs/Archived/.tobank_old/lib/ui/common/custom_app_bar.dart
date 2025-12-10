import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../util/theme/theme_util.dart';
import '../../widget/svg/svg_icon.dart';
import '../support/support_screen.dart';

class CustomAppBar extends AppBar {
  final String titleString;
  final BuildContext context;
  final bool? hideSupport;
  final Function? moreFunction;

  CustomAppBar({
    required this.titleString,
    required this.context,
    super.key,
    this.hideSupport,
    this.moreFunction,
  }) : super(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgIcon(
              SvgIcons.arrowBack,
              colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
              size: 24.0,
            ),
          ),
          title: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      titleString,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: ThemeUtil.textTitleColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  if (moreFunction!=null)
                    InkWell(
                      onTap: (){
                        moreFunction();
                      },
                      child: SvgIcon(
                        SvgIcons.moreOptions,
                        colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                        size: 24.0,
                      ),
                    )
                ],
              ),

            ],
          ),
          actions: [
            if (hideSupport == true)
              Container()
            else
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(() => const SupportScreen());
                    },
                    child: Card(
                      elevation: 1,
                      margin: EdgeInsets.zero,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgIcon(
                          SvgIcons.support,
                          colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                          size: 24.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                ],
              ),
          ],
        );
}
