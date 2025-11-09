# Parsers

Parsers in Stac are responsible for converting JSON into Flutter widgets and handling actions. They form the core of Stac's functionality, allowing you to extend the framework with custom widgets and actions.

## What are Parsers?

Parsers are classes that:
1. **Parse JSON** into widget models or action models
2. **Convert models** into Flutter widgets or execute actions
3. **Handle errors** gracefully
4. **Provide type safety** through Dart's type system

## Widget Parsers

Widget parsers convert JSON into Flutter widgets. They extend the `StacParser` class and implement three key methods:

### Basic Structure

```dart
class CustomWidgetParser extends StacParser<CustomWidget> {
  @override
  String get type => 'customWidget';
  
  @override
  CustomWidget getModel(Map<String, dynamic> json) => CustomWidget.fromJson(json);
  
  @override
  Widget parse(BuildContext context, CustomWidget model) {
    return CustomFlutterWidget(
      title: model.title,
      content: model.content,
    );
  }
}
```

### Example: Custom Card Parser

```dart
@freezed
class StacCustomCard with _$StacCustomCard {
  const factory StacCustomCard({
    required String title,
    required String content,
    String? imageUrl,
    Color? backgroundColor,
    double? borderRadius,
    EdgeInsets? padding,
  }) = _StacCustomCard;

  factory StacCustomCard.fromJson(Map<String, dynamic> json) =>
      _$StacCustomCardFromJson(json);
}

class StacCustomCardParser extends StacParser<StacCustomCard> {
  const StacCustomCardParser();
  
  @override
  String get type => 'customCard';
  
  @override
  StacCustomCard getModel(Map<String, dynamic> json) => StacCustomCard.fromJson(json);
  
  @override
  Widget parse(BuildContext context, StacCustomCard model) {
    return Card(
      color: model.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(model.borderRadius ?? 8.0),
      ),
      child: Padding(
        padding: model.padding ?? const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (model.imageUrl != null)
              Image.network(
                model.imageUrl!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            const SizedBox(height: 8),
            Text(
              model.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 4),
            Text(
              model.content,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
```

### Example: Custom Button Parser

```dart
@freezed
class StacCustomButton with _$StacCustomButton {
  const factory StacCustomButton({
    required String text,
    required String actionType,
    Map<String, dynamic>? actionData,
    Color? backgroundColor,
    Color? textColor,
    double? borderRadius,
    EdgeInsets? padding,
    bool? isLoading,
  }) = _StacCustomButton;

  factory StacCustomButton.fromJson(Map<String, dynamic> json) =>
      _$StacCustomButtonFromJson(json);
}

class StacCustomButtonParser extends StacParser<StacCustomButton> {
  const StacCustomButtonParser();
  
  @override
  String get type => 'customButton';
  
  @override
  StacCustomButton getModel(Map<String, dynamic> json) => StacCustomButton.fromJson(json);
  
  @override
  Widget parse(BuildContext context, StacCustomButton model) {
    return ElevatedButton(
      onPressed: model.isLoading == true ? null : () => _handleAction(context, model),
      style: ElevatedButton.styleFrom(
        backgroundColor: model.backgroundColor,
        foregroundColor: model.textColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(model.borderRadius ?? 8.0),
        ),
        padding: model.padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      child: model.isLoading == true
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Text(model.text),
    );
  }
  
  void _handleAction(BuildContext context, StacCustomButton model) {
    // Handle the action based on actionType and actionData
    switch (model.actionType) {
      case 'navigate':
        Navigator.pushNamed(context, model.actionData?['route'] ?? '/');
        break;
      case 'snackBar':
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(model.actionData?['message'] ?? '')),
        );
        break;
      default:
        // Handle unknown action type
        break;
    }
  }
}
```

## Action Parsers

Action parsers handle user interactions and business logic. They implement the `StacActionParser` interface:

### Basic Structure

```dart
class CustomActionParser implements StacActionParser<CustomAction> {
  @override
  String get actionType => 'custom';
  
  @override
  CustomAction getModel(Map<String, dynamic> json) => CustomAction.fromJson(json);
  
  @override
  FutureOr onCall(BuildContext context, CustomAction model) async {
    // Custom action logic
    await performCustomAction(model);
  }
}
```

### Example: Share Action Parser

