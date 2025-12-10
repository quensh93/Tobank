// Example: Creating a Custom Analytics Action for STAC
// This example demonstrates how to create a custom action that tracks analytics events

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

// Import STAC core (adjust path based on your project structure)
// import 'package:stac/stac.dart';

part 'custom-action-example.g.dart';

// ============================================================================
// STEP 1: Create the Action Model
// ============================================================================

/// Model representing an analytics tracking action
@JsonSerializable()
class AnalyticsActionModel {
  /// Event name to track
  final String eventName;
  
  /// Event category (e.g., 'user_interaction', 'navigation', 'purchase')
  final String category;
  
  /// Event parameters/properties
  final Map<String, dynamic>? parameters;
  
  /// Whether to track user ID with the event
  final bool includeUserId;
  
  /// Whether to track timestamp
  final bool includeTimestamp;
  
  /// Optional callback action to execute after tracking
  final Map<String, dynamic>? onComplete;

  const AnalyticsActionModel({
    required this.eventName,
    required this.category,
    this.parameters,
    this.includeUserId = true,
    this.includeTimestamp = true,
    this.onComplete,
  });

  /// Create from JSON
  factory AnalyticsActionModel.fromJson(Map<String, dynamic> json) =>
      _$AnalyticsActionModelFromJson(json);

  /// Convert to JSON
  Map<String, dynamic> toJson() => _$AnalyticsActionModelToJson(this);
}

// ============================================================================
// STEP 2: Create the Action Parser
// ============================================================================

/// Parser that executes analytics tracking actions
class AnalyticsActionParser extends StacActionParser<AnalyticsActionModel> {
  @override
  String get actionType => 'trackAnalytics';

  @override
  AnalyticsActionModel fromJson(Map<String, dynamic> json) {
    return AnalyticsActionModel.fromJson(json);
  }

  @override
  Future<void> execute(BuildContext context, AnalyticsActionModel model) async {
    try {
      // Log the action start
      print('📊 Tracking analytics event: ${model.eventName}');
      
      // Build event data
      final eventData = _buildEventData(model);
      
      // Track the event
      await _trackEvent(model.eventName, model.category, eventData);
      
      // Log success
      StacLogger.logComponentRender(
        componentType: 'analyticsAction',
        properties: model.toJson(),
        duration: Duration.zero,
      );
      
      // Execute callback action if provided
      if (model.onComplete != null) {
        await _executeCallback(context, model.onComplete!);
      }
    } catch (e, stackTrace) {
      // Log error
      StacLogger.logError(
        operation: 'trackAnalytics',
        error: e.toString(),
        suggestion: 'Check analytics service configuration',
        stackTrace: stackTrace,
      );
      
      // Don't throw - analytics failures shouldn't break the app
      print('⚠️ Analytics tracking failed: $e');
    }
  }

  Map<String, dynamic> _buildEventData(AnalyticsActionModel model) {
    final data = <String, dynamic>{};
    
    // Add custom parameters
    if (model.parameters != null) {
      data.addAll(model.parameters!);
    }
    
    // Add user ID if requested
    if (model.includeUserId) {
      // Get user ID from your auth service
      // final userId = AuthService.instance.currentUserId;
      // data['user_id'] = userId;
      data['user_id'] = 'demo_user_123'; // Example
    }
    
    // Add timestamp if requested
    if (model.includeTimestamp) {
      data['timestamp'] = DateTime.now().toIso8601String();
    }
    
    // Add category
    data['category'] = model.category;
    
    return data;
  }

  Future<void> _trackEvent(
    String eventName,
    String category,
    Map<String, dynamic> data,
  ) async {
    // Integrate with your analytics service
    // Examples:
    
    // Firebase Analytics:
    // await FirebaseAnalytics.instance.logEvent(
    //   name: eventName,
    //   parameters: data,
    // );
    
    // Mixpanel:
    // await Mixpanel.track(eventName, properties: data);
    
    // Custom Analytics:
    // await AnalyticsService.instance.track(eventName, data);
    
    // For demonstration:
    print('📊 Event tracked: $eventName');
    print('   Category: $category');
    print('   Data: $data');
    
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 100));
  }

  Future<void> _executeCallback(
    BuildContext context,
    Map<String, dynamic> callbackAction,
  ) async {
    // Execute the callback action using STAC action system
    // Example: await StacActionService.execute(context, callbackAction);
    print('✅ Analytics tracked, executing callback');
  }
}

