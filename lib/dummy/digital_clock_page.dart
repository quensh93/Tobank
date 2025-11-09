import 'package:flutter/material.dart';
import 'digital_clock_widget.dart';

class DigitalClockPage extends StatelessWidget {
  const DigitalClockPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Digital Clock'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFFEFBFF),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '🕐 Digital Clock Widget',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w400,
                color: Color(0xFF1C1B1F),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Built with Flutter Timer and STAC Framework',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFF49454F),
              ),
            ),
            const SizedBox(height: 32),
            // 24-hour format clock
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF7F2FA),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
              child: DigitalClockWidget(
                showSeconds: true,
                timeFormat: '24',
                textStyle: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6750A4),
                  fontFamily: 'monospace',
                ),
                backgroundColor: Colors.transparent,
              ),
            ),
            const SizedBox(height: 24),
            // 12-hour format clock
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E8),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
              child: DigitalClockWidget(
                showSeconds: false,
                timeFormat: '12',
                textStyle: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF2E7D32),
                  fontFamily: 'monospace',
                ),
                backgroundColor: Colors.transparent,
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'This widget demonstrates:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1C1B1F),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '• Real-time updates with Timer',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF49454F),
              ),
            ),
            const Text(
              '• Flutter StatefulWidget',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF49454F),
              ),
            ),
            const Text(
              '• STAC framework integration',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF49454F),
              ),
            ),
            const Text(
              '• Server-driven UI architecture',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF49454F),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
