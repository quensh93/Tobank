import 'package:flutter/material.dart';
import '../models/navigation_route.dart';

/// Visual editor for navigation routes and flows
/// Allows adding, editing, and deleting routes with parameter configuration
class NavigationEditor extends StatefulWidget {
  /// List of navigation routes
  final List<NavigationRoute> routes;

  /// Callback when routes are updated
  final ValueChanged<List<NavigationRoute>>? onRoutesChanged;

  /// Callback when a route is selected
  final ValueChanged<NavigationRoute>? onRouteSelected;

  /// Currently selected route
  final NavigationRoute? selectedRoute;

  const NavigationEditor({
    super.key,
    required this.routes,
    this.onRoutesChanged,
    this.onRouteSelected,
    this.selectedRoute,
  });

  @override
  State<NavigationEditor> createState() => _NavigationEditorState();
}

class _NavigationEditorState extends State<NavigationEditor> {
  late List<NavigationRoute> _routes;
  NavigationRoute? _selectedRoute;

  @override
  void initState() {
    super.initState();
    _routes = List.from(widget.routes);
    _selectedRoute = widget.selectedRoute;
  }

  @override
  void didUpdateWidget(NavigationEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.routes != oldWidget.routes) {
      _routes = List.from(widget.routes);
    }
    if (widget.selectedRoute != oldWidget.selectedRoute) {
      _selectedRoute = widget.selectedRoute;
    }
  }

  void _addRoute() {
    final newRoute = NavigationRoute(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      path: '/new_route',
      name: 'New Route',
      screenName: 'new_screen',
    );

    setState(() {
      _routes.add(newRoute);
      _selectedRoute = newRoute;
    });

    widget.onRoutesChanged?.call(_routes);
    widget.onRouteSelected?.call(newRoute);
  }

  void _deleteRoute(NavigationRoute route) {
    setState(() {
      _routes.remove(route);
      if (_selectedRoute == route) {
        _selectedRoute = null;
      }
    });

    widget.onRoutesChanged?.call(_routes);
  }

  void _updateRoute(NavigationRoute oldRoute, NavigationRoute newRoute) {
    setState(() {
      final index = _routes.indexOf(oldRoute);
      if (index != -1) {
        _routes[index] = newRoute;
        if (_selectedRoute == oldRoute) {
          _selectedRoute = newRoute;
        }
      }
    });

    widget.onRoutesChanged?.call(_routes);
  }

  void _selectRoute(NavigationRoute route) {
    setState(() {
      _selectedRoute = route;
    });
    widget.onRouteSelected?.call(route);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Routes list
        Expanded(
          flex: 2,
          child: _buildRoutesList(),
        ),
        const VerticalDivider(width: 1),
        // Route editor
        Expanded(
          flex: 3,
          child: _selectedRoute != null
              ? _buildRouteEditor(_selectedRoute!)
              : _buildEmptyState(),
        ),
      ],
    );
  }

  Widget _buildRoutesList() {
    return Column(
      children: [
        // Header
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).dividerColor,
              ),
            ),
          ),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  'Routes',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: _addRoute,
                tooltip: 'Add Route',
              ),
            ],
          ),
        ),
        // Routes list
        Expanded(
          child: _routes.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.route,
                        size: 64,
                        color: Theme.of(context).disabledColor,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No routes defined',
                        style: TextStyle(
                          color: Theme.of(context).disabledColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton.icon(
                        onPressed: _addRoute,
                        icon: const Icon(Icons.add),
                        label: const Text('Add Route'),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: _routes.length,
                  itemBuilder: (context, index) {
                    final route = _routes[index];
                    final isSelected = route == _selectedRoute;

                    return ListTile(
                      selected: isSelected,
                      leading: Icon(
                        route.isInitial ? Icons.home : Icons.route,
                        color: route.isInitial
                            ? Theme.of(context).colorScheme.primary
                            : null,
                      ),
                      title: Text(route.name),
                      subtitle: Text(route.path),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, size: 20),
                        onPressed: () => _deleteRoute(route),
                        tooltip: 'Delete Route',
                      ),
                      onTap: () => _selectRoute(route),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildRouteEditor(NavigationRoute route) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Expanded(
                child: Text(
                  'Edit Route',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              if (route.isInitial)
                const Chip(
                  label: Text('Initial Route'),
                  avatar: Icon(Icons.home, size: 16),
                ),
            ],
          ),
          const SizedBox(height: 24),

          // Route Name
          _buildTextField(
            label: 'Route Name',
            value: route.name,
            onChanged: (value) {
              _updateRoute(route, route.copyWith(name: value));
            },
            hint: 'e.g., Home Screen',
          ),
          const SizedBox(height: 16),

          // Route Path
          _buildTextField(
            label: 'Route Path',
            value: route.path,
            onChanged: (value) {
              _updateRoute(route, route.copyWith(path: value));
            },
            hint: 'e.g., /home or /profile/:id',
            helperText: 'Use :paramName for dynamic parameters',
          ),
          const SizedBox(height: 16),

          // Screen Name
          _buildTextField(
            label: 'Screen Name',
            value: route.screenName,
            onChanged: (value) {
              _updateRoute(route, route.copyWith(screenName: value));
            },
            hint: 'e.g., home_screen',
            helperText: 'JSON file name to load for this route',
          ),
          const SizedBox(height: 16),

          // Initial Route Toggle
          SwitchListTile(
            title: const Text('Set as Initial Route'),
            subtitle: const Text('This route will be shown on app launch'),
            value: route.isInitial,
            onChanged: (value) {
              // If setting as initial, remove initial flag from other routes
              if (value) {
                final updatedRoutes = _routes.map((r) {
                  if (r == route) {
                    return route.copyWith(isInitial: true);
                  } else if (r.isInitial) {
                    return r.copyWith(isInitial: false);
                  }
                  return r;
                }).toList();
                setState(() {
                  _routes = updatedRoutes;
                  _selectedRoute = route.copyWith(isInitial: true);
                });
                widget.onRoutesChanged?.call(_routes);
              } else {
                _updateRoute(route, route.copyWith(isInitial: false));
              }
            },
          ),
          const SizedBox(height: 24),

          // Parameters Section
          Text(
            'Route Parameters',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          if (route.pathParameters.isEmpty)
            Text(
              'No parameters defined in path',
              style: TextStyle(
                color: Theme.of(context).disabledColor,
                fontSize: 12,
              ),
            )
          else
            ...route.pathParameters.map((param) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _buildParameterField(
                  route: route,
                  paramName: param,
                  paramType: route.parameters[param] ?? 'string',
                ),
              );
            }),
          const SizedBox(height: 24),

          // Validation Status
          if (!route.isValid)
            Card(
              color: Theme.of(context).colorScheme.errorContainer,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Icon(
                      Icons.warning,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Some path parameters are not defined',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onErrorContainer,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String value,
    required ValueChanged<String> onChanged,
    String? hint,
    String? helperText,
  }) {
    return TextField(
      controller: TextEditingController(text: value)
        ..selection = TextSelection.collapsed(offset: value.length),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        helperText: helperText,
        border: const OutlineInputBorder(),
      ),
      onChanged: onChanged,
    );
  }

  Widget _buildParameterField({
    required NavigationRoute route,
    required String paramName,
    required String paramType,
  }) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: TextField(
            controller: TextEditingController(text: paramName),
            decoration: const InputDecoration(
              labelText: 'Parameter Name',
              border: OutlineInputBorder(),
            ),
            enabled: false,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: DropdownButtonFormField<String>(
            initialValue: paramType,
            decoration: const InputDecoration(
              labelText: 'Type',
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(value: 'string', child: Text('String')),
              DropdownMenuItem(value: 'int', child: Text('Integer')),
              DropdownMenuItem(value: 'double', child: Text('Double')),
              DropdownMenuItem(value: 'bool', child: Text('Boolean')),
            ],
            onChanged: (value) {
              if (value != null) {
                final updatedParams = Map<String, String>.from(route.parameters);
                updatedParams[paramName] = value;
                _updateRoute(route, route.copyWith(parameters: updatedParams));
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.route,
            size: 64,
            color: Theme.of(context).disabledColor,
          ),
          const SizedBox(height: 16),
          Text(
            'Select a route to edit',
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).disabledColor,
            ),
          ),
        ],
      ),
    );
  }
}