// ============================================================================
// STEP 3: Create Additional Action Types (Optional)
// ============================================================================

/// Model for screen view tracking
@JsonSerializable()
class ScreenViewActionModel {
  final String screenName;
  final String? screenClass;
  final Map<String, dynamic>? parameters;

  const ScreenViewActionModel({
    required this.screenName,
    this.screenClass,
    this.parameters,
  });

  factory ScreenViewActionModel.fromJson(Map<String, dynamic> json) =>
      _$ScreenViewActionModelFromJson(json);

  Map<String, dynamic> toJson() => _$ScreenViewActionModelToJson(this);
}

/// Parser for screen view tracking
class ScreenViewActionParser extends StacActionParser<ScreenViewActionModel> {
  @override
  String get actionType => 'trackScreenView';

  @override
  ScreenViewActionModel fromJson(Map<String, dynamic> json) {
    return ScreenViewActionModel.fromJson(json);
  }

  @override
  Future<void> execute(BuildContext context, ScreenViewActionModel model) async {
    print('📱 Screen view: ${model.screenName}');
    
    // Track screen view
    // await FirebaseAnalytics.instance.logScreenView(
    //   screenName: model.screenName,
    //   screenClass: model.screenClass,
    // );
    
    // Or custom implementation
    final data = {
      'screen_name': model.screenName,
      if (model.screenClass != null) 'screen_class': model.screenClass,
      if (model.parameters != null) ...model.parameters!,
    };
    
    print('   Data: $data');
  }
}

// ============================================================================
// STEP 4: Register the Parsers
// ============================================================================

/// Register the custom action parsers in your app initialization
/// 
/// Example in main.dart:
/// ```dart
/// void main() {
///   // Register custom actions
///   final registry = CustomComponentRegistry.instance;
///   registry.registerAction(AnalyticsActionParser());
///   registry.registerAction(ScreenViewActionParser());
///   
///   runApp(MyApp());
/// }
/// ```

// ============================================================================
// STEP 5: Use in JSON
// ============================================================================

/// Example 1: Track button click
/// ```json
/// {
///   "type": "elevatedButton",
///   "child": {
///     "type": "text",
///     "data": "Add to Cart"
///   },
///   "onPressed": {
///     "actionType": "trackAnalytics",
///     "eventName": "add_to_cart",
///     "category": "ecommerce",
///     "parameters": {
///       "product_id": "12345",
///       "product_name": "Wireless Headphones",
///       "price": 299.99,
///       "quantity": 1
///     },
///     "includeUserId": true,
///     "includeTimestamp": true,
///     "onComplete": {
///       "actionType": "showSnackbar",
///       "message": "Added to cart!"
///     }
///   }
/// }
/// ```

/// Example 2: Track screen view on navigation
/// ```json
/// {
///   "type": "listTile",
///   "title": {
///     "type": "text",
///     "data": "View Profile"
///   },
///   "onTap": {
///     "actionType": "sequence",
///     "actions": [
///       {
///         "actionType": "trackScreenView",
///         "screenName": "profile_screen",
///         "screenClass": "ProfileScreen",
///         "parameters": {
///           "source": "menu"
///         }
///       },
///       {
///         "actionType": "navigate",
///         "route": "/profile"
///       }
///     ]
///   }
/// }
/// ```

/// Example 3: Track form submission
/// ```json
/// {
///   "type": "elevatedButton",
///   "child": {
///     "type": "text",
///     "data": "Submit"
///   },
///   "onPressed": {
///     "actionType": "trackAnalytics",
///     "eventName": "form_submitted",
///     "category": "user_interaction",
///     "parameters": {
///       "form_name": "contact_form",
///       "form_type": "inquiry"
///     },
///     "onComplete": {
///       "actionType": "navigate",
///       "route": "/thank-you"
///     }
///   }
/// }
/// ```

// ============================================================================
// STEP 6: Write Tests
// ============================================================================

