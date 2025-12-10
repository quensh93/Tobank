import 'package:universal_io/io.dart';

// Update the findApiUsages function to return markdown formatted links
String findApiUsages(String enumName, String projectPath) {
  final result = <String>[];
  try {
    final dir = Directory(projectPath);
    if (!dir.existsSync()) return 'No usages found';

    void searchInDirectory(Directory dir) {
      for (final entity in dir.listSync(recursive: false, followLinks: false)) {
        if (entity is File && entity.path.endsWith('.dart')) {
          final content = entity.readAsStringSync();
          // Search for exact pattern: ApiProviderEnum.enumName
          if (content.contains('ApiProviderEnum.$enumName') && 
              !entity.path.endsWith('api_provider.dart')) {
            final relativePath = entity.path.replaceAll(projectPath, '');
            result.add('[${relativePath.split('/').last}](../../${relativePath.replaceFirst('/', '')})');
          }
        } else if (entity is Directory && !entity.path.contains('/.')) {
          searchInDirectory(entity);
        }
      }
    }

    searchInDirectory(dir);
  } catch (e) {
    return 'Error finding usages: $e';
  }

  return result.isEmpty ? 'No usages found' : result.join('<br>');
}

// Update the findModelReference function to return both name and link
(String name, String link) findModelReference(String enumName, String projectPath) {
  try {
    final dir = Directory(projectPath);
    if (!dir.existsSync()) return ('', '');

    final apiPattern = RegExp(r'ApiProviderEnum\.' + enumName + r'[\s\S]*?modelFromJson:[\s\S]*?=>\s*(\w+)\.fromJson');

    for (final entity in dir.listSync(recursive: true, followLinks: false)) {
      if (entity is File && entity.path.endsWith('.dart')) {
        final content = entity.readAsStringSync();
        final match = apiPattern.firstMatch(content);
        if (match != null) {
          final modelName = match.group(1) ?? '';
          // Search for the model file
          final modelFile = findModelFile(modelName, projectPath);
          if (modelFile.isNotEmpty) {
            final relativePath = modelFile.replaceAll(projectPath, '');
            return (modelName, '[${modelName}](../../${relativePath.replaceFirst('/', '')})');
          }
          return (modelName, modelName); // Return just the name if file not found
        }
      }
    }
  } catch (e) {
    print('Error finding model reference: $e');
  }
  return ('', '');
}

// Add this helper function to find the model file
String findModelFile(String modelName, String projectPath) {
  try {
    final dir = Directory(projectPath);
    if (!dir.existsSync()) return '';

    for (final entity in dir.listSync(recursive: true, followLinks: false)) {
      if (entity is File && 
          entity.path.endsWith('.dart') && 
          entity.readAsStringSync().contains('class $modelName')) {
        return entity.path;
      }
    }
  } catch (e) {
    print('Error finding model file: $e');
  }
  return '';
}

void main(List<String> arguments) {
  if (arguments.isEmpty) {
    print('Usage: dart generate_md.dart <api_provider_file>');
    exit(1);
  }

  final inputFilePath = arguments[0];
  const outputFilePath = 'api_provider_documentation.md';

  try {
    // Read the API provider file
    final inputFile = File(inputFilePath);
    if (!inputFile.existsSync()) {
      print('File $inputFilePath does not exist.');
      exit(1);
    }

    final content = inputFile.readAsStringSync();
    final enumData = parseApiProvider(content);

    final outputFile = File(outputFilePath);
    final buffer = StringBuffer();

    buffer.writeln('''
# API Provider Enum Documentation

| **#** | **Title** | **Category** | **Enum Name** | **Path** | **Usage** | **Model Reference** | **Method** | **API Version** | **Require Token** | **Require Base64** | **Require Decryption** | **Require EKYC Sign** |
|-------|-----------|--------------|---------------|-----------|------------|-------------------|------------|-----------------|------------------|-------------------|----------------------|---------------------|''');

    final projectPath = Directory.current.parent.parent.path;

    for (var i = 0; i < enumData.length; i++) {
      final e = enumData[i];
      final usages = findApiUsages(e.name, projectPath);
      buffer.writeln('| ${i + 1} | ${e.title} | ${e.category} | ${e.name} | ${e.path} | ${usages} | ${e.modelReferenceLink} | ${e.method} | ${e.apiVersion} | ${e.requireToken} | ${e.requireBase64EncodedBody} | ${e.requireDecryption} | ${e.requireEkycSign} |');
    }

    outputFile.writeAsStringSync(buffer.toString());

    print('Generated $outputFilePath');
  } catch (e) {
    print('Error: $e');
  }
}

