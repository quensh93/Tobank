import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../../../util/app_util.dart';
import '../../../../util/automate_auth/automation_controller.dart';
import '../../app_config/app_config.dart' show AppConfigService, AppEnvironment;
import '../../injection/injection.dart';

class EnvironmentDropdown extends StatefulWidget {
  const EnvironmentDropdown({super.key});

  @override
  State<EnvironmentDropdown> createState() => _EnvironmentDropdownState();
}

class _EnvironmentDropdownState extends State<EnvironmentDropdown> {
  late AppConfigService _configService;
  late AppEnvironment _selectedEnv;

  @override
  void initState() {
    super.initState();
    _configService = GetIt.I<AppConfigService>();
    _selectedEnv = _configService.config.environment;
  }

  Future<void> _changeEnv(AppEnvironment newEnv) async {
    if (newEnv == _selectedEnv) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Change Environment?'),
        content: Text(
          "You are about to switch from '${_selectedEnv.name.toUpperCase()}' "
          "to '${newEnv.name.toUpperCase()}'.\n\n"
          "⚠️ This may log you out or affect app data.\n\n"
          "to take changes => RESTART APP MANUALY\n\n"
          "Are you sure?",
        ),
        actions: [
          TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.pop(context, false)),
          ElevatedButton(
              child: const Text('Change'),
              onPressed: () => Navigator.pop(context, true)),
        ],
      ),
    );
    if (confirmed != true) return;

    await getIt<AppConfigService>().setEnvironment(newEnv);

    await Get.find<AutomationController>().cleanAllData(needToClearRoute: true);

    // Optionally: show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
              "Environment switched to '${newEnv.name.toUpperCase()}' Now Restart App")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Current Env: ',
            style: TextStyle(fontWeight: FontWeight.bold)),
        DropdownButton<AppEnvironment>(
          value: _selectedEnv,
          onChanged: (env) {
            if (env != null) _changeEnv(env);
          },
          items: AppEnvironment.values.map((env) {
            return DropdownMenuItem<AppEnvironment>(
              value: env,
              child: Row(
                children: [
                  Text(env.name.toUpperCase()),
                  if (env == _selectedEnv) ...[
                    const SizedBox(width: 8),
                    const Icon(Icons.check, color: Colors.green, size: 18),
                  ],
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
