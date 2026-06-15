import 'dart:async';
import 'package:stac/stac.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../core/helpers/logger.dart';
import '../../../../core/services/biometric/biometric_service.dart';
import '../../../../core/services/biometric/web_biometric_service.dart'
    if (dart.library.io) '../../../../core/services/biometric/non_web_biometric_service.dart';

class BiometricDebugActionModel {
  final String operation;
  final String? userId;
  final String? message;
  final String? reason;
  final bool showDialog;
  final String? dialogTitle;
  final Map<String, dynamic>? onSuccess;
  final Map<String, dynamic>? onFailure;

  const BiometricDebugActionModel({
    required this.operation,
    this.userId,
    this.message,
    this.reason,
    this.showDialog = true,
    this.dialogTitle,
    this.onSuccess,
    this.onFailure,
  });

  factory BiometricDebugActionModel.fromJson(Map<String, dynamic> json) {
    return BiometricDebugActionModel(
      operation: (json['operation'] ?? '').toString(),
      userId: json['userId']?.toString(),
      message: json['message']?.toString(),
      reason: json['reason']?.toString(),
      showDialog: json['showDialog'] != false,
      dialogTitle: json['dialogTitle']?.toString(),
      onSuccess: json['onSuccess'] is Map<String, dynamic>
          ? json['onSuccess'] as Map<String, dynamic>
          : null,
      onFailure: json['onFailure'] is Map<String, dynamic>
          ? json['onFailure'] as Map<String, dynamic>
          : null,
    );
  }
}

class _BiometricDebugResult {
  final bool success;
  final String operation;
  final List<String> lines;

  const _BiometricDebugResult({
    required this.success,
    required this.operation,
    required this.lines,
  });
}

class _ResultEntry {
  final String? key;
  final String value;

  const _ResultEntry({this.key, required this.value});
}

