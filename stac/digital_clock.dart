import 'dart:async';
import 'package:stac_core/stac_core.dart';

/// Digital Clock Widget using STAC annotations
/// This demonstrates the proper STAC workflow for building widgets
@StacScreen(screenName: 'digital_clock')
StacWidget digitalClock() {
  return StacScaffold(
    appBar: StacAppBar(
      title: StacText(
        data: 'Digital Clock',
        style: StacTextStyle(
          fontSize: 24,
          fontWeight: 'bold',
        ),
      ),
      backgroundColor: 'transparent',
      elevation: 0,
      centerTitle: true,
    ),
    backgroundColor: '#FEFBFF',
    body: StacPadding(
      padding: StacEdgeInsets(
        left: 16,
        right: 16,
        top: 32,
        bottom: 16,
      ),
      child: StacColumn(
        mainAxisAlignment: 'center',
        crossAxisAlignment: 'stretch',
        children: [
          StacText(
            data: '🕐 Digital Clock Widget',
            style: StacTextStyle(
              fontSize: 28,
              fontWeight: 'w400',
              color: '#1C1B1F',
            ),
          ),
          StacSizedBox(height: 8),
          StacText(
            data: 'Built with STAC annotations and code generation',
            style: StacTextStyle(
              fontSize: 16,
              fontWeight: 'w400',
              color: '#49454F',
            ),
          ),
          StacSizedBox(height: 40),
          // 24-hour format clock
          StacContainer(
            decoration: StacBoxDecoration(
              color: '#F7F2FA',
              borderRadius: 12,
              boxShadow: [
                StacBoxShadow(
                  color: '#000000',
                  opacity: 0.1,
                  blurRadius: 8,
                  offset: StacOffset(x: 0, y: 2),
                ),
              ],
            ),
            padding: StacEdgeInsets(
              top: 24,
              bottom: 24,
              left: 32,
              right: 32,
            ),
            child: StacText(
              data: '12:34:56',
              style: StacTextStyle(
                fontSize: 32,
                fontWeight: 'bold',
                color: '#6750A4',
                fontFamily: 'monospace',
              ),
              textAlign: 'center',
            ),
          ),
          StacSizedBox(height: 32),
          // 12-hour format clock
          StacContainer(
            decoration: StacBoxDecoration(
              color: '#E8F5E8',
              borderRadius: 12,
              boxShadow: [
                StacBoxShadow(
                  color: '#000000',
                  opacity: 0.1,
                  blurRadius: 8,
                  offset: StacOffset(x: 0, y: 2),
                ),
              ],
            ),
            padding: StacEdgeInsets(
              top: 20,
              bottom: 20,
              left: 24,
              right: 24,
            ),
            child: StacText(
              data: '12:34 PM',
              style: StacTextStyle(
                fontSize: 24,
                fontWeight: 'w500',
                color: '#2E7D32',
                fontFamily: 'monospace',
              ),
              textAlign: 'center',
            ),
          ),
          StacSizedBox(height: 24),
          StacText(
            data: 'This widget demonstrates:',
            style: StacTextStyle(
              fontSize: 16,
              fontWeight: 'w500',
              color: '#1C1B1F',
            ),
          ),
          StacSizedBox(height: 8),
          StacText(
            data: '• @StacScreen() annotations',
            style: StacTextStyle(
              fontSize: 14,
              fontWeight: 'w400',
              color: '#49454F',
            ),
          ),
          StacText(
            data: '• STAC widget composition',
            style: StacTextStyle(
              fontSize: 14,
              fontWeight: 'w400',
              color: '#49454F',
            ),
          ),
          StacText(
            data: '• Code generation with stac build',
            style: StacTextStyle(
              fontSize: 14,
              fontWeight: 'w400',
              color: '#49454F',
            ),
          ),
          StacText(
            data: '• Server-driven UI architecture',
            style: StacTextStyle(
              fontSize: 14,
              fontWeight: 'w400',
              color: '#49454F',
            ),
          ),
        ],
      ),
    ),
  );
}
