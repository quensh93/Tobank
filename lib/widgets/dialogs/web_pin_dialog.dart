import 'package:flutter/material.dart';

class WebPinDialog extends StatefulWidget {
  final Function(Function(String) setError) onDialogCreated;
  final Function(String password) onConfirm;

  const WebPinDialog({
    super.key,
    required this.onDialogCreated,
    required this.onConfirm,
  });

  @override
  State<WebPinDialog> createState() => _WebPinDialogState();
}

class _WebPinDialogState extends State<WebPinDialog> {
  final TextEditingController _controller = TextEditingController();
  String? _errorText;

  @override
  void initState() {
    super.initState();
    widget.onDialogCreated((error) {
      if (mounted) {
        setState(() {
          _errorText = error;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Enter Password'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _controller,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Password',
              errorText: _errorText,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onConfirm(_controller.text);
          },
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}
