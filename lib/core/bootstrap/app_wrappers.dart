import 'package:flutter/material.dart';

class AppWrappers extends StatelessWidget {
  const AppWrappers({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