class BiometricDebugActionParser
    extends StacActionParser<BiometricDebugActionModel> {
  const BiometricDebugActionParser();

  @override
  String get actionType => 'biometricDebug';

  @override
  BiometricDebugActionModel getModel(Map<String, dynamic> json) =>
      BiometricDebugActionModel.fromJson(json);

  @override
  FutureOr<void> onCall(
    BuildContext context,
    BiometricDebugActionModel model,
  ) async {
    final op = model.operation.trim();
    if (op.isEmpty) {
      AppLogger.wc(LogCategory.action, '[biometricDebug] Empty operation');
      _dispatch(context, model.onFailure);
      return;
    }

    try {
      AppLogger.ic(
        LogCategory.action,
        '[biometricDebug] start op=$op isWeb=$kIsWeb userIdProvided=${model.userId != null && model.userId!.isNotEmpty}',
      );

      final result = await _runOperation(model);

      AppLogger.ic(
        LogCategory.action,
        '[biometricDebug] end op=$op success=${result.success}',
      );

      if (!context.mounted) {
        return;
      }

      if (model.showDialog) {
        await _showResultDialog(context, model, result);
        if (!context.mounted) {
          return;
        }
      }

      _dispatch(context, result.success ? model.onSuccess : model.onFailure);
    } catch (e, st) {
      AppLogger.ec(
        LogCategory.action,
        '[biometricDebug] op=$op failed: $e',
        null,
        st,
      );
      if (!context.mounted) {
        return;
      }
      await _showResultDialog(
        context,
        model,
        _BiometricDebugResult(
          success: false,
          operation: op,
          lines: ['Exception: $e'],
        ),
      );
      if (!context.mounted) {
        return;
      }
      _dispatch(context, model.onFailure);
    }
  }

  Future<_BiometricDebugResult> _runOperation(
    BiometricDebugActionModel model,
  ) async {
    final op = model.operation.trim();
    switch (op) {
      case 'checkAvailability':
        return _checkAvailability(op);
      case 'checkRegistration':
        return _checkRegistration(op);
      case 'checkPasskeyRegistration':
        return _checkPasskeyRegistration(op);
      case 'authenticate':
        return _authenticate(op, model);
      case 'createCredential':
      case 'registerPasskey':
        return _registerPasskey(op, model.userId);
      case 'clearCredential':
        return _clearCredential(op);
      case 'logProbe':
        return _logProbe(op, model.message);
      default:
        AppLogger.wc(LogCategory.action, '[biometricDebug] Unknown op=$op');
        return _BiometricDebugResult(
          success: false,
          operation: op,
          lines: ['Unknown operation: $op'],
        );
    }
  }

  Future<_BiometricDebugResult> _checkAvailability(String op) async {
    final available = await BiometricService.isAvailable();
    if (kIsWeb) {
      final enabled = await WebBiometricService.isEnabled();
      final registered = await WebBiometricService.isRegistered();
      AppLogger.ic(
        LogCategory.action,
        '[biometricDebug] web availability: available=$available enabled=$enabled registered=$registered',
      );
      return _BiometricDebugResult(
        success: available,
        operation: op,
        lines: [
          'platform: web',
          'available: $available',
          'enabled: $enabled',
          'registered: $registered',
        ],
      );
    }

    AppLogger.ic(
      LogCategory.action,
      '[biometricDebug] native availability: available=$available',
    );
    return _BiometricDebugResult(
      success: available,
      operation: op,
      lines: ['platform: native', 'available: $available'],
    );
  }

  Future<_BiometricDebugResult> _checkRegistration(String op) async {
    final registered = await BiometricService.isRegistered();
    if (kIsWeb) {
      final enabled = await WebBiometricService.isEnabled();
      final passkeyRegistered = await WebBiometricService.isPasskeyRegistered();
      final passwordFallbackRegistered = registered && !passkeyRegistered;
      AppLogger.ic(
        LogCategory.action,
        '[biometricDebug] web registration: registered=$registered passkey=$passkeyRegistered passwordFallback=$passwordFallbackRegistered enabled=$enabled',
      );
      return _BiometricDebugResult(
        success: registered,
        operation: op,
        lines: [
          'platform: web',
          'registered: $registered',
          'passkeyRegistered: $passkeyRegistered',
          'passwordFallbackRegistered: $passwordFallbackRegistered',
          'enabled: $enabled',
        ],
      );
    }

    return _BiometricDebugResult(
      success: registered,
      operation: op,
      lines: [
        'platform: native',
        'registered: $registered',
        'note: native local_auth has no separate app-side credential creation step',
      ],
    );
  }

  Future<_BiometricDebugResult> _checkPasskeyRegistration(String op) async {
    if (!kIsWeb) {
      return _BiometricDebugResult(
        success: false,
        operation: op,
        lines: ['platform: native', 'passkeyRegistered: not supported'],
      );
    }

    final passkeyRegistered = await WebBiometricService.isPasskeyRegistered();
    return _BiometricDebugResult(
      success: passkeyRegistered,
      operation: op,
      lines: ['platform: web', 'passkeyRegistered: $passkeyRegistered'],
    );
  }

  Future<_BiometricDebugResult> _authenticate(
    String op,
    BiometricDebugActionModel model,
  ) async {
    final reason = (model.reason == null || model.reason!.trim().isEmpty)
        ? 'Biometric module test'
        : model.reason!.trim();
    final authenticated = await BiometricService.authenticate(
      reason: reason,
      userId: model.userId,
    );
    AppLogger.ic(
      LogCategory.action,
      '[biometricDebug] authenticate result=$authenticated',
    );
    return _BiometricDebugResult(
      success: authenticated,
      operation: op,
      lines: [
        'platform: ${kIsWeb ? "web" : "native"}',
        'reason: $reason',
        'userIdProvided: ${model.userId != null && model.userId!.isNotEmpty}',
        'authenticated: $authenticated',
      ],
    );
  }

  Future<_BiometricDebugResult> _registerPasskey(
    String op,
    String? userId,
  ) async {
    if (!kIsWeb) {
      AppLogger.wc(
        LogCategory.action,
        '[biometricDebug] registerPasskey skipped: not web',
      );
      return _BiometricDebugResult(
        success: false,
        operation: op,
        lines: ['platform: native', 'registerPasskey: not supported'],
      );
    }

    final resolvedUserId = (userId != null && userId.trim().isNotEmpty)
        ? userId.trim()
        : 'biometric_test_user';

    final registered = await BiometricService.register(
      userId: resolvedUserId,
      passkeyOnly: true,
    );
    AppLogger.ic(
      LogCategory.action,
      '[biometricDebug] registerPasskey result=$registered',
    );
    return _BiometricDebugResult(
      success: registered,
      operation: op,
      lines: [
        'platform: web',
        'passkeyOnly: true',
        'userIdProvided: true',
        'registered: $registered',
      ],
    );
  }

  Future<_BiometricDebugResult> _clearCredential(String op) async {
    if (!kIsWeb) {
      AppLogger.wc(
        LogCategory.action,
        '[biometricDebug] clearCredential skipped: not web',
      );
      return _BiometricDebugResult(
        success: false,
        operation: op,
        lines: ['platform: native', 'clearCredential: not supported'],
      );
    }
    await WebBiometricService.removeCredential();
    final stillRegistered = await WebBiometricService.isRegistered();
    final success = !stillRegistered;
    AppLogger.ic(
      LogCategory.action,
      '[biometricDebug] clearCredential result=$success',
    );
    return _BiometricDebugResult(
      success: success,
      operation: op,
      lines: [
        'platform: web',
        'stillRegistered: $stillRegistered',
        'cleared: $success',
      ],
    );
  }

  Future<_BiometricDebugResult> _logProbe(String op, String? message) async {
    final msg = (message == null || message.trim().isEmpty)
        ? 'biometric module logger probe'
        : message.trim();
    AppLogger.dc(LogCategory.action, '[biometricDebug] DEBUG: $msg');
    AppLogger.ic(LogCategory.action, '[biometricDebug] INFO: $msg');
    AppLogger.wc(LogCategory.action, '[biometricDebug] WARN: $msg');
    AppLogger.ec(LogCategory.action, '[biometricDebug] ERROR: $msg');
    return _BiometricDebugResult(
      success: true,
      operation: op,
      lines: ['logger: debug/info/warn/error emitted', 'message: $msg'],
    );
  }

  Future<void> _showResultDialog(
    BuildContext context,
    BiometricDebugActionModel model,
    _BiometricDebugResult result,
  ) async {
    if (!context.mounted) return;
    final title =
        (model.dialogTitle != null && model.dialogTitle!.trim().isNotEmpty)
        ? model.dialogTitle!.trim()
        : 'Biometric Test';
    final statusText = result.success ? 'SUCCESS' : 'FAILED';
    final statusColor = result.success ? Colors.green : Colors.red;
    final entries = result.lines.map(_parseEntry).toList();

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(
            title,
            textDirection: TextDirection.ltr,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          content: SizedBox(
            width: 380,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 430),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: statusColor.withValues(alpha: 0.28),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            statusText,
                            style: TextStyle(
                              color: statusColor,
                              fontWeight: FontWeight.w800,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 6),
                          _buildSummaryRow('operation', result.operation),
                          _buildSummaryRow(
                            'userIdProvided',
                            '${model.userId != null && model.userId!.isNotEmpty}',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Details',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...entries.map(
                      (entry) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: _buildEntryRow(entry),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  _ResultEntry _parseEntry(String line) {
    final separatorIndex = line.indexOf(':');
    if (separatorIndex <= 0) {
      return _ResultEntry(value: line);
    }

    final key = line.substring(0, separatorIndex).trim();
    final value = line.substring(separatorIndex + 1).trim();
    if (value.isEmpty) {
      return _ResultEntry(value: line);
    }
    return _ResultEntry(key: key, value: value);
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white70,
              ),
            ),
          ),
          Expanded(
            child: SelectableText(
              value,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEntryRow(_ResultEntry entry) {
    if (entry.key == null) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(10),
        ),
        child: SelectableText(
          entry.value,
          style: const TextStyle(fontSize: 13),
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              entry.key!,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            child: SelectableText(
              entry.value,
              style: const TextStyle(fontSize: 12.5),
            ),
          ),
        ],
      ),
    );
  }

  void _dispatch(BuildContext context, Map<String, dynamic>? action) {
    if (!context.mounted || action == null) return;
    Stac.onCallFromJson(action, context);
  }
}
