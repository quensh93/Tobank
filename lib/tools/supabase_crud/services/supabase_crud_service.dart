import '../models/screen_metadata.dart';

/// Service for Supabase CRUD operations
/// Currently disabled - add Supabase dependencies to enable
class SupabaseCrudService {
  // final SupabaseFirestore _firestore;
  // static const String _screensCollection = 'stac_screens';
  // static const String _versionsCollection = 'screen_versions';

  SupabaseCrudService();

  /// Create a new screen
  Future<String> createScreen({
    required String name,
    required Map<String, dynamic> jsonData,
    String? description,
    String? route,
    List<String>? tags,
    String? author,
  }) async {
    throw UnimplementedError(
      'Supabase CRUD service is disabled. Add Supabase dependencies to enable.',
    );
  }

  /// Get screen by ID
  Future<ScreenMetadata?> getScreen(String id) async {
    throw UnimplementedError(
      'Supabase CRUD service is disabled. Add Supabase dependencies to enable.',
    );
  }

  /// Get screen JSON data
  Future<Map<String, dynamic>?> getScreenJson(String id) async {
    throw UnimplementedError(
      'Supabase CRUD service is disabled. Add Supabase dependencies to enable.',
    );
  }

  /// Update screen
  Future<void> updateScreen({
    required String id,
    String? name,
    Map<String, dynamic>? jsonData,
    String? description,
    List<String>? tags,
    String? author,
  }) async {
    throw UnimplementedError(
      'Supabase CRUD service is disabled. Add Supabase dependencies to enable.',
    );
  }

  /// Delete screen
  Future<void> deleteScreen(String id) async {
    throw UnimplementedError(
      'Supabase CRUD service is disabled. Add Supabase dependencies to enable.',
    );
  }

  /// List all screens with pagination
  Future<List<ScreenMetadata>> listScreens({
    int? limit,
    String? startAfter,
    String? orderBy,
    bool descending = false,
  }) async {
    throw UnimplementedError(
      'Supabase CRUD service is disabled. Add Supabase dependencies to enable.',
    );
  }

  /// Search screens by name or tags
  Future<List<ScreenMetadata>> searchScreens({
    String? query,
    List<String>? tags,
    int? limit,
  }) async {
    throw UnimplementedError(
      'Supabase CRUD service is disabled. Add Supabase dependencies to enable.',
    );
  }

  /// Get version history for a screen
  Future<List<Map<String, dynamic>>> getVersionHistory(String screenId) async {
    throw UnimplementedError(
      'Supabase CRUD service is disabled. Add Supabase dependencies to enable.',
    );
  }

  /// Restore screen to a specific version
  Future<void> restoreVersion(String screenId, String versionId) async {
    throw UnimplementedError(
      'Supabase CRUD service is disabled. Add Supabase dependencies to enable.',
    );
  }

  /// Duplicate a screen
  Future<String> duplicateScreen(String id, {String? newName}) async {
    throw UnimplementedError(
      'Supabase CRUD service is disabled. Add Supabase dependencies to enable.',
    );
  }

  /// Bulk operations
  Future<void> bulkDelete(List<String> ids) async {
    throw UnimplementedError(
      'Supabase CRUD service is disabled. Add Supabase dependencies to enable.',
    );
  }

  Future<void> bulkUpdateTags(List<String> ids, List<String> tags) async {
    throw UnimplementedError(
      'Supabase CRUD service is disabled. Add Supabase dependencies to enable.',
    );
  }

  /// Export screens
  Future<Map<String, dynamic>> exportScreens(List<String> ids) async {
    throw UnimplementedError(
      'Supabase CRUD service is disabled. Add Supabase dependencies to enable.',
    );
  }

  /// Import screens
  Future<List<String>> importScreens(Map<String, dynamic> data) async {
    throw UnimplementedError(
      'Supabase CRUD service is disabled. Add Supabase dependencies to enable.',
    );
  }

  /// Validate screen JSON
  bool validateScreenJson(Map<String, dynamic> json) {
    // Basic validation that doesn't require Supabase
    if (!json.containsKey('type')) return false;
    if (!json.containsKey('properties')) return false;
    return true;
  }

  /// Get screen statistics
  Future<Map<String, dynamic>> getScreenStats() async {
    throw UnimplementedError(
      'Supabase CRUD service is disabled. Add Supabase dependencies to enable.',
    );
  }

  /// Export all screens to JSON
  Future<Map<String, dynamic>> exportAllScreens() async {
    throw UnimplementedError(
      'Supabase CRUD service is disabled. Add Supabase dependencies to enable.',
    );
  }

  /// Bulk upload screens
  Future<void> bulkUploadScreens(
    Map<String, Map<String, dynamic>> screens,
  ) async {
    throw UnimplementedError(
      'Supabase CRUD service is disabled. Add Supabase dependencies to enable.',
    );
  }

  /// Rollback to version
  Future<void> rollbackToVersion(String screenId, int version) async {
    throw UnimplementedError(
      'Supabase CRUD service is disabled. Add Supabase dependencies to enable.',
    );
  }
}
