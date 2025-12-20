import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stac/stac.dart';
import '../services/widget/stac_widget_loader.dart';
import '../services/theme/stac_theme_wrapper.dart';

/// Flow Step Model - represents a single step in a flow
class FlowStep {
  final String id;
  final String title;
  final String description;
  final String widgetType;
  final String jsonPath;
  final String apiPath;
  final int? duration; // milliseconds, null = wait for user action
  final bool enabled;

  FlowStep({
    required this.id,
    required this.title,
    required this.description,
    required this.widgetType,
    required this.jsonPath,
    required this.apiPath,
    this.duration,
    this.enabled = true,
  });

  factory FlowStep.fromJson(Map<String, dynamic> json) {
    return FlowStep(
      id: json['id'] as String,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      widgetType: json['widgetType'] as String,
      jsonPath: json['jsonPath'] as String? ?? '',
      apiPath: json['apiPath'] as String? ?? '',
      duration: json['duration'] as int?,
      enabled: json['enabled'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'widgetType': widgetType,
    'jsonPath': jsonPath,
    'apiPath': apiPath,
    'duration': duration,
    'enabled': enabled,
  };
}

/// Flow Config Model - represents the entire flow configuration
class FlowConfig {
  final String flowId;
  final String title;
  final String description;
  final List<FlowStep> steps;
  final List<FlowStep> allSteps; // includes disabled steps

  FlowConfig({
    required this.flowId,
    required this.title,
    required this.description,
    required this.steps,
    required this.allSteps,
  });

  factory FlowConfig.fromJson(Map<String, dynamic> json) {
    final stepsJson = json['steps'] as List<dynamic>? ?? [];
    final allSteps = stepsJson
        .map((s) => FlowStep.fromJson(s as Map<String, dynamic>))
        .toList();
    return FlowConfig(
      flowId: json['flowId'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      allSteps: allSteps,
      steps: allSteps.where((step) => step.enabled).toList(), // Filter enabled
    );
  }

  /// Get the next step after the given step ID
  FlowStep? getNextStep(String currentStepId) {
    final currentIndex = steps.indexWhere((s) => s.id == currentStepId);
    if (currentIndex == -1 || currentIndex >= steps.length - 1) {
      return null; // No next step
    }
    return steps[currentIndex + 1];
  }

  /// Check if this is the last step
  bool isLastStep(String stepId) {
    final index = steps.indexWhere((s) => s.id == stepId);
    return index == steps.length - 1;
  }
}

/// Flow Manager - manages the flow state and navigation
class FlowManager extends ChangeNotifier {
  final FlowConfig config;
  int _currentStepIndex = 0;
  bool _isCompleted = false;

  FlowManager(this.config);

  FlowStep get currentStep => config.steps[_currentStepIndex];
  bool get isCompleted => _isCompleted;
  bool get isLastStep => _currentStepIndex >= config.steps.length - 1;
  int get currentIndex => _currentStepIndex;
  int get totalSteps => config.steps.length;

  /// Move to the next step
  bool nextStep() {
    if (_currentStepIndex < config.steps.length - 1) {
      _currentStepIndex++;
      notifyListeners();
      return true;
    } else {
      _isCompleted = true;
      notifyListeners();
      return false;
    }
  }

  /// Go to a specific step by ID
  bool goToStep(String stepId) {
    final index = config.steps.indexWhere((s) => s.id == stepId);
    if (index != -1) {
      _currentStepIndex = index;
      notifyListeners();
      return true;
    }
    return false;
  }

  /// Reset the flow to the beginning
  void reset() {
    _currentStepIndex = 0;
    _isCompleted = false;
    notifyListeners();
  }
}

/// Flow Manager Widget - the main widget that renders and manages the flow
class FlowManagerWidget extends StatefulWidget {
  final String configPath; // Path to flow config JSON
  final bool useApiPath; // Whether to use API mock path
  final VoidCallback? onFlowComplete;

  const FlowManagerWidget({
    super.key,
    required this.configPath,
    this.useApiPath = false,
    this.onFlowComplete,
  });

  @override
  State<FlowManagerWidget> createState() => _FlowManagerWidgetState();
}

class _FlowManagerWidgetState extends State<FlowManagerWidget> {
  FlowManager? _flowManager;
  bool _isLoading = true;
  String? _error;
  Timer? _durationTimer;

  @override
  void initState() {
    super.initState();
    _loadFlowConfig();
  }

  @override
  void dispose() {
    _durationTimer?.cancel();
    _flowManager?.removeListener(_onFlowStateChanged);
    _flowManager?.dispose();
    super.dispose();
  }

  Future<void> _loadFlowConfig() async {
    try {
      final jsonString = await rootBundle.loadString(widget.configPath);
      var json = jsonDecode(jsonString) as Map<String, dynamic>;

      // If API format, extract data
      if (json.containsKey('GET')) {
        json =
            (json['GET'] as Map<String, dynamic>)['data']
                as Map<String, dynamic>;
      }

      final config = FlowConfig.fromJson(json);
      setState(() {
        _flowManager = FlowManager(config);
        // Add listener to rebuild when flow state changes (from flowNext action)
        _flowManager!.addListener(_onFlowStateChanged);
        _isLoading = false;
      });

      // Start duration timer if needed
      _handleStepDuration();
    } catch (e) {
      setState(() {
        _error = 'Error loading flow config: $e';
        _isLoading = false;
      });
    }
  }

  /// Called when FlowManager state changes (from flowNext action)
  void _onFlowStateChanged() {
    debugPrint(
      '🔄 FlowManager state changed! Current step: ${_flowManager!.currentIndex}',
    );

    // Check if flow is completed
    if (_flowManager!.isCompleted) {
      debugPrint('✅ Flow completed! Navigating back...');
      // Schedule the completion action for next frame to avoid calling during build
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _completeFlow();
        }
      });
      return;
    }

    _handleStepDuration();
    setState(() {}); // Rebuild to show new step
  }

