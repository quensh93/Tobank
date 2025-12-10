import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../util/automate_auth/automation_page.dart';
import '../new_structure/core/injection/injection.dart';
import '../new_structure/core/services/logger_service/talker/talker.dart';
import '../util/log_util.dart';

// Assume ApiLogService was modified per above
class ApiLogHistoryScreen extends StatefulWidget {
  const ApiLogHistoryScreen({super.key});

  @override
  State<ApiLogHistoryScreen> createState() => _ApiLogHistoryScreenState();
}

class _ApiLogHistoryScreenState extends State<ApiLogHistoryScreen> {
  final ApiLogService _logService = Get.find<ApiLogService>();

  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    // 1️⃣ If the flag is on, open Talker UI immediately and pop this
    if (ApiLogService.showTalkerLogsInsteadOfOldScreen) {
      // Use post frame callback so the widget tree is ready
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => TalkerScreen(
              talker: getIt<TalkerService>().talker,
            ),
          ),
        );
      });
      // Return a placeholder widget
      return const Scaffold(
        backgroundColor: Colors.indigo,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // 2️⃣ If flag is OFF, show your current log expansion UI
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        title: const Text('API Logs'),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) async {
              switch (value) {
                case 'automationPage':
                  final formattedLogs = _generateFormattedLogs();
                  Get.to(() => AutomationPage());
                  break;
                case 'copyLogs':
                  final formattedLogs = _generateFormattedLogs();
                  await Clipboard.setData(ClipboardData(text: formattedLogs));
                  Get.snackbar(
                    'Success',
                    'All logs copied to clipboard',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                  break;
                case 'copyCurls':
                  final formattedCurls = _generateFormattedCurls();
                  await Clipboard.setData(ClipboardData(text: formattedCurls));
                  Get.snackbar(
                    'Success',
                    'All cURLs copied to clipboard',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                  break;
                case 'sendEmail':
                  await _sendLogsViaEmail();
                  break;
                case 'talker':
                // Only open Talker if we are *not* already showing its screen by default
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => TalkerScreen(talker: getIt<TalkerService>().talker),
                    ),
                  );
                  break;
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'automationPage',
                child: Row(
                  children: [
                    Icon(Icons.bug_report_outlined),
                    SizedBox(width: 8),
                    Text('Automation Auth'),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'copyLogs',
                child: Row(
                  children: [
                    Icon(Icons.copy),
                    SizedBox(width: 8),
                    Text('Copy Logs'),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'copyCurls',
                child: Row(
                  children: [
                    Icon(Icons.copy),
                    SizedBox(width: 8),
                    Text('Copy Curls'),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'sendEmail',
                child: Row(
                  children: [
                    Icon(Icons.email),
                    SizedBox(width: 8),
                    Text('Send Logs'),
                  ],
                ),
              ),
              // Hide the Talker entry if Talker is already default
              if (!ApiLogService.showTalkerLogsInsteadOfOldScreen)
                const PopupMenuItem<String>(
                  value: 'talker',
                  child: Row(
                    children: [
                      Icon(Icons.bug_report_rounded),
                      SizedBox(width: 8),
                      Text('talker'),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                selectedIndex = index == selectedIndex ? -1 : index;
              });
            },
            children: List.generate(
              _logService.logs.length,
                  (index) {
                final ApiLogModel log = _logService.logs[index];
                return ExpansionPanel(
                  canTapOnHeader: true,
                  isExpanded: index == selectedIndex,
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      title: Text(log.title),
                      leading: IconButton(
                        onPressed: () {
                          Share.share(log.toString(), subject: log.title);
                        },
                        icon: const Icon(
                          Icons.share,
                          size: 20,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  },
                  body: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Divider(),
                        ApiLogItem(
                          title: 'cURL',
                          value: log.request.curl,
                          trailing: IconButton(
                            icon: const Icon(Icons.copy, size: 20, color: Colors.grey),
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: log.request.curl));
                              Get.snackbar(
                                'Success',
                                'cURL command copied to clipboard',
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            },
                          ),
                        ),
                        const Divider(),
                        ApiLogItem(
                          title: 'Request Method',
                          value: log.request.method,
                        ),
                        const Divider(),
                        ApiLogItem(
                          title: 'Request URL',
                          value: log.request.url,
                        ),
                        const Divider(),
                        ApiLogItem(
                          title: 'Request Headers',
                          value: log.request.headers,
                        ),
                        const Divider(),
                        ApiLogItem(
                          title: 'Request Params',
                          value: log.request.queryParameters,
                        ),
                        const Divider(),
                        ApiLogItem(
                          title: 'Request Data',
                          value: log.request.data,
                        ),
                        const Divider(),
                        ApiLogItem(
                          title: 'Time',
                          value: log.time,
                        ),
                        if (_logService.isResponse(log))
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Divider(),
                              ApiLogItem(
                                title: 'Response StatusCode',
                                value: log.response!.statusCode,
                              ),
                              if (ApiLogService.isDisplayResponseHeaders)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    const Divider(),
                                    ApiLogItem(
                                      title: 'Response Headers',
                                      value: log.response!.headers,
                                    ),
                                  ],
                                ),
                              const Divider(),
                              ApiLogItem(
                                title: 'Response Data',
                                value: log.response!.data,
                              ),
                            ],
                          )
                        else if (_logService.isError(log))
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Divider(),
                              ApiLogItem(
                                title: 'Error Type',
                                value: log.error!.type,
                              ),
                              const Divider(),
                              ApiLogItem(
                                title: 'Error DisplayMessage',
                                value: log.error!.displayMessage,
                              ),
                              const Divider(),
                              ApiLogItem(
                                title: 'Error DisplayCode',
                                value: log.error!.displayCode,
                              ),
                              const Divider(),
                              ApiLogItem(
                                title: 'Error StatusCode',
                                value: log.error!.statusCode,
                              ),
                              if (ApiLogService.isDisplayErrorHeaders)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    const Divider(),
                                    ApiLogItem(
                                      title: 'Error Headers',
                                      value: log.error!.headers,
                                    ),
                                  ],
                                ),
                              const Divider(),
                              ApiLogItem(
                                title: 'Error Data',
                                value: log.error!.data,
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  String _generateFormattedLogs() {
    final allLogs = _logService.logs.map((log) {
      String logString = '';
      logString += '----------------------------------------\n';
      logString += 'Title: ${log.title}\n';
      logString += '----------------------------------------\n';
      logString += 'cURL: ${log.request.curl}\n';
      logString += '----------------------------------------\n';
      logString += 'Request Method: ${log.request.method}\n';
      logString += 'Request URL: ${log.request.url}\n';
      logString += 'Request Headers: ${log.request.headers}\n';
      logString += 'Request Params: ${log.request.queryParameters}\n';
      logString += 'Request Data: ${log.request.data}\n';
      logString += 'Time: ${log.time}\n';

      if (_logService.isResponse(log)) {
        logString += '----------------------------------------\n';
        logString += 'Response StatusCode: ${log.response!.statusCode}\n';
        if (ApiLogService.isDisplayResponseHeaders) {
          logString += 'Response Headers: ${log.response!.headers}\n';
        }
        logString += 'Response Data: ${log.response!.data}\n';
      } else if (_logService.isError(log)) {
        logString += '----------------------------------------\n';
        logString += 'Error Type: ${log.error!.type}\n';
        logString += 'Error DisplayMessage: ${log.error!.displayMessage}\n';
        logString += 'Error DisplayCode: ${log.error!.displayCode}\n';
        logString += 'Error StatusCode: ${log.error!.statusCode}\n';
        if (ApiLogService.isDisplayErrorHeaders) {
          logString += 'Error Headers: ${log.error!.headers}\n';
        }
        logString += 'Error Data: ${log.error!.data}\n';
      }
      logString += '========================================\n\n';
      return logString;
    }).join('');

    return allLogs;
  }

  String _generateFormattedCurls() {
    // Each cURL on a new line with no empty lines between them
    final allCurls = _logService.logs.map((log) {
      // Remove any existing line breaks and ensure each cURL is on a single line
      return log.request.curl.replaceAll('\\\n\t', ' ').replaceAll('\n', ' ').trim();
    }).join('\n');

    return allCurls;
  }

  Future<void> _sendLogsViaEmail() async {
    try {
      final logs = _logService.logs;
      if (logs.isEmpty) {
        Get.snackbar(
          'Warning',
          'No logs to send',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.yellow[100],
        );
        return;
      }

      // Create formatted logs content
      final content = StringBuffer();

      for (var log in logs) {
        content.writeln('========================================');
        content.writeln('Title: ${log.title}');
        content.writeln('----------------------------------------');
        content.writeln('cURL: ${log.request.curl}');
        content.writeln('----------------------------------------');
        content.writeln('Request Method: ${log.request.method}');
        content.writeln('Request URL: ${log.request.url}');
        content.writeln('Request Headers: ${log.request.headers}');
        content.writeln('Request Params: ${log.request.queryParameters}');
        content.writeln('Request Data: ${log.request.data}');
        content.writeln('Time: ${log.time}');

        if (_logService.isResponse(log)) {
          content.writeln('----------------------------------------');
          content.writeln('Response StatusCode: ${log.response!.statusCode}');
          if (ApiLogService.isDisplayResponseHeaders) {
            content.writeln('Response Headers: ${log.response!.headers}');
          }
          content.writeln('Response Data: ${log.response!.data}');
        } else if (_logService.isError(log)) {
          content.writeln('----------------------------------------');
          content.writeln('Error Type: ${log.error!.type}');
          content.writeln('Error DisplayMessage: ${log.error!.displayMessage}');
          content.writeln('Error DisplayCode: ${log.error!.displayCode}');
          content.writeln('Error StatusCode: ${log.error!.statusCode}');
          if (ApiLogService.isDisplayErrorHeaders) {
            content.writeln('Error Headers: ${log.error!.headers}');
          }
          content.writeln('Error Data: ${log.error!.data}');
        }
        content.writeln('========================================\n');
      }

      final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: '', // Add default email if needed
        queryParameters: {
          'subject': 'API Logs',
          'body': content.toString(),
        },
      );

      if (await canLaunchUrl(emailLaunchUri)) {
        await launchUrl(emailLaunchUri);
      } else {
        Get.snackbar(
          'Error',
          'Could not launch email client',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red[100],
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to send logs: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
      );
    }
  }
}

class ApiLogItem extends StatelessWidget {
  final String title;
  final dynamic value;
  final Widget? trailing;

  const ApiLogItem({
    required this.title,
    required this.value,
    this.trailing,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: '$title: ',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: value.toString(),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}
