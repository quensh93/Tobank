import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../util/data_constants.dart';
import 'owner_status_item_widget.dart';

class CheckStatusBottomSheet extends StatelessWidget {
  const CheckStatusBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
              height: 16.0,
            ),
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return OwnerStatusItemWidget(
                      checkOwnerStatusData: DataConstants.getCheckOwnerStatusList()[index],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 16.0);
                  },
                  itemCount: DataConstants.getCheckOwnerStatusList().length),
            ),
          ],
        ),
      ),
    );
  }
}
