import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/main_theme.dart';

class MainButton extends StatefulWidget {
  final String? title;
  final Function onTap;
  final Color? buttonColor;
  final Widget? widget;
  final EdgeInsets? margin;
  final bool disable;

  const MainButton({
    required this.onTap,
    required this.disable,
    this.title,
    this.margin,
    this.buttonColor,
    this.widget,
    super.key,
  });

  @override
  State<MainButton> createState() => _MainButtonState();
}

class _MainButtonState extends State<MainButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        if (!widget.disable) {
          widget.onTap();
        }
      },
      child: Container(
        margin: widget.margin ??const EdgeInsets.symmetric(vertical: 16),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: ShapeDecoration(
          color:
              widget.disable ? MainTheme.of(context).surfaceContainerLowest : widget.buttonColor ?? MainTheme.of(context).primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Center(
          child: widget.widget ??
              Text(
                widget.title ?? 'no name',
                textAlign: TextAlign.center,
                style: context.theme.textTheme.titleMedium?.copyWith(
                  color: MainTheme.of(context).staticWhite,
                ),
              ),
        ),
      ),
    );
  }
}
