import 'package:flutter/material.dart';

import 'custom_app_bar.dart';

class CustomScreen extends StatelessWidget {
  final String title;
  final Widget child;

  const CustomScreen({
    required this.title,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: CustomAppBar(
          titleString: title,
          context: context,
        ),
        body: SafeArea(
          child: child,
        ),
      ),
    );
  }
}