/// Example unit tests:
/// ```dart
/// void main() {
///   group('AnalyticsActionModel', () {
///     test('should serialize to JSON correctly', () {
///       final model = AnalyticsActionModel(
///         eventName: 'button_clicked',
///         category: 'user_interaction',
///         parameters: {'button_id': 'submit'},
///       );
///       
///       final json = model.toJson();
///       
///       expect(json['eventName'], 'button_clicked');
///       expect(json['category'], 'user_interaction');
///       expect(json['parameters'], {'button_id': 'submit'});
///     });
///     
///     test('should deserialize from JSON correctly', () {
///       final json = {
///         'eventName': 'button_clicked',
///         'category': 'user_interaction',
///         'parameters': {'button_id': 'submit'},
///         'includeUserId': true,
///         'includeTimestamp': true,
///       };
///       
///       final model = AnalyticsActionModel.fromJson(json);
///       
///       expect(model.eventName, 'button_clicked');
///       expect(model.category, 'user_interaction');
///       expect(model.includeUserId, true);
///     });
///   });
///   
///   group('AnalyticsActionParser', () {
///     test('should execute analytics tracking', () async {
///       final parser = AnalyticsActionParser();
///       final model = AnalyticsActionModel(
///         eventName: 'test_event',
///         category: 'test',
///       );
///       
///       // Mock context
///       final context = MockBuildContext();
///       
///       // Should not throw
///       await expectLater(
///         parser.execute(context, model),
///         completes,
///       );
///     });
///     
///     test('should handle errors gracefully', () async {
///       final parser = AnalyticsActionParser();
///       final model = AnalyticsActionModel(
///         eventName: 'test_event',
///         category: 'test',
///       );
///       
///       // Even if tracking fails, should not throw
///       await expectLater(
///         parser.execute(null, model), // Invalid context
///         completes,
///       );
///     });
///   });
/// }
/// ```

// ============================================================================
// Advanced Usage Examples
// ============================================================================

/// Example: Conditional analytics based on user properties
/// ```json
/// {
///   "type": "elevatedButton",
///   "child": {
///     "type": "text",
///     "data": "Premium Feature"
///   },
///   "onPressed": {
///     "actionType": "conditional",
///     "condition": "${user.isPremium}",
///     "ifTrue": {
///       "actionType": "trackAnalytics",
///       "eventName": "premium_feature_used",
///       "category": "premium",
///       "parameters": {
///         "feature": "advanced_search"
///       }
///     },
///     "ifFalse": {
///       "actionType": "trackAnalytics",
///       "eventName": "premium_feature_blocked",
///       "category": "conversion",
///       "parameters": {
///         "feature": "advanced_search",
///         "reason": "not_premium"
///       }
///     }
///   }
/// }
/// ```

/// Example: Track multiple events in sequence
/// ```json
/// {
///   "actionType": "sequence",
///   "actions": [
///     {
///       "actionType": "trackAnalytics",
///       "eventName": "checkout_started",
///       "category": "ecommerce",
///       "parameters": {
///         "cart_value": 599.99,
///         "item_count": 3
///       }
///     },
///     {
///       "actionType": "navigate",
///       "route": "/checkout"
///     },
///     {
///       "actionType": "trackScreenView",
///       "screenName": "checkout_screen"
///     }
///   ]
/// }
/// ```

// ============================================================================
// Best Practices
// ============================================================================

/// 1. Always handle errors gracefully - analytics should never break the app
/// 2. Use consistent event naming conventions (e.g., snake_case)
/// 3. Include relevant context in parameters
/// 4. Don't track sensitive user data (PII)
/// 5. Test analytics in development before production
/// 6. Use categories to organize events
/// 7. Document all tracked events for your team
/// 8. Consider privacy regulations (GDPR, CCPA)
/// 9. Provide opt-out mechanisms for users
/// 10. Monitor analytics performance impact

// ============================================================================
// Integration with Popular Analytics Services
// ============================================================================

/// Firebase Analytics:
/// ```dart
/// await FirebaseAnalytics.instance.logEvent(
///   name: eventName,
///   parameters: data,
/// );
/// ```

/// Mixpanel:
/// ```dart
/// await Mixpanel.track(eventName, properties: data);
/// ```

/// Amplitude:
/// ```dart
/// Amplitude.getInstance().logEvent(eventName, eventProperties: data);
/// ```

/// Google Analytics:
/// ```dart
/// await analytics.logEvent(
///   name: eventName,
///   parameters: data,
/// );
/// ```

// ============================================================================
// Notes:
// - Remember to run `dart run build_runner build` after creating the model
// - Test analytics tracking in debug mode before production
// - Consider implementing a debug mode that logs events without sending
// - Add rate limiting to prevent excessive tracking
// - Implement offline queuing for analytics events
// - Document all tracked events in your analytics plan
// ============================================================================
