import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ml_card_scanner/ml_card_scanner.dart';
import 'package:stac/stac.dart';

import '../../registry/custom_component_registry.dart';
import '../../utils/registry_notifier.dart';
import '../../utils/text_form_field_controller_registry.dart';

class ShowTransferCardScannerActionModel {
  final String fieldId;
  final Map<String, dynamic>? successAction;
  final Map<String, dynamic>? failedAction;

  const ShowTransferCardScannerActionModel({
    required this.fieldId,
    this.successAction,
    this.failedAction,
  });

  factory ShowTransferCardScannerActionModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final rawSuccessAction = json['successAction'];
    final rawFailedAction = json['failedAction'];

    return ShowTransferCardScannerActionModel(
      fieldId: json['fieldId'] as String? ?? 'transferApiCardInput',
      successAction: rawSuccessAction is Map<String, dynamic>
          ? rawSuccessAction
          : rawSuccessAction is Map
          ? Map<String, dynamic>.from(rawSuccessAction)
          : null,
      failedAction: rawFailedAction is Map<String, dynamic>
          ? rawFailedAction
          : rawFailedAction is Map
          ? Map<String, dynamic>.from(rawFailedAction)
          : null,
    );
  }
}

class ShowTransferCardScannerActionParser
    extends StacActionParser<ShowTransferCardScannerActionModel> {
  const ShowTransferCardScannerActionParser();

  @override
  String get actionType => 'showTransferCardScanner';

  @override
  ShowTransferCardScannerActionModel getModel(Map<String, dynamic> json) {
    return ShowTransferCardScannerActionModel.fromJson(json);
  }

  @override
  FutureOr<void> onCall(
    BuildContext context,
    ShowTransferCardScannerActionModel model,
  ) async {
    if (!context.mounted) return;

    final result = await Navigator.of(context).push<_ScannedTransferCardResult>(
      MaterialPageRoute(builder: (_) => const _TransferCardScannerScreen()),
    );

    if (!context.mounted) return;

    final scannedDigits = _normalizeCard(result?.cardNumber ?? '');
    final isSuccess = result?.isSuccess == true && scannedDigits.length == 16;

    if (!isSuccess) {
      if (model.failedAction != null) {
        await Stac.onCallFromJson(model.failedAction!, context);
      }
      return;
    }

    TextFormFieldControllerRegistry.instance.updateValue(
      model.fieldId,
      scannedDigits,
    );
    StacRegistry.instance.setValue(model.fieldId, scannedDigits);
    RegistryNotifier.instance.notify();

    if (model.successAction != null) {
      await Stac.onCallFromJson(model.successAction!, context);
    }
  }

  String _normalizeCard(String input) {
    return input.replaceAll(RegExp(r'[^0-9]'), '');
  }
}

class _TransferCardScannerScreen extends StatefulWidget {
  const _TransferCardScannerScreen();

  @override
  State<_TransferCardScannerScreen> createState() =>
      _TransferCardScannerScreenState();
}

class _TransferCardScannerScreenState
    extends State<_TransferCardScannerScreen> {
  final ScannerWidgetController _controller = ScannerWidgetController();
  bool _didReturn = false;

  @override
  void initState() {
    super.initState();
    _controller.setCardListener((cardInfo) {
      if (_didReturn) return;
      _didReturn = true;

      Navigator.of(context).pop(
        _ScannedTransferCardResult(
          cardNumber: cardInfo?.number,
          isSuccess: cardInfo?.number != null,
        ),
      );
    });
    _controller.setErrorListener((_) {
      if (_didReturn) return;
      _didReturn = true;
      Navigator.of(
        context,
      ).pop(const _ScannedTransferCardResult(isSuccess: false));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'اسکن کارت',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        body: SafeArea(
          child: Center(
            child: ScannerWidget(
              overlayOrientation: CardOrientation.landscape,
              controller: _controller,
            ),
          ),
        ),
      ),
    );
  }
}

class _ScannedTransferCardResult {
  final String? cardNumber;
  final bool isSuccess;

  const _ScannedTransferCardResult({this.cardNumber, required this.isSuccess});
}

void registerShowTransferCardScannerActionParser() {
  CustomComponentRegistry.instance.registerAction(
    const ShowTransferCardScannerActionParser(),
  );
}
