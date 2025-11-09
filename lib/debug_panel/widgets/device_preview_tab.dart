import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:device_frame/device_frame.dart';
import '../state/device_preview_state.dart';

/// Device preview tab - replaces the Logs tab
class DevicePreviewTab extends ConsumerWidget {
  const DevicePreviewTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(devicePreviewProvider);
    final controller = ref.read(devicePreviewProvider.notifier);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Device Selection Section
          _buildSectionHeader(context, 'Device Selection'),
          const SizedBox(height: 8),
          _buildDeviceSelector(context, state, controller),
          
          const SizedBox(height: 24),
          
          // Preview Controls Section
          _buildSectionHeader(context, 'Preview Controls'),
          const SizedBox(height: 8),
          _buildPreviewControls(context, state, controller),
          
          const SizedBox(height: 24),
          
          // Device Info Section
          _buildSectionHeader(context, 'Device Information'),
          const SizedBox(height: 8),
          _buildDeviceInfo(context, state),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Widget _buildDeviceSelector(BuildContext context, DevicePreviewState state, DevicePreviewController controller) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.phone_android,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Select Device',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _DeviceSelectorButton(
              selectedDevice: state.selectedDevice,
              devices: _getAllDevices(),
              onDeviceSelected: (device) => controller.selectDevice(device),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreviewControls(BuildContext context, DevicePreviewState state, DevicePreviewController controller) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Frame Visibility Toggle
            ListTile(
              leading: Icon(
                state.isFrameVisible ? Icons.border_outer : Icons.border_clear,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: const Text('Device Frame'),
              subtitle: Text(state.isFrameVisible ? 'Visible' : 'Hidden'),
              trailing: Switch(
                value: state.isFrameVisible,
                onChanged: (_) => controller.toggleFrame(),
              ),
              onTap: () => controller.toggleFrame(),
            ),
            const Divider(),
            // Preview Enabled Toggle
            ListTile(
              leading: Icon(
                state.isPreviewEnabled ? Icons.visibility : Icons.visibility_off,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: const Text('Device Preview'),
              subtitle: Text(state.isPreviewEnabled ? 'Enabled' : 'Disabled'),
              trailing: Switch(
                value: state.isPreviewEnabled,
                onChanged: (_) => controller.togglePreview(),
              ),
              onTap: () => controller.togglePreview(),
            ),
            const Divider(),
            // Orientation Toggle
            ListTile(
              leading: Icon(
                Icons.screen_rotation,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: const Text('Orientation'),
              subtitle: Text(
                state.orientation == Orientation.portrait ? 'Portrait' : 'Landscape',
              ),
              trailing: IconButton(
                icon: AnimatedRotation(
                  turns: state.orientation == Orientation.landscape ? 0.25 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  child: const Icon(Icons.rotate_90_degrees_cw),
                ),
                onPressed: () => controller.rotate(),
              ),
              onTap: () => controller.rotate(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeviceInfo(BuildContext context, DevicePreviewState state) {
    final device = state.selectedDevice;
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Current Device',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildInfoRow(context, 'Name', device.name),
            _buildInfoRow(context, 'Platform', device.identifier.platform.name.toUpperCase()),
            _buildInfoRow(context, 'Type', device.identifier.type.name.toUpperCase()),
            _buildInfoRow(context, 'Screen Size', '${device.screenSize.width.toInt()} x ${device.screenSize.height.toInt()}'),
            _buildInfoRow(context, 'Pixel Ratio', '${device.pixelRatio}x'),
            _buildInfoRow(context, 'Orientation', state.orientation.name.toUpperCase()),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }

  List<DeviceInfo> _getAllDevices() {
    return [
      // iOS Devices
      Devices.ios.iPhone15Pro,
      Devices.ios.iPhone15ProMax,
      Devices.ios.iPhone16,
      Devices.ios.iPhone16Pro,
      Devices.ios.iPhone13,
      Devices.ios.iPhoneSE,
      Devices.ios.iPadAir4,
      Devices.ios.iPad,
      Devices.ios.iPadPro11Inches,
      
      // Android Devices
      Devices.android.samsungGalaxyS20,
      Devices.android.samsungGalaxyS25,
      Devices.android.samsungGalaxyA50,
      Devices.android.googlePixel9,
      Devices.android.onePlus8Pro,
      Devices.android.smallPhone,
      Devices.android.mediumPhone,
      Devices.android.bigPhone,
      Devices.android.smallTablet,
      Devices.android.mediumTablet,
      Devices.android.largeTablet,
    ];
  }
}

/// Custom device selector button that uses Stack-based dropdown
/// to avoid Navigator/Overlay context issues in debug panel
class _DeviceSelectorButton extends StatefulWidget {
  const _DeviceSelectorButton({
    required this.selectedDevice,
    required this.devices,
    required this.onDeviceSelected,
  });

  final DeviceInfo selectedDevice;
  final List<DeviceInfo> devices;
  final ValueChanged<DeviceInfo> onDeviceSelected;

  @override
  State<_DeviceSelectorButton> createState() => _DeviceSelectorButtonState();
}

class _DeviceSelectorButtonState extends State<_DeviceSelectorButton> {
  bool _isMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Button
        InkWell(
          onTap: () {
            setState(() {
              _isMenuOpen = !_isMenuOpen;
            });
          },
          borderRadius: BorderRadius.circular(4),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: colorScheme.outline,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Icon(
                  _getDeviceIcon(widget.selectedDevice.identifier.type),
                  size: 16,
                  color: colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    widget.selectedDevice.name.isNotEmpty
                        ? widget.selectedDevice.name
                        : '${widget.selectedDevice.screenSize.width.toInt()}x${widget.selectedDevice.screenSize.height.toInt()} @${widget.selectedDevice.pixelRatio}x',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                Icon(
                  _isMenuOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  size: 20,
                  color: colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
        // Dropdown menu (shown when _isMenuOpen is true)
        if (_isMenuOpen) ...[
          const SizedBox(height: 4),
          Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(4),
            color: colorScheme.surface,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 300),
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                children: widget.devices.map((device) {
                  final isSelected = device.identifier.name == widget.selectedDevice.identifier.name;
                  return InkWell(
                    onTap: () {
                      widget.onDeviceSelected(device);
                      setState(() {
                        _isMenuOpen = false;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        children: [
                          Icon(
                            _getDeviceIcon(device.identifier.type),
                            size: 16,
                            color: colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              device.name.isNotEmpty
                                  ? device.name
                                  : '${device.screenSize.width.toInt()}x${device.screenSize.height.toInt()} @${device.pixelRatio}x',
                              style: TextStyle(
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                fontSize: 14,
                                color: colorScheme.onSurface,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          if (isSelected)
                            Icon(
                              Icons.check,
                              size: 16,
                              color: colorScheme.primary,
                            ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ],
    );
  }

  IconData _getDeviceIcon(DeviceType type) {
    switch (type) {
      case DeviceType.phone:
        return Icons.phone_android;
      case DeviceType.tablet:
        return Icons.tablet;
      case DeviceType.desktop:
        return Icons.desktop_windows;
      case DeviceType.laptop:
        return Icons.laptop;
      case DeviceType.tv:
        return Icons.tv;
      case DeviceType.unknown:
        return Icons.device_unknown;
    }
  }
}