```dart
@freezed
class StacShareAction with _$StacShareAction {
  const factory StacShareAction({
    required String text,
    String? subject,
    String? title,
  }) = _StacShareAction;

  factory StacShareAction.fromJson(Map<String, dynamic> json) =>
      _$StacShareActionFromJson(json);
}

class StacShareActionParser implements StacActionParser<StacShareAction> {
  @override
  String get actionType => 'share';
  
  @override
  StacShareAction getModel(Map<String, dynamic> json) => StacShareAction.fromJson(json);
  
  @override
  FutureOr onCall(BuildContext context, StacShareAction model) async {
    try {
      await Share.share(
        model.text,
        subject: model.subject,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to share: $e')),
      );
    }
  }
}
```

### Example: Analytics Action Parser

```dart
@freezed
class StacAnalyticsAction with _$StacAnalyticsAction {
  const factory StacAnalyticsAction({
    required String event,
    Map<String, dynamic>? parameters,
  }) = _StacAnalyticsAction;

  factory StacAnalyticsAction.fromJson(Map<String, dynamic> json) =>
      _$StacAnalyticsActionFromJson(json);
}

class StacAnalyticsActionParser implements StacActionParser<StacAnalyticsAction> {
  @override
  String get actionType => 'analytics';
  
  @override
  StacAnalyticsAction getModel(Map<String, dynamic> json) => StacAnalyticsAction.fromJson(json);
  
  @override
  FutureOr onCall(BuildContext context, StacAnalyticsAction model) async {
    // Log analytics event
    FirebaseAnalytics.instance.logEvent(
      name: model.event,
      parameters: model.parameters,
    );
  }
}
```

## Registering Parsers

### During Initialization

```dart
void main() async {
  await Stac.initialize(
    parsers: const [
      StacCustomCardParser(),
      StacCustomButtonParser(),
    ],
    actionParsers: const [
      StacShareActionParser(),
      StacAnalyticsActionParser(),
    ],
  );
  
  runApp(const MyApp());
}
```

### Runtime Registration

```dart
// Register a single parser
StacRegistry.instance.register(StacCustomCardParser());

// Register multiple parsers
StacRegistry.instance.registerAll([
  StacCustomCardParser(),
  StacCustomButtonParser(),
]);

// Register action parsers
StacRegistry.instance.registerAction(StacShareActionParser());
StacRegistry.instance.registerAllActions([
  StacShareActionParser(),
  StacAnalyticsActionParser(),
]);
```

## Advanced Parser Examples

### Complex Widget Parser

```dart
@freezed
class StacDataTable with _$StacDataTable {
  const factory StacDataTable({
    required List<Map<String, dynamic>> data,
    required List<String> columns,
    List<String>? sortableColumns,
    String? sortColumn,
    bool? sortAscending,
    Map<String, String>? columnLabels,
    Map<String, double>? columnWidths,
  }) = _StacDataTable;

  factory StacDataTable.fromJson(Map<String, dynamic> json) =>
      _$StacDataTableFromJson(json);
}

class StacDataTableParser extends StacParser<StacDataTable> {
  const StacDataTableParser();
  
  @override
  String get type => 'dataTable';
  
  @override
  StacDataTable getModel(Map<String, dynamic> json) => StacDataTable.fromJson(json);
  
  @override
  Widget parse(BuildContext context, StacDataTable model) {
    return DataTable(
      columns: model.columns.map((column) {
        return DataColumn(
          label: Text(model.columnLabels?[column] ?? column),
          onSort: model.sortableColumns?.contains(column) == true
              ? (index, ascending) => _handleSort(context, column, ascending)
              : null,
        );
      }).toList(),
      rows: model.data.map((row) {
        return DataRow(
          cells: model.columns.map((column) {
            return DataCell(
              Text(row[column]?.toString() ?? ''),
            );
          }).toList(),
        );
      }).toList(),
    );
  }
  
  void _handleSort(BuildContext context, String column, bool ascending) {
    // Handle sorting logic
  }
}
```

### Network Action Parser

