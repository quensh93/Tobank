import 'package:flutter/material.dart';

class TextFieldClearIconWidget extends StatelessWidget {
  const TextFieldClearIconWidget({
    required this.isVisible,
    required this.clearFunction,
    super.key,
  });

  final bool isVisible;
  final Function clearFunction;

  @override
  Widget build(BuildContext context) {
    return ExcludeFocus(
      child: isVisible
          ? Padding(
              padding: const EdgeInsets.all(12.0),
              child: InkWell(
                onTap: () {
                  clearFunction();
                },
                child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.withOpacity(0.2),
                    ),
                    child: const Icon(
                      Icons.close,
                      size: 12,
                    )),
              ),
            )
          : const SizedBox(
              width: 0,
            ),
    );
  }
}
