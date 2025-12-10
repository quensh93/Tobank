import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../supabase_crud_app.dart';
import '../providers/supabase_crud_provider.dart';
import '../widgets/screen_card.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/error_display.dart';

/// Screen list screen
///
/// Displays all STAC screens from Supabase with search and filter capabilities.
/// Shows metadata like version and updated_at for each screen.
class ScreenListScreen extends HookConsumerWidget {
  const ScreenListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    final searchQuery = useState('');
    final sortBy = useState<ScreenSortBy>(ScreenSortBy.name);
    final sortAscending = useState(true);

    // Watch the screens list
    final screensAsync = ref.watch(screensListProvider());

    // Filter and sort screens based on search query and sort options
    final filteredScreens = useMemoized(() {
      return screensAsync.whenData((screens) {
        var filtered = screens;

        // Apply search filter
        if (searchQuery.value.isNotEmpty) {
          final query = searchQuery.value.toLowerCase();
          filtered = filtered.where((screen) {
            return screen.name.toLowerCase().contains(query) ||
                (screen.description?.toLowerCase().contains(query) ?? false) ||
                screen.tags.any((tag) => tag.toLowerCase().contains(query));
          }).toList();
        }

        // Apply sorting
        filtered.sort((a, b) {
          int comparison;
          switch (sortBy.value) {
            case ScreenSortBy.name:
              comparison = a.name.compareTo(b.name);
              break;
            case ScreenSortBy.updatedAt:
              comparison = a.updatedAt.compareTo(b.updatedAt);
              break;
            case ScreenSortBy.version:
              comparison = a.version.compareTo(b.version);
              break;
          }
          return sortAscending.value ? comparison : -comparison;
        });

        return filtered;
      });
    }, [screensAsync, searchQuery.value, sortBy.value, sortAscending.value]);

    return CrudLayout(
      title: 'STAC Screens',
      actions: [
        // Bulk operations button
        IconButton(
          icon: const Icon(Icons.cloud_sync),
          tooltip: 'Bulk Operations',
          onPressed: () => CrudNavigation.toBulkOperations(context),
        ),
        // Refresh button
        IconButton(
          icon: const Icon(Icons.refresh),
          tooltip: 'Refresh',
          onPressed: () {
            ref.invalidate(screensListProvider());
          },
        ),
        // Sort menu
        PopupMenuButton<ScreenSortBy>(
          icon: const Icon(Icons.sort),
          tooltip: 'Sort by',
          onSelected: (value) {
            if (sortBy.value == value) {
              // Toggle sort direction if same field
              sortAscending.value = !sortAscending.value;
            } else {
              sortBy.value = value;
              sortAscending.value = true;
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: ScreenSortBy.name,
              child: Row(
                children: [
                  Icon(
                    sortBy.value == ScreenSortBy.name
                        ? (sortAscending.value
                            ? Icons.arrow_upward
                            : Icons.arrow_downward)
                        : Icons.sort_by_alpha,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  const Text('Name'),
                ],
              ),
            ),
            PopupMenuItem(
              value: ScreenSortBy.updatedAt,
              child: Row(
                children: [
                  Icon(
                    sortBy.value == ScreenSortBy.updatedAt
                        ? (sortAscending.value
                            ? Icons.arrow_upward
                            : Icons.arrow_downward)
                        : Icons.access_time,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  const Text('Updated'),
                ],
              ),
            ),
            PopupMenuItem(
              value: ScreenSortBy.version,
              child: Row(
                children: [
                  Icon(
                    sortBy.value == ScreenSortBy.version
                        ? (sortAscending.value
                            ? Icons.arrow_upward
                            : Icons.arrow_downward)
                        : Icons.numbers,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  const Text('Version'),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(width: 8),
      ],
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => CrudNavigation.toCreateScreen(context),
        icon: const Icon(Icons.add),
        label: const Text('New Screen'),
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search screens by name, description, or tags...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: searchQuery.value.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          searchController.clear();
                          searchQuery.value = '';
                        },
                      )
                    : null,
              ),
              onChanged: (value) {
                searchQuery.value = value;
              },
            ),
          ),

          // Screens list
          Expanded(
            child: filteredScreens.when(
              data: (screens) {
                if (screens.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          searchQuery.value.isNotEmpty
                              ? Icons.search_off
                              : Icons.cloud_off,
                          size: 64,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          searchQuery.value.isNotEmpty
                              ? 'No screens found matching "${searchQuery.value}"'
                              : 'No screens available',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          searchQuery.value.isNotEmpty
                              ? 'Try a different search term'
                              : 'Create your first screen to get started',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.grey,
                              ),
                        ),
                        if (searchQuery.value.isEmpty) ...[
                          const SizedBox(height: 24),
                          ElevatedButton.icon(
                            onPressed: () => CrudNavigation.toCreateScreen(context),
                            icon: const Icon(Icons.add),
                            label: const Text('Create Screen'),
                          ),
                        ],
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    ref.invalidate(screensListProvider());
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: screens.length,
                    itemBuilder: (context, index) {
                      final screen = screens[index];
                      return ScreenCard(
                        screen: screen,
                        onTap: () => CrudNavigation.toEditScreen(
                          context,
                          screen.name,
                        ),
                        onDelete: () async {
                          final confirmed = await _showDeleteConfirmation(
                            context,
                            screen.name,
                          );
                          if (confirmed == true) {
                            await ref
                                .read(supabaseCrudServiceProvider)
                                .deleteScreen(screen.name);
                            ref.invalidate(screensListProvider);
                          }
                        },
                      );
                    },
                  ),
                );
              },
              loading: () => const CrudLoadingIndicator(
                message: 'Loading screens...',
              ),
              error: (error, stack) => CrudErrorDisplay(
                error: error,
                onRetry: () {
                  ref.invalidate(screensListProvider());
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Show delete confirmation dialog
  Future<bool?> _showDeleteConfirmation(
    BuildContext context,
    String screenName,
  ) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Screen'),
        content: Text(
          'Are you sure you want to delete "$screenName"?\n\n'
          'This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

/// Sort options for screens
enum ScreenSortBy {
  name,
  updatedAt,
  version,
}
