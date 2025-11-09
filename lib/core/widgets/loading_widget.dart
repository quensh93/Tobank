import 'package:flutter/material.dart';

/// Custom loading widget for displaying loading states
class LoadingWidget extends StatelessWidget {
  final String? message;
  final bool center;

  const LoadingWidget({
    super.key,
    this.message,
    this.center = true,
  });

  @override
  Widget build(BuildContext context) {
    final widget = Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircularProgressIndicator(),
        if (message != null) ...[
          const SizedBox(height: 16),
          Text(
            message!,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );

    if (center) {
      return Center(child: widget);
    }

    return widget;
  }
}

/// Loading overlay widget
class LoadingOverlay extends StatelessWidget {
  final Widget child;
  final bool isLoading;

  const LoadingOverlay({
    super.key,
    required this.child,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: Colors.black.withOpacity(0.3),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}
