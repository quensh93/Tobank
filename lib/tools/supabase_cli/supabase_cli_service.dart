import 'package:supabase/supabase.dart';

/// Service for managing Supabase operations in CLI tool
class SupabaseCliService {
  final String url;
  final String key;
  late final SupabaseClient _client;
  bool _initialized = false;

  SupabaseCliService({required this.url, required this.key});

  /// Initialize Supabase
  Future<void> initialize() async {
    if (_initialized) return;
    _client = SupabaseClient(url, key);
    _initialized = true;
  }

  /// Upload screen to Supabase with version history
  Future<void> uploadScreen({
    required String screenName,
    required Map<String, dynamic> jsonData,
    String? description,
    List<String>? tags,
  }) async {
    _ensureInitialized();

    // 1. Upsert the screen to 'stac_screens'
    await _client.from('stac_screens').upsert({
      'name': screenName,
      'json': jsonData,
      'updated_at': DateTime.now().toIso8601String(),
    }, onConflict: 'name');

    // 2. Add entry to 'screen_versions' (Optional, but good for history)
    // We try-catch this in case the table doesn't exist yet
    try {
      // Get current max version
      final versions = await _client
          .from('screen_versions')
          .select('version')
          .eq('screen', screenName)
          .order('version', ascending: false)
          .limit(1);

      int nextVersion = 1;
      if (versions.isNotEmpty) {
        nextVersion = (versions.first['version'] as int) + 1;
      }

      await _client.from('screen_versions').insert({
        'screen': screenName,
        'version': nextVersion,
        'json': jsonData,
        'created_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      // Ignore version history errors if table doesn't exist
      print('Warning: Could not save version history: $e');
    }
  }

  /// Download screen from Supabase
  Future<Map<String, dynamic>?> downloadScreen(String screenName) async {
    _ensureInitialized();
    final response = await _client
        .from('stac_screens')
        .select()
        .eq('name', screenName)
        .maybeSingle();

    if (response == null) return null;
    return response['json'] as Map<String, dynamic>;
  }

  /// List all screens
  Future<List<Map<String, dynamic>>> listScreens({
    int? limit,
    String? orderBy,
    bool descending = false,
  }) async {
    _ensureInitialized();
    final query = _client.from('stac_screens').select('name, updated_at');

    final response = await query;
    return List<Map<String, dynamic>>.from(response);
  }

  /// Delete screen and its history
  Future<void> deleteScreen(String screenName) async {
    _ensureInitialized();
    await _client.from('stac_screens').delete().eq('name', screenName);
    try {
      await _client.from('screen_versions').delete().eq('screen', screenName);
    } catch (_) {}
  }

  /// Execute raw SQL query
  /// Note: This requires a database function to be created in Supabase
  /// or using the service role key with proper permissions
  Future<void> executeSql(String sql) async {
    _ensureInitialized();

    // Use Supabase's rpc to execute SQL
    // This requires creating a function in Supabase that can execute SQL
    // For now, we'll try to use the REST API directly
    try {
      await _client.rpc('exec_sql', params: {'query': sql});
    } catch (e) {
      // If the RPC function doesn't exist, throw a helpful error
      throw Exception(
        'Failed to execute SQL. You may need to:\n'
        '1. Create an exec_sql function in Supabase, or\n'
        '2. Run the SQL manually in Supabase Dashboard > SQL Editor\n'
        'Error: $e',
      );
    }
  }

  void _ensureInitialized() {
    if (!_initialized) {
      throw StateError(
        'SupabaseCliService not initialized. Call initialize() first.',
      );
    }
  }
}