  void _handleStepDuration() {
    _durationTimer?.cancel();

    final currentStep = _flowManager?.currentStep;
    if (currentStep?.duration != null && currentStep!.duration! > 0) {
      _durationTimer = Timer(
        Duration(milliseconds: currentStep.duration!),
        _goToNextStep,
      );
    }
  }

  void _goToNextStep() {
    if (_flowManager == null) return;

    if (_flowManager!.isLastStep) {
      // Flow completed
      _completeFlow();
    } else {
      _flowManager!.nextStep();
      _handleStepDuration();
      setState(() {});
    }
  }

  void _completeFlow() {
    if (widget.onFlowComplete != null) {
      widget.onFlowComplete!();
    } else {
      // Default: pop all and go back to menu
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_error != null) {
      return Scaffold(
        body: Center(
          child: Text(_error!, style: const TextStyle(color: Colors.red)),
        ),
      );
    }

    final currentStep = _flowManager!.currentStep;

    return FlowProvider(
      manager: _flowManager!,
      child: _FlowStepWidget(
        key: ValueKey(currentStep.id),
        step: currentStep,
        flowManager: _flowManager!,
        onStepComplete: _goToNextStep,
        onFlowComplete: _completeFlow,
      ),
    );
  }
}

/// Inherited Widget to provide FlowManager to descendants
class FlowProvider extends InheritedWidget {
  final FlowManager manager;

  const FlowProvider({super.key, required this.manager, required super.child});

  @override
  bool updateShouldNotify(FlowProvider oldWidget) {
    return manager != oldWidget.manager ||
        manager.currentIndex != oldWidget.manager.currentIndex;
  }
}

/// Widget that renders a single flow step
class _FlowStepWidget extends StatelessWidget {
  final FlowStep step;
  final FlowManager flowManager;
  final VoidCallback onStepComplete;
  final VoidCallback onFlowComplete;

  const _FlowStepWidget({
    super.key,
    required this.step,
    required this.flowManager,
    required this.onStepComplete,
    required this.onFlowComplete,
  });

  @override
  Widget build(BuildContext context) {
    // Load the widget JSON using StacWidgetLoader
    return FutureBuilder<Map<String, dynamic>?>(
      future: _loadStepWidget(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError || snapshot.data == null) {
          return Scaffold(
            body: Center(
              child: Text(
                'Error loading step: ${step.id}',
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        }

        // Build the widget using Stac with theme wrapper for consistent styling
        final widget = Stac.fromJson(snapshot.data!, context);

        // Wrap with StacThemeWrapper to ensure proper border styling
        // This matches how standalone screens are rendered via StacWidgetResolver
        return widget != null
            ? StacThemeWrapper.wrapWithTheme(context, widget)
            : const SizedBox.shrink();
      },
    );
  }

  Future<Map<String, dynamic>?> _loadStepWidget() async {
    debugPrint('🔍 Loading step widget: ${step.widgetType}');

    // First try to load from StacWidgetLoader (for dart-based widgets)
    final json = StacWidgetLoader.loadWidgetJson(step.widgetType);
    if (json != null) {
      debugPrint('✅ Loaded from Dart: ${step.widgetType}');
      return json;
    }

    debugPrint(
      '⚠️ Dart loader returned null for ${step.widgetType}, falling back to JSON file: ${step.jsonPath}',
    );

    // Fallback to loading from jsonPath
    try {
      final jsonString = await rootBundle.loadString(step.jsonPath);
      debugPrint('✅ Loaded from JSON file: ${step.jsonPath}');
      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      debugPrint('❌ Error loading from JSON file: $e');
      return null;
    }
  }
}

/// Helper function to load and parse a flow config
Future<FlowConfig?> loadFlowConfig(String configPath) async {
  try {
    final jsonString = await rootBundle.loadString(configPath);
    var json = jsonDecode(jsonString) as Map<String, dynamic>;

    // If API format, extract data
    if (json.containsKey('GET')) {
      json =
          (json['GET'] as Map<String, dynamic>)['data'] as Map<String, dynamic>;
    }

    return FlowConfig.fromJson(json);
  } catch (e) {
    debugPrint('Error loading flow config: $e');
    return null;
  }
}
