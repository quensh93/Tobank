import 'package:stac/stac.dart';
import '../../helpers/logger.dart';

/// Debug utility to test variable resolution
/// 
/// Use this to verify that strings are accessible via the variable resolver
class VariableResolverDebug {
  /// Test if a variable can be resolved from StacRegistry
  static void testVariableResolution(String variableName) {
    final value = StacRegistry.instance.getValue(variableName);
    if (value != null) {
      AppLogger.i('✅ Variable "$variableName" = "$value"');
    } else {
      AppLogger.w('❌ Variable "$variableName" NOT FOUND in registry');
      
      // Try to find similar keys
      AppLogger.d('   Searching for similar keys...');
      // Note: StacRegistry doesn't expose _variables directly, so we can't search
      // But we can log what we tried
    }
  }
  
  /// Test multiple common variables
  static void testCommonVariables() {
    AppLogger.i('🔍 Testing variable resolution...');
    
    final testVars = [
      'appStrings.menu.appBarTitle',
      'appStrings.login.validationTitle',
      'appStrings.common.loading',
      'appStrings.common.error',
    ];
    
    for (final varName in testVars) {
      testVariableResolution(varName);
    }
  }
}
