import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../ui/launcher/launcher_screen.dart';
import '../../../../util/automate_auth/automation_controller.dart';
import '../../../../util/automate_auth/automation_page.dart';
import '../../../../util/automate_auth/user_model.dart';
import '../../app_config/app_config.dart';
import '../../injection/injection.dart';
import 'environment_drop_down.dart';

class DebugPage extends StatefulWidget {
  const DebugPage({super.key});

  @override
  State<DebugPage> createState() => _DebugPageState();
}

class _DebugPageState extends State<DebugPage> {
  final AutomationController controller = Get.put(
    AutomationController(),
    permanent: true,
  );

  @override
  Widget build(BuildContext context) {
    // List of choices for the grid
    final List<_AuthModeItem> modes = [
      _AuthModeItem(
        title: 'Automation',
        icon: Icons.smart_toy_outlined,
        onTapComment:
            '/// TODO: Start automate authentication flow (debug/dev only)',
        onTap: () {
          Get.to(() => AutomationPage());
        },
      ),
      _AuthModeItem(
        title: 'Clear All Data',
        icon: Icons.delete_outline,
        onTapComment:
        '/// TODO: Start automate authentication flow (debug/dev only)',
        onTap: () {
          Get.to(() async {
            await Get.find<AutomationController>().cleanAllData(needToClearRoute: true);
            Get.snackbar(
              'Data Cleared',
              'Completed!',
            );
          });
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Debug Page'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                  // Show selected config, for demo
                  'Base URL: ${getIt<AppConfigService>().config.baseUrl}'),
            ),
            const Divider(height: 1),
            const Padding(
                padding: EdgeInsets.all(12.0), child: EnvironmentDropdown()),

            // Dropdown at the top of the body
            Obx(
              () {
                return Container(
                  padding: EdgeInsets.all(4),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).dividerColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButton<UserData>(
                    isExpanded: true,
                    value: controller.selectedUser.value,
                    items: controller.users.map((user) {
                      return DropdownMenuItem<UserData>(
                        value: user,
                        child: Text(user
                            .globalLastName), // Assuming `UserData` has this field
                      );
                    }).toList(),
                    onChanged: (_selectedUser) {
                      // Handle user selection
                      if (_selectedUser != null) {
                        Get.snackbar(
                          'User Selected',
                          'You selected ${_selectedUser.globalLastName}',
                        );
                        controller.selectedUser.value = _selectedUser;
                      }
                    },
                    underline: const SizedBox(),
                    // Removes default underline
                    hint: const Text('Select a User'),
                  ),
                );
              },
            ),
            const SizedBox(height: 20), // Space between dropdown and grid
            Expanded(
              child: GridView.builder(
                itemCount: modes.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 columns
                  mainAxisSpacing: 24,
                  crossAxisSpacing: 24,
                  childAspectRatio: 1.1,
                ),
                itemBuilder: (context, index) {
                  final item = modes[index];
                  return GestureDetector(
                    onTap: () {
                      print(item.onTapComment); // Debug
                      item.onTap();
                    },
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(item.icon, size: 48, color: Colors.blueAccent),
                            const SizedBox(height: 10),
                            Text(
                              item.title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20), // Space between grid and checkbox
            // Checkbox below the grid
            Obx(() {
              return Row(
                children: [
                  Checkbox(
                    value: controller.downloadUserBigDataToTextFile.value,
                    onChanged: (value) {
                      controller.downloadUserBigDataToTextFile.value =
                          value ?? false;
                    },
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    "Download user big data to text file",
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _AuthModeItem {
  final String title;
  final IconData icon;
  final String onTapComment;
  final VoidCallback onTap;

  _AuthModeItem({
    required this.title,
    required this.icon,
    required this.onTapComment,
    required this.onTap,
  });
}
