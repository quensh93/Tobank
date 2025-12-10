import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_color_utilities/material_color_utilities.dart';
import '../../core/design_system/color_schemes.dart';
import '../../core/design_system/app_theme.dart';

/// Color showcase screen that displays Material widgets with all ColorScheme colors
/// This screen appears in the main app (device frame) to show how colors look in a real device context
class ColorShowcaseScreen extends ConsumerStatefulWidget {
  const ColorShowcaseScreen({super.key});

  @override
  ConsumerState<ColorShowcaseScreen> createState() => _ColorShowcaseScreenState();
}

class _ColorShowcaseScreenState extends ConsumerState<ColorShowcaseScreen> {
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  Brightness? _brightnessOverride;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<_ColorItem> _getAllColorItems(ColorScheme cs) {
    return [
      // Primary colors
      _ColorItem('primary', 'Main brand color', cs.primary, cs.onPrimary, cs),
      _ColorItem('onPrimary', 'Text/icons on primary', cs.onPrimary, cs.primary, cs),
      _ColorItem('primaryContainer', 'Less prominent primary', cs.primaryContainer, cs.onPrimaryContainer, cs),
      _ColorItem('onPrimaryContainer', 'Text on primary container', cs.onPrimaryContainer, cs.primaryContainer, cs),
      _ColorItem('primaryFixed', 'Fixed primary (light/dark)', cs.primaryFixed, cs.onPrimaryFixed, cs),
      _ColorItem('primaryFixedDim', 'Dimmed fixed primary', cs.primaryFixedDim, cs.onPrimaryFixed, cs),
      _ColorItem('onPrimaryFixed', 'Text on primary fixed', cs.onPrimaryFixed, cs.primaryFixed, cs),
      _ColorItem('onPrimaryFixedVariant', 'Variant text on primary fixed', cs.onPrimaryFixedVariant, cs.primaryFixed, cs),
      
      // Secondary colors
      _ColorItem('secondary', 'Secondary accent color', cs.secondary, cs.onSecondary, cs),
      _ColorItem('onSecondary', 'Text/icons on secondary', cs.onSecondary, cs.secondary, cs),
      _ColorItem('secondaryContainer', 'Less prominent secondary', cs.secondaryContainer, cs.onSecondaryContainer, cs),
      _ColorItem('onSecondaryContainer', 'Text on secondary container', cs.onSecondaryContainer, cs.secondaryContainer, cs),
      _ColorItem('secondaryFixed', 'Fixed secondary (light/dark)', cs.secondaryFixed, cs.onSecondaryFixed, cs),
      _ColorItem('secondaryFixedDim', 'Dimmed fixed secondary', cs.secondaryFixedDim, cs.onSecondaryFixed, cs),
      _ColorItem('onSecondaryFixed', 'Text on secondary fixed', cs.onSecondaryFixed, cs.secondaryFixed, cs),
      _ColorItem('onSecondaryFixedVariant', 'Variant text on secondary fixed', cs.onSecondaryFixedVariant, cs.secondaryFixed, cs),
      
      // Tertiary colors
      _ColorItem('tertiary', 'Tertiary accent color', cs.tertiary, cs.onTertiary, cs),
      _ColorItem('onTertiary', 'Text/icons on tertiary', cs.onTertiary, cs.tertiary, cs),
      _ColorItem('tertiaryContainer', 'Less prominent tertiary', cs.tertiaryContainer, cs.onTertiaryContainer, cs),
      _ColorItem('onTertiaryContainer', 'Text on tertiary container', cs.onTertiaryContainer, cs.tertiaryContainer, cs),
      _ColorItem('tertiaryFixed', 'Fixed tertiary (light/dark)', cs.tertiaryFixed, cs.onTertiaryFixed, cs),
      _ColorItem('tertiaryFixedDim', 'Dimmed fixed tertiary', cs.tertiaryFixedDim, cs.onTertiaryFixed, cs),
      _ColorItem('onTertiaryFixed', 'Text on tertiary fixed', cs.onTertiaryFixed, cs.tertiaryFixed, cs),
      _ColorItem('onTertiaryFixedVariant', 'Variant text on tertiary fixed', cs.onTertiaryFixedVariant, cs.tertiaryFixed, cs),
      
      // Error colors
      _ColorItem('error', 'Error/destructive actions', cs.error, cs.onError, cs),
      _ColorItem('onError', 'Text/icons on error', cs.onError, cs.error, cs),
      _ColorItem('errorContainer', 'Less prominent error', cs.errorContainer, cs.onErrorContainer, cs),
      _ColorItem('onErrorContainer', 'Text on error container', cs.onErrorContainer, cs.errorContainer, cs),
      
      // Surface colors
      _ColorItem('surface', 'Default background', cs.surface, cs.onSurface, cs),
      _ColorItem('onSurface', 'Text/icons on surface', cs.onSurface, cs.surface, cs),
      _ColorItem('surfaceDim', 'Dimmed surface', cs.surfaceDim, cs.onSurface, cs),
      _ColorItem('surfaceBright', 'Bright surface', cs.surfaceBright, cs.onSurface, cs),
      _ColorItem('surfaceContainerLowest', 'Lowest elevation container', cs.surfaceContainerLowest, cs.onSurface, cs),
      _ColorItem('surfaceContainerLow', 'Low elevation container', cs.surfaceContainerLow, cs.onSurface, cs),
      _ColorItem('surfaceContainer', 'Default container', cs.surfaceContainer, cs.onSurface, cs),
      _ColorItem('surfaceContainerHigh', 'High elevation container', cs.surfaceContainerHigh, cs.onSurface, cs),
      _ColorItem('surfaceContainerHighest', 'Highest elevation container', cs.surfaceContainerHighest, cs.onSurface, cs),
      _ColorItem('onSurfaceVariant', 'Lower emphasis text', cs.onSurfaceVariant, cs.surface, cs),
      
      // Outline colors
      _ColorItem('outline', 'Important borders', cs.outline, cs.surface, cs),
      _ColorItem('outlineVariant', 'Subtle borders', cs.outlineVariant, cs.surface, cs),
      
      // Inverse colors
      _ColorItem('inverseSurface', 'Inverted surface (snackbars)', cs.inverseSurface, cs.onInverseSurface, cs),
      _ColorItem('onInverseSurface', 'Text on inverse surface', cs.onInverseSurface, cs.inverseSurface, cs),
      _ColorItem('inversePrimary', 'Primary on inverse surface', cs.inversePrimary, cs.inverseSurface, cs),
      
      // Other colors
      _ColorItem('surfaceTint', 'Tint for elevated surfaces', cs.surfaceTint, cs.onSurface, cs),
      _ColorItem('shadow', 'Shadow color', cs.shadow, Colors.white, cs),
      _ColorItem('scrim', 'Overlay for modals', cs.scrim, Colors.white, cs),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final systemBrightness = Theme.of(context).brightness;
    final brightness = _brightnessOverride ?? systemBrightness;
    final colorScheme = brightness == Brightness.dark ? darkScheme : lightScheme;
    final palettes = _Palettes.fromColorScheme(colorScheme);

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: const Text('Color Showcase'),
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          // Theme toggle button with indicator
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  brightness == Brightness.dark ? 'Dark' : 'Light',
                  style: TextStyle(
                    fontSize: 12,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    brightness == Brightness.dark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
                  ),
                  tooltip: 'Switch to ${brightness == Brightness.dark ? "Light" : "Dark"} mode',
                  onPressed: () {
                    setState(() {
                      _brightnessOverride = brightness == Brightness.dark 
                          ? Brightness.light 
                          : Brightness.dark;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      body: _buildContent(colorScheme, palettes, brightness),
    );
  }

  Widget _buildContent(ColorScheme colorScheme, _Palettes palettes, Brightness brightness) {
    return Theme(
      data: buildTheme(brightness: brightness),
      child: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            // Search bar BETWEEN AppBar and TabBar
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search colors or widgets...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              _searchController.clear();
                              _searchQuery = '';
                            });
                          },
                        )
                      : null,
                  border: const OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
            ),
            const TabBar(
              tabs: [
                Tab(text: 'Color Roles', icon: Icon(Icons.color_lens)),
                Tab(text: 'Tonal Palettes', icon: Icon(Icons.palette)),
                Tab(text: 'Material Widgets', icon: Icon(Icons.widgets)),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildColorRolesTab(colorScheme),
                  _buildTonalPalettesTab(palettes),
                  _buildMaterialWidgetsTab(colorScheme),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorRolesTab(ColorScheme colorScheme) {
    final allItems = _getAllColorItems(colorScheme);
    final filteredItems = _searchQuery.isEmpty
        ? allItems
        : allItems.where((item) =>
            item.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            item.description.toLowerCase().contains(_searchQuery.toLowerCase())).toList();

    return Column(
      children: [
        // Results count
        if (_searchQuery.isNotEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Text(
              'Found ${filteredItems.length} of ${allItems.length} properties',
              style: TextStyle(
                color: colorScheme.onSurfaceVariant,
                fontSize: 13,
              ),
            ),
          ),
        // Color items
        Expanded(
          child: filteredItems.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search_off, size: 64, color: colorScheme.onSurfaceVariant),
                      const SizedBox(height: 16),
                      Text(
                        'No properties found',
                        style: TextStyle(
                          fontSize: 18,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Try a different search term',
                        style: TextStyle(
                          fontSize: 14,
                          color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: filteredItems.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = filteredItems[index];
                    return _buildSearchableColorCard(item);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildTonalPalettesTab(_Palettes palettes) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Tonal Palettes'),
          const SizedBox(height: 16),
          _buildTonalPaletteRow('Primary', palettes.primary),
          const SizedBox(height: 16),
          _buildTonalPaletteRow('Secondary', palettes.secondary),
          const SizedBox(height: 16),
          _buildTonalPaletteRow('Tertiary', palettes.tertiary),
          const SizedBox(height: 16),
          _buildTonalPaletteRow('Error', palettes.error),
          const SizedBox(height: 16),
          _buildTonalPaletteRow('Neutral', palettes.neutral),
          const SizedBox(height: 16),
          _buildTonalPaletteRow('Neutral Variant', palettes.neutralVariant),
        ],
      ),
    );
  }

  Widget _buildMaterialWidgetsTab(ColorScheme colorScheme) {
    // Get all widget examples
    final allWidgets = _getAllMaterialWidgets(colorScheme);
    
    // Filter based on search query
    final filteredWidgets = _searchQuery.isEmpty
        ? allWidgets
        : allWidgets.where((widget) =>
            widget.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            widget.colors.toLowerCase().contains(_searchQuery.toLowerCase())).toList();

    return Column(
      children: [
        // Results count
        if (_searchQuery.isNotEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Text(
              'Found ${filteredWidgets.length} of ${allWidgets.length} widgets',
              style: TextStyle(
                color: colorScheme.onSurfaceVariant,
                fontSize: 13,
              ),
            ),
          ),
        // Widget list
        Expanded(
          child: filteredWidgets.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search_off, size: 64, color: colorScheme.onSurfaceVariant),
                      const SizedBox(height: 16),
                      Text(
                        'No widgets found',
                        style: TextStyle(
                          fontSize: 18,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Try a different search term',
                        style: TextStyle(
                          fontSize: 14,
                          color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: filteredWidgets.length,
                  itemBuilder: (context, index) => filteredWidgets[index].widget,
                ),
        ),
      ],
    );
  }

  List<_WidgetExample> _getAllMaterialWidgets(ColorScheme colorScheme) {
    return [
      // AppBar Example
      _WidgetExample(
        title: 'AppBar',
        colors: 'surface, onSurface, primary',
        widget: _buildExpandableExample(
            colorScheme: colorScheme,
            title: 'AppBar',
            colors: 'surface, onSurface, primary',
            basicExample: Material(
              elevation: 4,
              child: Container(
                height: 56,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                color: colorScheme.surface,
                child: Row(
                  children: [
                    Icon(Icons.menu, color: colorScheme.primary),
                    const SizedBox(width: 16),
                    Text('App Title', style: TextStyle(fontSize: 20, color: colorScheme.onSurface)),
                    const Spacer(),
                    Icon(Icons.search, color: colorScheme.primary),
                    const SizedBox(width: 16),
                    Icon(Icons.more_vert, color: colorScheme.primary),
                  ],
                ),
              ),
            ),
            colorBoxes: [
              _ColorBox('surface', colorScheme.surface),
              _ColorBox('onSurface', colorScheme.onSurface),
              _ColorBox('primary', colorScheme.primary),
              _ColorBox('surfaceTint', colorScheme.surfaceTint),
            ],
            detailedExamples: [
              _ExampleItem('Standard AppBar', 'Uses surface + onSurface + primary for icons'),
              _ExampleItem('Scrolled AppBar', 'Adds surfaceTint overlay when scrolled'),
              _ExampleItem('Icon Colors', 'Icons use primary color by default'),
              _ExampleItem('Text Color', 'Title uses onSurface for maximum contrast'),
            ],
          ),
      ),

      // Filled Button
      _WidgetExample(
        title: 'FilledButton',
        colors: 'primary (background), onPrimary (text)',
        widget: _buildExpandableExample(
            colorScheme: colorScheme,
            title: 'FilledButton',
            colors: 'primary (background), onPrimary (text)',
            basicExample: FilledButton(onPressed: () {}, child: const Text('Filled Button')),
            colorBoxes: [
              _ColorBox('primary', colorScheme.primary),
              _ColorBox('onPrimary', colorScheme.onPrimary),
              _ColorBox('onSurface', colorScheme.onSurface),
            ],
            detailedExamples: [
              _ExampleItem('Background', 'Uses primary color for filled background', color: colorScheme.primary),
              _ExampleItem('Text & Icons', 'Uses onPrimary for maximum contrast', color: colorScheme.onPrimary),
              _ExampleItem('Hover State', 'Adds onPrimary overlay at 8% opacity', color: colorScheme.onPrimary),
              _ExampleItem('Pressed State', 'Adds onPrimary overlay at 12% opacity', color: colorScheme.onPrimary),
              _ExampleItem('Disabled State', 'Uses onSurface at 12% opacity', color: colorScheme.onSurface),
              _ExampleItem('Focus State', 'Shows primary overlay ring', color: colorScheme.primary),
              _ExampleItem('Splash/Ripple', 'Uses onPrimary at 12% for ripple effect', color: colorScheme.onPrimary),
            ],
          ),
      ),

      // Tonal Button
      _WidgetExample(
        title: 'FilledButton.tonal',
        colors: 'primaryContainer (background), onPrimaryContainer (text)',
        widget: _buildExpandableExample(
            colorScheme: colorScheme,
            title: 'FilledButton.tonal',
            colors: 'primaryContainer (background), onPrimaryContainer (text)',
            basicExample: FilledButton.tonal(onPressed: () {}, child: const Text('Tonal Button')),
            colorBoxes: [
              _ColorBox('primaryContainer', colorScheme.primaryContainer),
              _ColorBox('onPrimaryContainer', colorScheme.onPrimaryContainer),
            ],
            detailedExamples: [
              _ExampleItem('Background', 'Uses primaryContainer for softer appearance', color: colorScheme.primaryContainer),
              _ExampleItem('Text & Icons', 'Uses onPrimaryContainer for contrast', color: colorScheme.onPrimaryContainer),
              _ExampleItem('Hover State', 'Adds onPrimaryContainer overlay at 8%', color: colorScheme.onPrimaryContainer),
              _ExampleItem('Pressed State', 'Adds onPrimaryContainer overlay at 12%', color: colorScheme.onPrimaryContainer),
              _ExampleItem('Use Case', 'Secondary actions, less prominent than FilledButton'),
              _ExampleItem('Accessibility', 'Maintains WCAG AA contrast ratio'),
            ],
          ),
      ),

      // Elevated Button
      _WidgetExample(
        title: 'ElevatedButton',
        colors: 'surface (background), primary (text), surfaceTint (elevation)',
        widget: _buildExpandableExample(
            colorScheme: colorScheme,
            title: 'ElevatedButton',
            colors: 'surface (background), primary (text), surfaceTint (elevation)',
            basicExample: ElevatedButton(onPressed: () {}, child: const Text('Elevated Button')),
            colorBoxes: [
              _ColorBox('surface', colorScheme.surface),
              _ColorBox('primary', colorScheme.primary),
              _ColorBox('surfaceTint', colorScheme.surfaceTint),
              _ColorBox('shadow', colorScheme.shadow),
            ],
            detailedExamples: [
              _ExampleItem('Background', 'Uses surface color with elevation shadow', color: colorScheme.surface),
              _ExampleItem('Text Color', 'Uses primary for text and icons', color: colorScheme.primary),
              _ExampleItem('Elevation Tint', 'surfaceTint creates colored overlay at elevation', color: colorScheme.surfaceTint),
              _ExampleItem('Hover State', 'Increases elevation from 1dp to 3dp'),
              _ExampleItem('Pressed State', 'Reduces elevation, adds primary overlay', color: colorScheme.primary),
              _ExampleItem('Shadow', 'Uses shadow color for elevation effect', color: colorScheme.shadow),
            ],
          ),
      ),

      // Outlined Button
      _WidgetExample(
        title: 'OutlinedButton',
        colors: 'outline (border), primary (text)',
        widget: _buildExpandableExample(
            colorScheme: colorScheme,
            title: 'OutlinedButton',
            colors: 'outline (border), primary (text)',
            basicExample: OutlinedButton(onPressed: () {}, child: const Text('Outlined Button')),
            colorBoxes: [
              _ColorBox('outline', colorScheme.outline),
              _ColorBox('primary', colorScheme.primary),
              _ColorBox('onSurface', colorScheme.onSurface),
            ],
            detailedExamples: [
              _ExampleItem('Border', 'Uses outline color for 1px border', color: colorScheme.outline),
              _ExampleItem('Text Color', 'Uses primary for text and icons', color: colorScheme.primary),
              _ExampleItem('Background', 'Transparent by default'),
              _ExampleItem('Hover State', 'Adds primary overlay at 8% opacity', color: colorScheme.primary),
              _ExampleItem('Pressed State', 'Adds primary overlay at 12% opacity', color: colorScheme.primary),
              _ExampleItem('Disabled Border', 'Uses onSurface at 12% opacity', color: colorScheme.onSurface),
            ],
          ),
      ),

      // Text Button
      _WidgetExample(
        title: 'TextButton',
        colors: 'primary (text)',
        widget: _buildExpandableExample(
            colorScheme: colorScheme,
            title: 'TextButton',
            colors: 'primary (text)',
            basicExample: TextButton(onPressed: () {}, child: const Text('Text Button')),
            colorBoxes: [
              _ColorBox('primary', colorScheme.primary),
            ],
            detailedExamples: [
              _ExampleItem('Text Color', 'Uses primary for text and icons', color: colorScheme.primary),
              _ExampleItem('Background', 'Transparent, no background'),
              _ExampleItem('Hover State', 'Adds primary overlay at 8% opacity', color: colorScheme.primary),
              _ExampleItem('Pressed State', 'Adds primary overlay at 12% opacity', color: colorScheme.primary),
              _ExampleItem('Splash/Ripple', 'Uses primary at 12% for ripple', color: colorScheme.primary),
              _ExampleItem('Use Case', 'Lowest emphasis actions, inline links'),
            ],
          ),
      ),

      // FAB
      _WidgetExample(
        title: 'FloatingActionButton',
        colors: 'primaryContainer (background), onPrimaryContainer (icon)',
        widget: _buildExpandableExample(
            colorScheme: colorScheme,
            title: 'FloatingActionButton',
            colors: 'primaryContainer (background), onPrimaryContainer (icon)',
            basicExample: Row(
              children: [
                FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add)),
                const SizedBox(width: 12),
                FloatingActionButton.small(onPressed: () {}, child: const Icon(Icons.edit)),
                const SizedBox(width: 12),
                FloatingActionButton.extended(
                  onPressed: () {}, 
                  icon: const Icon(Icons.add),
                  label: const Text('Extended'),
                ),
              ],
            ),
            colorBoxes: [
              _ColorBox('primaryContainer', colorScheme.primaryContainer),
              _ColorBox('onPrimaryContainer', colorScheme.onPrimaryContainer),
              _ColorBox('surfaceTint', colorScheme.surfaceTint),
              _ColorBox('shadow', colorScheme.shadow),
            ],
            detailedExamples: [
              _ExampleItem('Background', 'Uses primaryContainer for prominent appearance', color: colorScheme.primaryContainer),
              _ExampleItem('Icon Color', 'Uses onPrimaryContainer for contrast', color: colorScheme.onPrimaryContainer),
              _ExampleItem('Elevation', 'Default 6dp elevation with shadow', color: colorScheme.shadow),
              _ExampleItem('Hover State', 'Increases elevation to 8dp'),
              _ExampleItem('Pressed State', 'Reduces elevation to 6dp, adds overlay'),
              _ExampleItem('Surface Tint', 'Uses surfaceTint for elevation overlay', color: colorScheme.surfaceTint),
              _ExampleItem('Sizes', 'Regular (56dp), Small (40dp), Large (96dp), Extended'),
            ],
          ),
      ),

      // Icon Buttons
      _WidgetExample(
        title: 'IconButton',
        colors: 'Various: onSurfaceVariant, primary, secondaryContainer, outline',
        widget: _buildExpandableExample(
            colorScheme: colorScheme,
            title: 'IconButton (Standard, Filled, Tonal, Outlined)',
            colors: 'Various: onSurfaceVariant, primary, secondaryContainer, outline',
            basicExample: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.favorite)),
                IconButton.filled(onPressed: () {}, icon: const Icon(Icons.favorite)),
                IconButton.filledTonal(onPressed: () {}, icon: const Icon(Icons.favorite)),
                IconButton.outlined(onPressed: () {}, icon: const Icon(Icons.favorite)),
              ],
            ),
            colorBoxes: [
              _ColorBox('onSurfaceVariant', colorScheme.onSurfaceVariant),
              _ColorBox('primary', colorScheme.primary),
              _ColorBox('onPrimary', colorScheme.onPrimary),
              _ColorBox('secondaryContainer', colorScheme.secondaryContainer),
              _ColorBox('onSecondaryContainer', colorScheme.onSecondaryContainer),
              _ColorBox('outline', colorScheme.outline),
            ],
            detailedExamples: [
              _ExampleItem('Standard', 'Icon: onSurfaceVariant, Hover: onSurface overlay 8%', color: colorScheme.onSurfaceVariant),
              _ExampleItem('Filled', 'Background: primary, Icon: onPrimary, Hover: onPrimary 8%', color: colorScheme.primary),
              _ExampleItem('Tonal', 'Background: secondaryContainer, Icon: onSecondaryContainer', color: colorScheme.secondaryContainer),
              _ExampleItem('Outlined', 'Border: outline, Icon: onSurfaceVariant, Hover: onSurface 8%', color: colorScheme.outline),
              _ExampleItem('Selected State', 'Filled uses primary, Tonal uses secondaryContainer', color: colorScheme.primary),
              _ExampleItem('Disabled', 'Icon at 38% opacity, no interaction states'),
            ],
          ),
      ),

      // Cards
      _WidgetExample(
        title: 'Card',
        colors: 'surfaceContainerLow (background), onSurface (text), surfaceTint (elevation)',
        widget: _buildExpandableExample(
            colorScheme: colorScheme,
            title: 'Card',
            colors: 'surfaceContainerLow (background), onSurface (text), surfaceTint (elevation)',
            basicExample: Column(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text('Standard Card', style: Theme.of(context).textTheme.bodyMedium),
                  ),
                ),
                const SizedBox(height: 8),
                Card(
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text('Elevated Card', style: Theme.of(context).textTheme.bodyMedium),
                  ),
                ),
              ],
            ),
            colorBoxes: [
              _ColorBox('surfaceContainerLow', colorScheme.surfaceContainerLow),
              _ColorBox('onSurface', colorScheme.onSurface),
              _ColorBox('surfaceTint', colorScheme.surfaceTint),
              _ColorBox('shadow', colorScheme.shadow),
              _ColorBox('outline', colorScheme.outline),
            ],
            detailedExamples: [
              _ExampleItem('Background', 'Uses surfaceContainerLow (elevation 0)', color: colorScheme.surfaceContainerLow),
              _ExampleItem('Text Color', 'Uses onSurface for content', color: colorScheme.onSurface),
              _ExampleItem('Elevation Levels', '0dp (flat), 1dp (default), 2-8dp (elevated)'),
              _ExampleItem('Surface Tint', 'Applies surfaceTint overlay based on elevation', color: colorScheme.surfaceTint),
              _ExampleItem('Shadow', 'Uses shadow color with opacity based on elevation', color: colorScheme.shadow),
              _ExampleItem('Hover State', 'Can add onSurface overlay at 8% (if interactive)', color: colorScheme.onSurface),
              _ExampleItem('Border', 'Optional outline color for bordered variant', color: colorScheme.outline),
            ],
          ),
      ),

      // ListTile
      _WidgetExample(
        title: 'ListTile',
        colors: 'onSurface (title), onSurfaceVariant (subtitle), primary (selected)',
        widget: _buildExpandableExample(
            colorScheme: colorScheme,
            title: 'ListTile',
            colors: 'onSurface (title), onSurfaceVariant (subtitle), primary (selected)',
            basicExample: Card(
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.person, color: colorScheme.primary),
                    title: const Text('Title'),
                    subtitle: const Text('Subtitle'),
                    trailing: Icon(Icons.chevron_right, color: colorScheme.onSurfaceVariant),
                  ),
                  Divider(height: 1, color: colorScheme.outlineVariant),
                  const ListTile(
                    selected: true,
                    leading: Icon(Icons.notifications),
                    title: Text('Selected Item'),
                  ),
                ],
              ),
            ),
            colorBoxes: [
              _ColorBox('onSurface', colorScheme.onSurface),
              _ColorBox('onSurfaceVariant', colorScheme.onSurfaceVariant),
              _ColorBox('primary', colorScheme.primary),
              _ColorBox('secondaryContainer', colorScheme.secondaryContainer),
              _ColorBox('outlineVariant', colorScheme.outlineVariant),
            ],
            detailedExamples: [
              _ExampleItem('Title', 'Uses onSurface for primary text'),
              _ExampleItem('Subtitle', 'Uses onSurfaceVariant for secondary text'),
              _ExampleItem('Leading Icon', 'Can use primary, onSurface, or onSurfaceVariant'),
              _ExampleItem('Trailing Icon', 'Typically onSurfaceVariant for lower emphasis'),
              _ExampleItem('Selected State', 'Background: secondaryContainer, Text: onSecondaryContainer'),
              _ExampleItem('Hover State', 'Adds onSurface overlay at 8% opacity'),
              _ExampleItem('Pressed State', 'Adds onSurface overlay at 12% opacity'),
              _ExampleItem('Divider', 'Uses outlineVariant between items'),
            ],
          ),
      ),

      // Chips
      _WidgetExample(
        title: 'Chips',
        colors: 'secondaryContainer (selected), outline, onSurface',
        widget: _buildExpandableExample(
            colorScheme: colorScheme,
            title: 'Chips (Filter, Action, Input)',
            colors: 'secondaryContainer (selected), outline, onSurface',
            basicExample: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                const Chip(label: Text('Chip'), avatar: Icon(Icons.star, size: 18)),
                FilterChip(label: const Text('Filter'), selected: false, onSelected: (_) {}),
                FilterChip(label: const Text('Selected'), selected: true, onSelected: (_) {}),
                ActionChip(label: const Text('Action'), onPressed: () {}),
                InputChip(label: const Text('Input'), onDeleted: () {}),
              ],
            ),
            colorBoxes: [
              _ColorBox('surfaceContainerLow', colorScheme.surfaceContainerLow),
              _ColorBox('onSurface', colorScheme.onSurface),
              _ColorBox('outline', colorScheme.outline),
              _ColorBox('secondaryContainer', colorScheme.secondaryContainer),
              _ColorBox('onSecondaryContainer', colorScheme.onSecondaryContainer),
              _ColorBox('primary', colorScheme.primary),
            ],
            detailedExamples: [
              _ExampleItem('Chip (Assist)', 'Background: surfaceContainerLow, Text: onSurface', color: colorScheme.surfaceContainerLow),
              _ExampleItem('FilterChip Unselected', 'Background: transparent, Border: outline', color: colorScheme.outline),
              _ExampleItem('FilterChip Selected', 'Background: secondaryContainer, Text: onSecondaryContainer', color: colorScheme.secondaryContainer),
              _ExampleItem('ActionChip', 'Background: transparent, Text: primary, Hover: onSurface 8%', color: colorScheme.primary),
              _ExampleItem('InputChip', 'Background: surfaceContainerLow, Border: outline', color: colorScheme.surfaceContainerLow),
              _ExampleItem('Hover State', 'Adds overlay at 8% opacity'),
              _ExampleItem('Pressed State', 'Adds overlay at 12% opacity'),
              _ExampleItem('Delete Icon', 'Uses onSurfaceVariant', color: colorScheme.onSurfaceVariant),
            ],
          ),
      ),

      // TextField
      _WidgetExample(
        title: 'TextField',
        colors: 'outline, onSurface, onSurfaceVariant, primary (focus), error',
        widget: _buildExpandableExample(
            colorScheme: colorScheme,
            title: 'TextField',
            colors: 'outline, onSurface, onSurfaceVariant, primary (focus), error',
            basicExample: const Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Label',
                    hintText: 'Hint text',
                    helperText: 'Helper text',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Error state',
                    errorText: 'Error message',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
            colorBoxes: [
              _ColorBox('outline', colorScheme.outline),
              _ColorBox('primary', colorScheme.primary),
              _ColorBox('onSurface', colorScheme.onSurface),
              _ColorBox('onSurfaceVariant', colorScheme.onSurfaceVariant),
              _ColorBox('error', colorScheme.error),
            ],
            detailedExamples: [
              _ExampleItem('Border (Unfocused)', 'Uses outline color'),
              _ExampleItem('Border (Focused)', 'Uses primary color, 2px width'),
              _ExampleItem('Label (Unfocused)', 'Uses onSurfaceVariant'),
              _ExampleItem('Label (Focused)', 'Uses primary color'),
              _ExampleItem('Input Text', 'Uses onSurface'),
              _ExampleItem('Hint Text', 'Uses onSurfaceVariant at 60% opacity'),
              _ExampleItem('Helper Text', 'Uses onSurfaceVariant'),
              _ExampleItem('Error State', 'Border & label use error, message uses error'),
              _ExampleItem('Disabled', 'Border: onSurface 12%, Text: onSurface 38%'),
              _ExampleItem('Fill Color', 'Optional: surfaceContainerHighest for filled variant'),
            ],
          ),
      ),

      // Selection Controls
      _WidgetExample(
        title: 'Selection Controls',
        colors: 'primary (selected), onSurface (unselected), surfaceContainerHighest',
        widget: _buildExpandableExample(
            colorScheme: colorScheme,
            title: 'Selection Controls (Checkbox, Radio, Switch)',
            colors: 'primary (selected), onSurface (unselected), surfaceContainerHighest',
            basicExample: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Checkbox(value: false, onChanged: (_) {}),
                        Checkbox(value: true, onChanged: (_) {}),
                        const SizedBox(width: 16),
                        Radio(value: 1, groupValue: 2, onChanged: (_) {}),
                        Radio(value: 2, groupValue: 2, onChanged: (_) {}),
                        const SizedBox(width: 16),
                        Switch(value: false, onChanged: (_) {}),
                        Switch(value: true, onChanged: (_) {}),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            colorBoxes: [
              _ColorBox('primary', colorScheme.primary),
              _ColorBox('onPrimary', colorScheme.onPrimary),
              _ColorBox('onSurfaceVariant', colorScheme.onSurfaceVariant),
              _ColorBox('surfaceContainerHighest', colorScheme.surfaceContainerHighest),
              _ColorBox('outline', colorScheme.outline),
              _ColorBox('error', colorScheme.error),
            ],
            detailedExamples: [
              _ExampleItem('Checkbox Unchecked', 'Border: onSurfaceVariant, Hover: onSurface 8%', color: colorScheme.onSurfaceVariant),
              _ExampleItem('Checkbox Checked', 'Background: primary, Checkmark: onPrimary', color: colorScheme.primary),
              _ExampleItem('Radio Unselected', 'Border: onSurfaceVariant', color: colorScheme.onSurfaceVariant),
              _ExampleItem('Radio Selected', 'Outer ring: primary, Inner dot: primary', color: colorScheme.primary),
              _ExampleItem('Switch Off', 'Track: surfaceContainerHighest, Thumb: outline', color: colorScheme.surfaceContainerHighest),
              _ExampleItem('Switch On', 'Track: primary, Thumb: onPrimary', color: colorScheme.primary),
              _ExampleItem('Hover State', 'Adds overlay circle at 8% opacity'),
              _ExampleItem('Pressed State', 'Adds overlay circle at 12% opacity'),
              _ExampleItem('Disabled', 'Uses onSurface at 38% opacity', color: colorScheme.onSurface),
              _ExampleItem('Error State', 'Can use error color for validation', color: colorScheme.error),
            ],
          ),
      ),

      // Slider
      _WidgetExample(
        title: 'Slider',
        colors: 'primary (active), surfaceContainerHighest (inactive)',
        widget: _buildExpandableExample(
            colorScheme: colorScheme,
            title: 'Slider',
            colors: 'primary (active), surfaceContainerHighest (inactive)',
            basicExample: Slider(value: 0.5, onChanged: (_) {}),
            colorBoxes: [
              _ColorBox('primary', colorScheme.primary),
              _ColorBox('onPrimary', colorScheme.onPrimary),
              _ColorBox('surfaceContainerHighest', colorScheme.surfaceContainerHighest),
              _ColorBox('onSurface', colorScheme.onSurface),
            ],
            detailedExamples: [
              _ExampleItem('Active Track', 'Uses primary color', color: colorScheme.primary),
              _ExampleItem('Inactive Track', 'Uses surfaceContainerHighest', color: colorScheme.surfaceContainerHighest),
              _ExampleItem('Thumb', 'Uses primary color', color: colorScheme.primary),
              _ExampleItem('Hover State', 'Adds primary overlay at 8% on thumb', color: colorScheme.primary),
              _ExampleItem('Pressed State', 'Adds primary overlay at 12% on thumb', color: colorScheme.primary),
              _ExampleItem('Value Label', 'Background: primary, Text: onPrimary', color: colorScheme.primary),
              _ExampleItem('Disabled', 'Uses onSurface at 38% opacity', color: colorScheme.onSurface),
            ],
          ),
      ),

      // Progress Indicators
      _WidgetExample(
        title: 'Progress Indicators',
        colors: 'primary (indicator), surfaceContainerHighest (track)',
        widget: _buildExpandableExample(
            colorScheme: colorScheme,
            title: 'Progress Indicators',
            colors: 'primary (indicator), surfaceContainerHighest (track)',
            basicExample: const Row(
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 24),
                Expanded(child: LinearProgressIndicator(value: 0.7)),
              ],
            ),
            colorBoxes: [
              _ColorBox('primary', colorScheme.primary),
              _ColorBox('surfaceContainerHighest', colorScheme.surfaceContainerHighest),
            ],
            detailedExamples: [
              _ExampleItem('Indicator Color', 'Uses primary for progress', color: colorScheme.primary),
              _ExampleItem('Track Color', 'Uses surfaceContainerHighest for background', color: colorScheme.surfaceContainerHighest),
              _ExampleItem('Circular', 'Rotating animation, 4dp stroke width'),
              _ExampleItem('Linear', 'Horizontal bar, 4dp height'),
              _ExampleItem('Determinate', 'Shows specific progress value'),
              _ExampleItem('Indeterminate', 'Shows ongoing activity without specific progress'),
            ],
          ),
      ),

      // SnackBar
      _WidgetExample(
        title: 'SnackBar',
        colors: 'inverseSurface (background), onInverseSurface (text), inversePrimary (action)',
        widget: _buildExpandableExample(
            colorScheme: colorScheme,
            title: 'SnackBar',
            colors: 'inverseSurface (background), onInverseSurface (text), inversePrimary (action)',
            basicExample: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: colorScheme.inverseSurface,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Snackbar message',
                      style: TextStyle(color: colorScheme.onInverseSurface),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor: colorScheme.inversePrimary,
                    ),
                    child: const Text('ACTION'),
                  ),
                ],
              ),
            ),
            colorBoxes: [
              _ColorBox('inverseSurface', colorScheme.inverseSurface),
              _ColorBox('onInverseSurface', colorScheme.onInverseSurface),
              _ColorBox('inversePrimary', colorScheme.inversePrimary),
            ],
            detailedExamples: [
              _ExampleItem('Background', 'Uses inverseSurface (inverted from main surface)'),
              _ExampleItem('Message Text', 'Uses onInverseSurface for contrast'),
              _ExampleItem('Action Button', 'Uses inversePrimary color'),
              _ExampleItem('Elevation', 'Typically 6dp elevation'),
              _ExampleItem('Duration', 'Short (4s), Long (10s), or Indefinite'),
              _ExampleItem('Position', 'Bottom of screen, centered or left-aligned'),
            ],
          ),
      ),

      // Badge
      _WidgetExample(
        title: 'Badge',
        colors: 'error (background), onError (text)',
        widget: _buildExpandableExample(
            colorScheme: colorScheme,
            title: 'Badge',
            colors: 'error (background), onError (text)',
            basicExample: Row(
              children: [
                Badge(
                  label: const Text('3'),
                  child: Icon(Icons.notifications, size: 32, color: colorScheme.onSurface),
                ),
                const SizedBox(width: 24),
                Badge(
                  child: Icon(Icons.mail, size: 32, color: colorScheme.onSurface),
                ),
              ],
            ),
            colorBoxes: [
              _ColorBox('error', colorScheme.error),
              _ColorBox('onError', colorScheme.onError),
            ],
            detailedExamples: [
              _ExampleItem('Background', 'Uses error color for attention', color: colorScheme.error),
              _ExampleItem('Text/Label', 'Uses onError for contrast', color: colorScheme.onError),
              _ExampleItem('Small Badge', 'Dot only, 6dp diameter'),
              _ExampleItem('Large Badge', 'With label/number, 16dp height'),
              _ExampleItem('Position', 'Top-right corner of parent widget'),
              _ExampleItem('Use Cases', 'Notifications, unread counts, status indicators'),
            ],
          ),
      ),

      // Divider
      _WidgetExample(
        title: 'Divider',
        colors: 'outlineVariant',
        widget: _buildExpandableExample(
            colorScheme: colorScheme,
            title: 'Divider',
            colors: 'outlineVariant',
            basicExample: const Divider(),
            colorBoxes: [
              _ColorBox('outlineVariant', colorScheme.outlineVariant),
            ],
            detailedExamples: [
              _ExampleItem('Color', 'Uses outlineVariant for subtle separation', color: colorScheme.outlineVariant),
              _ExampleItem('Thickness', 'Default 1dp height'),
              _ExampleItem('Horizontal', 'Full width separator'),
              _ExampleItem('Vertical', 'Use VerticalDivider for vertical separation'),
              _ExampleItem('Use Cases', 'List items, sections, content groups'),
            ],
          ),
      ),

      // NavigationBar
      _WidgetExample(
        title: 'NavigationBar',
        colors: 'surfaceContainer (background), secondaryContainer (indicator), onSurface (icons)',
        widget: _buildExpandableExample(
            colorScheme: colorScheme,
            title: 'NavigationBar',
            colors: 'surfaceContainer (background), secondaryContainer (indicator), onSurface (icons)',
            basicExample: NavigationBar(
              selectedIndex: 1,
              destinations: const [
                NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
                NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
                NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
              ],
            ),
            colorBoxes: [
              _ColorBox('surfaceContainer', colorScheme.surfaceContainer),
              _ColorBox('secondaryContainer', colorScheme.secondaryContainer),
              _ColorBox('onSecondaryContainer', colorScheme.onSecondaryContainer),
              _ColorBox('onSurfaceVariant', colorScheme.onSurfaceVariant),
              _ColorBox('onSurface', colorScheme.onSurface),
            ],
            detailedExamples: [
              _ExampleItem('Background', 'Uses surfaceContainer', color: colorScheme.surfaceContainer),
              _ExampleItem('Selected Indicator', 'Background: secondaryContainer', color: colorScheme.secondaryContainer),
              _ExampleItem('Selected Icon', 'Uses onSecondaryContainer', color: colorScheme.onSecondaryContainer),
              _ExampleItem('Unselected Icon', 'Uses onSurfaceVariant', color: colorScheme.onSurfaceVariant),
              _ExampleItem('Label', 'Uses onSurface (selected) or onSurfaceVariant (unselected)', color: colorScheme.onSurface),
              _ExampleItem('Hover State', 'Adds overlay at 8% opacity'),
              _ExampleItem('Elevation', 'Typically 3dp elevation'),
            ],
          ),
      ),

      // NavigationRail
      _WidgetExample(
        title: 'NavigationRail',
        colors: 'surface (background), secondaryContainer (indicator)',
        widget: _buildExpandableExample(
            colorScheme: colorScheme,
            title: 'NavigationRail',
            colors: 'surface (background), secondaryContainer (indicator)',
            basicExample: Container(
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(color: colorScheme.outline.withValues(alpha: 0.2)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: NavigationRail(
                selectedIndex: 0,
                destinations: const [
                  NavigationRailDestination(icon: Icon(Icons.home), label: Text('Home')),
                  NavigationRailDestination(icon: Icon(Icons.search), label: Text('Search')),
                  NavigationRailDestination(icon: Icon(Icons.person), label: Text('Profile')),
                ],
              ),
            ),
            colorBoxes: [
              _ColorBox('surface', colorScheme.surface),
              _ColorBox('secondaryContainer', colorScheme.secondaryContainer),
              _ColorBox('onSecondaryContainer', colorScheme.onSecondaryContainer),
              _ColorBox('onSurfaceVariant', colorScheme.onSurfaceVariant),
              _ColorBox('onSurface', colorScheme.onSurface),
            ],
            detailedExamples: [
              _ExampleItem('Background', 'Uses surface color', color: colorScheme.surface),
              _ExampleItem('Selected Indicator', 'Background: secondaryContainer', color: colorScheme.secondaryContainer),
              _ExampleItem('Selected Icon', 'Uses onSecondaryContainer', color: colorScheme.onSecondaryContainer),
              _ExampleItem('Unselected Icon', 'Uses onSurfaceVariant', color: colorScheme.onSurfaceVariant),
              _ExampleItem('Label', 'Optional, uses onSurface', color: colorScheme.onSurface),
              _ExampleItem('Hover State', 'Adds overlay at 8% opacity'),
              _ExampleItem('Use Case', 'Vertical navigation for tablet/desktop layouts'),
            ],
          ),
      ),
    ];
  }

  Widget _buildSearchableColorCard(_ColorItem item) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: item.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: item.colorScheme.outlineVariant,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: item.colorScheme.primary,
                        fontFamily: 'monospace',
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.description,
                      style: TextStyle(
                        fontSize: 13,
                        color: item.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              // Color swatch
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: item.backgroundColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: item.colorScheme.outline.withValues(alpha: 0.3),
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _hex(item.backgroundColor),
                        style: TextStyle(
                          color: item.foregroundColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'monospace',
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Icon(
                        Icons.circle,
                        color: item.foregroundColor,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Example widget
          _buildExampleForColor(item),
        ],
      ),
    );
  }

  Widget _buildExampleForColor(_ColorItem item) {
    final cs = item.colorScheme;
    
    // Return appropriate example based on color name
    if (item.name.contains('primary') && !item.name.contains('on') && !item.name.contains('inverse')) {
      return Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          FilledButton(
            onPressed: () {},
            style: FilledButton.styleFrom(
              backgroundColor: item.backgroundColor,
              foregroundColor: item.foregroundColor,
            ),
            child: Text('${item.name} Button'),
          ),
          if (item.name == 'primary')
            FloatingActionButton.small(
              onPressed: () {},
              backgroundColor: item.backgroundColor,
              foregroundColor: item.foregroundColor,
              child: const Icon(Icons.add),
            ),
        ],
      );
    }
    
    if (item.name.contains('secondary') && !item.name.contains('on')) {
      return FilledButton(
        onPressed: () {},
        style: FilledButton.styleFrom(
          backgroundColor: item.backgroundColor,
          foregroundColor: item.foregroundColor,
        ),
        child: Text('${item.name} Button'),
      );
    }
    
    if (item.name.contains('tertiary') && !item.name.contains('on')) {
      return FilledButton(
        onPressed: () {},
        style: FilledButton.styleFrom(
          backgroundColor: item.backgroundColor,
          foregroundColor: item.foregroundColor,
        ),
        child: Text('${item.name} Button'),
      );
    }
    
    if (item.name.contains('error') && !item.name.contains('on')) {
      return Wrap(
        spacing: 8,
        children: [
          FilledButton(
            onPressed: () {},
            style: FilledButton.styleFrom(
              backgroundColor: item.backgroundColor,
              foregroundColor: item.foregroundColor,
            ),
            child: const Text('Delete'),
          ),
          Icon(Icons.error, color: item.backgroundColor),
        ],
      );
    }
    
    if (item.name.contains('surface') || item.name.contains('Container')) {
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: item.backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: cs.outline.withValues(alpha: 0.2)),
        ),
        child: Text(
          item.name,
          style: TextStyle(color: item.foregroundColor),
        ),
      );
    }
    
    if (item.name.contains('outline')) {
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: item.backgroundColor, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          'Border with ${item.name}',
          style: TextStyle(color: cs.onSurface),
        ),
      );
    }
    
    if (item.name.contains('inverse')) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: item.backgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          'Snackbar style',
          style: TextStyle(color: item.foregroundColor),
        ),
      );
    }
    
    if (item.name == 'shadow') {
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: item.backgroundColor.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          'Shadow example',
          style: TextStyle(color: cs.onSurface),
        ),
      );
    }
    
    if (item.name == 'scrim') {
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: item.backgroundColor.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text(
          'Modal overlay',
          style: TextStyle(color: Colors.white),
        ),
      );
    }
    
    if (item.name == 'surfaceTint') {
      return Card(
        elevation: 4,
        surfaceTintColor: item.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            'Elevated with tint',
            style: TextStyle(color: cs.onSurface),
          ),
        ),
      );
    }
    
    // Default example
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: item.backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        item.name,
        style: TextStyle(color: item.foregroundColor),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Widget _buildInlineColorIndicator(_ColorBox box, ColorScheme colorScheme) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Big colored circle
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: box.color,
            shape: BoxShape.circle,
            border: Border.all(
              color: colorScheme.outline.withValues(alpha: 0.3),
              width: 2,
            ),
          ),
        ),
        const SizedBox(width: 8),
        // Name and hex code
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              box.name,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
            ),
            Text(
              _hex(box.color),
              style: TextStyle(
                fontSize: 11,
                fontFamily: 'monospace',
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSmallColorDot(Color color, ColorScheme colorScheme) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(
              color: colorScheme.outline.withValues(alpha: 0.3),
              width: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          _hex(color),
          style: TextStyle(
            fontSize: 9,
            fontFamily: 'monospace',
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildExpandableExample({
    required ColorScheme colorScheme,
    required String title,
    required String colors,
    required Widget basicExample,
    required List<_ExampleItem> detailedExamples,
    List<_ColorBox>? colorBoxes,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border.all(
          color: colorScheme.outlineVariant,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          subtitle: Text(
            'Colors: $colors',
            style: TextStyle(
              fontSize: 12,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Color indicators inline
                  if (colorBoxes != null && colorBoxes.isNotEmpty) ...[
                    Text(
                      'Colors Used:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 16,
                      runSpacing: 12,
                      children: colorBoxes.map((box) => _buildInlineColorIndicator(box, colorScheme)).toList(),
                    ),
                    const SizedBox(height: 16),
                  ],
                  Text(
                    'Basic Example:',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 12),
                  basicExample,
                  const SizedBox(height: 16),
                  Text(
                    'Usage Details:',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...detailedExamples.map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.check_circle_outline, size: 16, color: colorScheme.primary),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: 4),
                              // Show description with inline color if available
                              if (item.color != null)
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        item.description,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: colorScheme.onSurfaceVariant,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    _buildSmallColorDot(item.color!, colorScheme),
                                  ],
                                )
                              else
                                Text(
                                  item.description,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTonalPaletteRow(String label, TonalPalette palette) {
    const tones = [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 95, 100];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: tones.map((tone) {
            final color = Color(palette.get(tone));
            final fg = ThemeData.estimateBrightnessForColor(color) == Brightness.dark
                ? Colors.white
                : Colors.black;
            return Container(
              width: 64,
              height: 44,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black12),
              ),
              child: Text(
                '$tone',
                style: TextStyle(
                  color: fg,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  String _hex(Color color) {
    final argb = color.toARGB32();
    return '#${(argb & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}';
  }
}

class _ColorItem {
  final String name;
  final String description;
  final Color backgroundColor;
  final Color foregroundColor;
  final ColorScheme colorScheme;

  _ColorItem(this.name, this.description, this.backgroundColor, this.foregroundColor, this.colorScheme);
}

class _ExampleItem {
  final String title;
  final String description;
  final Color? color;

  _ExampleItem(this.title, this.description, {this.color});
}

class _ColorBox {
  final String name;
  final Color color;

  _ColorBox(this.name, this.color);
}

class _WidgetExample {
  final String title;
  final String colors;
  final Widget widget;

  _WidgetExample({
    required this.title,
    required this.colors,
    required this.widget,
  });
}

class _Palettes {
  final TonalPalette primary;
  final TonalPalette secondary;
  final TonalPalette tertiary;
  final TonalPalette error;
  final TonalPalette neutral;
  final TonalPalette neutralVariant;

  _Palettes({
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.error,
    required this.neutral,
    required this.neutralVariant,
  });

  factory _Palettes.fromColorScheme(ColorScheme cs) {
    TonalPalette fromBase(Color c, {double? minChroma}) {
      final hct = Hct.fromInt(c.toARGB32());
      final h = hct.hue;
      var ch = hct.chroma;
      if (minChroma != null && ch < minChroma) ch = minChroma;
      return TonalPalette.of(h, ch);
    }

    return _Palettes(
      primary: fromBase(cs.primary),
      secondary: fromBase(cs.secondary, minChroma: 12),
      tertiary: fromBase(cs.tertiary, minChroma: 18),
      error: fromBase(cs.error, minChroma: 30),
      neutral: fromBase(cs.onSurface, minChroma: 4),
      neutralVariant: fromBase(cs.onSurfaceVariant, minChroma: 8),
    );
  }
}

