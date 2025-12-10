import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextFieldErrorWidget extends StatelessWidget {
  const TextFieldErrorWidget({
    required this.isValid,
    required this.errorText,
    super.key,
  });

  final bool isValid;
  final String errorText;

  @override
  Widget build(BuildContext context) {
    return isValid
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 4.0,
              ),
              Row(
                children: [
                  Text(
                    !isValid ? errorText : '',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: context.theme.colorScheme.error,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ],
          );
  }
}
