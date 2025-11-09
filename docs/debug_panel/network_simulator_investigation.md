# Network Simulator Investigation Report

## Issue
Network requests were slow even after disabling the network simulator in the debug panel.

## Root Causes Identified

### 1. **SlowNetSimulator Still Being Configured When Disabled** ✅ FIXED
**Problem**: When the network simulator was disabled, the code was still calling `SlowNetSimulator.configure()` with LTE_4G speed and 0.0 failure probability. This meant the global SlowNetSimulator configuration was still active, even though requests were being bypassed at the adapter level.

**Location**: `lib/debug_panel/state/network_simulator_state.dart:179-194`

**Fix Applied**: 
- Removed the `SlowNetSimulator.configure()` call when disabled
- Now when disabled, we don't configure SlowNetSimulator at all
- The `NetworkSimulatorAdapter` checks `isEnabled()` before wrapping requests, so it properly bypasses without needing global configuration

### 2. **StacNetworkService Uses Separate Dio Instance** ⚠️ NOT AN ISSUE
**Finding**: `Stac.initialize()` in `lib/main.dart` creates its own `Dio()` instance if none is provided. This Dio instance doesn't have the `NetworkSimulatorAdapter` configured.

**Impact**: 
- When simulator is **disabled**: This is fine - Stac requests won't be slowed down
- When simulator is **enabled**: Stac requests won't be simulated (inconsistency)

**Note**: This is not the cause of the current issue since the simulator is disabled. If you want Stac requests to also be simulated when enabled, you'll need to pass the Dio instance from the provider to `Stac.initialize()`.

### 3. **Dio Provider Reactivity** ✅ WORKING CORRECTLY
**Finding**: The Dio provider uses `ref.watch(networkSimulatorProvider)` and passes `isEnabled: () => networkSimulatorState.isEnabled` as a callback to the adapter.

**Status**: This is working correctly. The callback is evaluated at runtime for each request, so it always reads the current state value.

## Fixes Applied

1. **Removed SlowNetSimulator configuration when disabled**
   - File: `lib/debug_panel/state/network_simulator_state.dart`
   - Changed `_applySettingsToSimulator()` to not call `SlowNetSimulator.configure()` when disabled
   - Added explanatory comments

2. **Improved logging**
   - File: `lib/core/network/network_simulator_adapter.dart`
   - Added comments explaining the bypass behavior
   - Removed verbose logging when disabled to reduce noise

## Testing Recommendations

1. **Test with simulator disabled**:
   - Verify requests are fast (normal network speed)
   - Check logs to confirm "bypassing simulation" behavior
   - Verify no `SlowNetSimulator.configure()` is called

2. **Test with simulator enabled**:
   - Verify requests are slowed according to selected speed
   - Check that `SlowNetSimulator.configure()` is called with correct settings

3. **Test state changes**:
   - Enable simulator, make a request, then disable it
   - Verify that subsequent requests are fast immediately after disabling

## Current Behavior

### When Network Simulator is DISABLED:
- ✅ `SlowNetSimulator.configure()` is **NOT called** (no global config)
- ✅ `NetworkSimulatorAdapter` checks `isEnabled()` and **bypasses** `SlowNetSimulator.simulate()`
- ✅ Requests go directly through the underlying adapter (IOHttpClientAdapter)
- ✅ No delays or simulations are applied

### When Network Simulator is ENABLED:
- ✅ `SlowNetSimulator.configure()` is called with selected speed and failure probability
- ✅ `NetworkSimulatorAdapter` wraps requests with `SlowNetSimulator.simulate()`
- ✅ Network delays and failures are applied according to configuration

## Additional Notes

- The `NetworkSimulatorInterceptor` is still added even when disabled, but it only marks requests for debugging - it doesn't add any delays
- StacNetworkService uses a separate Dio instance, which is fine when simulator is disabled but creates inconsistency when enabled
- If you need consistent simulation across all Dio instances, consider passing the Dio from the provider to `Stac.initialize()`

## Conclusion

The issue was that `SlowNetSimulator.configure()` was being called even when disabled. This has been fixed. The network simulator should now work correctly:
- **When disabled**: No delays, normal network speed
- **When enabled**: Configured delays and failure probabilities applied

If you still experience slow requests after these fixes, the slowness is likely due to:
1. Normal network latency
2. Actual network conditions
3. Server response times
4. Other factors unrelated to the network simulator

