import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:draggable_panel/draggable_panel.dart';
import 'package:get/get.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../injection/injection.dart';
import '../logger_service/talker/talker.dart';
import 'debug_page.dart';

final DraggablePanelController _devPanelController = DraggablePanelController();
// bool _devPanelIsActivated = kDebugMode || kIsWeb;
bool _devPanelIsActivated = false;

Widget developerPanelWrap({required Widget child}) {
  if (!_devPanelIsActivated) return child;

  return DraggablePanel(
    items: [
      DraggablePanelItem(
        enableBadge: false,
        icon: Icons.multiline_chart,
        onTap: (context) {
          Get.to(
                () => TalkerScreen(
              talker: getIt<TalkerService>().talker,
            ),
          );
        },
      ),
      DraggablePanelItem(
        enableBadge: false,
        icon: Icons.bug_report_outlined,
        onTap: (context) {
          Get.to(() => const DebugPage());
        },
      ),
    ],
    buttons: [
      DraggablePanelButtonItem(
        icon: Icons.cleaning_services,
        label: 'Clear Talker Logs',
        onTap: (context) {
          final talker = getIt<TalkerService>().talker;
          talker.cleanHistory();
        },
      ),
    ],
    controller: _devPanelController,
    child: child,
  );
}

void disposeDeveloperPanel() {
  _devPanelController.dispose();
}
