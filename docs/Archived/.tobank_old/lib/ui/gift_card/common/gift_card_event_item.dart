import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/gift_card/response/list_event_plan_data.dart';
import '../../../util/app_util.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/svg/svg_icon.dart';

class GiftCardEventItemWidget extends StatelessWidget {
  const GiftCardEventItemWidget({
    required this.event,
    required this.returnSelectedFunction,
    required this.reloadFunction,
    super.key,
    this.selectedEvent,
  });

  final Event? selectedEvent;
  final Event event;
  final Function(Event event) returnSelectedFunction;
  final Function reloadFunction;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: context.theme.dividerColor),
      ),
      child: InkWell(
        onTap: () {
          returnSelectedFunction(event);
        },
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
              child: FastCachedImage(
                fit: BoxFit.fill,
                width: double.infinity,
                filterQuality: FilterQuality.high,
                url: AppUtil.baseUrlStatic() + event.image!,
                loadingBuilder: (context, progress) => const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ),
                errorBuilder: (context, url, error) {
                  return InkWell(
                    onTap: () {
                      reloadFunction();
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: SvgIcon(
                          SvgIcons.imageLoadError,
                          size: 32,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              event.title ?? '',
              style: TextStyle(
                color: ThemeUtil.textTitleColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
