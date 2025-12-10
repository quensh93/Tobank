import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../services/supabase_crud_service.dart';
import '../models/screen_metadata.dart';

part 'supabase_crud_provider.g.dart';

/// Provider for Supabase CRUD service
@riverpod
SupabaseCrudService supabaseCrudService(Ref ref) {
  return SupabaseCrudService();
}

/// Provider for listing screens
@riverpod
Future<List<ScreenMetadata>> screensList(Ref ref, {
  int? limit,
  String? startAfter,
  String? orderBy,
  bool descending = false,
}) async {
  final service = ref.watch(supabaseCrudServiceProvider);
  return service.listScreens(
    limit: limit,
    startAfter: startAfter,
    orderBy: orderBy,
    descending: descending,
  );
}

/// Provider for getting a specific screen
@riverpod
Future<ScreenMetadata?> screen(Ref ref, String id) async {
  final service = ref.watch(supabaseCrudServiceProvider);
  return service.getScreen(id);
}

/// Provider for getting screen JSON data
@riverpod
Future<Map<String, dynamic>?> screenJson(Ref ref, String id) async {
  final service = ref.watch(supabaseCrudServiceProvider);
  return service.getScreenJson(id);
}

/// Provider for searching screens
@riverpod
Future<List<ScreenMetadata>> searchScreens(Ref ref, {
  String? query,
  List<String>? tags,
  int? limit,
}) async {
  final service = ref.watch(supabaseCrudServiceProvider);
  return service.searchScreens(
    query: query,
    tags: tags,
    limit: limit,
  );
}

/// Provider for version history
@riverpod
Future<List<Map<String, dynamic>>> versionHistory(Ref ref, String screenId) async {
  final service = ref.watch(supabaseCrudServiceProvider);
  return service.getVersionHistory(screenId);
}

/// Provider for screen statistics
@riverpod
Future<Map<String, dynamic>> screenStats(Ref ref) async {
  final service = ref.watch(supabaseCrudServiceProvider);
  return service.getScreenStats();
}