class ApiProvider {
  final String name;
  final String title;
  final String path;
  final String method;
  final String apiVersion;
  final bool requireToken;
  final bool requireBase64EncodedBody;
  final bool requireDecryption;
  final bool requireEkycSign;
  final String category;
  final String modelReferenceName;
  final String modelReferenceLink;

  ApiProvider({
    required this.name,
    required this.title,
    required this.path,
    required this.method,
    required this.apiVersion,
    required this.requireToken,
    required this.requireBase64EncodedBody,
    required this.requireDecryption,
    required this.requireEkycSign,
    required this.category,
    required this.modelReferenceName,
    required this.modelReferenceLink,
  });
}

String determineCategoryFromPath(String path) {
  if (path.isEmpty) return 'Uncategorized';
  
  final pathSegments = path.split('/').where((s) => s.isNotEmpty).toList();
  if (pathSegments.isEmpty) return 'Uncategorized';

  // Common API patterns
  if (path.contains('/auth/')) return 'Authentication';
  if (path.contains('/user/')) return 'User Management';
  if (path.contains('/account/')) return 'Account Management';
  if (path.contains('/transaction/')) return 'Transactions';
  if (path.contains('/payment/')) return 'Payments';
  if (path.contains('/transfer/')) return 'Transfers';
  if (path.contains('/card/')) return 'Card Services';
  if (path.contains('/bill/')) return 'Bill Payments';
  if (path.contains('/kyc/')) return 'KYC';
  if (path.contains('/notification/')) return 'Notifications';
  if (path.contains('/profile/')) return 'Profile';
  if (path.contains('/config/')) return 'Configuration';
  
  // Use first segment as fallback category
  return pathSegments.first.capitalize();
}

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
}

List<ApiProvider> parseApiProvider(String content) {
  final List<ApiProvider> providers = [];
  final enumRegExp = RegExp(r'(\w+)\(([^)]*)\),');
  final matches = enumRegExp.allMatches(content);

  for (final match in matches) {
    final name = match.group(1);
    final properties = match.group(2)?.split(',');

    // Skip if name is empty or properties are missing
    if (name == null || properties == null || properties.isEmpty) continue;

    Map<String, String> propertyValues = {};
    for (final property in properties) {
      final keyValue = property.split(':');
      if (keyValue.length == 2) {
        propertyValues[keyValue[0].trim()] = keyValue[1].trim().replaceAll('\'', '');
      }
    }

    // Skip entries that don't have essential properties
    if (propertyValues['path']?.isEmpty ?? true) continue;
    if (propertyValues['title']?.isEmpty ?? true) continue;

    String method = propertyValues['method'] ?? '';
    if (method.toUpperCase() == 'ApiMethod.get'.toUpperCase()) {
      method = 'GET';
    } else if (method.toUpperCase() == 'ApiMethod.post'.toUpperCase()) {
      method = 'POST';
    }

    final path = propertyValues['path'] ?? '';
    final category = determineCategoryFromPath(path);
    final (modelName, modelLink) = findModelReference(name, Directory.current.parent.parent.path);

    // Skip entries that look like they might be invalid
    if (name == 'Duration' || name == 'ApiProviderEnum') continue;
    
    providers.add(ApiProvider(
      name: name ?? '',
      title: propertyValues['title'] ?? '',
      path: path,
      method: method,
      apiVersion: propertyValues['apiVersion'] ?? 'v1',
      requireToken: propertyValues['requireToken'] == 'true',
      requireBase64EncodedBody: propertyValues['requireBase64EncodedBody'] == 'true',
      requireDecryption: propertyValues['requireDecryption'] == 'true',
      requireEkycSign: propertyValues['requireEkycSign'] == 'true',
      category: category,
      modelReferenceName: modelName,
      modelReferenceLink: modelLink,
    ));
  }

  // Sort providers by category and then by name
  providers.sort((a, b) {
    final categoryCompare = a.category.compareTo(b.category);
    if (categoryCompare != 0) return categoryCompare;
    return a.name.compareTo(b.name);
  });

  return providers;
}