```dart
@freezed
class StacNetworkAction with _$StacNetworkAction {
  const factory StacNetworkAction({
    required String url,
    required String method,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    int? timeout,
    bool? showLoading,
    String? successMessage,
    String? errorMessage,
  }) = _StacNetworkAction;

  factory StacNetworkAction.fromJson(Map<String, dynamic> json) =>
      _$StacNetworkActionFromJson(json);
}

class StacNetworkActionParser implements StacActionParser<StacNetworkAction> {
  @override
  String get actionType => 'network';
  
  @override
  StacNetworkAction getModel(Map<String, dynamic> json) => StacNetworkAction.fromJson(json);
  
  @override
  FutureOr onCall(BuildContext context, StacNetworkAction model) async {
    if (model.showLoading == true) {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    
    try {
      final response = await http.Request(
        model.method,
        Uri.parse(model.url),
      )
        ..headers.addAll(model.headers ?? {})
        ..body = jsonEncode(model.body ?? {});
      
      final streamedResponse = await response.send();
      final responseBody = await streamedResponse.stream.bytesToString();
      
      if (model.showLoading == true) {
        Navigator.of(context).pop(); // Hide loading indicator
      }
      
      if (streamedResponse.statusCode >= 200 && streamedResponse.statusCode < 300) {
        if (model.successMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(model.successMessage!)),
          );
        }
      } else {
        throw Exception('HTTP ${streamedResponse.statusCode}');
      }
    } catch (e) {
      if (model.showLoading == true) {
        Navigator.of(context).pop(); // Hide loading indicator
      }
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(model.errorMessage ?? 'Network error: $e')),
      );
    }
  }
}
```

## Error Handling

### Parser Error Handling

```dart
class SafeStacParser extends StacParser<StacWidget> {
  @override
  Widget parse(BuildContext context, StacWidget model) {
    try {
      return _buildWidget(context, model);
    } catch (e) {
      return ErrorWidget('Failed to parse widget: $e');
    }
  }
  
  Widget _buildWidget(BuildContext context, StacWidget model) {
    // Widget building logic
  }
}
```

### Action Error Handling

```dart
class SafeStacActionParser implements StacActionParser<StacAction> {
  @override
  FutureOr onCall(BuildContext context, StacAction model) async {
    try {
      await _executeAction(context, model);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Action failed: $e')),
      );
    }
  }
  
  Future<void> _executeAction(BuildContext context, StacAction model) async {
    // Action execution logic
  }
}
```

## Testing Parsers

### Unit Tests

```dart
void main() {
  group('StacCustomCardParser', () {
    test('should parse JSON correctly', () {
      final json = {
        'type': 'customCard',
        'title': 'Test Card',
        'content': 'Test content',
        'backgroundColor': '#FF5733',
        'borderRadius': 8.0,
      };
      
      final parser = StacCustomCardParser();
      final model = parser.getModel(json);
      
      expect(model.title, 'Test Card');
      expect(model.content, 'Test content');
      expect(model.backgroundColor, const Color(0xFFFF5733));
      expect(model.borderRadius, 8.0);
    });
  });
}
```

### Widget Tests

```dart
void main() {
  group('StacCustomCardParser Widget Tests', () {
    testWidgets('should render custom card', (WidgetTester tester) async {
      final json = {
        'type': 'customCard',
        'title': 'Test Card',
        'content': 'Test content',
      };
      
      await tester.pumpWidget(
        MaterialApp(
          home: Stac.fromJson(json, tester.element(find.byType(MaterialApp))),
        ),
      );
      
      expect(find.text('Test Card'), findsOneWidget);
      expect(find.text('Test content'), findsOneWidget);
    });
  });
}
```

## Best Practices

### 1. Model Design

- Use `freezed` for immutable models
- Provide meaningful default values
- Include validation in model constructors
- Use proper type annotations

### 2. Parser Implementation

- Handle errors gracefully
- Provide meaningful error messages
- Use const constructors where possible
- Follow Flutter widget conventions

### 3. Action Implementation

- Handle async operations properly
- Provide user feedback
- Handle errors appropriately
- Use proper context management

### 4. Testing

- Write unit tests for models
- Write widget tests for parsers
- Test error scenarios
- Mock external dependencies

## Performance Considerations

### 1. Model Caching

```dart
class CachedStacParser extends StacParser<StacWidget> {
  final Map<String, StacWidget> _cache = {};
  
  @override
  StacWidget getModel(Map<String, dynamic> json) {
    final key = json.hashCode.toString();
    return _cache.putIfAbsent(key, () => StacWidget.fromJson(json));
  }
}
```

### 2. Lazy Loading

```dart
class LazyStacParser extends StacParser<StacWidget> {
  @override
  Widget parse(BuildContext context, StacWidget model) {
    return FutureBuilder(
      future: _loadData(model),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _buildWidget(context, snapshot.data!);
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
```

## Next Steps

- [Theming](./09-theming-styles.md) - Customize appearance
- [Examples](./11-examples.md) - See complete examples
- [API Reference](./12-api-reference.md) - Detailed API documentation
